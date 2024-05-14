package com.justeam.justbuy.ui;

import java.io.IOException;
import com.justeam.justbuy.businesslogic.BusinessLogic;
import com.justeam.justbuy.model.Prodotto;
import com.justeam.justbuy.utils.ChiaveBL;
import com.justeam.justbuy.utils.ChiaviProdotto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/paginaProdotto")
public class PaginaProdottoServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			BusinessLogic businessLogic = (BusinessLogic) getServletContext().getAttribute(ChiaveBL.BUSINESS_LOGIC);
			Integer idProdotto = Integer.parseInt(req.getParameter(ChiaviProdotto.ID_PRODOTTO));
			Prodotto prodottoAttuale = businessLogic.prodottoRetrieveBy(idProdotto);	
			req.getSession().setAttribute(ChiaviProdotto.PRODOTTO_CERCATO, prodottoAttuale);
			req.getRequestDispatcher("/JSP/pubblica/prodotto.jsp").forward(req, resp);
		} catch (Exception e) {
			e.printStackTrace();
			req.getRequestDispatcher("/JSP/pubblica/errore.jsp").forward(req, resp);
		}
	}

}