require 'rss'
require 'simple-rss'
require 'open-uri'

namespace :rss do
  desc "Daemon for fetching rss feeds"
  task daemon: :environment do
    # Signal.trap('TERM') { abort }

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
        rescue => e
          p "Rescued network error: #{e.inspect} [feed: #{f.url}]"
        end

        f.last_fetched_at = Time.now
        f.save!

      rescue => e
        p "Rescued general error: #{e.inspect}"
      end
    end

    fetching_now = []
    fetch_queue = []
    last_printed_at = nil

    20.times do |t|
      spy = Thread.new do
        p "Started thread ##{t}"
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
      if last_printed_at.blank? || ((Time.now - last_printed_at) > 1)
        p ['fetch_queue', fetch_queue].inspect
        p ['fetch_queue.length', fetch_queue.length].inspect
        p ['fetching_now', fetching_now].inspect
        last_printed_at = Time.now
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
