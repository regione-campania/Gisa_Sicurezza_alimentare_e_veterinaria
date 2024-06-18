package it.us.web.bean.remoteBean;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;
import org.hibernate.annotations.NamedNativeQuery;

@Entity
//@Table(name = "sync_registrazioni_canina", schema = "public")
@NamedNativeQuery(name = "GetRegistrazioniCanina", query = "select * from sync_registrazioni_canina where identificativo = :identificativo", resultClass = RegistrazioniCanina.class)

public class RegistrazioniCanina implements RegistrazioniInterface, Serializable
{
	private static final long serialVersionUID = -7289087085008520718L;
	
	private int idCane;
	private Boolean adozione;
	private Boolean adozioneFuoriAsl;
	private Boolean adozioneVersoAssocCanili;
	private Boolean ricattura;
	private Boolean cessione;
	private Boolean controllComm;
	private Boolean controlli;
	private Boolean sterilizzazione;
	private Boolean decesso;
	private Boolean furto;
	private Boolean gestCessione;
	private Boolean passaporto;
	private Boolean rinnovoPassaporto;
	private Boolean presaCessione;
	private Boolean reimmissione;
	private Boolean ritornoAslOrigine;
	private Boolean restituisci;
	private Boolean rientro;
	private Boolean ritrovamento;
	private Boolean ritrovamentoSmarrNonDenunciato;
	private Boolean smarrimento;
	private Boolean trasfCanile;
	private Boolean ritornoProprietario;
	private Boolean trasfPropCanile;
	private Boolean trasfRegione;
	private Boolean trasferimento;
	private Boolean trasferimentoFr;
	private Boolean trasferimentoResidenzaProp;
	private Boolean prelievoDna;
	private Boolean prelievoLeishmania;
	private Boolean ritornoCanileOrigine;
	private String errorDescription;
	private Integer errorCode;
	
	@Id
	public int getIdCane() {
		return this.idCane;
	}

	public void setIdCane(int idCane) {
		this.idCane = idCane;
	}
	
	
	@Column(name="adozione")
	public Boolean getAdozione() {
		return adozione;
	}
	public void setAdozione(Boolean adozione) {
		this.adozione = adozione;
	}
	
	@Column(name="adozionefa")
	public Boolean getAdozioneFuoriAsl() {
		return adozioneFuoriAsl;
	}
	public void setAdozioneFuoriAsl(Boolean adozioneFuoriAsl) {
		this.adozioneFuoriAsl = adozioneFuoriAsl;
	}
	
	@Column(name="adozione_verso_assoc_canili")
	public Boolean getAdozioneVersoAssocCanili() {
		return adozioneVersoAssocCanili;
	}
	public void setAdozioneVersoAssocCanili(Boolean adozioneVersoAssocCanili) {
		this.adozioneVersoAssocCanili = adozioneVersoAssocCanili;
	}
	
	@Column(name="sterilizzazione")
	public Boolean getSterilizzazione() {
		return sterilizzazione;
	}
	public void setSterilizzazione(Boolean sterilizzazione) {
		this.sterilizzazione = sterilizzazione;
	}
	
	@Column(name="ricattura")
	public Boolean getRicattura() {
		return ricattura;
	}
	public void setRicattura(Boolean ricattura) {
		this.ricattura = ricattura;
	}
	
	@Column(name="cessione")
	public Boolean getCessione() {
		return cessione;
	}
	public void setCessione(Boolean cessione) {
		this.cessione = cessione;
	}
	
	@Column(name="controllcomm")
	public Boolean getControllComm() {
		return controllComm;
	}
	public void setControllComm(Boolean controllComm) {
		this.controllComm = controllComm;
	}
	
	@Column(name="controlli")
	public Boolean getControlli() {
		return controlli;
	}
	public void setControlli(Boolean controlli) {
		this.controlli = controlli;
	}
	
	@Column(name="decesso")
	public Boolean getDecesso() {
		return decesso;
	}
	public void setDecesso(Boolean decesso) {
		this.decesso = decesso;
	}
	
	/*@Column(name="detentore")
	public boolean getDetentore() {
		return detentore;
	}
	public void setDetentore(boolean detentore) {
		this.detentore = detentore;
	}*/
	
	/*@Column(name="fuori_regione")
	public boolean getFuoriRegione() {
		return fuoriRegione;
	}
	public void setFuoriRegione(boolean fuoriRegione) {
		this.fuoriRegione = fuoriRegione;
	}*/
	
	@Column(name="furto")
	public Boolean getFurto() {
		return furto;
	}
	public void setFurto(Boolean furto) {
		this.furto = furto;
	}
	
	@Column(name="gestcessione")
	public Boolean getGestCessione() {
		return gestCessione;
	}
	public void setGestCessione(Boolean gestCessione) {
		this.gestCessione = gestCessione;
	}
	
	@Column(name="passaporto")
	public Boolean getPassaporto() {
		return (passaporto==null)?(false):(passaporto);
	}
	public void setPassaporto(Boolean passaporto) {
		this.passaporto = passaporto;
	}
	
