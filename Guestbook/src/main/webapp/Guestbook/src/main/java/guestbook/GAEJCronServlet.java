package guestbook;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Properties;
import java.util.logging.Logger;

import javax.mail.*;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;



@SuppressWarnings("serial")
public class GAEJCronServlet extends HttpServlet {
private static final Logger _logger = Logger.getLogger(GAEJCronServlet.class.getName());
public void doGet(HttpServletRequest req, HttpServletResponse resp)
throws IOException {

try {
_logger.info("Cron Job has been executed");

//Put your logic here
//BEGIN
//END

Properties props = new Properties();
Session session = Session.getDefaultInstance(props, null);

try {
  Message msg = new MimeMessage(session);
  msg.setFrom(new InternetAddress("Group11@triple-odyssey-255115.appspotmail.com", "Group 11 Admin - HW 4"));
  msg.addRecipient(Message.RecipientType.TO,
                   new InternetAddress("ninghubert@gmail.com", "Mr. User"));
  msg.setSubject("Your Example.com account has been activated");
  msg.setText("This is a test");
  Transport.send(msg);
} catch (AddressException e) {
  // ...
} catch (MessagingException e) {
  // ...
} catch (UnsupportedEncodingException e) {
  // ...
}

}

catch (Exception ex) {
//Log any exceptions in your Cron Job
}
}


@Override
public void doPost(HttpServletRequest req, HttpServletResponse resp)
throws ServletException, IOException {
doGet(req, resp);
}
}