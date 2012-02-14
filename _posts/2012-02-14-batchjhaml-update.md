---
layout: post
title: BatchJHaml Update
---

<h2>
  {{ page.title }}
</h2>

<h3>14 February 2012</h3>

I've updated <a href="https://github.com/pugnusferreus/batchjhaml">BatchJHaml</a> to support sub directories.
If you set the last argument to true, it'll generate the Haml file in subdirectories as well.
Do note that the layout folder will be omitted.

Here is a sample from my build.xml
{% highlight xml %}
<target name="run">
  <java fork="true" 
    classname="com.progriff.jhaml.BatchJHaml" 
    outputproperty="javaoutput">
    <classpath>
      <path refid="classpath"/>
      <path location="${dist}/BatchJHaml.jar"/>
    </classpath>
    <arg value="${haml.path}"/>
    <arg value="${haml.layout.path}"/>
    <arg value="${haml.output.path}"/>
    <arg value="${haml.output.extension}"/>
    <arg value="${haml.javascript.path}"/>
    <arg value="${haml.stylesheet.path}"/>
    <arg value="${haml.recursive}" />
    </java><echo message="${javaoutput}" />
</target>
{% endhighlight %}

For example if you have the following in your haml folder,
<pre class="text">
haml
  |-- someDir
        `- baz.haml
  `foo.haml
  `- bar.haml
</pre>

The resulting jsp folder will look like this

<pre class="text">
jsp
  |-- someDir
        `- baz.jsp
  `foo.jsp
  `- bar.jsp
</pre>