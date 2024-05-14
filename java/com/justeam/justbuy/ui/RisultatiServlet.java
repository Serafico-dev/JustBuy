package com.justeam.justbuy.ui;

import java.io.IOException;
import com.justeam.justbuy.businesslogic.BusinessLogic;
import com.justeam.justbuy.utils.ChiaveBL;
import com.justeam.justbuy.utils.ChiaviProdotto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/risultati")
public class RisultatiServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			BusinessLogic businessLogic = (BusinessLogic) getServletContext().getAttribute(ChiaveBL.BUSINESS_LOGIC);
			if (req.getParameter(ChiaviProdotto.RICERCA_PRODOTTI).equals("")){
				req.getRequestDispatcher("/JSP/pubblica/index.jsp").forward(req, resp);
			}
			req.getSession().setAttribute(ChiaviProdotto.RISULTATI_RICERCA, businessLogic.prodottoRetrieveBy(req.getParameter(ChiaviProdotto.RICERCA_PRODOTTI)));
			req.getSession().setAttribute(ChiaviProdotto.PRODOTTO_CERCATO, req.getParameter(ChiaviProdotto.RICERCA_PRODOTTI));
			req.getRequestDispatcher("/JSP/pubblica/risultati.jsp").forward(req, resp);
		} catch (Exception e) {
			e.printStackTrace();
			req.getRequestDispatcher("/JSP/pubblica/errore.jsp").forward(req, resp);
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}

}