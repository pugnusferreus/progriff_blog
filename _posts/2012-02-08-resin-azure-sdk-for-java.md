---
layout: post
title: Resin 3.1 and Azure SDK for Java
---

<h2>
  {{ page.title }}
</h2>

<h3>08 February 2012</h3>

I was writing a REST service that will send a Cloud Queue Message to Azure. 
After testing my utility class with JUnit, it passed.
However, when I tried to send a Cloud Queue Message via REST service (hosted in Resin 3.1), I got the following error:

{% highlight java %}
java.lang.IllegalArgumentException: property 
  "javax.xml.stream.isReplacingEntityReferences" not supported
at com.caucho.xml.stream.XMLInputFactoryImpl.setProperty
  (XMLInputFactoryImpl.java:265)
at com.microsoft.windowsazure.services.core.storage.utils
  .Utility.createXMLStreamReaderFromStream(Utility.java:321)
{% endhighlight %}

Resin Web Server uses it's own `XMLInputFactory` implementation called `com.caucho.xml.stream.XMLInputFactoryImpl`.
According to this <a href="http://www.caucho.com/resin-3.1/doc/jaxp.xtp">article</a>, you can override the 
implementation by having `<system-property/>` following in your `resin.conf`.
Put the following to use the JDK's version of XMLInputFactoryImpl
{% highlight xml %}
<system-property javax.xml.stream.XMLInputFactory=
  "com.sun.xml.internal.stream.XMLInputFactoryImpl" />
{% endhighlight %}

Problem solved? Not really. Tried running the REST service again and I got the following:
{% highlight java %}
com.microsoft.windowsazure.services.core.storage.StorageException: 
  XML specified is not syntactically valid.
{% endhighlight %}

After looking at the Azure SDK for Java's <a href="https://github.com/WindowsAzure/azure-sdk-for-java">source</a>,
I've found out that the XMLOutputFactory and XMLStreamWriter was unable to generate the XML request body in
`com.microsoft.windowsazure.services.queue.client
  .QueueRequest.generateMessageRequestBody`

Why? If you do a simple system out on the class name, resin is using it's own implementation
for XMLOutputFactory and XMLStreamWriter.
So add the following as well into your resin.conf
{% highlight xml %}
<system-property javax.xml.stream.XMLOutputFactory=
  "com.sun.xml.internal.stream.XMLOutputFactoryImpl" />
<system-property javax.xml.stream.XMLStreamWriter=
  "com.sun.xml.internal.stream.writers.XMLStreamWriterImpl" />
{% endhighlight %}

tl;dr? Add the following in your resin.conf
{% highlight xml %}
<system-property javax.xml.stream.XMLInputFactory=
  "com.sun.xml.internal.stream.XMLInputFactoryImpl" />
<system-property javax.xml.stream.XMLOutputFactory=
  "com.sun.xml.internal.stream.XMLOutputFactoryImpl" />
<system-property javax.xml.stream.XMLStreamWriter=
  "com.sun.xml.internal.stream.writers.XMLStreamWriterImpl" />
{% endhighlight %}

After that, my code works perfectly. I'm sure there are other weird problems as well, 
I'll keep you posted if I've found anymore weird stuff.