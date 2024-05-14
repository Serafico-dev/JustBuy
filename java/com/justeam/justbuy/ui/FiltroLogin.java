package com.justeam.justbuy.ui;

import java.io.IOException;
import com.justeam.justbuy.model.Utente;
import com.justeam.justbuy.utils.ChiaviUtente;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;

@WebFilter(urlPatterns = {"/JSP/pubblica/login.jsp", "/JSP/pubblica/registrati.jsp"})
public class FiltroLogin implements Filter {

	@Override
	public void doFilter(ServletRequest arg0, ServletResponse arg1, FilterChain arg2)
			throws IOException, ServletException {
		try {
			HttpServletRequest request = (HttpServletRequest) arg0;
			Utente check = (Utente) request.getSession().getAttribute(ChiaviUtente.UTENTE_LOGGATO);
			if (check == null) {
				arg2.doFilter(arg0, arg1);
			} else {
				arg0.getRequestDispatcher("/JSP/pubblica/index.jsp").forward(arg0, arg1);
			}
		} catch (Exception e) {
			e.printStackTrace();
			arg0.getRequestDispatcher("/JSP/pubblica/errore.jsp").forward(arg0, arg1);
		}
	}

}