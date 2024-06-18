package it.us.web.bean.vam;

import it.us.web.bean.BUtente;
import it.us.web.bean.vam.lookup.LookupArticoliSanitari;
import it.us.web.bean.vam.lookup.LookupFarmaci;
import it.us.web.bean.vam.lookup.LookupTipiFarmaco;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;
import javax.validation.Valid;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

import org.hibernate.annotations.Where;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.Range;

@Entity
@Table(name = "magazzino_articoli_sanitari", schema = "public")
@Where( clause = "trashed_date is null" )
public class MagazzinoArticoliSanitari implements java.io.Serializable
{
	private static final long serialVersionUID = -1921248398217301209L;
	
	private int id;
	private Clinica clinica;
	private LookupArticoliSanitari 		lookupArticoliSanitari;
	
	private float quantita;
	private String descrizione;
	private String note;
	private Date entered;
	private Date modified;
	private Date trashedDate;
	private BUtente enteredBy;
	private BUtente modifiedBy;
	
	private Set<CaricoArticoloSanitario>  caricoArticoliSanitari  = new HashSet<CaricoArticoloSanitario>(0);
	private Set<ScaricoArticoloSanitario> scaricoArticoliSanitari = new HashSet<ScaricoArticoloSanitario>(0);
	
	public MagazzinoArticoliSanitari()
	{
		
	}
	
	@Transient
	public String getNomeEsame()
	{
		return "Magazzino Articoli Sanitari";
	}
	
	@Override
	public String toString()
	{
		return id+"";
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

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "clinica")
	public Clinica getClinica() {
		return this.clinica;
	}

	public void setClinica(Clinica clinica) {
		this.clinica = clinica;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "articolo_sanitario")
	@NotNull		
	public LookupArticoliSanitari getLookupArticoliSanitari() {
		return lookupArticoliSanitari;
	}

	public void setLookupArticoliSanitari(LookupArticoliSanitari lookupArticoliSanitari) {
		this.lookupArticoliSanitari = lookupArticoliSanitari;
	}

	
	@Column(name = "quantita")		
	@Min(value=0, message = "La quantit� residua deve essere maggiore di zero")
	public float getQuantita() {
		return quantita;
	}
	
	public void setQuantita(float quantita) {
		this.quantita = quantita;
	}

	@Column(name = "descrizione")
	public String getDescrizione() {
		return this.descrizione;
	}

	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}

	@Column(name = "note", length = 64)
	@Length(max = 64)
	public String getNote() {
		return this.note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "entered", length = 29)
	public Date getEntered() {
		return this.entered;
	}

	public void setEntered(Date entered) {
		this.entered = entered;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "modified", length = 29)
	public Date getModified() {
		return this.modified;
	}

	public void setModified(Date modified) {
		this.modified = modified;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "trashed_date", length = 29)
	public Date getTrashedDate() {
		return this.trashedDate;
	}

	public void setTrashedDate(Date trashedDate) {
		this.trashedDate = trashedDate;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "entered_by")
	@NotNull	
	public BUtente getEnteredBy() {
		return this.enteredBy;
	}

	public void setEnteredBy(BUtente enteredBy) {
		this.enteredBy = enteredBy;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "modified_by")
	public BUtente getModifiedBy() {
		return this.modifiedBy;
	}

	public void setModifiedBy(BUtente modifiedBy) {
		this.modifiedBy = modifiedBy;
	}

	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "magazzinoArticoliSanitari")	
	public Set<CaricoArticoloSanitario> getCaricoArticoliSanitari() {
		return caricoArticoliSanitari;
	}

	public void setCaricoArticoliSanitari(Set<CaricoArticoloSanitario> caricoArticoliSanitari) {
		this.caricoArticoliSanitari = caricoArticoliSanitari;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "magazzinoArticoliSanitari")	
	public Set<ScaricoArticoloSanitario> getScaricoArticoliSanitari() {
		return scaricoArticoliSanitari;
	}

	public void setScaricoArticoliSanitari(Set<ScaricoArticoloSanitario> scaricoArticoliSanitari) {
		this.scaricoArticoliSanitari = scaricoArticoliSanitari;
	}

}

