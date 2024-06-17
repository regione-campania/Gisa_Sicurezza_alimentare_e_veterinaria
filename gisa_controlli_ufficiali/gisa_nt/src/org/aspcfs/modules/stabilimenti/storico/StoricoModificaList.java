package org.aspcfs.modules.stabilimenti.storico;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Vector;

import org.aspcfs.modules.base.SyncableList;
import org.aspcfs.utils.DatabaseUtils;
import org.aspcfs.utils.web.PagedListInfo;

public class StoricoModificaList extends Vector implements SyncableList {

	private int idModifica = -1;
	private int idStab = -1;
	private int idUtente = -1;
	private java.sql.Timestamp dataModifica = null;
	private String motivazioneModifica = "";
	private int nrCampiModificati = 0;

	protected PagedListInfo pagedListInfo = null;

	public PagedListInfo getPagedListInfo() {
		return pagedListInfo;
	}

	public void setPagedListInfo(PagedListInfo pagedListInfo) {
		this.pagedListInfo = pagedListInfo;
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

	public void setSyncType(String tmp) {
		// TODO Auto-generated method stub

	}

	public int getIdModifica() {
		return idModifica;
	}

	public void setIdModifica(int idModifica) {
		this.idModifica = idModifica;
	}

	public int getIdStabilimento() {
		return idStab;
	}

	public void setIdStabilimento(int idStab) {
		this.idStab = idStab;
	}

	public int getIdUtente() {
		return idUtente;
	}

	public void setIdUtente(int idUtente) {
		this.idUtente = idUtente;
	}

	public java.sql.Timestamp getDataModifica() {
		return dataModifica;
	}

	public void setDataModifica(java.sql.Timestamp dataModifica) {
		this.dataModifica = dataModifica;
	}

	public String getMotivazioneModifica() {
		return motivazioneModifica;
	}

	public void setMotivazioneModifica(String motivazioneModifica) {
		this.motivazioneModifica = motivazioneModifica;
	}

	public int getNrCampiModificati() {
		return nrCampiModificati;
	}

	public void setNrCampiModificati(int nrCampiModificati) {
		this.nrCampiModificati = nrCampiModificati;
	}

	public void buildList(Connection db) throws SQLException 
	{
		PreparedStatement pst = null;

		ResultSet rs = queryList(db, pst);
		while (rs.next()) {
			StoricoModifica thisModifica = this.buildModifica(rs);

			// Costruisco lista campi
			thisModifica.getListaCampiModificatiDb(db);
			// thisAnimale.setDetentore(detentore);
			this.add(thisModifica);

		}

		rs.close();
		if (pst != null) {
			pst.close();
		}
		// buildResources(db);
	}

	public StoricoModifica buildModifica(ResultSet rs) throws SQLException {
		StoricoModifica modifica = new StoricoModifica(rs);
		return modifica;
	}

	public ResultSet queryList(Connection db, PreparedStatement pst)
			throws SQLException {
		ResultSet rs = null;
		int items = -1;

		StringBuffer sqlSelect = new StringBuffer();
		StringBuffer sqlCount = new StringBuffer();
		StringBuffer sqlFilter = new StringBuffer();
		StringBuffer sqlOrder = new StringBuffer();

		// Need to build a base SQL statement for counting records

		sqlCount.append("Select COUNT(distinct m.* ) AS recordcount "
				+ " from storico_modif_stab m left join contact c on c.user_id = m.id_utente ");

		sqlCount.append(" WHERE m.id >= 0 ");

		createFilter(db, sqlFilter);

		if (pagedListInfo != null) {
			// Get the total number of records matching filter
			pst = db.prepareStatement(sqlCount.toString()
					+ sqlFilter.toString());
			// UnionAudit(sqlFilter,db);

			items = prepareFilter(pst);

			rs = pst.executeQuery();
			if (rs.next()) {
				int maxRecords = rs.getInt("recordcount");
				pagedListInfo.setMaxRecords(maxRecords);
			}
			rs.close();
			pst.close();

			// Determine the offset, based on the filter, for the first record
			// to show
			if (!pagedListInfo.getCurrentLetter().equals("")) {
				pst = db.prepareStatement(sqlCount.toString()
						+ sqlFilter.toString() + " AND  "
						+ DatabaseUtils.toLowerCase(db) + "(m.id) < ? ");
				items = prepareFilter(pst);
				pst.setString(++items, pagedListInfo.getCurrentLetter()
						.toLowerCase());
				rs = pst.executeQuery();
				if (rs.next()) {
					int offsetCount = rs.getInt("recordcount");
					pagedListInfo.setCurrentOffset(offsetCount);
				}
				rs.close();
				pst.close();
			}

			// Determine column to sort by
			pagedListInfo.setColumnToSortBy("m.id");
			pagedListInfo.appendSqlTail(db, sqlOrder);

			// Optimize SQL Server Paging
			// sqlFilter.append(" AND  o.org_id NOT IN (SELECT TOP 10 org_id FROM organization "
			// + sqlOrder.toString());
		} else {
			sqlOrder.append(" ORDER BY m.id ");
		}

		// Need to build a base SQL statement for returning records
		if (pagedListInfo != null) {
			pagedListInfo.appendSqlSelectHead(db, sqlSelect);
		} else {
			sqlSelect.append("SELECT ");
		}

		sqlSelect
				.append("distinct m.*, case when c.namelast is not null and c.namefirst is not null then c.namelast || ' ' || c.namefirst "+
						" when c.namelast is null and c.namefirst is not null then c.namefirst when c.namelast is not null and c.namefirst is null then c.namelast "+
						" else 'N.D' end as utente from storico_modif_stab m left join contact c on c.user_id = m.id_utente ");

		sqlSelect.append(" where m.id >= 0 ");

		pst = db.prepareStatement(sqlSelect.toString() + sqlFilter.toString()
				+ sqlOrder.toString());
		items = prepareFilter(pst);

		if (pagedListInfo != null) {
			pagedListInfo.doManualOffset(db, pst);
		}

		rs = DatabaseUtils.executeQuery(db, pst, pagedListInfo);
		if (pagedListInfo != null) {
			pagedListInfo.doManualOffset(db, rs);
		}
		return rs;
	}

	protected void createFilter(Connection db, StringBuffer sqlFilter) {

		if (sqlFilter == null) {
			sqlFilter = new StringBuffer();
		}

		if (idModifica > -1) {
			sqlFilter.append(" AND  m.id = ? ");
		}
	
		if (idStab > -1) {
			sqlFilter.append(" AND  m.id_stabilimento = ? ");
		}
		if (dataModifica != null) {
			sqlFilter.append(" AND  m.data_modifica = ? ");
		}
		if (idUtente > -1) {
			sqlFilter.append(" AND  m.id_utente = ? ");
		}
		if (nrCampiModificati > 0) {
			sqlFilter.append(" AND  m.nr_campi_modificati = ? ");
		}

		
	}

	protected int prepareFilter(PreparedStatement pst) throws SQLException {
		int i = 0;

		if (idModifica > -1) {
			pst.setInt(++i, idModifica);
		}
		
		if (idStab > -1) {
			pst.setInt(++i, idStab);
		}
		if (dataModifica != null) {
			pst.setTimestamp(++i, dataModifica);
		}
		if (idUtente > -1) {
			pst.setInt(++i, idUtente);
		}
		if (nrCampiModificati > 0) {
			pst.setInt(++i, nrCampiModificati);
		}

		return i;
	}

}
