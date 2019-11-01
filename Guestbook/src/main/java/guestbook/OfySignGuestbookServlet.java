//https://triple-odyssey-255115.appspot.com/
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

import static com.googlecode.objectify.ObjectifyService.ofy;

import com.googlecode.objectify.Objectify;

import com.googlecode.objectify.ObjectifyService;

import java.util.Collections;

import com.googlecode.objectify.*;






public class OfySignGuestbookServlet extends HttpServlet {
	
    private static final Logger log = Logger.getLogger(SignGuestbookServlet.class.getName());
    
    static {

        ObjectifyService.register(Greeting.class);
       

    }
    
    

    public void doPost(HttpServletRequest req, HttpServletResponse resp)

                throws IOException {

        UserService userService = UserServiceFactory.getUserService();

        User user = userService.getCurrentUser();
        
        String guestbookName = req.getParameter("guestbookName");

        Key guestbookKey = KeyFactory.createKey("Guestbook", guestbookName);

        String content = req.getParameter("content");
        
        String title = req.getParameter("title");

        Date date = new Date();

        //Entity greeting = new Entity("Greeting", guestbookKey);
        /* greeting.setProperty("user", user);

        greeting.setProperty("date", date);

        greeting.setProperty("content", content);*/

        
        Greeting greeting = new Greeting(user, content, title, guestbookName);
       
        ofy().save().entity(greeting).now();   

 


 

       // resp.sendRedirect("/ofyguestbook.jsp?guestbookName=" + guestbookName);

        resp.sendRedirect("/ofyblogpost.jsp?guestbookName=" + guestbookName);


     

    }

}

