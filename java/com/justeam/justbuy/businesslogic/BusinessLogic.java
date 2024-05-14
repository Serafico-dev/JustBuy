package com.justeam.justbuy.businesslogic;

import java.time.LocalDate;
import java.time.Period;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import org.mindrot.jbcrypt.BCrypt;
import com.justeam.justbuy.dao.CarrelloDao;
import com.justeam.justbuy.dao.OrdineDao;
import com.justeam.justbuy.dao.ProdottoDao;
import com.justeam.justbuy.dao.RuoloDao;
import com.justeam.justbuy.dao.UtenteDao;
import com.justeam.justbuy.exception.InvalidEmailException;
import com.justeam.justbuy.exception.InvalidPasswordException;
import com.justeam.justbuy.exception.NullParameterException;
import com.justeam.justbuy.model.Carrello;
import com.justeam.justbuy.model.Ordine;
import com.justeam.justbuy.model.Prodotto;
import com.justeam.justbuy.model.Ruolo;
import com.justeam.justbuy.model.Utente;
import com.justeam.justbuy.utils.Categoria;
import com.justeam.justbuy.utils.ChiaviProdotto;
import com.justeam.justbuy.utils.ChiaviRegistrazione;

import jakarta.servlet.http.HttpServletRequest;

public class BusinessLogic {

	private EntityManager manager;
	private CarrelloDao carrelloDao;
	private OrdineDao ordineDao;
	private ProdottoDao prodottoDao;
	private RuoloDao ruoloDao;
	private UtenteDao utenteDao;

	public BusinessLogic(
			EntityManager manager,
			CarrelloDao carrelloDao,
			OrdineDao ordineDao,
			ProdottoDao prodottoDao,
			RuoloDao ruoloDao,
			UtenteDao utenteDao
			) {
		this.manager = manager;
		this.carrelloDao = carrelloDao;
		this.ordineDao = ordineDao;
		this.prodottoDao = prodottoDao;
		this.ruoloDao = ruoloDao;
		this.utenteDao = utenteDao;
	}

	//CARRELLO BUSINESS LOGIC

	public void carrelloCreate(Carrello carrello) {
		try {
			manager.getTransaction().begin();
			carrelloDao.create(carrello);
			manager.getTransaction().commit();
		} catch (Exception e) {
			manager.getTransaction().rollback();
			e.printStackTrace();
			throw e;
		}
	}

	public List<Carrello> carrelloRetrieveAll() {
		try {
			manager.getTransaction().begin();
			List<Carrello> listaCarrelli = carrelloDao.retrieveAll();
			manager.getTransaction().commit();
			return listaCarrelli;
		} catch (Exception e) {
			manager.getTransaction().rollback();
			e.printStackTrace();
			throw e;
		}
	}

	public void carrelloUpdate(Carrello carrello) {
		try {
			manager.getTransaction().begin();
			carrelloDao.update(carrello);
			manager.getTransaction().commit();
		} catch (Exception e) {
			manager.getTransaction().rollback();
			e.printStackTrace();
			throw e;
		}
	}

	public void carrelloAggiungiProdotto(Carrello carrello, Prodotto prodotto) {
		try {
			manager.getTransaction().begin();
			carrello.getProdotti().add(prodotto);
			prodotto.getCarrelli().add(carrello);
			carrelloDao.update(carrello);
			manager.getTransaction().commit();
		} catch (Exception e) {
			manager.getTransaction().rollback();
			e.printStackTrace();
			throw e;
		}
	}

	public void carrelloRimuoviProdotto(Integer id, Carrello carrello) {
		try {
			manager.getTransaction().begin();
			Prodotto prodotto = prodottoDao.retrieveBy(id);
			carrello.getProdotti().remove(prodotto);
			prodotto.getCarrelli().remove(carrello);
			carrelloDao.update(carrello);
			manager.getTransaction().commit();
		} catch (Exception e) {
			manager.getTransaction().rollback();
			e.printStackTrace();
			throw e;
		}
	}

	public void carrelloSvuotaCarrello(Carrello carrello, List<Prodotto> listaProdotti) {
		try {
			manager.getTransaction().begin();
			carrello.setProdotti(new ArrayList<>());
			for (Prodotto p : listaProdotti) {
				p.getCarrelli().remove(carrello);
			}
			carrelloDao.update(carrello);
			manager.getTransaction().commit();
		} catch(Exception e) {
			manager.getTransaction().rollback();
			e.printStackTrace();
			throw e;
		}
	}

