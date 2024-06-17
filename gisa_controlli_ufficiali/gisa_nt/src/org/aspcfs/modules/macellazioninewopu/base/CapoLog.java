package org.aspcfs.modules.macellazioninewopu.base;

import java.sql.Timestamp;

public class CapoLog {
	
	private int idMacello;
	private String matricola = "";
	private String codiceAziendaNascita  = "";
	private String codiceAziendaNascitaFromBdn  = "";
	private String comuneSpeditore = "";
	private String comuneSpeditoreFromBdn = "";
	private int aslSpeditore;
	private int aslSpeditoreFromBdn;
	private Timestamp dataNascita;
	private Timestamp dataNascitaFromBdn;
	private String sesso = "";
	private String sessoFromBdn = "";
	private int specie;
	private int specieFromBdn;
	private int razza;
	private int razzaFromBdn;
	private boolean inBdn;
	private int enteredBy;
	private int modifiedBy;
	private Timestamp trashedDate;
	
	
	public int getIdMacello() {
		return idMacello;
	}
	public void setIdMacello(int idMacello) {
		this.idMacello = idMacello;
	}
	public String getMatricola() {
		return matricola;
	}
	public void setMatricola(String matricola) {
		this.matricola = matricola;
	}
	public String getCodiceAziendaNascita() {
		return codiceAziendaNascita;
	}
	public void setCodiceAziendaNascita(String codiceAziendaNascita) {
		this.codiceAziendaNascita = codiceAziendaNascita;
	}
	public String getCodiceAziendaNascitaFromBdn() {
		return codiceAziendaNascitaFromBdn;
	}
	public void setCodiceAziendaNascitaFromBdn(String codiceAziendaNascitaFromBdn) {
		this.codiceAziendaNascitaFromBdn = codiceAziendaNascitaFromBdn;
	}
	public String getComuneSpeditore() {
		return comuneSpeditore;
	}
	public void setComuneSpeditore(String comuneSpeditore) {
		this.comuneSpeditore = comuneSpeditore;
	}
	public String getComuneSpeditoreFromBdn() {
		return comuneSpeditoreFromBdn;
	}
	public void setComuneSpeditoreFromBdn(String comuneSpeditoreFromBdn) {
		this.comuneSpeditoreFromBdn = comuneSpeditoreFromBdn;
	}
	public int getAslSpeditore() {
		return aslSpeditore;
	}
	public void setAslSpeditore(int aslSpeditore) {
		this.aslSpeditore = aslSpeditore;
	}
	public int getAslSpeditoreFromBdn() {
		return aslSpeditoreFromBdn;
	}
	public void setAslSpeditoreFromBdn(int aslSpeditoreFromBdn) {
		this.aslSpeditoreFromBdn = aslSpeditoreFromBdn;
	}
	public Timestamp getDataNascita() {
		return dataNascita;
	}
	public void setDataNascita(Timestamp dataNascita) {
		this.dataNascita = dataNascita;
	}
	public Timestamp getDataNascitaFromBdn() {
		return dataNascitaFromBdn;
	}
	public void setDataNascitaFromBdn(Timestamp dataNascitaFromBdn) {
		this.dataNascitaFromBdn = dataNascitaFromBdn;
	}
	public String getSesso() {
		return sesso;
	}
	public void setSesso(String sesso) {
		this.sesso = sesso;
	}
	public String getSessoFromBdn() {
		return sessoFromBdn;
	}
	public void setSessoFromBdn(String sessoFromBdn) {
		this.sessoFromBdn = sessoFromBdn;
	}
	public int getSpecie() {
		return specie;
	}
	public void setSpecie(int specie) {
		this.specie = specie;
	}
	public int getSpecieFromBdn() {
		return specieFromBdn;
	}
	public void setSpecieFromBdn(int specieFromBdn) {
		this.specieFromBdn = specieFromBdn;
	}
	public int getRazza() {
		return razza;
	}
	public void setRazza(int razza) {
		this.razza = razza;
	}
	public int getRazzaFromBdn() {
		return razzaFromBdn;
	}
	public void setRazzaFromBdn(int razzaFromBdn) {
		this.razzaFromBdn = razzaFromBdn;
	}
	public boolean isInBdn() {
		return inBdn;
	}
	public void setInBdn(boolean inBdn) {
		this.inBdn = inBdn;
	}
	public int getEnteredBy() {
		return enteredBy;
	}
	public void setEnteredBy(int enteredBy) {
		this.enteredBy = enteredBy;
	}
	public int getModifiedBy() {
		return modifiedBy;
	}
	public void setModifiedBy(int modifiedBy) {
		this.modifiedBy = modifiedBy;
	}
	public Timestamp getTrashedDate() {
		return trashedDate;
	}
	public void setTrashedDate(Timestamp trashedDate) {
		this.trashedDate = trashedDate;
	}
	
	

}
