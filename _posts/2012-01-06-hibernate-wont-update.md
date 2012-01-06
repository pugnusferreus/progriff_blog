---
layout: post
title: Hibernate won't update my object!
---

<h2>
  {{ page.title }}
</h2>

<h3>06 January 2012</h3>

Yesterday, I was given a Hibernate related bug to fix. 
We have an object, say object A which has a list of object B. 
This list of object B are stored as a JSON string in table A.

So here's the problem, after calling a `session.update` on object A with the updated object B,
the change was not persisted into the database.
After hours of Googling and some help from Michael who is a fellow colleague of mine, I found the problem.

According to this <a href="http://stackoverflow.com/questions/4293768/does-hibernate-update-an-entity-that-has-not-changed">article</a>,
Hibernate will only do a `UPDATE` statement after `session.flush()`.
During this operation, Hibernate will compare the original object and the object to be updated.

This <a href="http://blog.xebia.com/2009/11/09/understanding-and-writing-hibernate-user-types/">article</a> explains
how Hibernate compares the object.

The fix? In your Hibernate user type, override the `deepCopy` and return another instance of list.
{% highlight java %}
@Override
public Object deepCopy(Object value) throws HibernateException
{

  // if value is null, return null
  if(value == null)
  {
    return null;
  }

  // convert the value to a List first
  List<ObjectB> objectBList = (List<ObjectB>)value;

  // create a new Arraylist and add all the objects
  List<ObjectB> newObjectBList = new ArrayList<ObjectB>();
  for(ObjectB objectB : objectBList)
  {
    newObjectBList.add(objectB);
  }
  return newObjectBList;
}
{% endhighlight %}