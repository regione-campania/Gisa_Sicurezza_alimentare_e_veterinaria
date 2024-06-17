package org.aspcfs.modules.tamponi.base;

import java.io.Serializable;
import java.util.HashMap;

public class Tampone implements Serializable {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = -6842719494559486778L;
	
	private int idTampone=0;
	private int idTicket=0;
	private HashMap<Integer, String> ricerca=new HashMap<Integer, String>();
	private int superfice=-1;
	private String superficeStringa="";
	private HashMap<Integer, String> esiti=new HashMap<Integer, String>();
	private int tipo=0;
	private String desrizioneSuperficeIntero="";
	
	public String getDesrizioneSuperficeIntero() {
		return desrizioneSuperficeIntero;
	}
	public void setDesrizioneSuperficeIntero(String desrizioneSuperficeIntero) {
		this.desrizioneSuperficeIntero = desrizioneSuperficeIntero;
	}
	public int getTipo() {
		return tipo;
	}
	public void setTipo(int tipo) {
		this.tipo = tipo;
	}
	public void addEsito(int k,String v){
		esiti.put(k, v);
	}
	public void addRicerca(int k,String v){
		ricerca.put(k, v);
	}
	public int getIdTampone() {
		return idTampone;
	}


	public void setIdTampone(int idTampone) {
		this.idTampone = idTampone;
	}


	public int getIdTicket() {
		return idTicket;
	}


	public void setIdTicket(int idTicket) {
		this.idTicket = idTicket;
	}


	public HashMap<Integer, String> getRicerca() {
		return ricerca;
	}


	public void setRicerca(HashMap<Integer, String> ricerca) {
		this.ricerca = ricerca;
	}


	public int getSuperfice() {
		return superfice;
	}


	public void setSuperfice(int superfice) {
		this.superfice = superfice;
	}


	public String getSuperficeStringa() {
		return superficeStringa;
	}


	public void setSuperficeStringa(String superficeStringa) {
		this.superficeStringa = superficeStringa;
	}


	public HashMap<Integer, String> getEsiti() {
		return esiti;
	}


	public void setEsiti(HashMap<Integer, String> esiti) {
		this.esiti = esiti;
	}


	public Tampone() {
		// TODO Auto-generated constructor stub
	}

}
