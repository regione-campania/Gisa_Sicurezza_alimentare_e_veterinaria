package it.us.web.bean.vam.lookup;

import it.us.web.bean.vam.Autopsia;
import it.us.web.bean.vam.Ehrlichiosi;

import java.util.HashSet;
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

import org.hibernate.annotations.Where;
import org.hibernate.validator.constraints.Length;

@Entity
@Table(name = "lookup_ehrlichiosi_esiti", schema = "public")
@Where( clause = "enabled" )
public class LookupEhrlichiosiEsiti implements java.io.Serializable {

	private int id;
	private String description;
	private Integer level;
	private Boolean enabled;
	
	private Set<Ehrlichiosi> ehrlichiosis = new HashSet<Ehrlichiosi>(0);
	
	@Transient
	public String getNomeEsame()
	{
		return "Esiti";
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
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "lee")
	@Where( clause = "trashed_date is null" )
	public Set<Ehrlichiosi> getEhrlichiosis() {
		return ehrlichiosis;
	}
	public void setEhrlichiosis(Set<Ehrlichiosi> ehrlichiosis) {
		this.ehrlichiosis = ehrlichiosis;
	}
	
	@Override
	public String toString()
	{
		return description;
	}
	
	
	
	
}
