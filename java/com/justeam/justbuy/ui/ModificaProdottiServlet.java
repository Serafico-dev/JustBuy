package com.justeam.justbuy.ui;

import java.io.File;
import java.io.IOException;
import com.justeam.justbuy.businesslogic.BusinessLogic;
import com.justeam.justbuy.utils.ChiaveBL;
import com.justeam.justbuy.utils.ChiaviFormHTML;
import com.justeam.justbuy.utils.ChiaviProdotto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/modificaProdotti")
@MultipartConfig(fileSizeThreshold = 1024 * 1024,maxFileSize = 1024 * 1024 * 10,maxRequestSize = 1024 * 1024 * 10 * 5)
public class ModificaProdottiServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		try {
			
			//String uploadPath = getServletContext().getAttribute(ChiaveBL.FILE_PATH) + File.separator + ChiaviFormHTML.UPLOAD_DIRECTORY;
			String uploadPath = getServletContext().getAttribute(ChiaveBL.FILE_PATH) + File.separator + ChiaviFormHTML.UPLOAD_DIRECTORY;
			File uploadDir = new File(uploadPath);
			if (!uploadDir.exists()) {
				uploadDir.mkdir();
			}

			String filePath = null;
			String path = "";
			for ( Part part : req.getParts() ) {
				String fileName = part.getSubmittedFileName();
				if ( fileName!=null && !fileName.isEmpty() ) {
					filePath = uploadPath + File.separator + fileName;
					part.write(filePath);
					path = File.separator + ChiaviFormHTML.UPLOAD_DIRECTORY + File.separator + fileName;
				}
			}
			
			BusinessLogic businessLogic = (BusinessLogic) getServletContext().getAttribute(ChiaveBL.BUSINESS_LOGIC);
			businessLogic.prodottoModifica(Integer.parseInt(req.getParameter(ChiaviProdotto.OPERAZIONI_PRODOTTI)), req, path);
			
			req.setAttribute(ChiaviProdotto.STATUS_OPERAZIONE, "Modifica avvenuta con successo!");
			req.getRequestDispatcher("/JSP/admin/prodotti.jsp").forward(req, resp);
		} catch (Exception e) {
			e.printStackTrace();
			req.getRequestDispatcher("/JSP/pubblica/errore.jsp").forward(req, resp);
		}
	}

}