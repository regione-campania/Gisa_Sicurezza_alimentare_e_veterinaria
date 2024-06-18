package org.aspcfs.modules.opu.base;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Vector;

import org.aspcfs.modules.base.SyncableList;

public class IndirizzoList extends Vector implements SyncableList {
	
	private int idProvincia ;
	private int idComune ;
	private String startComune ;
	
	
	public String getStartComune() {
		return startComune;
	}

	public void setStartComune(String startComune) {
		this.startComune = startComune;
	}

	public int getIdProvincia() {
		return idProvincia;
	}

	public void setIdProvincia(int idProvincia) {
		this.idProvincia = idProvincia;
	}

	public int getIdComune() {
		return idComune;
	}

	public void setIdComune(int idComune) {
		this.idComune = idComune;
	}

	public String getTableName() {
		// TODO Auto-generated method stub
		return null;
	}

	public String getUniqueField() {
		// TODO Auto-generated method stub
		return null;
	}

	public void setLastAnchor(Timestamp tmp) {
		// TODO Auto-generated method stub
		
	}

	public void setLastAnchor(String tmp) {
		// TODO Auto-generated method stub
		
	}

	public void setNextAnchor(Timestamp tmp) {
		// TODO Auto-generated method stub
		
	}

	public void setNextAnchor(String tmp) {
		// TODO Auto-generated method stub
		
	}

	public void setSyncType(int tmp) {
		// TODO Auto-generated method stub
		
	}
	
	public void buildList(Connection db)
	{
		int i = 0 ;
		try
		{
			String sel = "select i.*,comuni1.cod_provincia,comuni1.nome as descrizione_comune,lp.description as descrizione_provincia from opu_indirizzo i " +
			"left join comuni1 on comuni1.id = i.comune " +
			"left join lookup_province lp on lp.code = comuni1.cod_provincia::int " +
					"where trashed is false " ;
			if(idComune>0)
				sel += " and i.comune = ? ";
			sel += " and via ilike ? order by via limit 50";
			PreparedStatement pst = db.prepareStatement(sel);
			if(idComune>0)
				pst.setInt(++i, idComune);
			pst.setString(++i, "%"+startComune+"%");
			if(idComune>0)
			{
			ResultSet rs = pst.executeQuery() ;
			while (rs.next())
			{
				Indirizzo ind = new Indirizzo(rs);
				this.add(ind);
				
			}
			}
			
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		
		
	}

	@Override
	public void setSyncType(String tmp) {
		// TODO Auto-generated method stub
		
	}

}
