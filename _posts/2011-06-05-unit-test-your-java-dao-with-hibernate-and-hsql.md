---
layout: post
title: Unit Test Your Java DAO With Hibernate And HSQL DB
---

<h2>
  {{ page.title }}
</h2>

<h3>05 June 2011</h3>

Unlike Rails which allow you to do unit test on your models, there's no easy way to actually unit test your Java DAO. 
Sometimes, we do not have access to the development database or we do not want to polute the development database with our data.

Sure, we could run a local db on our machine. 
What happen if it's a huge RDBMS like Oracle or DB2? 
Yes, the previous sentence sounds enterprisey but as a Java developer, you can't get away with enterprisey things.

Take a look at this sample <a href="https://github.com/pugnusferreus/dao_unit_test">project</a>.
Assuming that your current project is using Hibernate as your ORM, you can use <a href="http://hsqldb.org/">HSQL DB</a> to load up a "in memory" database for your unit test.
Hibernate and hsql will automatically creates the table for you.

Here's how. I'll assume that you have Git, Java 1.6 (or whatever it's called now) and Ant installed on your machine.

1. `git clone https://github.com/pugnusferreus/dao_unit_test`
2. `cd dao_unit_test`
3. `ant`
4. Open docs/unitTest/index.html in your browser

You can see that all the unit test passed. 

Take a look in "com.progriff.model.User" and the hibernate.cfg.xml in the "src" folder.
It's just your typical hibernate configs.

Make sure that your hibernate config points to the HSQL DB and your model is mapped.
Open up "com.progriff.dao.UserDaoTest" and you can see that it's your typical Java Unit Test
