package com.justeam.justbuy.dao;

import java.util.List;
import javax.persistence.EntityManager;
import com.justeam.justbuy.model.Carrello;

public class CarrelloDao implements DaoInterface<Carrello> {

	private EntityManager manager;

	public CarrelloDao(EntityManager manager) {
		this.manager = manager;
	}

	@Override
	public void create(Carrello ref) {
		manager.persist(ref);
	}

	@Override
	public List<Carrello> retrieveAll() {
		return manager.createQuery("SELECT c FROM Carrello c", Carrello.class).getResultList();
	}

	@Override
	public void update(Carrello ref) {
		manager.persist(ref);
	}

	@Override
	public void delete(Carrello ref) {
		manager.remove(ref);
	}

} 