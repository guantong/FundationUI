package contact;

import java.util.Properties;
import java.util.Date;
import javax.mail.*;
import javax.mail.internet.*;
import com.sun.mail.smtp.*;
import java.io.IOException;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.RequestScoped;
import javax.faces.context.ExternalContext;
import javax.faces.context.FacesContext;

/**
 *
 * @author SumayaBaitalmal
 * 
 * This is the backing bean used for the contact us form.
 * To change the victogreen communications email please put the value in the constructor below where noted
 * Currently victogreen uses the mailgun api and a SMTP method for sending the messages from the contact form
 * 
 * 
 * 
 * REQUIRED JAR FILES:
 * JSF 2.2 - javax.faces.jar
 * activation-1.1.1.jar
 * mail-1.4.1.jar
 */
@ManagedBean
@RequestScoped
public class EmailBean {

    String from;            //Reflects the "email" field from the contact-us page
    String name;            //"name" field
    String recepient;       // victogreen's communications email or project represented for enquiries
    String message;         //message body from the textarea in the contact-us form
    String subject;         //default subject line for the victogreen email to be received

    public EmailBean() {
        //Default declaration
        this.recepient = "victogreen.a1@gmail.com"; //Change this email to the appropriate recepient's email of victogreen. password 204204204
        this.subject = "Contact Form";  // + name done in the sendEmail method
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getFrom() {
        return from;
    }

    public void setFrom(String from) {
        this.from = from;
    }

    public String getRecepient() {
        return recepient;
    }

    public void setRecepient(String recepient) {
        this.recepient = recepient;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    
    //Sending message using the mailgun api and SMTP
    public void sendEmail() throws Exception {
        
        Properties props = System.getProperties();
        props.put("mail.smtps.host", "smtp.mailgun.org");
        props.put("mail.smtps.auth", "true");
        Session session = Session.getInstance(props, null);
        Message msg = new MimeMessage(session);
        msg.setFrom(new InternetAddress(from));
        msg.setRecipients(Message.RecipientType.TO,
                InternetAddress.parse(recepient, false));
        msg.setSubject(subject + " From: " + name);             //Subject line
        msg.setText(message + "\n Sender's Email: " + from);    // Message followed by sender's email
        msg.setSentDate(new Date());
        SMTPTransport t
                = (SMTPTransport) session.getTransport("smtps");
        t.connect("smtp.mailgun.com", "postmaster@victogreen.tk", "b7b62c9179650ca5ae74a195592631a8"); //this is the mailgun credentials
        t.sendMessage(msg, msg.getAllRecipients());
        System.out.println("Response: " + t.getLastServerResponse());
        t.close();
        
        // send another copy to user        
        Session sessionToUser = Session.getInstance(props, null);
        Message msgToUser = new MimeMessage(sessionToUser);
        msgToUser.setFrom(new InternetAddress("postmaster@victogreen.tk"));
        msgToUser.setRecipients(Message.RecipientType.TO,
                InternetAddress.parse(from, false));
        msgToUser.setSubject("VictoGreen");             //Subject line
        msgToUser.setText("Thank you for your feedback, we will get back to you very soon" + "\n\nP.S Please do not respond to this email, This is auto-generated email.");    // Message followed by sender's email
        msgToUser.setSentDate(new Date());
        SMTPTransport toUser = (SMTPTransport) sessionToUser.getTransport("smtps");
        toUser.connect("smtp.mailgun.com", "postmaster@victogreen.tk", "b7b62c9179650ca5ae74a195592631a8"); //this is the mailgun credentials
        toUser.sendMessage(msgToUser, msgToUser.getAllRecipients());
        System.out.println("Response: " + toUser.getLastServerResponse());
        toUser.close();
        
        showSuccessMessage();
    }

    private void showSuccessMessage() throws IOException {
        ExternalContext externalContext = FacesContext.getCurrentInstance().getExternalContext();
        externalContext.redirect("response.xhtml");     //Redirect to the response page upond successful sending of message
    }
}
