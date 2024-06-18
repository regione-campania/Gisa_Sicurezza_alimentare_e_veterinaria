package it.us.web.bean.vam.lookup;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;

import org.hibernate.annotations.Where;


@Entity
@Table(name = "lookup_soglie_esami", schema = "public")
@Where( clause = "enabled" )
public class LookupSoglieEsami implements java.io.Serializable
{

	private static final long serialVersionUID = 1L;
	
	private int id;
	private String esame;
	private LookupSpecie specie;
	private String proprieta;
	private Float min;
	private Float max;
	private Boolean enabled;

	public LookupSoglieEsami(){}
	
	
	public LookupSoglieEsami(int id,String nome) {
		this.id = id;
	}

	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	@NotNull
	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	@Column(name = "esame")
	public String getEsame() {
		return esame;
	}

	public void setEsame(String esame) {
		this.esame = esame;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "specie")
	public LookupSpecie getSpecie() {
		return specie;
	}

	public void setSpecie(LookupSpecie specie) {
		this.specie = specie;
	}

	@Column(name = "proprieta")
	public String getProprieta() {
		return proprieta;
	}

	public void setProprieta(String proprieta) {
		this.proprieta = proprieta;
	}

	@Column(name = "min")
	public Float getMin() {
		return min;
	}


	public void setMin(Float min) {
		this.min = min;
	}

	@Column(name = "max")
	public Float getMax() {
		return max;
	}

	public void setMax(Float max) {
		this.max = max;
	}

	@Column(name = "enabled")
	public Boolean getEnabled() {
		return this.enabled;
	}

	public void setEnabled(Boolean enabled) {
		this.enabled = enabled;
	}
	
	@Override
	public String toString()
	{
		return proprieta;
	}
	
	@Transient
	public String getNomeEsame()
	{
		return "Soglie esami";
	}
}
