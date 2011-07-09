---
layout: post
title: Modernizing Lunchpicker Part 2
---

<h2>
  {{ page.title }}
</h2>

<h3>9 July 2011</h3>

When I wrote lunchpicker, I was obviously not yet enlightened with <a href="http://en.wikipedia.org/wiki/Test-driven_development">TDD</a>.
While migrating lunchpicker from Rails 2 to Rails 3, I took the opportunity to learn <a href="http://rspec.info/">RSpec</a>.
So again, here is my journey with RSpec. Since lunchpicker is a Rails app, I'll be using <a href="http://rspec.info/rails/">rspec-rails</a>

1.) Some stuff from the Sass plugin has been deprecated in Rails3.
Remove the plugin by removing the directory in vendor/plugins and add `https://github.com/jasoncodes/hassle.git` in your Gemfile.

2.) Move `filter_parameter_logging` in `application_controller.rb` to `/config/application.rb`

3.) Remove the test folder because we'll be using Rspec

4.) Add the following lines into your Gemfile. These gems should be loaded in Dev and Testing environments only.
{% highlight ruby %}
group :development, :test do
  gem 'rspec-rails'
  gem 'spork'
  gem 'awesome_print', :require => 'ap'
  gem 'mocha'
  gem 'shoulda'
  gem 'vcr'
  gem 'webmock', :require => false
end
{% endhighlight %}

5.) Run `bundle install` and then run `rails g rspec:install`.
This will create the rspec folder and the rake file to create a test database.

6.) The structure of your `spec/` directory should mirror that of `app`. 
For example, the spec file for `app/models/location.rb` would be `app/models/location_spec.rb`.

7.) Create your rspec test! Need example? See <a href="https://github.com/pugnusferreus/lunchpicker/tree/master/spec">here</a>.

8.) Now, in the lunchpicker directory, type `bundle exec rspec spec`.
This will run the tests. Since we're testing the controllers and models, rspec would need to bootstrap all the Rails stuff.
The result? Slowness.

9.) To overcome this, we'll be using spork to bootstrap the Rails libraries. 
Open another terminal window and `cd` to the lunchpicker folder.
Type in `bundle exec spork rspec`.

10.) Open another window and `cd` into the lunchpicker folder.
Type in `bundle exec rspec --drb spec`.
Notice that the tests run faster. 
If you change any Rails related config, remember to restart spork.

What's VCR? VCR records your test suite's HTTP interactions and replay them during future test runs for fast, deterministic, accurate tests.
We're interacting with Google Weather which is an external API. 

ps. <a href="http://lunch.progriff.com">lunchpicker</a> is now Rails 3
