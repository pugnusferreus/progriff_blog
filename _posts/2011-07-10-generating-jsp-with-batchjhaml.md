---
layout: post
title: Generating JSPs With BatchJHaml
---

<h2>
  {{ page.title }}
</h2>

<h3>10 July 2011</h3>

Last year, I was assigned to build a web app using <a href="http://struts.apache.org/">Struts</a>.
I wanted a Haml interpreter and found <a href="https://github.com/raymyers/JHaml">JHaml</a>.
The problem is it only converts Haml strings to HTML. I need something to convert .haml files to .html or .jsp files.
Why should you use Haml? See <a href="http://haml-lang.com/">here</a>.

Due to this limitation, I created <a href="https://github.com/pugnusferreus/batchjhaml">BatchJHaml</a>.
If you're using BatchJHaml as a standalone app, it's pretty straight forward. 
But what if you want to include BatchJHaml into your Ant build script?
Here's what you need to do.

1.) Run `git clone git@github.com:pugnusferreus/batchjhaml.git` in your terminal

2.) cd to BatchJHaml

3.) Run `ant` and `BatchJHaml.jar` will appear in the `dist` directory.

4.) Copy and paste `BatchJHaml.jar` in your local lib directory.

5.) Copy the following into your local lib directory as well. You can find them in the `BatchJHaml/lib` folder.
If you already have the following, you can ommit this step.
If you have a later version of the following jars, you can use them as well.

- commons-io-1.4.jar

- commons-lang-2.5.jar

- guava-r06.jar

- jhaml-0.1.2.jar

- markdownj-1.0.2b4-0.3.0.jar

6.) Copy the following build target into your build.xml
{% highlight xml %}
<target name="compile-haml">
  <echo message="Converting haml files into jsp ..." />
  <java fork="true" classname="com.progriff.jhaml.BatchJHaml">
    <classpath>
      <fileset dir="${library.home}">
        <include name="**/commons-io-*.jar" />
        <include name="**/commons-lang-*.jar" />
        <include name="**/guava-*.jar" />
        <include name="**/jhaml-*.jar" />
        <include name="**/markdownj-*.jar" />
      </fileset>
      <path location="${library.home}/BatchJHaml.jar"/>
    </classpath>
    <arg value="~/YourProject/haml"/>
    <arg value="~/YourProject/haml/layouts"/>
    <arg value="~/YourProject/jsp"/>
    <arg value="jsp"/>
    <arg value="~/YourProject/javascripts"/>
    <arg value="~/YourProject/stylesheets"/>
  </java>
</target>
{% endhighlight %}

7.) In your `build` target, add `compile-haml` to your `depends`. Example:
{% highlight xml %}
<target name="build" depends="clean, prepare,compile, compile-haml">
{% endhighlight %}

And enjoy your Haml.
