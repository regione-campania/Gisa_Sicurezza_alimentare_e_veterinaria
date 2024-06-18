package org.aspcfs.modules.opu_ext.base;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Vector;

import org.apache.log4j.Logger;
import org.aspcfs.modules.base.SyncableList;
import org.aspcfs.utils.DatabaseUtils;
import org.aspcfs.utils.web.PagedListInfo;

public class StabilimentoList extends Vector implements SyncableList {

	private static Logger log = Logger.getLogger(org.aspcfs.modules.opu_ext.base.StabilimentoList.class);
	protected PagedListInfo pagedListInfo = null;
	private int idOperatore ;
	private int idAsl ;
	private Integer[] idLineaProduttiva ;
	
	public PagedListInfo getPagedListInfo() {
		return pagedListInfo;
	}

	public void setPagedListInfo(PagedListInfo pagedListInfo) {
		this.pagedListInfo = pagedListInfo;
	}

	public int getIdOperatore() {
		return idOperatore;
	}

	
	public int getIdAsl() {
		return idAsl;
	}

	public void setIdAsl(int idAsl) {
		this.idAsl = idAsl;
	}

	public void setIdOperatore(int idOperatore) {
		this.idOperatore = idOperatore;
	}
	
	

	public Integer[] getIdLineaProduttiva() {
		return idLineaProduttiva;
	}

