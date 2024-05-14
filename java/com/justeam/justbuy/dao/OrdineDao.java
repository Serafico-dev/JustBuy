package com.justeam.justbuy.dao;

import java.util.Date;
import java.util.List;
import javax.persistence.EntityManager;
import com.justeam.justbuy.model.Ordine;

public class OrdineDao implements DaoInterface<Ordine> {

	private EntityManager manager;

	public OrdineDao(EntityManager manager) {
		this.manager = manager;
	}

	@Override
	public void create(Ordine ref) {
		manager.persist(ref);
	}

	@Override
	public List<Ordine> retrieveAll() {
		return manager.createQuery("SELECT o FROM Ordine o", Ordine.class).getResultList();
	}

	public List<Ordine> retrieveBy(Date data){
		return manager.createQuery("SELECT o FROM Ordine o WHERE o.data = :d", Ordine.class).setParameter("d", data).getResultList();
	}

	public List<Ordine> retrieveBy(Integer id){
		return manager.createQuery("SELECT o FROM Ordine o WHERE o.id = :i", Ordine.class).setParameter("i", id).getResultList();
	}

	@Override
	public void update(Ordine ref) {
		manager.persist(ref);
	}

	@Override
	public void delete(Ordine ref) {
		manager.remove(ref);
	}

}