	public void carrelloDelete(Carrello carrello) {
		try {
			manager.getTransaction().begin();
			carrelloDao.delete(carrello);
			manager.getTransaction().commit();
		} catch (Exception e) {
			manager.getTransaction().rollback();
			e.printStackTrace();
			throw e;
		}
	}

	// ORDINE BUSINESS LOGIC

	public void ordineCrea(Ordine ordine, Carrello carrello, List<Prodotto> listaProdotti) {
		try {
			manager.getTransaction().begin();
			ordineDao.create(ordine);
			carrello.setProdotti(new ArrayList<>());
			for (Prodotto p : listaProdotti) {
				p.getCarrelli().remove(carrello);
			}
			carrelloDao.update(carrello);
			manager.getTransaction().commit();
		} catch (Exception e) {
			manager.getTransaction().rollback();
			e.printStackTrace();
			throw e;
		}
	}

	public List<Ordine> ordineRetrieveAll() {
		try {
			manager.getTransaction().begin();
			List<Ordine> listaOrdini = ordineDao.retrieveAll();
			manager.getTransaction().commit();
			return listaOrdini;
		} catch (Exception e) {
			manager.getTransaction().rollback();
			e.printStackTrace();
			throw e;
		}
	}

	public List<Ordine> ordineRetrieveBy(Date data) {
		try {
			manager.getTransaction().begin();
			List<Ordine> listaOrdini = ordineDao.retrieveBy(data);
			manager.getTransaction().commit();
			return listaOrdini;
		} catch (Exception e) {
			manager.getTransaction().rollback();
			e.printStackTrace();
			throw e;
		}
	}

	public List<Ordine> ordineRetrieveBy(Integer id) {
		try {
			manager.getTransaction().begin();
			List<Ordine> listaOrdini = ordineDao.retrieveBy(id);
			manager.getTransaction().commit();
			return listaOrdini;
		} catch (Exception e) {
			manager.getTransaction().rollback();
			e.printStackTrace();
			throw e;
		}
	}

	// PRODOTTO BUSINESS LOGIC

	public boolean prodottoCreate(Prodotto prodotto) {
		try {	
			if (prodottoRetrieveByUguale(prodotto.getNome()).isEmpty()) {
				manager.getTransaction().begin();
				prodottoDao.create(prodotto);
				manager.getTransaction().commit();
				return true;
			} 
			return false;
		} catch (Exception e) {
			manager.getTransaction().rollback();
			e.printStackTrace();
			throw e;
		}
	}

	public List<Prodotto> prodottoRetrieveAll() {
		try {
			manager.getTransaction().begin();
			List<Prodotto> listaProdotti = prodottoDao.retrieveAll();
			manager.getTransaction().commit();
			return listaProdotti;
		} catch (Exception e) {
			manager.getTransaction().rollback();
			e.printStackTrace();
			throw e;
		}
	}

	public List<Prodotto> prodottoRetrieveBy(String nome) {
		try {
			manager.getTransaction().begin();
			List<Prodotto> listaProdotti = prodottoDao.retrieveBy("%" + nome + "%");
			manager.getTransaction().commit();
			return listaProdotti;
		} catch (Exception e) {
			manager.getTransaction().rollback();
			e.printStackTrace();
			throw e;
		}
	}

	public List<Prodotto> prodottoRetrieveByUguale(String nome) {
		try {
			manager.getTransaction().begin();
			List<Prodotto> listaProdotti = prodottoDao.retrieveByUguale(nome);
			manager.getTransaction().commit();
			return listaProdotti;
		} catch (Exception e) {
			manager.getTransaction().rollback();
			e.printStackTrace();
			throw e;
		}
	}

	public Prodotto prodottoRetrieveBy(Integer id) {
		try {
			manager.getTransaction().begin();
			Prodotto prodotto = prodottoDao.retrieveBy(id);
			manager.getTransaction().commit();
			return prodotto;
		} catch (Exception e) {
			manager.getTransaction().rollback();
			e.printStackTrace();
			throw e;
		}
	}

