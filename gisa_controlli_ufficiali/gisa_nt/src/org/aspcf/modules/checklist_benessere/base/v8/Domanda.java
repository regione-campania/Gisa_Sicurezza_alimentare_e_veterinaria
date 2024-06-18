package org.aspcf.modules.checklist_benessere.base.v8;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.darkhorseventures.framework.beans.GenericBean;

public class Domanda extends GenericBean {
										 	

  private static final long serialVersionUID = 1L;
 
  private int id;
  private int idmod;
  private int level;
  private int irrId;
  private int dettIrrId;
  private String requisito;
  private String quesito;
  private Risposta risposta = new Risposta();
  
public Domanda(Connection db, ResultSet rs, int idChkBnsModIst) throws SQLException {
	buildRecord(rs);
	if (idChkBnsModIst>0)
		setRisposta(db, idChkBnsModIst);
}

private void setRisposta(Connection db, int idChkBnsModIst) throws SQLException {
	Risposta r = new Risposta(db, this.id, idChkBnsModIst);
	this.risposta = r;
}

private void buildRecord(ResultSet rs) throws SQLException{
	this.id = rs.getInt("id");
	this.idmod = rs.getInt("idmod");
	this.level = rs.getInt("level");
	this.irrId = rs.getInt("irr_id");
	this.dettIrrId = rs.getInt("dettirrid");
	this.requisito = rs.getString("requisito");
	this.quesito = rs.getString("quesito");
	
}
public int getId() {
	return id;
}
public void setId(int id) {
	this.id = id;
}
public int getIdmod() {
	return idmod;
}
public void setIdmod(int idmod) {
	this.idmod = idmod;
}
public int getLevel() {
	return level;
}
public void setLevel(int level) {
	this.level = level;
}
public int getIrrId() {
	return irrId;
}
public void setIrrId(int irrId) {
	this.irrId = irrId;
}
public int getDettIrrId() {
	return dettIrrId;
}
public void setDettIrrId(int dettIrrId) {
	this.dettIrrId = dettIrrId;
}
public String getRequisito() {
	return requisito;
}
public void setRequisito(String requisito) {
	this.requisito = requisito;
}
public String getQuesito() {
	return quesito;
}
public void setQuesito(String quesito) {
	this.quesito = quesito;
}
public Risposta getRisposta() {
	return risposta;
}

public void setRisposta(Risposta risposta) {
	this.risposta = risposta;
}
  
  
  
} 
