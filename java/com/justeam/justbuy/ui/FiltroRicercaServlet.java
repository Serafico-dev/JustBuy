package com.justeam.justbuy.ui;

import java.io.IOException;
import java.util.List;
import com.justeam.justbuy.businesslogic.BusinessLogic;
import com.justeam.justbuy.model.Prodotto;
import com.justeam.justbuy.utils.Categoria;
import com.justeam.justbuy.utils.ChiaveBL;
import com.justeam.justbuy.utils.ChiaviFiltro;
import com.justeam.justbuy.utils.ChiaviProdotto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/filtroRicerca")
public class FiltroRicercaServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
            BusinessLogic businessLogic = (BusinessLogic) getServletContext().getAttribute(ChiaveBL.BUSINESS_LOGIC);
            boolean disponibile = false;
            String prodottoCercato = (String) req.getSession().getAttribute(ChiaviProdotto.PRODOTTO_CERCATO);
            Double prezzoMin = 0.0;
            Double prezzoMax = 1000000.0;
            Categoria categoria;
            if (!req.getParameter(ChiaviFiltro.PREZZO_MIN).equals("")){
            	prezzoMin = Double.parseDouble((req.getParameter(ChiaviFiltro.PREZZO_MIN)));	
            	}
            if (!req.getParameter(ChiaviFiltro.PREZZO_MAX).equals("")){
            	prezzoMax = Double.parseDouble((req.getParameter(ChiaviFiltro.PREZZO_MAX)));
            }
            if (req.getParameter(ChiaviFiltro.CATEGORIA_FILTRO) == null) {
            	categoria = null;
            }
            else {
            	categoria = Categoria.valueOf(req.getParameter(ChiaviFiltro.CATEGORIA_FILTRO));
            }
            if (req.getParameter(ChiaviFiltro.DISPONIBILE) == null) {
            	disponibile = false;
            } else {
            	disponibile = true;
            }
            List<Prodotto> prodottiFiltrati = businessLogic.RetrieveByFiltro(prezzoMin, prezzoMax, categoria, disponibile, prodottoCercato);
            req.getSession().setAttribute(ChiaviProdotto.RISULTATI_RICERCA, prodottiFiltrati);
			req.getRequestDispatcher("/JSP/pubblica/risultati.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.getRequestDispatcher("/JSP/pubblica/errore.jsp").forward(req, resp);
        }
	}
}