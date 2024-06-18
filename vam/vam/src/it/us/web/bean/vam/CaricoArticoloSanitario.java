package it.us.web.bean.vam;

import it.us.web.bean.BUtente;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;

import org.hibernate.annotations.Where;


@Entity
@Table(name = "carico_articoli_sanitari", schema = "public")
@Where( clause = "trashed_date is null" )
public class CaricoArticoloSanitario implements java.io.Serializable
{
	private static final long serialVersionUID = -1921248398217301209L;
	
	private int id;
	
	private int 	numeroConfezioni;
	private Date 	dataScadenza;
	
	private Date 	entered;
	private Date 	modified;
	private Date 	trashedDate;
	private BUtente enteredBy;
	private BUtente modifiedBy;
	
	private MagazzinoArticoliSanitari magazzinoArticoliSanitari;
	
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

	@Column(name = "numero_confezioni")
	public int getNumeroConfezioni() {
		return numeroConfezioni;
	}

	public void setNumeroConfezioni(int numeroConfezioni) {
		this.numeroConfezioni = numeroConfezioni;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "data_scadenza", length = 29)
	public Date getDataScadenza() {
		return dataScadenza;
	}

	public void setDataScadenza(Date dataScadenza) {
		this.dataScadenza = dataScadenza;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "entered", length = 29)
	public Date getEntered() {
		return entered;
	}

	public void setEntered(Date entered) {
		this.entered = entered;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "modified", length = 29)
	public Date getModified() {
		return modified;
	}

	public void setModified(Date modified) {
		this.modified = modified;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "trashed_date", length = 29)
	public Date getTrashedDate() {
		return trashedDate;
	}

	public void setTrashedDate(Date trashedDate) {
		this.trashedDate = trashedDate;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "entered_by")
	@NotNull	
	public BUtente getEnteredBy() {
		return enteredBy;
	}

	public void setEnteredBy(BUtente enteredBy) {
		this.enteredBy = enteredBy;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "modified_by")
	@NotNull	
	public BUtente getModifiedBy() {
		return modifiedBy;
	}

	public void setModifiedBy(BUtente modifiedBy) {
		this.modifiedBy = modifiedBy;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "magazzino")
	public MagazzinoArticoliSanitari getMagazzinoArticoliSanitari() {
		return magazzinoArticoliSanitari;
	}

	public void setMagazzinoArticoliSanitari(MagazzinoArticoliSanitari magazzinoArticoliSanitari) {
		this.magazzinoArticoliSanitari = magazzinoArticoliSanitari;
	}
	
	@Override
	public String toString()
	{
		return id+"";
	}
	

}