	public List<Prodotto> prodottoRetrieveBy(Categoria categoria) {
		try {
			manager.getTransaction().begin();
			List<Prodotto> listaProdotti = prodottoDao.retrieveBy(categoria);
			manager.getTransaction().commit();
			return listaProdotti;
		} catch (Exception e) {
			manager.getTransaction().rollback();
			e.printStackTrace();
			throw e;
		}
	}

	public List<Prodotto> prodottoRetrieveByMax(Double prezzo) {
		try {
			manager.getTransaction().begin();
			List<Prodotto> listaProdotti = prodottoDao.retrieveByMax(prezzo);
			manager.getTransaction().commit();
			return listaProdotti;
		} catch (Exception e) {
			manager.getTransaction().rollback();
			e.printStackTrace();
			throw e;
		}
	}

	public List<Prodotto> prodottoRetrieveByMin(Double prezzo) {
		try {
			manager.getTransaction().begin();
			List<Prodotto> listaProdotti = prodottoDao.retrieveByMin(prezzo);
			manager.getTransaction().commit();
			return listaProdotti;
		} catch (Exception e) {
			manager.getTransaction().rollback();
			e.printStackTrace();
			throw e;
		}
	}

	public List<Prodotto> prodottoRetrieveByDesc(int limite){
		try {
			manager.getTransaction().begin();
			List<Prodotto> listaProdotti = prodottoDao.retrieveByDesc(limite);
			manager.getTransaction().commit();
			return listaProdotti;
		} catch (Exception e) {
			manager.getTransaction().rollback();
			e.printStackTrace();
			throw e;
		}
	}

	public void prodottoModifica(Integer id, HttpServletRequest req, String path) {
		try {
			manager.getTransaction().begin();
			Prodotto prodotto = prodottoDao.retrieveBy(id);
			prodottoUpdateProdotto(
					prodotto,
					req.getParameter(ChiaviProdotto.NOME_PRODOTTO),
					req.getParameter(ChiaviProdotto.DESCRIZIONE),
					path,
					req.getParameter(ChiaviProdotto.PREZZO),
					req.getParameter(ChiaviProdotto.QUANTITA),
					req.getParameter(ChiaviProdotto.CATEGORIA)
					);

			manager.getTransaction().commit();
		} catch (Exception e) {
			manager.getTransaction().rollback();
			e.printStackTrace();
			throw e;
		}
	}

	public List<Prodotto> RetrieveByFiltro (Double prezzoMin, Double prezzoMax, Categoria categoria, boolean disponibile, String nome){
		try {
			manager.getTransaction().begin();
			if(nome == null) {
				nome = "";
			}
			List<Prodotto> listaProdotti = new ArrayList<Prodotto>();
			List<Prodotto> listaProdottiFiltrata = new ArrayList<Prodotto>();
			if(disponibile) {
				listaProdotti = prodottoDao.retrieveByFiltro(prezzoMin, prezzoMax, "%" + nome + "%");
			}
			else {
				listaProdotti = prodottoDao.retrieveByFiltroFalse(prezzoMin, prezzoMax, "%" + nome + "%");
			}
			if (categoria == null) {
				listaProdottiFiltrata = listaProdotti;
			} else {
				for (Prodotto p : listaProdotti) {
					if (p.getCategoria() == categoria) {
						listaProdottiFiltrata.add(p);
					}
				}
			}
			manager.getTransaction().commit();
			return listaProdottiFiltrata;
		} catch (Exception e) {
			manager.getTransaction().rollback();
			e.printStackTrace();
			throw e;
		}
	}

	public void prodottoUpdate(Prodotto prodotto) {
		try {
			manager.getTransaction().begin();
			prodottoDao.update(prodotto);
			manager.getTransaction().commit();
		} catch (Exception e) {
			manager.getTransaction().rollback();
			e.printStackTrace();
			throw e;
		}
	}

	public void prodottoUpdateNome(Prodotto prodotto, String nome) {
		prodotto.setNome(nome);
		prodottoDao.update(prodotto);
	}

	public void prodottoUpdateDesc(Prodotto prodotto, String desc) {
		prodotto.setDescrizione(desc);
		prodottoDao.update(prodotto);
	}

	public void prodottoUpdateImgPath(Prodotto prodotto, String path) {
		prodotto.setImmagine(path);
		prodottoDao.update(prodotto);
	}

