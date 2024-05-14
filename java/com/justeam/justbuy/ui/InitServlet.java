package com.justeam.justbuy.ui;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import com.justeam.justbuy.businesslogic.BusinessLogic;
import com.justeam.justbuy.dao.CarrelloDao;
import com.justeam.justbuy.dao.OrdineDao;
import com.justeam.justbuy.dao.ProdottoDao;
import com.justeam.justbuy.dao.RuoloDao;
import com.justeam.justbuy.dao.UtenteDao;
import com.justeam.justbuy.utils.ChiaveBL;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;

@WebServlet(value="/init", loadOnStartup = 1)
public class InitServlet extends HttpServlet {

	@Override
	public void init() throws ServletException {
		EntityManager manager = null;
		try {
			EntityManagerFactory factory = Persistence.createEntityManagerFactory("JustBuy");
			manager = factory.createEntityManager();
			CarrelloDao carrelloDao = new CarrelloDao(manager);
			OrdineDao ordineDao = new OrdineDao(manager);
			ProdottoDao prodottoDao = new ProdottoDao(manager);
			RuoloDao ruoloDao = new RuoloDao(manager);
			UtenteDao utenteDao = new UtenteDao(manager);
			BusinessLogic businessLogic = new BusinessLogic(manager, carrelloDao, ordineDao, prodottoDao, ruoloDao, utenteDao);	
			String filePath = "C:\\Users\\Giovanni\\eclipse-workspace\\JustBuy\\src\\main\\webapp\\MEDIA";		
			getServletContext().setAttribute(ChiaveBL.BUSINESS_LOGIC, businessLogic);
			getServletContext().setAttribute(ChiaveBL.FILE_PATH, filePath);
			businessLogic.init();
		} catch (Exception e) {
			e.printStackTrace();
			if (manager != null) {
				manager.close();
			}
			System.exit(0);
		}
	}
}