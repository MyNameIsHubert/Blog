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
  
  <link type="text/css" rel="stylesheet" href="/stylesheets/homepage.css"/>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

  </head>

 

  <body>

<!-- Navigation Bar -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="ofyguestbook.jsp">Home<span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item active">
                        <a class="nav-link" href="#">All Posts<span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item active">
                        <a class="nav-link" href="#">Create Post<span class="sr-only">(current)</span></a>
                    </li>
                </ul>
            </div>
        </nav>
        
        <!-- Jumbotron -->
        <div class = "jumbotron">
            <div class = "container">
                <h1>AppEngine Blog - Homework 4</h1>
                <br>
                    <p>
                        Aditya Khanna and Hubert Ning
                    </p>
            </div>
        </div>


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

    if (user != null) {

      pageContext.setAttribute("user", user);

%>

<p>Hello, ${fn:escapeXml(user.nickname)}! (You can

<a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">sign out</a>.)</p>

<%

    } else {

%>

<p>Hello!

<a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Sign in</a>

to include your name with greetings you post.</p>

<%

    }

%>

 

<%

	
	ObjectifyService.register(Greeting.class);
	
	List<Greeting> greetings = ObjectifyService.ofy().load().type(Greeting.class).list();   
	
	Collections.sort(greetings); 
	

   // DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();

    Key guestbookKey = KeyFactory.createKey("Guestbook", guestbookName);

    // Run an ancestor query to ensure we see the most up-to-date

    // view of the Greetings belonging to the selected Guestbook.


    Query query = new Query("Greeting", guestbookKey).addSort("date", Query.SortDirection.DESCENDING).addSort("user", Query.SortDirection.DESCENDING);

  //  List<Entity> greetings = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(20));

    if (greetings.isEmpty()) {

        %>

        <p>Guestbook '${fn:escapeXml(guestbookName)}' has no messages.</p>

        <%

    } else {

        %>

        <p>Messages in Guestbook '${fn:escapeXml(guestbookName)}'.</p>

        <%

        for (Greeting greeting : greetings) {

      
            

            if (greeting.getUser() == null) {
					

            } else {
            	
            	pageContext.setAttribute("greeting_title", greeting.getTitle());
            	pageContext.setAttribute("greeting_content", greeting.getContent());
            	pageContext.setAttribute("greeting_date", greeting.getDate());
                pageContext.setAttribute("greeting_user", greeting.getUser());

                %>
                <hr size = "12">
    			<blockquote id = "titleBlock">${fn:escapeXml(greeting_title)}</blockquote>
                <blockquote>${fn:escapeXml(greeting_content)}</blockquote>
                <blockquote>${fn:escapeXml(greeting_date)}</blockquote>
                <p>Written by: <b>${fn:escapeXml(greeting_user.nickname)}</b></p>
				<hr size = "12">
                <%
        
            } 
            	
            	
       

        }

    }

%>


<!--   
<div id = "Blog_posts">
    <form action="/ofysign" method="post"> -->

    <!-- Title of Blog Post -->  
    <!--    <div><textarea name="title" rows="2" cols="30"></textarea></div> -->
      
    <!-- Content of Blog Post -->
  <!--     <div><textarea name="content" rows="15" cols="120"></textarea></div> -->

	<!-- Submit button -->
  <!--     <div><input type="submit" value="Click to create title name and blog post" /></div> 
      
     
      <input type="hidden" name="guestbookName" value="${fn:escapeXml(guestbookName)}"/>

    </form>
</div>
 
-->

<a href = "createblogpost.jsp"> Create Blog Post </a>

  </body>

</html>