	public void setIdLineaProduttiva(Integer[] idLineaProduttiva) {
		this.idLineaProduttiva = idLineaProduttiva;
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

	public ResultSet queryList(Connection db, PreparedStatement pst) throws SQLException {
		ResultSet rs = null;
		int items = -1;

		StringBuffer sqlSelect = new StringBuffer();
		StringBuffer sqlCount = new StringBuffer();
		StringBuffer sqlFilter = new StringBuffer();
		StringBuffer sqlOrder = new StringBuffer();
		
		
		sqlCount.append("select count(*) as recordcount from stabilimento where 1=1 ");
		createFilter(db, sqlFilter);

		if (pagedListInfo != null) {
			//Get the total number of records matching filter
			pst = db.prepareStatement(
					sqlCount.toString() +
					sqlFilter.toString());
			// UnionAudit(sqlFilter,db);

			items = prepareFilter(pst);


			rs = pst.executeQuery();
			if (rs.next()) {
				int maxRecords = rs.getInt("recordcount");
				pagedListInfo.setMaxRecords(maxRecords);
			}
			rs.close();
			pst.close();

			//Determine the offset, based on the filter, for the first record to show
			if (!pagedListInfo.getCurrentLetter().equals("")) {
				pst = db.prepareStatement(
						sqlCount.toString() +
						sqlFilter.toString() +
						"AND " + DatabaseUtils.toLowerCase(db) + "(org.name) < ? ");
				items = prepareFilter(pst);
				pst.setString(++items, pagedListInfo.getCurrentLetter().toLowerCase());
				rs = pst.executeQuery();
				if (rs.next()) {
					int offsetCount = rs.getInt("recordcount");
					pagedListInfo.setCurrentOffset(offsetCount);
				}
				rs.close();
				pst.close();
			}

			//Determine column to sort by
		
			pagedListInfo.appendSqlTail(db, sqlOrder);

			//Optimize SQL Server Paging
			//sqlFilter.append("AND o.org_id NOT IN (SELECT TOP 10 org_id FROM organization " + sqlOrder.toString());
		} else {
			sqlOrder.append("");
		}

		//Need to build a base SQL statement for returning records
		if (pagedListInfo != null) {
			pagedListInfo.appendSqlSelectHead(db, sqlSelect);
		} else {
			sqlSelect.append("SELECT ");
		}
		sqlSelect.append(" s.* from opu_stabilimento as s join opu_relazione_stabilimento_linee_produttive r on s.id=r.id_stabilimento where 1=1 and r.trashed_date is null ");
		pst = db.prepareStatement(sqlSelect.toString() + sqlFilter.toString() + sqlOrder.toString());
		items = prepareFilter(pst);
		System.out.println("[QUERY LIST STABILIMENTI] "+pst.toString());
		rs = pst.executeQuery();
		if (pagedListInfo != null) {
			pagedListInfo.doManualOffset(db, rs);
		}
		return rs;
	}
	
	public ResultSet queryStabilimento(Connection db, PreparedStatement pst,int idLineaProduttiva) throws SQLException {
		ResultSet rs = null;
		int items = -1;

		StringBuffer sqlSelect = new StringBuffer();
		StringBuffer sqlCount = new StringBuffer();
		StringBuffer sqlFilter = new StringBuffer();
		StringBuffer sqlOrder = new StringBuffer();
		
		
	
		sqlSelect.append("select * from opu_stabilimento s join opu_relazione_stabilimento_linee_produttive r on s.id=r.id_stabilimento where 1=1 and r.id =? and r.trashed_date is null ");
		pst = db.prepareStatement(sqlSelect.toString());
		pst.setInt(1, idLineaProduttiva);

		rs = pst.executeQuery();
		
		return rs;
	}

	protected void createFilter(Connection db, StringBuffer sqlFilter) 
	{
		//andAudit( sqlFilter );
		if (sqlFilter == null) 
		{
			sqlFilter = new StringBuffer();
		}
		
		if (idOperatore>0)
		{
			sqlFilter.append(" and id_operatore = ? ");
		}
		if (idAsl>0)
		{
			sqlFilter.append(" and id_asl = ? ");
		}
		
		
	    if (idLineaProduttiva != null && idLineaProduttiva.length>0)
	    {
	    	sqlFilter.append("AND  r.id_linea_produttiva in ( ");
	    	for (int i = 0 ; i<idLineaProduttiva.length-1 ; i++)
	    	{
	    		if(! idLineaProduttiva[i].equals("-1"))
	    			sqlFilter.append(idLineaProduttiva[i]+",");
	    	}
	    	if(! idLineaProduttiva[idLineaProduttiva.length-1].equals("-1"))
	    		sqlFilter.append(idLineaProduttiva[idLineaProduttiva.length-1]+") ");
	    	else
	    		sqlFilter.append(") ");
	    	
	    	
	    }
		
	}
	protected int prepareFilter(PreparedStatement pst) throws SQLException 
	{
		int i = 0;
		if (idOperatore>0)
		{
			pst.setInt(++i, idOperatore) ;
		}
		if (idAsl>0)
		{
			pst.setInt(++i, idAsl) ;
		}
		return i;
	}


	public void buildList(Connection db) throws SQLException, IndirizzoNotFoundException {
		PreparedStatement pst = null;

		ResultSet rs = queryList(db, pst);
		while (rs.next()) {

			Stabilimento thisStab = this.getObject(rs);
			
			Indirizzo sedeOp = new Indirizzo(db,thisStab.getSedeOperativa().getIdIndirizzo());
		    thisStab.setSedeOperativa(sedeOp);
		    
		    SoggettoFisico rappLegale = new SoggettoFisico(db,thisStab.getRappLegale().getIdSoggetto());
		    thisStab.setRappLegale(rappLegale);
		    LineaProduttivaList lpList = new LineaProduttivaList();
		    lpList.setIdStabilimento(thisStab.getIdStabilimento());
		    lpList.setIdLineaProduttiva(this.getIdLineaProduttiva());
		    lpList.buildListStabilimento(db);
		    thisStab.setListaLineeProduttive(lpList);
			
		    this.add(thisStab);

		    
		    
		}

		rs.close();
		if (pst != null) {
			pst.close();
		}
	}
	
	
	
	public void buildStabilimento(Connection db,int idLineaProduttiva) throws SQLException {
		PreparedStatement pst = null;

		ResultSet rs = queryStabilimento(db, pst,idLineaProduttiva);
		while (rs.next()) {

			Stabilimento thisStab = this.getObject(rs);
			
			Indirizzo sedeOp = new Indirizzo(db,thisStab.getSedeOperativa().getIdIndirizzo());
		    thisStab.setSedeOperativa(sedeOp);
		    
		    LineaProduttivaList lpList = new LineaProduttivaList();
		    lpList.setId(idLineaProduttiva);
		    lpList.buildListStabilimento(db);
		    

		    thisStab.setListaLineeProduttive(lpList);
		    
		    SoggettoFisico soggettoRappLegale = new SoggettoFisico(db, thisStab.getRappLegale().getIdSoggetto());
		    thisStab.setRappLegale(soggettoRappLegale);
			
		    this.add(thisStab);

		}

		rs.close();
		if (pst != null) {
			pst.close();
		}
	}


	public Stabilimento getObject(ResultSet rs) throws SQLException {
		  
		return new Stabilimento(rs) ;
	    
	  }

	@Override
	public void setSyncType(String tmp) {
		// TODO Auto-generated method stub
		
	}
}
