package org.aspcf.modules.checklist_benessere.base.v6;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.darkhorseventures.framework.beans.GenericBean;

public class Esito extends GenericBean {

  private static final long serialVersionUID = 1L;
 
  private int id;
  private String description;
  private String shortDescription;
  
  public Esito(ResultSet rs) throws SQLException {
		buildRecord(rs);
	}

  
  private void buildRecord(ResultSet rs) throws SQLException {
	this.id = rs.getInt("id");
	this.description = rs.getString("description");
	this.shortDescription = rs.getString("short_description");
}


public Esito(Connection db, String shortDescription) throws SQLException {

	PreparedStatement pst = db.prepareStatement("select * from chk_bns_domande_v6_esiti where short_description ilike ?");
	pst.setString (1, shortDescription);
	ResultSet rs = pst.executeQuery();
	if (rs.next()){
		buildRecord(rs);
	}
	
}


public int getId() {
	return id;
}


public void setId(int id) {
	this.id = id;
}


public String getDescription() {
	return description;
}


public void setDescription(String description) {
	this.description = description;
}


public String getShortDescription() {
	return shortDescription;
}


public void setShortDescription(String shortDescription) {
	this.shortDescription = shortDescription;
}
  
  
} 
