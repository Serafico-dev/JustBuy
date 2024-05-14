package com.justeam.justbuy.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;

import javassist.expr.NewArray;

@Entity
public class Ordine {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	private Date data;
	private Double prezzoTotale;
	
	@ManyToOne
	private Utente utente;
	@ManyToMany(mappedBy="ordini")
	private List<Prodotto> prodotti = new ArrayList<>();

	public Ordine() {
	}

	public Ordine(Date data, Double prezzoTotale) {
		this.data = data;
		this.prezzoTotale = prezzoTotale;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Date getData() {
		return data;
	}

	public void setData(Date data) {
		this.data = data;
	}

	public Double getPrezzoTotale() {
		return prezzoTotale;
	}

	public void setPrezzoTotale(Double prezzoTotale) {
		this.prezzoTotale = prezzoTotale;
	}

	public Utente getUtente() {
		return utente;
	}

	public void setUtente(Utente utente) {
		this.utente = utente;
	}

	public List<Prodotto> getProdotti() {
		return prodotti;
	}

	public void setProdotti(List<Prodotto> prodotti) {
		this.prodotti = prodotti;
	}

	@Override
	public String toString() {
		return "Ordine [id=" + id + ", data=" + data + ", prezzoTotale=" + prezzoTotale + "]";
	}

}