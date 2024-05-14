package com.justeam.justbuy.dao;

import java.util.List;
import javax.persistence.EntityManager;
import com.justeam.justbuy.model.Prodotto;
import com.justeam.justbuy.utils.Categoria;

public class ProdottoDao implements DaoInterface<Prodotto>{

	private EntityManager manager;

	public ProdottoDao(EntityManager manager) {
		this.manager = manager;
	}

	@Override
	public void create(Prodotto ref) {
		manager.persist(ref);
	}

	@Override
	public List<Prodotto> retrieveAll() {
		return manager.createQuery("SELECT p FROM Prodotto p", Prodotto.class).getResultList();
	}

	public List<Prodotto> retrieveBy(String nome) {
		return manager.createQuery("SELECT p FROM Prodotto p WHERE p.nome LIKE:n", Prodotto.class).setParameter("n", nome).getResultList();
	}
	
	public List<Prodotto> retrieveByUguale(String nome) {
		return manager.createQuery("SELECT p FROM Prodotto p WHERE p.nome = :n", Prodotto.class).setParameter("n", nome).getResultList();
	}

	public List<Prodotto> retrieveBy(Categoria categoria) {
		return manager.createQuery("SELECT p FROM Prodotto p WHERE p.categoria = :c", Prodotto.class).setParameter("c", categoria).getResultList();
	}

	public Prodotto retrieveBy(Integer id) {
		return manager.createQuery("SELECT p FROM Prodotto p WHERE p.id = :i", Prodotto.class).setParameter("i", id).getSingleResult();
	}

	public List<Prodotto> retrieveByMin(Double prezzo) {
		return manager.createQuery("SELECT p FROM Prodotto p WHERE p.prezzo >=:p", Prodotto.class).setParameter("p", prezzo).getResultList();
	}

	public List<Prodotto> retrieveByMax(Double prezzo) {
		return manager.createQuery("SELECT p FROM Prodotto p WHERE p.prezzo <=:p", Prodotto.class).setParameter("p", prezzo).getResultList();
	}
	
	public List<Prodotto> retrieveByDesc(int limite){
		return manager.createQuery("Select p from Prodotto p order by p.id desc" ,Prodotto.class).setMaxResults(limite).getResultList();
	}

	public List<Prodotto> retrieveByFiltro(Double prezzoMin, Double prezzoMax, String nome){
		return manager.createQuery("Select p from Prodotto p Where p.prezzo >= :min AND p.prezzo <= :max AND p.quantita > 0 AND p.nome LIKE:n" ,Prodotto.class)
				.setParameter("min", prezzoMin).setParameter("max", prezzoMax)
				.setParameter("n", nome).getResultList();
	}
	
	public List<Prodotto> retrieveByFiltroFalse(Double prezzoMin, Double prezzoMax, String nome){
		return manager.createQuery("Select p from Prodotto p Where p.prezzo >= :min AND p.prezzo <= :max AND p.nome LIKE:n" ,Prodotto.class)
				.setParameter("min", prezzoMin).setParameter("max", prezzoMax)
				.setParameter("n", nome).getResultList();
	}
	
	@Override
	public void update(Prodotto ref) {
		manager.persist(ref);
	}

	@Override
	public void delete(Prodotto ref) {
		manager.remove(ref);
	}

}