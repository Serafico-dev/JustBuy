package com.justeam.justbuy.ui;

import java.io.IOException;
import java.util.Collections;
import com.justeam.justbuy.businesslogic.BusinessLogic;
import com.justeam.justbuy.model.Carrello;
import com.justeam.justbuy.model.Prodotto;
import com.justeam.justbuy.model.Utente;
import com.justeam.justbuy.utils.ChiaveBL;
import com.justeam.justbuy.utils.ChiaviProdotto;
import com.justeam.justbuy.utils.ChiaviUtente;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/aggiungiCarrelloHome")
public class AggiungiCarrelloHomeServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			BusinessLogic businessLogic = (BusinessLogic) getServletContext().getAttribute(ChiaveBL.BUSINESS_LOGIC);	
			Integer idProdotto = Integer.parseInt(req.getParameter(ChiaviProdotto.ID_PRODOTTO));
			Utente utenteAttuale = (Utente) req.getSession().getAttribute(ChiaviUtente.UTENTE_LOGGATO);
			Carrello carrelloUtenteAttuale = utenteAttuale.getCarrello();	
			Prodotto prodottoAttuale = businessLogic.prodottoRetrieveBy(idProdotto);	
			if (prodottoAttuale.getQuantita() > 0 && prodottoAttuale.getQuantita() > Collections.frequency(carrelloUtenteAttuale.getProdotti(), prodottoAttuale)) {
				businessLogic.carrelloAggiungiProdotto(carrelloUtenteAttuale, prodottoAttuale);
			}		
			resp.sendRedirect("JSP/pubblica/index.jsp" + "#card-" + prodottoAttuale.getId());		
		} catch (Exception e) {
			e.printStackTrace();
			req.getRequestDispatcher("/JSP/pubblica/errore.jsp").forward(req, resp);
		}
	}
}