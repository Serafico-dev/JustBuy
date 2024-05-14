package com.justeam.justbuy.dao;

import java.util.List;
import javax.persistence.EntityManager;
import com.justeam.justbuy.model.Utente;

public class UtenteDao implements DaoInterface<Utente>{

	private EntityManager manager;

	public UtenteDao(EntityManager manager) {
		this.manager = manager;
	}

	@Override
	public void create(Utente ref) {
		manager.persist(ref);
	}

	@Override
	public List<Utente> retrieveAll() {
		return manager.createQuery("SELECT u FROM Utente u", Utente.class).getResultList();
	}

	public Utente retrieveByMail(String email) {
		return manager.createQuery("SELECT u FROM Utente u WHERE u.email = :e", Utente.class).setParameter("e", email).getSingleResult();
	}
	
	public Utente retrieveBy(Integer id) {
		return manager.createQuery("SELECT u FROM Utente u WHERE u.id = :i", Utente.class).setParameter("i", id).getSingleResult();
	}

	@Override
	public void update(Utente ref) {
		manager.persist(ref);
	}

	@Override
	public void delete(Utente ref) {
		manager.remove(ref);
	}
}