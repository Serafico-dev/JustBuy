package com.justeam.justbuy.ui;

import java.io.IOException;
import com.justeam.justbuy.businesslogic.BusinessLogic;
import com.justeam.justbuy.model.Carrello;
import com.justeam.justbuy.model.Utente;
import com.justeam.justbuy.utils.ChiaveBL;
import com.justeam.justbuy.utils.ChiaviUtente;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/svuotaCarrello")
public class SvuotaCarrelloServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			BusinessLogic businessLogic = (BusinessLogic) getServletContext().getAttribute(ChiaveBL.BUSINESS_LOGIC);
			Utente utenteAttuale = (Utente) req.getSession().getAttribute(ChiaviUtente.UTENTE_LOGGATO);
			Carrello carrelloUtenteAttuale = utenteAttuale.getCarrello();			
			businessLogic.carrelloSvuotaCarrello(carrelloUtenteAttuale, carrelloUtenteAttuale.getProdotti());	
			req.getRequestDispatcher("/JSP/privata/carrello.jsp").forward(req, resp);
		} catch (Exception e) {
			e.printStackTrace();
			req.getRequestDispatcher("/JSP/pubblica/errore.jsp").forward(req, resp);
		}
	}

}