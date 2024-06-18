package it.us.web.bean.vam;

import it.us.web.bean.BUtente;
import it.us.web.bean.vam.lookup.LookupTipoPrelievoToxoplasmosi;
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
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.hibernate.annotations.Type;
import org.hibernate.annotations.Where;

@Entity
@Table(name = "toxoplasmosi", schema = "public")
@Where( clause = "trashed_date is null" )
public class Toxoplasmosi implements java.io.Serializable, EsameInterface
{
	private static final long serialVersionUID = -5683301989406129454L;
	
	private int id;

	private CartellaClinica cartellaClinica;
	
	private Date dataRichiesta;
	private Date dataEsito;
	private String esito;
	private Date entered;
	private Date modified;
	private Date trashedDate;
	private BUtente enteredBy;
	private BUtente modifiedBy;
	
	private Set<LookupTipoPrelievoToxoplasmosi> tipoPrelievo = new HashSet<LookupTipoPrelievoToxoplasmosi>(0);
	

	public Toxoplasmosi()
	{
		
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
	@JoinColumn(name = "cartella_clinica")
	public CartellaClinica getCartellaClinica() {
		return this.cartellaClinica;
	}

	public void setCartellaClinica(CartellaClinica cartellaClinica) {
		this.cartellaClinica = cartellaClinica;
	}

		
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "data_richiesta", length = 29)
	public Date getDataRichiesta() {
		return dataRichiesta;
	}

	public void setDataRichiesta(Date dataRichiesta) {
		this.dataRichiesta = dataRichiesta;
	}
	
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "data_esito", length = 29)
	public Date getDataEsito() {
		return dataEsito;
	}

	public void setDataEsito(Date dataEsito) {
		this.dataEsito = dataEsito;
	}
		
	@Column(name = "esito")
	@Type(type = "text")
	public String getEsito() {
		return esito;
	}

	public void setEsito(String esito) {
		this.esito = esito;
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
	
	
	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "toxoplasmosi_tipo_prelievo", schema = "public", joinColumns = { @JoinColumn(name = "toxoplasmosi", nullable = false, updatable = false) }, inverseJoinColumns = { @JoinColumn(name = "tipo_prelievo", nullable = false, updatable = false) })
	@Size(min = 1, message = "Selezionare almeno un tipo di prelievo")
	public Set<LookupTipoPrelievoToxoplasmosi> getTipoPrelievo() {
		return tipoPrelievo;
	}

	public void setTipoPrelievo(Set<LookupTipoPrelievoToxoplasmosi> tipoPrelievo) {
		this.tipoPrelievo = tipoPrelievo;
	}

	@Override
	@Transient
	public String getNomeEsame()
	{
		return "Toxoplasmosi";
	}

	@Override
	@Transient
	public String getHtml()
	{
		return "implementare toxoplasmosi";
	}
	
	@Override
	public String toString()
	{
		return id+"";
	}
	
	
}

