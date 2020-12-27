package com.example.notebook.gmail;

import android.os.AsyncTask;
import android.util.Config;

import java.io.IOException;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import com.example.notebook.model.Constants;

public class GmailSender extends AsyncTask<String, Void, Void> {


    @Override
    protected Void doInBackground(String... strings) {


        String created_email = strings[0];
        System.out.println("Checking created email---"+created_email);

        Constants constants = new Constants();

        final String username = constants.getCompany_email();
        final String password = constants.getCompany_password();
        final String filename = "/data/user/0/com.example.notebook/databases/notebook.db" ;
        final String MAIL_SENDER = constants.getCompany_email();
        final String MAIL_RECEIVER = created_email;



        Properties prop = new Properties();
        prop.put("mail.smtp.host", "smtp.gmail.com");
        prop.put("mail.smtp.port", "587");
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.starttls.enable", "true"); //TLS

        Session session = Session.getInstance(prop,
                new javax.mail.Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(username, password);
                    }
                });

        try {

            MimeMessage mimeMessage = new MimeMessage(session);

            MimeMultipart mimeMultipart = new MimeMultipart();

            MimeBodyPart messageBodyPart = new MimeBodyPart();

            messageBodyPart.setContent("from android", "text/plain; charset=UTF-8");

            mimeMultipart.addBodyPart(messageBodyPart);

            MimeBodyPart attachmentBodyPart = new MimeBodyPart();

            DataSource source = (DataSource) new FileDataSource(filename);

            attachmentBodyPart.setDataHandler(new DataHandler((javax.activation.DataSource) source));
            attachmentBodyPart.setFileName("notebook.db");

            mimeMultipart.addBodyPart(attachmentBodyPart);

            mimeMessage.setFrom(new InternetAddress(MAIL_SENDER));

            mimeMessage.addRecipient(Message.RecipientType.TO, new
                    InternetAddress(MAIL_RECEIVER));

            mimeMessage.setSubject("exported database");

            mimeMessage.setContent(mimeMultipart);

            Transport.send(mimeMessage);

        } catch (MessagingException e) {
            e.printStackTrace();
        }
        catch(Exception e)
        {
            System.out.println("Error-----"+e);
        }

        return null;
    }

}
