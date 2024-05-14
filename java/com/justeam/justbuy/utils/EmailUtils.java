package com.justeam.justbuy.utils;

import java.io.IOException;
import java.io.InputStream;
import java.net.URISyntaxException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.text.NumberFormat;
import java.util.List;
import java.util.Locale;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import com.justeam.justbuy.model.Ordine;
import com.justeam.justbuy.model.Prodotto;

public class EmailUtils {
	
	public static void send(String to, String ogg, Ordine ordine) throws Exception {
		Properties prop = new Properties();
		InputStream is = EmailUtils.class.getClassLoader().getResourceAsStream("/email.properties");
		prop.load(is);
		String enabled = prop.getProperty("enabled");
		if (enabled != null && enabled.equals("true")) {
			prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
			prop.put("mail.smtp.ssl.protocols", "TLSv1.2");
			
			Session session = Session.getInstance(prop,
					new javax.mail.Authenticator() {
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(prop.getProperty("username"), prop.getProperty("password"));
				}
			});
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(prop.getProperty("from")));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
			message.setSubject(ogg);
			message.setContent(buildEmail(ordine), "text/html;charset=utf-8");
			Transport.send(message);
		}
	}

	private static String buildEmail(Ordine ordine) throws URISyntaxException, IOException {
		NumberFormat euro = NumberFormat.getCurrencyInstance(Locale.ITALY);
		String mailTemplate = Files.readString(Paths.get(EmailUtils.class.getResource("/email-acquisto.html").toURI()));
		mailTemplate = mailTemplate.replace("NORDINE", ordine.getId().toString());
		mailTemplate = mailTemplate.replace("DATA", ordine.getData().toString());
		mailTemplate = mailTemplate.replace("PRODOTTI", formattaProdotti(ordine.getProdotti(),euro));
		mailTemplate = mailTemplate.replace("PREZZO", euro.format(ordine.getPrezzoTotale()));
		return mailTemplate;
	}

	private static String formattaProdotti(List<Prodotto> prodotti, NumberFormat euro) {
		StringBuilder builder = new StringBuilder();

		for (Prodotto p : prodotti) {
			builder
					.append("<li>")
					.append("<i>")
					.append(p.getNome())
					.append("</i>")
					.append(" (")
					.append(euro.format(p.getPrezzo()))
					.append(")")
					.append("</li>");
		}

		return builder.toString();
	}
}