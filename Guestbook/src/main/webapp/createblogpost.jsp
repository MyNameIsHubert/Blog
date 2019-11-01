<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>

<%@ page import="com.google.appengine.api.users.User" %>

<%@ page import="com.google.appengine.api.users.UserService" %>

<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>

<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>

<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>

<%@ page import="com.google.appengine.api.datastore.Query" %>

<%@ page import="com.google.appengine.api.datastore.Entity" %>

<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>

<%@ page import="com.google.appengine.api.datastore.Key" %>

<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page import="com.googlecode.objectify.Objectify" %>

<%@ page import="com.googlecode.objectify.ObjectifyService" %>

<%@ page import = "java.util.Collections" %>

<%@ page import = "com.googlecode.objectify.*" %>

<%@ page import = "guestbook.Greeting"%>



 

<html>

  <head>
  
  <link type="text/css" rel="stylesheet" 
  href="/stylesheets/main.css" />

  </head>

 

  <body>

 <div id = "Homepage_Image">
	<img src="https://www.ecampusnews.com/files/2016/01/blogs.jpg" alt="HTML5 Icon" width="1024" height="256">
 </div>

<%

    String guestbookName = request.getParameter("guestbookName");

    if (guestbookName == null) {

        guestbookName = "default";

    }

    pageContext.setAttribute("guestbookName", guestbookName);

    UserService userService = UserServiceFactory.getUserService();

    User user = userService.getCurrentUser();


%>


<div id = "Blog_posts">
    <form action="/ofysign" method="post"> -->

    <!-- Title of Blog Post -->  
   <div><textarea name="title" rows="2" cols="30"></textarea></div> 
      
    <!-- Content of Blog Post -->
       <div><textarea name="content" rows="15" cols="120"></textarea></div> 

	<!-- Submit button -->
     <div><input type="submit" value="Click to create title name and blog post" /></div> 
      
     
      <input type="hidden" name="guestbookName" value="${fn:escapeXml(guestbookName)}"/>
      
      <a href = "ofyguestbook.jsp"> Create Blog Post </a>

    </form>
</div>
 
  </body>

</html>

