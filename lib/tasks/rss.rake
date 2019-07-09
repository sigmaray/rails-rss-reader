def insp(arr)
  p arr.inspect
end

def fetch_feed(f)
  begin
    require 'rss'
    require 'simple-rss'
    require 'open-uri'
    # rss_results = []


    begin 
      rss = RSS::Parser.parse(open(
        # 'http://feeds.feedburner.com/CoinDesk?format=xml'
        f.url
      ).read, false).items#[0..5]
      # # p rss[0].to_json
      # rss = (SimpleRSS.parse open(f.url)).items

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
      p "Rescued fetching Error: #{se.inspect} [feed: #{f.url}]"
    end

    # f.last_fetched_at = t
    f.last_fetched_at = Time.now
    f.save!
    
    # rss.each do 
    # result
    #   result = { title: result.title, date: result.pubDate, link: result.link, description: result.description }
    #   rss_results.push(result)
    # end
    # return rss_results

  rescue => ex
    p "Rescued error: #{ex.inspect}"
  end
end

namespace :rss do
  desc "TODO"
  task daemon: :environment do
    Signal.trap('TERM') { abort }

    fetching_now = []
    fetch_queue = []


    20.times do |t|
      spy = Thread.new do
        # fetcher_thread

        p 'started fetcher_thread'
        # sleep 50
        loop do
          n = 0.01
          # p "n: #{n}"
          # insp ['sleep(n)', sleep(n)]
          sleep(n)

          # insp ['l61', 'fetch_queue', fetch_queue]
          fetch_queue.each do |fq|
            # p 'l62'
            next if fetching_now.include?(fq)
            # p 'l64'

            fetching_now << fq
            sleep 5
            # fetching_now << f.id
            # fetch_feed(f)
            # fetching_now.delete(f.id)
            f = Feed.find(fq)
            puts "Fetching feed: #{f.url}"
            fetch_feed f
            fetching_now.delete fq
            fetch_queue.delete fq
            puts "Ended fetching feed: #{f.url}"
          end
        end
      end
    end

    last_tinst = nil
    loop do
      # Daemon code goes here...

      if last_tinst.blank? || ((Time.now - last_tinst) > 1)
        insp ['fetch_queue', fetch_queue]
        insp ['fetch_queue.length', fetch_queue.length]
        insp ['fetching_now', fetching_now]
        last_tinst = Time.now
      end

      n = 0.01
      # n = 1
      # p "n: #{n}"
      # insp ['sleep(n)', sleep(n)]
      # sleep(n)
      sleep(n)

      i = 0
      # Feed.fetchable.each do |q|
      #   f = Feed.find(q.id)
      # uncached do
      # Feed.connection.clear_query_cache
        Feed.fetchable.each do |f|
          # f = Feed.find(q.id)

          # insp ['i', i]
          i += 1
          # p 'Inside Feed.all.each do |f|'
          # insp ['f.url', f.url]

          t = Time.now
          # insp ['[f.last_fetched_at.present?, f.interval_seconds.present?]', [f.last_fetched_at.present?, f.interval_seconds.present?]]
          if f.last_fetched_at.present? 
            if f.interval_seconds.present?
              # if (t-f.last_fetched_at) < (f.interval_seconds * 5)
              # if (t-f.last_fetched_at) < 300
              if (t-f.last_fetched_at) < f.interval_seconds
                # p 'next'
                next
              end
            else
              # k = 60
              # p 'No f.interval_seconds.'
              # insp(['((t-f.last_fetched_at) < 60)', ((t-f.last_fetched_at) < 60)])
              if (t-f.last_fetched_at) < (60 * 1)
                # p 'next'
                next
              end
            end
          end

          # puts "Fetching feed: #{f.url}"
          # fetching_now << f.id
          # fetch_feed(f)
          # fetching_now.delete(f.id)
          fetch_queue << f.id if !fetch_queue.include?(f.id)
          # puts "Ended fetching feed"
        end
        # sleep ENV['INTERVAL'] || 1
      # end
    end

  end
end
