def insp(arr)
  p arr.inspect
end

def fetch_feed(f)
  begin
    require 'rss'
    require 'simple-rss'
    require 'open-uri'
    # rss_results = []


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

    f.last_fetched_at = t
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
    loop do
      # Daemon code goes here...

      n = 0.1
      p "n: #{n}"
      insp ['sleep(n)', sleep(n)]

      i = 0
      Feed.fetchable.each do |f|
        insp ['i', i]
        i += 1
        p 'Inside Feed.all.each do |f|'
        insp ['f.url', f.url]

        t = Time.now
        # insp ['[f.last_fetched_at.present?, f.interval_seconds.present?]', [f.last_fetched_at.present?, f.interval_seconds.present?]]
        if f.last_fetched_at.present? 
          if f.interval_seconds.present?
            if (t-f.last_fetched_at) < f.interval_seconds
              p 'next'
              next
            end
          else
            # k = 60
            p 'No f.interval_seconds.'
            # insp(['((t-f.last_fetched_at) < 60)', ((t-f.last_fetched_at) < 60)])
            if (t-f.last_fetched_at) < 60
              p 'next'
              next
            end
          end
        end

        puts "Fetching feed: #{f.url}"
        fetch_feed(f)
        puts "Ended fetching feed"
      end
      # sleep ENV['INTERVAL'] || 1
    end

  end
end
