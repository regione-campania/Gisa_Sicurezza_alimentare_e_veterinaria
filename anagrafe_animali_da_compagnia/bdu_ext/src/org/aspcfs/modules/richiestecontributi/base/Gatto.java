package org.aspcfs.modules.richiestecontributi.base;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class Gatto {
	private String microchip; //microchip
	private int id_gatto; //identificativo del gatto nella vista e nella tabella asset di felina
	private Timestamp approvato;
	private String tipologia;
	private Timestamp data_ster;	//data di sterilizzazione
	private int asl;//id asl
	private String descrizioneAsl; //descrizione dell'asl
	private int id_pratica;
	private String numero_protocollo;
	private boolean pagato;
	private String proprietario;
	//comune di cattura per i cani catturati o comune del proprietario per i padronali
	private String comune_cattura;
	private String comune_proprietario;
	private String comune_colonia;
	
	public String getMicrochip() {
		return microchip;
	}
	public void setMicrochip(String microchip) {
		this.microchip = microchip;
	}
	
	public int getId_gatto() {
		return id_gatto;
	}
	public void setId_gatto(int id_gatto) {
		this.id_gatto = id_gatto;
	}

	public void setDataApprovazione(java.sql.Timestamp approvato) {
		this.approvato = approvato;
	}
	public java.sql.Timestamp getDataApprovazione() {
		return approvato;
	}

	public String getTipologia() {
		return tipologia;
	}
	public void setTipologia(String tipo) {
		this.tipologia=tipo;
	}

	public void setDataSterilizzazione(java.sql.Timestamp data_ster) {
		this.data_ster = data_ster;
	}
	
	public java.sql.Timestamp getDataSterilizzazione() {
		return data_ster;
	}

	public void setAsl(int asl2) {
		this.asl = asl2;
	}
	public int getAsl() {
		return asl;
	}

	public String getDescrizioneAsl() {
		return descrizioneAsl;
	}
	public void setDescrizioneAsl(String descrizioneAsl) {
		this.descrizioneAsl = descrizioneAsl;
	}

	public void setId_pratica(int id_pratica) {
		this.id_pratica = id_pratica;
	}
	public int getId_pratica() {
		return id_pratica;
	}	

	public String getNumeroProtocollo() {
		return numero_protocollo;
	}
	
	public void setNumeroProtocollo(String num_prot) {
		this.numero_protocollo=num_prot;
	}

	public boolean isPagato() {
		return pagato;
	}
	public void setPagato(boolean pagato) {
		this.pagato = pagato;
	}
	
	public String getProprietario() {
		return proprietario;
	}
	public void setProprietario(String proprietario) {
		this.proprietario = proprietario;
	}

	public String getComuneCattura() {
		return comune_cattura;
	}
	public void setComuneCattura(String comune) {
		this.comune_cattura=comune;
	}
	
	public void setComune_proprietario(String comune_proprietario) {
		this.comune_proprietario = comune_proprietario;
	}
	public String getComune_proprietario() {
		return comune_proprietario;
	}
	
	public void setComune_colonia(String comune_colonia) {
		this.comune_colonia = comune_colonia;
	}
	public String getComune_colonia() {
		return comune_colonia;
	}
	public static String formatData(Timestamp timestamp)
	{
		return (timestamp == null) ? ("") : (sdf.format( timestamp ));
	}

	static SimpleDateFormat sdf = new SimpleDateFormat( "dd/MM/yyyy" );
	
}
