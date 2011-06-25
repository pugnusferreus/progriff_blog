---
layout: post
title: Modernizing Lunchpicker
---

<h2>
  {{ page.title }}
</h2>

<h3>26 June 2011</h3>

Lunchpicker is my first project with Rails. Back then, there was alot of hype regarding Rails and that was why I started Lunchpicker
to have a taste of Ruby On Rails. Yes, I fell in love with it immediately.

Wife had some plans for the entire afternoon and I've decided to dedicate my entire Saturday afternoon on migrating Lunchpicker from Rails 2 to Rails 3.
Here's a blog post on my adventure. Thanks <a href="http://twitter.com/#!/jasoncodes">@jasoncodes</a> for helping!


1 . Install <a href="https://rvm.beginrescueend.com/">RVM</a>. 
RVM allows you to install, manage and work with multiple ruby environments. 
For example, you can have project A running in Ruby 1.8.x and project B running in Ruby 1.9.x


2 . For lunchpicker, here is my .rvmrc file 
    {% highlight bash %}
    $ cat .rvmrc
    rvm --create 1.9.2@lunchpicker
    {% endhighlight %}

3 . Now, we need to intall Bundler. 
Bundler manages your application's dependencies via Gemfile. 
Here's a sample of lunchpicker's Gemfile
{% highlight ruby %}
source 'http://rubygems.org'

gem 'rails', '3.0.9'
gem 'google_weather', :git => 'http://github.com/Ennova/google-weather.git'
gem 'informal'
gem 'haml'
gem 'httparty'
gem 'authlogic', :git => 'http://github.com/radar/authlogic.git'
gem 'pg', :require => 'pg'
gem 'sass'
gem 'dynamic_form'
{% endhighlight %}

4 . After creating a Gemfile, run `gem install bundler` and then run `bundle intall` to install all the dependencies in your rvm.

5 . Go into the lunchpicker directory and run `rails new .`. 
It'll obviously overwrite your old configurations with Rails 3's. Replace all the files.

6 . Do a diff and merge all your codes (controllers, models, js, css, haml etc.)

7 . Remove config/initializers/new_rails_defaults.rb

8 . Remove scaffold related html from the `public` folder

9 . In your helpers, mark your HTML fragements as safe. For example you should change
{% highlight ruby %}
return <<-HTML
  <p>
    blah
  </p>
HTML
{% endhighlight %}
to
{% highlight ruby %}
return <<-HTML.html_safe
  <p>
    blah
  </p>
HTML
{% endhighlight %}

10 . If you have a non ActiveRecord model, and if you're using Validatable, change it to <a href="https://github.com/joshsusser/informal">Informal<a/>. 
For Lunchpicker, search.rb is not an ActiveRecord model. 
Also, we need to change 
{% highlight ruby %}
validates_presence_of :sheltered
{% endhighlight %}
to
{% highlight ruby %}
validates_inclusion_of :sheltered, :in => [true, false]
{% endhighlight %}
We're using validate inclusion rather than presence for booleans. This is due to the way Object#blank? handles boolean values. false.blank? # => true

11 . Add the following lines to config/application.rb. This will prefix the tablename infront of the PK. eg. venue_id
{% highlight ruby %}
config.active_record.primary_key_prefix_type = :table_name_with_underscore
config.active_record.schema_format = :sql
{% endhighlight %}

12 . default.html.haml has been changed to application.html.haml in Rails 3.
Run `git mv default.html.haml application.html.haml` and don't forget to remove the application.html.erb as well.

13 . Switch rails.js from Prototype to jQuery. Remove controls.js, dragdrop.js, effect.js and prototype.js. Please see
<a href="https://github.com/pugnusferreus/lunchpicker/blob/0e278acf24d1764d03c8ededa02e364da7c1c409/public/javascripts/rails.js">rails.js</a>.

14 . Add rails.js in the application.html.haml for Unobtrusive Javascript support.
{% highlight ruby %}
= javascript_include_tag 'rails'
{% endhighlight %}

15 . If you run `rake db:migrate` before step 11, run `rake db:reset` and then `rake db:migrate` again.

I hope that this will be useful to you if you need to migrate any old Rails 2 application to Rails 3. 
I'll use this opportunity to add unit test with RSpec.

The Rails 3 version of lunch picker won't be in production till unit test is done!

