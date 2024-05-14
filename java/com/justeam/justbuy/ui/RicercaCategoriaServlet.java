package com.justeam.justbuy.ui;

import com.justeam.justbuy.businesslogic.BusinessLogic;
import com.justeam.justbuy.model.Prodotto;
import com.justeam.justbuy.utils.Categoria;
import com.justeam.justbuy.utils.ChiaveBL;
import com.justeam.justbuy.utils.ChiaviProdotto;
import com.justeam.justbuy.utils.ChiaviRicerca;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/ricercaCategoria")
public class RicercaCategoriaServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            BusinessLogic businessLogic = (BusinessLogic) getServletContext().getAttribute(ChiaveBL.BUSINESS_LOGIC);
            List<Prodotto> prodotti = new ArrayList<>();
            if (req.getParameter(ChiaviRicerca.CATEGORIA) != null) {
            prodotti = businessLogic.prodottoRetrieveBy(
                    Categoria.valueOf(req.getParameter(ChiaviRicerca.CATEGORIA))
            );
            } else {
            	prodotti = businessLogic.prodottoRetrieveAll();
            }
            req.getSession().setAttribute(ChiaviProdotto.RISULTATI_RICERCA, prodotti);
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