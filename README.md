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

# Screenshots

![image](https://user-images.githubusercontent.com/1594701/60866336-bf1d2900-a230-11e9-912c-4e1e76364c1e.png)

![image](https://user-images.githubusercontent.com/1594701/60866518-3652bd00-a231-11e9-9758-c9258462c4cf.png)

![image](https://user-images.githubusercontent.com/1594701/60866548-48ccf680-a231-11e9-9e1a-4c29855eeb40.png)

# Credits

http://michalorman.com/2015/03/daemons-in-rails-environment/

https://medium.com/@Flyr1Q/rails-reverse-pagination-from-scratch-74346c9ab556
