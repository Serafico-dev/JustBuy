package com.justeam.justbuy.ui;

import java.io.IOException;
import com.justeam.justbuy.businesslogic.BusinessLogic;
import com.justeam.justbuy.utils.ChiaveBL;
import com.justeam.justbuy.utils.ChiaviErrore;
import com.justeam.justbuy.utils.ChiaviRegistrazione;
import com.justeam.justbuy.utils.ChiaviUtente;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/login")
public class LoginServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			BusinessLogic businessLogic = (BusinessLogic) getServletContext().getAttribute(ChiaveBL.BUSINESS_LOGIC);
			if (businessLogic.utenteCheckLogin(req.getParameter(ChiaviRegistrazione.EMAIL), req.getParameter(ChiaviRegistrazione.PASSWORD))){
				req.getSession().setAttribute(ChiaviUtente.UTENTE_LOGGATO, businessLogic.utenteRetrieveByMail(req.getParameter(ChiaviRegistrazione.EMAIL)));
				req.getRequestDispatcher("/JSP/pubblica/index.jsp").forward(req, resp);
			} else {
				req.setAttribute(ChiaviErrore.CHIAVE_LOGIN_ERROR, "Email e/o password non corretti");
				req.getRequestDispatcher("/JSP/pubblica/index.jsp").forward(req, resp);
			}
		} catch (Exception e) {
			e.printStackTrace();
			req.getRequestDispatcher("/JSP/pubblica/errore.jsp").forward(req, resp);
		}
	}

}