package com.justeam.justbuy.dao;

import java.util.List;
import javax.persistence.EntityManager;
import com.justeam.justbuy.model.Ruolo;

public class RuoloDao implements DaoInterface<Ruolo> {
	
	private EntityManager manager;
	
	public RuoloDao(EntityManager manager) {
		this.manager = manager;
	}

	@Override
	public void create(Ruolo ref) {
		manager.persist(ref);
	}

	@Override
	public List<Ruolo> retrieveAll() {
		return manager.createQuery("SELECT r FROM Ruolo r", Ruolo.class).getResultList();
	}
	
	public Ruolo retrieveBy(Integer id) {
		return manager.createQuery("SELECT r FROM Ruolo r WHERE r.id = :i", Ruolo.class).setParameter("i", id).getSingleResult();
	}

	@Override
	public void update(Ruolo ref) {
		manager.persist(ref);
	}

	@Override
	public void delete(Ruolo ref) {
		manager.remove(ref);
	}

}