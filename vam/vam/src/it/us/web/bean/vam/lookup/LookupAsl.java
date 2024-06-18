package it.us.web.bean.vam.lookup;

import it.us.web.bean.BUtente;
import it.us.web.bean.remoteBean.ProprietarioCane;
import it.us.web.bean.remoteBean.ProprietarioGatto;
import it.us.web.bean.vam.Accettazione;
import it.us.web.bean.vam.Clinica;
import it.us.web.util.vam.ComparatorUtenti;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Enumeration;
import java.util.HashSet;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.Set;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;

import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.hibernate.annotations.OrderBy;
import org.hibernate.annotations.Where;
import org.hibernate.validator.constraints.Length;

@Entity
@Table(name = "lookup_asl", schema = "public")
@Where( clause = "enabled" )
public class LookupAsl implements java.io.Serializable
{
	private static final long serialVersionUID = 4228259336170709625L;
	
	private int id;
	private String description;
	private Integer level;
	private Boolean enabled;
	private Set<Accettazione> accettaziones = new HashSet<Accettazione>(0);
	private Set<Clinica> clinicas = new HashSet<Clinica>(0);
	private Set<ProprietarioCane>  proprietariCane  = new HashSet<ProprietarioCane>(0);
	private Set<ProprietarioGatto> proprietariGatto = new HashSet<ProprietarioGatto>(0);
	private Set<LookupPersonaleInterno> personaleInterno = new HashSet<LookupPersonaleInterno>(0);
	private Set<BUtente> referentes = new HashSet<BUtente>(0);
	
	public LookupAsl()
	{
		
	}

	@Transient
	public ArrayList<BUtente> getUtenti()
	{
		ArrayList<BUtente> ret = new ArrayList<BUtente>();
		Iterator<Clinica> cliniche = this.getClinicas().iterator();

		while( cliniche.hasNext() )
		{
			Clinica clinicaTemp = cliniche.next();
			Iterator<BUtente> utentiTemp = clinicaTemp.getUtentis().iterator();
			while( utentiTemp.hasNext() )
			{
				BUtente utenteTemp = utentiTemp.next();
				if(utenteTemp.getEnabled())
					ret.add(utenteTemp);
			}
		}
		
		return ret;
	}
	
	@Transient
	public ArrayList<BUtente> getUtentiDistinct()
	{
		ArrayList<BUtente> ret = new ArrayList<BUtente>();
		
		Hashtable<Integer, BUtente> temp = new Hashtable<Integer, BUtente>();
		Hashtable<String, String> nominativi = new Hashtable<String, String>();
		for( Clinica clinica: clinicas )
		{
			for( BUtente utente: clinica.getUtentis() )
			{
				if(utente!=null && utente.getSuperutente()!=null)
				{
					if(utente.getEnabled() && temp.get(utente.getSuperutente().getId())==null && nominativi.get(utente.toString().toUpperCase())==null)
					{
						temp.put( new Integer( utente.getSuperutente().getId() ), utente );
						nominativi.put(utente.toString().toUpperCase(), utente.toString().toUpperCase());
					}
				}
			}
		}
		Enumeration<BUtente> e = temp.elements();
		
		while( e.hasMoreElements() )
		{
			ret.add( e.nextElement() );
		}
		
		Collections.sort(ret, new ComparatorUtenti());
		
		return ret;
	}
	
	@Id
	@GeneratedValue( strategy = GenerationType.IDENTITY )
	@Column(name = "id", unique = true, nullable = false)
	@NotNull
	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	@Column(name = "description", length = 64)
	@Length(max = 64)
	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	@Column(name = "level")
	public Integer getLevel() {
		return this.level;
	}

	public void setLevel(Integer level) {
		this.level = level;
	}

	@Column(name = "enabled")
	public Boolean getEnabled() {
		return this.enabled;
	}

	public void setEnabled(Boolean enabled) {
		this.enabled = enabled;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "richiedenteAsl")
	@Where( clause = "trashed_date is null" )
	public Set<Accettazione> getAccettaziones() {
		return this.accettaziones;
	}

	public void setAccettaziones(Set<Accettazione> accettaziones) {
		this.accettaziones = accettaziones;
	}

	@OneToMany(fetch = FetchType.EAGER, mappedBy = "lookupAsl")
	@Where( clause = "trashed_date is null" )
	@Fetch (FetchMode.SELECT) 
	public Set<Clinica> getClinicas() {
		return this.clinicas;
	}

	public void setClinicas(Set<Clinica> clinicas) {
		this.clinicas = clinicas;
	}
	
	@Override
	public String toString()
	{
		return description;
	}
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "asl")
	@Where( clause = "trashed_date is null" )
	public Set<ProprietarioCane> getProprietariCane() {
		return this.proprietariCane;
	}

	public void setProprietariCane(Set<ProprietarioCane> proprietariCane) {
		this.proprietariCane = proprietariCane;
	}
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "asl")
	@Where( clause = "trashed_date is null" )
	public Set<ProprietarioGatto> getProprietariGatto() {
		return this.proprietariGatto;
	}

	public void setProprietariGatto(Set<ProprietarioGatto> proprietariGatto) {
		this.proprietariGatto = proprietariGatto;
	}
	
	
	@OneToMany(fetch = FetchType.EAGER, mappedBy = "asl")
	@OrderBy(clause="nominativo")
	@Fetch (FetchMode.SELECT) 
	public Set<LookupPersonaleInterno> getPersonaleInterno() {
		return personaleInterno;
	}

	public void setPersonaleInterno(Set<LookupPersonaleInterno> personaleInterno) {
		this.personaleInterno = personaleInterno;
	}
	
	@OneToMany(fetch = FetchType.EAGER, mappedBy = "aslReferenza")
	@Where( clause = "enabled and trashed_date is null" )
	public Set<BUtente> getReferentes() {
		return referentes;
	}

	public void setReferentes(Set<BUtente> referentes) {
		this.referentes = referentes;
	}
	
	@Transient
	public String getNomeEsame()
	{
		return "Alimentazione";
	}
}
