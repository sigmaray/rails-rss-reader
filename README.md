RSS reader written in Ruby & Rails

# Setup

It's prefferable to use RVM (https://rvm.io/)

`cd` intro project folder. Run in terminal:
```
bundle install
rake db:migrate
```

# How to create feeds

Create sample feeds

Edit `db/seeds.rb`
Run in terminal:
`rake db:seed`

Or create feeds in /admin

# How to run web UI

Run in terminal:
```
rails s -p %PORT_NUMBER%
```

# How to run daemon for fetching RSS feeds
```
rake rss:daemon
```
