
package guestbook;

import java.io.IOException;

import java.util.Date;

import javax.servlet.http.HttpServlet;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;

import java.util.logging.Logger;

import javax.servlet.http.*;

import com.google.appengine.api.users.User;

import com.google.appengine.api.users.UserService;

import com.google.appengine.api.users.UserServiceFactory;

import com.google.appengine.api.datastore.DatastoreService;

import com.google.appengine.api.datastore.DatastoreServiceFactory;

import com.google.appengine.api.datastore.Entity;

import com.google.appengine.api.datastore.Key;

import com.google.appengine.api.datastore.KeyFactory;



 

public class SignGuestbookServlet extends HttpServlet {

    private static final Logger log = Logger.getLogger(SignGuestbookServlet.class.getName());
 

    public void doPost(HttpServletRequest req, HttpServletResponse resp)

                throws IOException {

        UserService userService = UserServiceFactory.getUserService();

        User user = userService.getCurrentUser();
        
        String guestbookName = req.getParameter("guestbookName");

        Key guestbookKey = KeyFactory.createKey("Guestbook", guestbookName);

        String content = req.getParameter("content");

        Date date = new Date();

        Entity greeting = new Entity("Greeting", guestbookKey);

        greeting.setProperty("user", user);

        greeting.setProperty("date", date);

        greeting.setProperty("content", content);

 

        DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();

        datastore.put(greeting);

 

        resp.sendRedirect("/guestbook.jsp?guestbookName=" + guestbookName);

 /*

        String content = req.getParameter("content");

        if (content == null) {

            content = "(No greeting)";

        }

        if (user != null) {

            log.info("Greeting posted by user " + user.getNickname() + ": " + content);

        } else {

            log.info("Greeting posted anonymously: " + content);

        }

        resp.sendRedirect("/guestbook.jsp");*/
     

    }

}