	public void prodottoUpdatePrezzo(Prodotto prodotto, Double prezzo) {
		prodotto.setPrezzo(prezzo);
		prodottoDao.update(prodotto);
	}

	public void prodottoUpdateQuantita(Prodotto prodotto, Integer quantita) {
		prodotto.setQuantita(quantita);
		prodottoDao.update(prodotto);
	}

	public void prodottoUpdateCategoria(Prodotto prodotto, Categoria categoria) {
		prodotto.setCategoria(categoria);
		prodottoDao.update(prodotto);
	}

	public void prodottoUpdateProdotto(Prodotto prodotto, String nome, String descrizione, String immagine, String prezzo, String quantita, String categoria) {
		if (!nome.equals("")) {
			prodottoUpdateNome(prodotto, nome);
		}
		if (!descrizione.equals("")) {
			prodottoUpdateDesc(prodotto, descrizione);
		}
		if (!immagine.equals("")) {
			prodottoUpdateImgPath(prodotto, immagine);
		}
		if (!prezzo.equals("")) {
			if (Double.parseDouble(prezzo) >= 0) {
				prodottoUpdatePrezzo(prodotto, Double.parseDouble(prezzo));
			}
		}
		if (!quantita.equals("")) {
			if (Integer.parseInt(quantita) >= 0) {
				prodottoUpdateQuantita(prodotto, Integer.parseInt(quantita));
			}	
		}
		if (categoria != null) {
			prodottoUpdateCategoria(prodotto, Categoria.valueOf(categoria));
		}
	}

	public void prodottoElimina(Integer id) {
		try {
			manager.getTransaction().begin();
			Prodotto prodotto = prodottoDao.retrieveBy(id);
			for (Carrello c : prodotto.getCarrelli()) {
				c.getProdotti().remove(prodotto);
			}
			prodottoDao.delete(prodotto);
			manager.getTransaction().commit();
		} catch (Exception e) {
			manager.getTransaction().rollback();
			e.printStackTrace();
			throw e;
		}
	}

	public void prodottoDelete(Prodotto prodotto) {
		try {
			manager.getTransaction().begin();
			prodottoDao.delete(prodotto);
			manager.getTransaction().commit();
		} catch (Exception e) {
			manager.getTransaction().rollback();
			e.printStackTrace();
			throw e;
		}
	}

	private boolean prodottoCheckParamNonNull(Prodotto prodotto) {
		return prodotto.getNome() != null && prodotto.getImmagine() != null && !prodotto.getNome().equals("") && !prodotto.getImmagine().equals("");
	}

	private boolean prodottoCheckNumeriPositivi(Prodotto prodotto) {
		return prodotto.getPrezzo() >= 0 && prodotto.getQuantita() >= 0;
	}

	public boolean prodottoCheckNumeri (String prezzo, String quantita) {
		return !prezzo.equals("") && !quantita.equals("");
	}

	public boolean prodottoCheckParametri(Prodotto prodotto) {
		return prodottoCheckParamNonNull(prodotto) && prodottoCheckNumeriPositivi(prodotto);
	}

	// RUOLO BUSINESS LOGIC

	public void ruoloCreate(Ruolo ruolo) {
		try {
			manager.getTransaction().begin();
			ruoloDao.create(ruolo);
			manager.getTransaction().commit();
		} catch (Exception e) {
			manager.getTransaction().rollback();
			e.printStackTrace();
			throw e;
		}
	}

	public List<Ruolo> ruoloRetrieveAll() {
		try {
			manager.getTransaction().begin();
			List<Ruolo> listaRuoli = ruoloDao.retrieveAll();
			manager.getTransaction().commit();
			return listaRuoli;
		} catch (Exception e) {
			manager.getTransaction().rollback();
			e.printStackTrace();
			throw e;
		}
	}

	public Ruolo ruoloRetrieveBy(Integer id) {
		try {
			manager.getTransaction().begin();
			Ruolo ruolo = ruoloDao.retrieveBy(id);
			manager.getTransaction().commit();
			return ruolo;
		} catch (Exception e) {
			manager.getTransaction().rollback();
			e.printStackTrace();
			throw e;
		}
	}

	public void ruoloUpdate(Ruolo ruolo) {
		try {
			manager.getTransaction().begin();
			ruoloDao.update(ruolo);
			manager.getTransaction().commit();
		} catch (Exception e) {
			manager.getTransaction().rollback();
			e.printStackTrace();
			throw e;
		}
	}

