package it.us.web.bean.remoteBean;

import it.us.web.bean.BUtente;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.EsameInterface;
import it.us.web.bean.vam.lookup.LookupLeishmaniosiEsiti;

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
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;

import org.hibernate.annotations.Where;
import org.hibernate.validator.constraints.Length;

public class EsitoLeishmaniosi implements java.io.Serializable
{
	private static final long serialVersionUID = -8831477707572244920L;
	
	private Date dataPrelievoLeishmaniosi;
	private Date dataEsitoLeishmaniosi;
	
	private String identificativo;
	private Date dataAccertamento;
	private String esito;
	private String esitoCar;
	
	public String toString()
	{
		return esito+", " + esitoCar;
	}
	
	public Date getDataPrelievoLeishmaniosi() {
		return dataPrelievoLeishmaniosi;
	}
	public void setDataPrelievoLeishmaniosi(Date dataPrelievoLeishmaniosi) {
		this.dataPrelievoLeishmaniosi = dataPrelievoLeishmaniosi;
	}
	
	public Date getDataEsitoLeishmaniosi() {
		return dataEsitoLeishmaniosi;
	}
	public void setDataEsitoLeishmaniosi(Date dataEsitoLeishmaniosi) {
		this.dataEsitoLeishmaniosi = dataEsitoLeishmaniosi;
	}
	
	
	public String getIdentificativo() {
		return identificativo;
	}
	public void setIdentificativo(String identificativo) {
		this.identificativo = identificativo;
	}
	
	public String getEsito() {
		return esito;
	}
	public void setEsito(String esito) {
		this.esito = esito;
	}
	
	public String getEsitoCar() {
		return esitoCar;
	}
	public void setEsitoCar(String esitoCar) {
		this.esitoCar = esitoCar;
	}
	
	public Date getDataAccertamento() {
		return dataAccertamento;
	}
	public void setDataAccertamento(Date dataAccertamento) {
		this.dataAccertamento = dataAccertamento;
	}
	
	public Date getDataEsito()
	{
		return getDataEsitoLeishmaniosi();
	}
	
	public Date getDataRichiesta()
	{
		return getDataPrelievoLeishmaniosi();
	}

	public String getNomeEsame()
	{
		return "Esito Leishamnia da bdu";
	}
	
	public String getHtml()
	{
		return "Esito Leishamnia da bdu";
	}
	
	
	
	
	
}
