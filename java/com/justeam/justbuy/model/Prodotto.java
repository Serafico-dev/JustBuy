package com.justeam.justbuy.model;

import java.util.ArrayList;
import java.util.List;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;

import org.hibernate.annotations.Type;

import com.justeam.justbuy.utils.Categoria;

@Entity
public class Prodotto {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	@Column(unique=true, nullable=false)
	private String nome;
	@Type(type="text")
	private String descrizione;
	@Column(nullable=false)
	private String immagine;
	@Column(nullable=false, columnDefinition="double unsigned")
	private Double prezzo;
	@Column(nullable=false, columnDefinition="int unsigned")
	private Integer quantita;
	@Column(nullable=false)
	@Enumerated(EnumType.STRING)
	private Categoria categoria;

	@ManyToMany
	@JoinTable(name="prodotto_carrello", joinColumns = @JoinColumn(name="prodotto_id"), inverseJoinColumns = @JoinColumn(name="carrello_id"))
	private List<Carrello> carrelli = new ArrayList<>();
	@ManyToMany
	@JoinTable(name="prodotto_ordine", joinColumns = @JoinColumn(name="prodotto_id"), inverseJoinColumns = @JoinColumn(name="ordine_id"))
	private List<Ordine> ordini = new ArrayList<>();

	public Prodotto() {
	}

	public Prodotto(String nome, String descrizione, String immagine, Double prezzo, Integer quantita,
			Categoria categoria) {
		this.nome = nome;
		this.descrizione = descrizione;
		this.immagine = immagine;
		this.prezzo = prezzo;
		this.quantita = quantita;
		this.categoria = categoria;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getDescrizione() {
		return descrizione;
	}

	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}

	public String getImmagine() {
		return immagine;
	}

	public void setImmagine(String immagine) {
		this.immagine = immagine;
	}

	public Double getPrezzo() {
		return prezzo;
	}

	public void setPrezzo(Double prezzo) {
		this.prezzo = prezzo;
	}

	public Integer getQuantita() {
		return quantita;
	}

	public void setQuantita(Integer quantita) {
		this.quantita = quantita;
	}

	public Categoria getCategoria() {
		return categoria;
	}

	public void setCategoria(Categoria categoria) {
		this.categoria = categoria;
	}

	public List<Carrello> getCarrelli() {
		return carrelli;
	}

	public void setCarrelli(List<Carrello> carrelli) {
		this.carrelli = carrelli;
	}

	public List<Ordine> getOrdini() {
		return ordini;
	}

	public void setOrdini(List<Ordine> ordini) {
		this.ordini = ordini;
	}

	@Override
	public String toString() {
		return "Prodotto [id=" + id + ", nome=" + nome + ", descrizione=" + descrizione + ", immagine=" + immagine
				+ ", prezzo=" + prezzo + ", quantita=" + quantita + ", categoria=" + categoria + "]";
	}

}