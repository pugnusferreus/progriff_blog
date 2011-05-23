---
layout: post
title: Things to do before you start programming
---

<h2>
  {{ page.title }}
</h2>

<h3>23 May 2011</h3>

I've been reading <a href="http://pragprog.com/titles/ahptl/pragmatic-thinking-and-learning">Pragmatic Thinking & Learning</a> by Andy Hunt. 
In one of the chapters, the author talks about UML. Yes, even I myself find that UML can get a bit boring. He suggests that I literally draw out
the diagram. And so I did. The author also suggests that you can do the same with Lego bricks or by role playing, but I won't go into that.

At <a href="http://www.movideo.com">movideo</a>, I've been assigned to make a program that runs on the server and upload videos to YouTube. In the future
we might externally syndicate our videos to another provider (eg. Vimeo). So, I come up with 
<a href="/images/external_syndication.png">this</a> diagram to see how it can aid me with my software development process.

This diagram actually helped me by:

  - Acting as a check list
  
  - Making Test-driven Development(TDD) easier. Why? By looking at this diagram, you'll be able to see the hollistic picture. By having a hollistic picture of the entire application that you're about to write, it's easier for you to write unit test for it's expected behaviour
  
  - Writing pseudo codes. I don't actually write pseudocode à la COBOL era, but for every function that I write, I'll write comments of the things that I need to do.For example:
  {% highlight java %}
    public void create()
    {
      // do validation
      
      // check if record exists
      
      // save to database   
    }
  {% endhighlight %}
  
Most importantly, before you start scribbling, get away from your computer. Computers can be distracting at times (emails, IM, Twitter). You'll be able to see a hollistic view without those distractions.