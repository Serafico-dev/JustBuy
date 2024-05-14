package com.justeam.justbuy.ui;

import java.io.IOException;
import java.util.Date;
import com.justeam.justbuy.businesslogic.BusinessLogic;
import com.justeam.justbuy.model.Carrello;
import com.justeam.justbuy.model.Ordine;
import com.justeam.justbuy.model.Prodotto;
import com.justeam.justbuy.model.Utente;
import com.justeam.justbuy.utils.ChiaveBL;
import com.justeam.justbuy.utils.ChiaviUtente;
import com.justeam.justbuy.utils.EmailUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/acquisto")
public class AcquistoServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			BusinessLogic businessLogic = (BusinessLogic) getServletContext().getAttribute(ChiaveBL.BUSINESS_LOGIC);
			Utente utenteAttuale = (Utente) req.getSession().getAttribute(ChiaviUtente.UTENTE_LOGGATO);
			Carrello carrelloAttuale = utenteAttuale.getCarrello();	
			Double prezzoTotale = 0.0;
			Ordine ordine = new Ordine(new Date(), prezzoTotale);
			for (Prodotto p : carrelloAttuale.getProdotti()) {
				prezzoTotale += p.getPrezzo();
				ordine.getProdotti().add(p);
				p.getOrdini().add(ordine);
				p.setQuantita(p.getQuantita()-1);
			}
			ordine.setPrezzoTotale(prezzoTotale);
			ordine.setUtente(utenteAttuale);
			utenteAttuale.getOrdini().add(ordine);
			businessLogic.ordineCrea(ordine, carrelloAttuale, carrelloAttuale.getProdotti());
			EmailUtils.send(utenteAttuale.getEmail(), "Ordine n°" + ordine.getId(), ordine);
			resp.sendRedirect("JSP/privata/ordini.jsp");
		} catch (Exception e) {
			e.printStackTrace();
			req.getRequestDispatcher("/JSP/pubblica/errore.jsp").forward(req, resp);
		}
	}

}