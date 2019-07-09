require 'rss'
require 'simple-rss'
require 'open-uri'

namespace :rss do
  desc "Daemon for fetching rss feeds"
  task daemon: :environment do
    # Signal.trap('TERM') { abort }

    def print_array(arr)
      p arr.inspect
    end

    def fetch_feed(f)
      begin
        begin 
          rss = RSS::Parser.parse(open(f.url).read, false).items

          rss.each do  |item|
            if Item.where(link: item.link).blank?
              f.items.create!(
                link: item.link,
                description: item.description,
                pub_date: item.pubDate,
                title: item.title,
                json: item.to_json
              )
            end
          end
        rescue => se
          p "Rescued network error: #{se.inspect} [feed: #{f.url}]"
        end

        f.last_fetched_at = Time.now
        f.save!

      rescue => ex
        p "Rescued general error: #{ex.inspect}"
      end
    end

    fetching_now = []
    fetch_queue = []
    last_printed = nil

    20.times do |t|
      spy = Thread.new do
        p "Started fetch thread ##{t}"
        loop do
          fetch_queue.each do |fq|
            next if fetching_now.include?(fq)

            fetching_now << fq
            f = Feed.find(fq)
            p "Fetching feed: #{f.url}"
            fetch_feed f
            fetching_now.delete fq
            fetch_queue.delete fq
            p "Finished fetching feed: #{f.url}"
          end

          sleep(0.01)
        end
      end
    end

    loop do
      if last_printed.blank? || ((Time.now - last_printed) > 1)
        print_array ['fetch_queue', fetch_queue]
        print_array ['fetch_queue.length', fetch_queue.length]
        print_array ['fetching_now', fetching_now]
        last_printed = Time.now
      end

      Feed.fetchable.each do |f|
        t = Time.now
        if f.last_fetched_at.present? 
          if f.interval_seconds.present?
            next if (t - f.last_fetched_at) < f.interval_seconds
          else
            next if (t - f.last_fetched_at) < 60
          end
        end
        fetch_queue << f.id if !fetch_queue.include?(f.id)
      end

      sleep(0.01)
    end
  end
end
