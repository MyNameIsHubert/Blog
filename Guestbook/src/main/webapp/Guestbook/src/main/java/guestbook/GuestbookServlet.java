package guestbook;

import java.io.IOException;
import javax.servlet.http.*;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;



public class GuestbookServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp) 
		throws IOException {
			resp.setContentType("text/html");
			resp.getWriter().println("<h1 > Hello, World </h1>");
			//resp.getWriter().println("<br>");
			
		UserService userService = UserServiceFactory.getUserService();	
		User user = userService.getCurrentUser();
		
		if (user != null) {
		//	resp.setContentType("text/html");
			resp.getWriter().println("<h2> Hello, " + user.getNickname() + "</h2>");
			//resp.getWriter().println(userService.createLogoutURL(req.getRequestURI()));
			resp.getWriter().println("<a href = '"+userService.createLogoutURL(req.getRequestURI()) + "'>Logout</a>");
			
			
		} else {
			
			resp.sendRedirect(userService.createLoginURL(req.getRequestURI()));
		}
	
	
	}
	
	
}