package it.us.web.bean.vam.lookup;

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
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;

import org.hibernate.annotations.OrderBy;
import org.hibernate.annotations.Where;
import org.hibernate.validator.constraints.Length;


@Entity
@Table(name = "lookup_esame_istopatologico_sede_lesione", schema = "public")
@Where( clause = "enabled" )
public class LookupEsameIstopatologicoSedeLesione implements java.io.Serializable {

	private static final long serialVersionUID = 4924979223182833401L;

	private int id;
	private String description;
	private String codice;
	private Integer level;
	private Boolean enabled;
	private LookupEsameIstopatologicoSedeLesione padre;
	private Set<LookupEsameIstopatologicoSedeLesione> figli = new HashSet<LookupEsameIstopatologicoSedeLesione>(0);
	
	@Transient
	public String getNomeEsame()
	{
		return "Sede lesione";
	}
	
	@Id
	@GeneratedValue( strategy = GenerationType.IDENTITY )
	@Column(name = "id", unique = true, nullable = false)
	@NotNull
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	
	@Column(name = "description", length = 128)
	@Length(max = 128)
	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	@Column(name = "codice", length = 128)
	@Length(max = 128)
	public String getCodice() {
		return codice;
	}
	
	public void setCodice(String codice) {
		this.codice = codice;
	}
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "padre")
	public LookupEsameIstopatologicoSedeLesione getPadre() {
		return padre;
	}
	
	public void setPadre(LookupEsameIstopatologicoSedeLesione padre) {
		this.padre = padre;
	}
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "padre")
	@OrderBy(clause="level asc")
	@Where(clause="enabled")
	public Set<LookupEsameIstopatologicoSedeLesione> getFigli() {
		return figli;
	}
	
	public void setFigli(Set<LookupEsameIstopatologicoSedeLesione> figli) {
		this.figli = figli;
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
	
	@Override
	public String toString()
	{
		return (padre == null) ? (description) : (padre.getDescription() + " -> " + description);
	}
	
}