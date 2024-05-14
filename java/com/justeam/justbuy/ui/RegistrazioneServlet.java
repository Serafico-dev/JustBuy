package com.justeam.justbuy.ui;

import java.io.IOException;
import com.justeam.justbuy.businesslogic.BusinessLogic;
import com.justeam.justbuy.exception.InvalidEmailException;
import com.justeam.justbuy.exception.InvalidPasswordException;
import com.justeam.justbuy.exception.NullParameterException;
import com.justeam.justbuy.utils.ChiaveBL;
import com.justeam.justbuy.utils.ChiaviErrore;
import com.justeam.justbuy.utils.ChiaviRegistrazione;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/registrati")
public class RegistrazioneServlet extends HttpServlet {


   @Override
   protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
      doPost(req, resp);
   }

   @Override
   protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
      try {
         BusinessLogic businessLogic = (BusinessLogic) getServletContext().getAttribute(ChiaveBL.BUSINESS_LOGIC);
         if (
               businessLogic.utenteCheckDataNascita(req.getParameter(ChiaviRegistrazione.DATA_NASCITA)) &&
               businessLogic.validaPassword(req.getParameter(ChiaviRegistrazione.PASSWORD)) &&
               businessLogic.validaEmail(req.getParameter(ChiaviRegistrazione.EMAIL))
         ) {
            businessLogic.utenteRegistra(req);
            req.setAttribute(ChiaviErrore.CHIAVE_LOGIN_ERROR, "Registrazione avvenuta con successo!");
            req.getRequestDispatcher("/JSP/pubblica/index.jsp").forward(req, resp);
         } else {
            req.setAttribute(ChiaviErrore.CHIAVE_NPE, "Il campo data non è valido");
            req.getRequestDispatcher("JSP/pubblica/registrati.jsp").forward(req, resp);
         }
      } catch (NullParameterException | InvalidPasswordException | InvalidEmailException e) {
         req.setAttribute(ChiaviErrore.CHIAVE_NPE, e.getMessage());
         req.getRequestDispatcher("JSP/pubblica/registrati.jsp").forward(req, resp);
      } catch (Exception e) {
         e.printStackTrace();
         req.getRequestDispatcher("/JSP/pubblica/errore.jsp").forward(req, resp);
      }
   }

}