require 'rss'
require 'simple-rss'
require 'open-uri'

namespace :rss do
  desc "TODO"
  task daemon: :environment do
    # Signal.trap('TERM') { abort }

    def insp(arr)
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
          p "Rescued fetching error: #{se.inspect} [feed: #{f.url}]"
        end

        f.last_fetched_at = Time.now
        f.save!

      rescue => ex
        p "Rescued general error: #{ex.inspect}"
      end
    end

    fetching_now = []
    fetch_queue = []

    20.times do |t|
      spy = Thread.new do
        p "Started fetcher_thread ##{t}"
        loop do
          fetch_queue.each do |fq|
            next if fetching_now.include?(fq)
            fetching_now << fq
            # sleep 5
            f = Feed.find(fq)
            puts "Fetching feed: #{f.url}"
            fetch_feed f
            fetching_now.delete fq
            fetch_queue.delete fq
            puts "Ended fetching feed: #{f.url}"
          end

          sleep(0.01)
        end
      end
    end

    last_printed = nil
    loop do
      # Daemon code goes here...

      if last_printed.blank? || ((Time.now - last_printed) > 1)
        insp ['fetch_queue', fetch_queue]
        insp ['fetch_queue.length', fetch_queue.length]
        insp ['fetching_now', fetching_now]
        last_printed = Time.now
      end

      Feed.fetchable.each do |f|
        t = Time.now
        if f.last_fetched_at.present? 
          if f.interval_seconds.present?
            if (t-f.last_fetched_at) < f.interval_seconds
              next
            end
          else
            if (t-f.last_fetched_at) < 60
              next
            end
          end
        end
        fetch_queue << f.id if !fetch_queue.include?(f.id)
      end
      sleep(0.01)
    end
  end
end