	@Column(name="rinnovo_passaporto")
	public Boolean getRinnovoPassaporto() {
		return (rinnovoPassaporto==null)?(false):(rinnovoPassaporto);
	}
	public void setRinnovoPassaporto(Boolean rinnovoPassaporto) {
		this.rinnovoPassaporto = rinnovoPassaporto;
	}
	
	/*@Column(name="presa_asl")
	public boolean getPresaAsl() {
		return presaAsl;
	}
	public void setPresaAsl(boolean presaAsl) {
		this.presaAsl = presaAsl;
	}*/
	
	@Column(name="presacessione")
	public Boolean getPresaCessione() {
		return presaCessione;
	}
	public void setPresaCessione(Boolean presaCessione) {
		this.presaCessione = presaCessione;
	}
	
	@Column(name="reimmissione")
	public Boolean getReimmissione() {
		return reimmissione;
	}
	public void setReimmissione(Boolean reimmissione) {
		this.reimmissione = reimmissione;
	}
	
	@Column(name="ritornoAslOrigine")
	public Boolean getRitornoAslOrigine() {
		return ritornoAslOrigine;
	}
	public void setRitornoAslOrigine(Boolean ritornoAslOrigine) {
		this.ritornoAslOrigine = ritornoAslOrigine;
	}
	
	@Column(name="restituisci")
	public Boolean getRestituisci() {
		return restituisci;
	}
	public void setRestituisci(Boolean restituisci) {
		this.restituisci = restituisci;
	}
	
	@Column(name="rientro")
	public Boolean getRientro() {
		return rientro;
	}
	public void setRientro(Boolean rientro) {
		this.rientro = rientro;
	}
	
	@Column(name="ritrovamento")
	public Boolean getRitrovamento() {
		return ritrovamento;
	}
	public void setRitrovamento(Boolean ritrovamento) {
		this.ritrovamento = ritrovamento;
	}
	
	
	public Boolean getRitrovamentoSmarrNonDenunciato() {
		return ritrovamentoSmarrNonDenunciato;
	}
	public void setRitrovamentoSmarrNonDenunciato(Boolean ritrovamentoSmarrNonDenunciato) {
		this.ritrovamentoSmarrNonDenunciato = ritrovamentoSmarrNonDenunciato;
	}
	
	@Column(name="smarrimento")
	public Boolean getSmarrimento() {
		return smarrimento;
	}
	public void setSmarrimento(Boolean smarrimento) {
		this.smarrimento = smarrimento;
	}
	
	@Column(name="trasfCanile")
	public Boolean getTrasfCanile() {
		return trasfCanile;
	}
	public void setTrasfCanile(Boolean trasfCanile) {
		this.trasfCanile = trasfCanile;
	}
	
	@Column(name="ritornoProprietario")
	public Boolean getRitornoProprietario() {
		return ritornoProprietario;
	}
	public void setRitornoProprietario(Boolean ritornoProprietario) {
		this.ritornoProprietario = ritornoProprietario;
	}
	
	@Column(name="trasferimentoResidenzaProp")
	public Boolean getTrasferimentoResidenzaProp() {
		return trasferimentoResidenzaProp;
	}
	public void setTrasferimentoResidenzaProp(Boolean trasferimentoResidenzaProp) {
		this.trasferimentoResidenzaProp = trasferimentoResidenzaProp;
	}
	
	@Column(name="trasfpropcanile")
	public Boolean getTrasfPropCanile() {
		return trasfPropCanile;
	}
	public void setTrasfPropCanile(Boolean trasfPropCanile) {
		this.trasfPropCanile = trasfPropCanile;
	}
	@Column(name="trasfregione")
	public Boolean getTrasfRegione() {
		return trasfRegione;
	}
	public void setTrasfRegione(Boolean trasfRegione) {
		this.trasfRegione = trasfRegione;
	}
	
	@Column(name="trasferimento")
	public Boolean getTrasferimento() {
		return trasferimento;
	}
	public void setTrasferimento(Boolean trasferimento) {
		this.trasferimento = trasferimento;
	}
	
	
	@Column(name="prelievodna")
	public Boolean getPrelievoDna() {
		return prelievoDna;
	}

	public void setPrelievoDna(Boolean prelievoDna) {
		this.prelievoDna = prelievoDna;
	}
	
	@Column(name="prelievoLeishmania")
	public Boolean getPrelievoLeishmania() {
		return prelievoLeishmania;
	}

	public void setPrelievoLeishmania(Boolean prelievoLeishmania) {
		this.prelievoLeishmania = prelievoLeishmania;
	}
	
	
	@Column(name="restituzionecanileorigine")
	public Boolean getRitornoCanileOrigine() {
		return ritornoCanileOrigine;
	}

	public void setRitornoCanileOrigine(Boolean ritornoCanileOrigine) {
		this.ritornoCanileOrigine = ritornoCanileOrigine;
	}

	@Transient
	public String getErrorDescription() {
		return errorDescription;
	}
	public void setErrorDescription(String errorDescription) {
		this.errorDescription = errorDescription;
	}
	
	@Transient
	public Integer getErrorCode() {
		return errorCode;
	}
	public void setErrorCode(Integer errorCode) {
		this.errorCode = errorCode;
	}
	
}