	public void ruoloDelete(Ruolo ruolo) {
		try {
			manager.getTransaction().begin();
			ruoloDao.delete(ruolo);
			manager.getTransaction().commit();
		} catch (Exception e) {
			manager.getTransaction().rollback();
			e.printStackTrace();
			throw e;
		}
	}

	// UTENTE BUSINESS LOGIC

	public void utenteCreate(Utente utente) {
		try {
			if (utenteParamNonNull(utente) && !utentePresente(utente))
			{
				utenteDao.create(utente);
			} 
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	public void utenteRegistra(HttpServletRequest req) {
		try {
			manager.getTransaction().begin();
			Ruolo ruolo = ruoloDao.retrieveBy(2);

			Utente utente = new Utente(
					req.getParameter(ChiaviRegistrazione.EMAIL),
					BCrypt.hashpw(req.getParameter(ChiaviRegistrazione.PASSWORD), BCrypt.gensalt()),
					req.getParameter(ChiaviRegistrazione.NOME),
					req.getParameter(ChiaviRegistrazione.COGNOME),
					LocalDate.parse(req.getParameter(ChiaviRegistrazione.DATA_NASCITA)),
					req.getParameter(ChiaviRegistrazione.INDIRIZZO),
					req.getParameter(ChiaviRegistrazione.INDIRIZZO),
					ruolo
					);

			Carrello carrello = new Carrello();
			carrelloDao.create(carrello);
			utente.setCarrello(carrello);
			if (utenteParamNonNull(utente) && !utentePresente(utente))
			{
				utenteCreate(utente);
			}

			manager.getTransaction().commit();
		} catch (Exception e) {
			manager.getTransaction().rollback();
			e.printStackTrace();
			throw e;
		}
	}

	public List<Utente> utenteRetrieveAll() {
		try {
			manager.getTransaction().begin();
			List<Utente> listaUtenti = utenteDao.retrieveAll();
			manager.getTransaction().commit();
			return listaUtenti;
		} catch (Exception e) {
			manager.getTransaction().rollback();
			e.printStackTrace();
			throw e;
		}
	}

	public Utente utenteRetrieveByMail (String email) {
		try {
			return utenteDao.retrieveByMail(email);
		} catch (NoResultException e) {
			throw e;
		}		
	}

	public Utente utenteRetrieveBy (Integer id) {
		try {
			manager.getTransaction().begin();
			Utente utente = utenteDao.retrieveBy(id);
			manager.getTransaction().commit();
			return utente;
		} catch (Exception e) {
			manager.getTransaction().rollback();
			e.printStackTrace();
			throw e;
		}
	}

	public void utenteDelete(Integer id) {
		try {
			manager.getTransaction().begin();
			Utente utente = utenteDao.retrieveBy(id);
			Ruolo ruolo = ruoloDao.retrieveBy(2);
			utente.setEmail(utente.getId() + "disabled");
			utente.setPassword("");
			utente.setDataNascita(LocalDate.of(1970, 1, 1));
			utente.setIndirizzoResidenza("");
			utente.setIndirizzoSpedizione("");
			utente.setRuolo(ruolo);
			utenteDao.update(utente);
			manager.getTransaction().commit();
		} catch (Exception e) {
			manager.getTransaction().rollback();
			e.printStackTrace();
			throw e;
		}
	}

	public boolean utenteParamNonNull(Utente utente) {
		String[] paramUtente = {
				utente.getNome(),
				utente.getCognome(),
				utente.getEmail(),
				utente.getPassword(),
				utente.getIndirizzoResidenza()
		};
		int i = 0;
		String cause = "";
		for(String param : paramUtente) {
			if (param.equals("")) {
				switch(i) {
				case 0: {
					cause = "nome";
					break;
				}
				case 1: {
					cause = "cognome";
					break;
				}
				case 2: {
					cause = "email";
					break;
				}
				case 3: {
					cause = "password";
					break;
				}
				case 4: {
					cause = "indirizzo";
					break;
				}
				}

				throw new NullParameterException("Il campo " + cause + " è vuoto");
			}
			i++;
		}
		return true;
	}

	public boolean utentePresente(Utente utente) {
		try {
			utenteDao.retrieveByMail(utente.getEmail());
			return true;
		} catch (NoResultException e) {
			return false;
		}
	}

	public boolean utenteCheckDataNascita(String data) {
		boolean stringaVuota = !data.equals("");
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		LocalDate dataDiNascita = LocalDate.parse(data, formatter);
		LocalDate oggi = LocalDate.now();
		Period period = Period.between(dataDiNascita, oggi);
		boolean maggiorenne = period.getYears() > 18;
		boolean ancoraVivo = period.getYears() < 100;
		return stringaVuota && maggiorenne && ancoraVivo;
	}

	public boolean utenteCheckLogin (String email, String password) {
		try {
			Utente utente = utenteDao.retrieveByMail(email);
			if (utente.getId() == 1) {
				return password.equals(utente.getPassword());
			}
			return BCrypt.checkpw(password, utente.getPassword());
		} catch (NoResultException e) {
			return false;
		}
	}
	
	public void utentePromuovi(Integer id) {
		try {
			manager.getTransaction().begin();
			Utente utente = utenteDao.retrieveBy(id);
			Ruolo ruolo = ruoloDao.retrieveBy(1);
			utente.setRuolo(ruolo);
			utenteDao.update(utente);
			manager.getTransaction().commit();
		} catch (Exception e) {
			manager.getTransaction().rollback();
			e.printStackTrace();
			throw e;
		}
	}
	
	public void utenteRetrocedi(Integer id) {
		try {
			manager.getTransaction().begin();
			Utente utente = utenteDao.retrieveBy(id);
			Ruolo ruolo = ruoloDao.retrieveBy(2);
			utente.setRuolo(ruolo);
			utenteDao.update(utente);
			manager.getTransaction().commit();
		} catch (Exception e) {
			manager.getTransaction().rollback();
			e.printStackTrace();
			throw e;
		}
	}

	// INIT SERVLET
	public void init() {
		try {
			manager.getTransaction().begin();
			List<Utente> listaUtenti = utenteDao.retrieveAll();

			if (listaUtenti.isEmpty()) {
				Ruolo ruoloAdmin = new Ruolo("admin");
				Ruolo ruoloUser = new Ruolo("user");
				ruoloDao.create(ruoloAdmin);
				ruoloDao.create(ruoloUser);
				Utente utenteAdmin = new Utente(
						"justbuy@justmail.com",
						"admin",
						"Robarco",
						"Pallastoro",
						LocalDate.parse("1970-01-01"),
						"Via Java 1, Hibernate",
						"Via Scrum 1, Agile",
						ruoloAdmin
						);
				Carrello carrello = new Carrello();
				carrelloDao.create(carrello);
				utenteAdmin.setCarrello(carrello);
				if (utenteParamNonNull(utenteAdmin) && !utentePresente(utenteAdmin))
				{
					utenteDao.create(utenteAdmin);
				}
			}
			manager.getTransaction().commit();
		} catch (Exception e) {
			manager.getTransaction().rollback();
			e.printStackTrace();
			throw e;
		}
	}
	
	// REGEX PWD EMAIL
	   public boolean validaPassword(String password) {
//	     ^                 # start-of-string
//	     (?=.*[0-9])       # a digit must occur at least once
//	     (?=.*[a-z])       # a lower case letter must occur at least once
//	     (?=.*[A-Z])       # an upper case letter must occur at least once
//	     (?=.*[@#$%^&+=])  # a special character must occur at least once
//	     (?=\S+$)          # no whitespace allowed in the entire string
//	     .{8,}             # anything, at least eight places though
//	     $                 # end-of-string
	      String pattern = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=])(?=\\S+$).{8,}$";
	      if (password.matches(pattern)) {
	         return true;
	      } else {
	         throw new InvalidPasswordException("La password deve avere almeno 8 caratteri e deve contere almeno un carattere maiuscolo, un numero e un carattere speciale (@#$%^&+=)");
	      }
	   }


	   public boolean validaEmail(String email) {
	      String pattern = "^[a-zA-Z0-9_!#$%&’*+/=?`{|}~^.-]+@[a-zA-Z0-9.-]+$";
	      if (email.matches(pattern)) {
	         return true;
	      } else {
	         throw new InvalidEmailException("Indirizzo email non valido");
	      }
	   }

}