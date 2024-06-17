package org.aspcf.modules.checklist_biosicurezza.base;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.darkhorseventures.framework.beans.GenericBean;

public class Risposta extends GenericBean {
										 	

  private static final long serialVersionUID = 1L;
 
  private int id;
  private int ordine =-1;
  private int idClassyfarm =-1;
  private String risposta = "";
  private String tipo = "";
  
  private String[] lista = {};
  
  private boolean risposto = false;
  private String note = "";

public Risposta(Connection db, ResultSet rs) throws SQLException {
	buildRecord(rs);
}


public Risposta() {
	// TODO Auto-generated constructor stub
}



private void buildRecord(ResultSet rs) throws SQLException{
	this.id = rs.getInt("id");
	this.ordine = rs.getInt("ordine");
	this.idClassyfarm = rs.getInt("id_classyfarm");
	this.risposta = rs.getString("risposta");
	this.tipo = rs.getString("tipo");
	setLista(rs.getString("lista"));
}


public int getId() {
	return id;
}


public void setId(int id) {
	this.id = id;
}


public int getOrdine() {
	return ordine;
}


public void setOrdine(int ordine) {
	this.ordine = ordine;
}


public String getRisposta() {
	return risposta;
}


public void setRisposta(String risposta) {
	this.risposta = risposta;
}


public String getTipo() {
	return tipo;
}


public void setTipo(String tipo) {
	this.tipo = tipo;
}


public String getNote() {
	return note;
}


public void setNote(String note) {
	this.note = note;
}


public static ArrayList<Risposta> getListaRisposte(Connection db, int idDomanda, int idIstanza) throws SQLException {
	ArrayList<Risposta> listaRisposte = new ArrayList<Risposta>();
	PreparedStatement pst = null;
	
	pst = db.prepareStatement("select * from biosicurezza_risposte where trashed_date is null and id_domanda = ? order by ordine asc");
	pst.setInt(1, idDomanda);
	
	ResultSet rs = pst.executeQuery();
	
	while (rs.next()){
		Risposta risposta = new Risposta();
		risposta.buildRecord(rs);
		
		if (idIstanza > 0)
			risposta.setRisposto(db, idDomanda, idIstanza);
		
		listaRisposte.add(risposta);
	}
	return listaRisposte;
}


private void setRisposto(Connection db, int idDomanda, int idIstanza) throws SQLException{
	PreparedStatement pst = null;
	pst = db.prepareStatement("select * from biosicurezza_istanze_risposte where id_istanza = ? and id_domanda = ? and id_risposta = ? and trashed_date is null");
	pst.setInt(1, idIstanza);
	pst.setInt(2, idDomanda);
	pst.setInt(3, this.id);
	
	ResultSet rs = pst.executeQuery();
	
	if (rs.next()){
			this.risposto = true;
			this.note = rs.getString("note");
	}
}


public boolean isRisposto() {
	return risposto;
}


public void setRisposto(boolean risposto) {
	this.risposto = risposto;
}

public void insertRisposta(Connection db, int idIstanza, int idDomanda, int enteredBy) throws SQLException {
	int i = 0;
	PreparedStatement pst = null;
	pst = db.prepareStatement("insert into biosicurezza_istanze_risposte (id_istanza, id_domanda, id_risposta, note) values (?, ?, ?, ?)");
	pst.setInt(++i, idIstanza);
	pst.setInt(++i, idDomanda);
	pst.setInt(++i, this.id);
	pst.setString(++i, this.note);
	pst.executeUpdate();		
}


public String[] getLista() {
	return lista;
}


public void setLista(String[] lista) {
	this.lista = lista;
}
  
public void setLista(String lista) {
	if (lista!=null)
		this.lista =  lista.split(";");
}


public int getIdClassyfarm() {
	return idClassyfarm;
}


public void setIdClassyfarm(int idClassyfarm) {
	this.idClassyfarm = idClassyfarm;
}
  
} 
