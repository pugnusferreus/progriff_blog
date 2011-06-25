---
layout: post
title: How to install jekyll
---

<h2>
  {{ page.title }}
</h2>

<h3>18 May 2011</h3>

This is my first blog post entry for progriff.com. Since this blog was made with <a href="https://github.com/mojombo/jekyll">Jekyll</a>, I'll walk you through how to setup a basic blog with Jekyll. Why Jekyll? Here are a couple of points I could think of :

- It generates static pages for you.
- You do not need a database in your server
- You do not need a webserver (Apache, IIS, etc ...)
- Without all those mumbo jumbo on your server, your server will be more secure

Here's how:


1 . First, install Jekyll
    {% highlight bash %}
    $ sudo gem install jekyll
    {% endhighlight %}
    
2 . Then install rdiscount
    {% highlight bash %}
    $ sudo gem install rdiscount
    {% endhighlight %}


3 . Make a directory. Let's call it blog.
    {% highlight bash %}
    $ mkdir blog
    $ cd blog
    {% endhighlight %}

4 . Create the directory structure as of below.
<pre class="text">
      blog
        |-- _layouts
                `-- default.html
                `-- post.html
        |-- _posts
           `-- 2011-05-18-foo-bar.md
        |-- _site
        |-- css
        `-- index.html
        `-- _config.yml
    
</pre>

5 . This is optional. If you need code syntax highlighting, you'll need Pygment. 
    {% highlight bash %}
    $ sudo easy_install Pygments
    $ pygmentize -S default -f html > /path/to/your/blog/css/pygment.css
    {% endhighlight %}

6 . Take a look at the <a href="https://github.com/pugnusferreus/progriff_blog">source</a> for this blog and copy whatever you need.

7 . After you're done, you want to preview your blog. In your terminal, type
    {% highlight bash %}
    $ jekyll --server --auto
    {% endhighlight %}

8 . Go to your browser and go to "http://localhost:4000"

9 . If you need to compile the pages without starting the server, just type "jekyll"