package org.aspcfs.modules.suap.base;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.darkhorseventures.framework.actions.ActionContext;
import com.darkhorseventures.framework.beans.GenericBean;

public class DatiMobile extends GenericBean {


	private int id = -1;
	private String targa="";
	private String carta ="";
	private int tipo = -1;
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTarga() {
		return targa;
	}

	public void setTarga(String targa) {
		this.targa = targa;
	}

	public String getCarta() {
		return carta;
	}

	public void setCarta(String carta) {
		this.carta = carta;
	}

	public int getTipo() {
		return tipo;
	}

	public void setTipo(int tipo) {
		this.tipo = tipo;
	}
	
	public void setTipo(String tipo) {
		try {
			this.tipo = Integer.parseInt(tipo);
			}
		catch (Exception e){
		}
		
	}

	public DatiMobile(){

	}
	
	public void queryRecord(Connection db , int id) throws SQLException
	{
		String sql = "select * from suap_ric_scia_mobile where id = ? and enabled";
		PreparedStatement pst = db.prepareStatement(sql);
		pst.setInt(1, id);
		ResultSet rs = pst.executeQuery();
		if (rs.next())
			this.buildRecord(rs);
	}

	
	public DatiMobile(Connection db, int id) throws SQLException{
		queryRecord(db, id);
	}
	
	public DatiMobile(ResultSet rs) throws SQLException{
		buildRecord(rs);
	}
	
	private void buildRecord(ResultSet rs){
		try {
			this.id = rs.getInt("id");
			this.targa = rs.getString("targa");
			this.tipo = rs.getInt("tipo");
			this.carta = rs.getString("carta");
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	}
	
	public DatiMobile(ActionContext context, int i){
	setTarga(context.getRequest().getParameter("mobile_targa"+i));
	setTipo(context.getRequest().getParameter("mobile_tipoautoveicolo"+i));
	setCarta(context.getRequest().getParameter("mobile_carta"+i));
	}

	public void insert(Connection db) throws SQLException
	{
		String sql = "insert into suap_ric_scia_mobile (targa, tipo, carta, id_stabilimento) values (?, ?, ?, ?)";
		PreparedStatement pst = db.prepareStatement(sql);
		pst.setString(1, this.getTarga());
		pst.setInt(2, this.getTipo());
		pst.setString(3, this.getCarta());
		pst.setInt(4, this.getIdStabilimento());
		
		if (this.getTarga()!=null && !this.getTarga().equals("null") && this.getCarta()!=null && !this.getCarta().equals("null") && this.getTipo()>-1) 
			 pst.execute();
	}
	
}



