package org.aspcfs.modules.registrazioniAnimali.base;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.aspcfs.modules.anagrafe_animali.base.Animale;
import org.aspcfs.modules.anagrafe_animali.base.Cane;
import org.aspcfs.modules.anagrafe_animali.base.Furetto;
import org.aspcfs.modules.anagrafe_animali.base.Gatto;
import org.aspcfs.modules.base.Constants;
import org.aspcfs.utils.DatabaseUtils;
import org.aspcfs.utils.DateUtils;

public class EventoMutilazione extends Evento {

	public static final int idTipologiaDB = 65;
	public static final int idTipoSoggettoASL = 1; 
	public static final int idTipoSoggettoLLPP = 2; 

	private int id;
	private java.sql.Timestamp dataMutilazione;
	private int idMedicoEsecutore;
	private int idVeterinarioASL = -1;
	private int idVeterinarioLLPP = -1;
	private int idInterventoEseguito = -1;
	private int idCausale = -1;
	
	private int idEvento;

	// public static final HashMap campi = new HashMap();

	public int getId() {
		return id;
	}

	public java.sql.Timestamp getDataMutilazione() {
		return dataMutilazione;
	}

	public void setDataMutilazione(java.sql.Timestamp dataMutilazione) {
		this.dataMutilazione = dataMutilazione;
	}

	public void setDataMutilazione(String dataSter) {
		this.dataMutilazione = DateUtils.parseDateStringNew(dataSter,
				"dd/MM/yyyy");
	}


	public int getIdMedicoEsecutore() {
		return idMedicoEsecutore;
	}

	public void setIdMedicoEsecutore(
			int idMedicoEsecutore) {
		this.idMedicoEsecutore = idMedicoEsecutore;
	}

	public void setIdMedicoEsecutore(
			String idMedicoEsecutore) {
		this.idMedicoEsecutore = new Integer(
				idMedicoEsecutore).intValue();
	}

	public int getIdVeterinarioASL() {
		return idVeterinarioASL;
	}

	public void setIdVeterinarioASL(
			int idVeterinarioASL) {
		this.idVeterinarioASL = idVeterinarioASL;
	}

	public void setIdVeterinarioASL(
			String idVeterinarioASL) {
		this.idVeterinarioASL = new Integer(
				idVeterinarioASL).intValue();
	}

	public int getIdVeterinarioLLPP() 
	{
		return idVeterinarioLLPP;
	}

	public void setIdVeterinarioLLPP(int idVeterinarioLLPP) 
	{
		this.idVeterinarioLLPP = idVeterinarioLLPP;
	}
	
	public void setIdVeterinarioLLPP(
			String idVeterinarioLLPP) {
		this.idVeterinarioLLPP = new Integer(
				idVeterinarioLLPP).intValue();
	}
	
	public int getIdInterventoEseguito() {
		return idInterventoEseguito;
	}

	public void setIdInterventoEseguito(int idInterventoEseguito) {
		this.idInterventoEseguito = idInterventoEseguito;
	}

	public void setIdInterventoEseguito(String idInterventoEseguito) {
		this.idInterventoEseguito = new Integer(idInterventoEseguito)
				.intValue();
	}
	
	public int getIdCausale() {
		return idCausale;
	}

	public void setIdCausale(int idCausale) {
		this.idCausale = idCausale;
	}
	
	public void setIdCausale(String idCausale) {
		this.idCausale = new Integer(
				idCausale).intValue();
	}
	
	public int getIdEvento() {
		return idEvento;
	}

	public void setIdEvento(int idEvento) {
		this.idEvento = idEvento;
	}

	public void setId(int id) {
		this.id = id;
	}

	public EventoMutilazione() {
		super();
		// TODO Auto-generated constructor stub
	}

	
	public EventoMutilazione(ResultSet rs) throws SQLException {
		buildRecord(rs);
	}

	protected void buildRecord(ResultSet rs) throws SQLException {

		super.buildRecord(rs);
		this.idEvento = rs.getInt("idevento");
		this.dataMutilazione = rs.getTimestamp("data_mutilazione");
		this.idMedicoEsecutore = rs.getInt("id_medico_esecutore");
		this.idVeterinarioASL = rs.getInt("id_veterinario_asl");
		this.idVeterinarioLLPP = rs.getInt("id_veterinario_llpp");
		this.idInterventoEseguito = rs.getInt("id_intervento_eseguito");
		this.idCausale = rs.getInt("id_causale");

		// buildSede(rs);
		// buildRappresentanteLegale(rs);

	}

	public boolean insert(Connection db) throws SQLException {
		
		StringBuffer sql = new StringBuffer();
		try {

			super.insert(db);
			idEvento = super.getIdEvento();

			
			id = DatabaseUtils.getNextSeq(db, "evento_mutilazione_id_seq");
			// sql.append("INSERT INTO animale (");

			sql
					.append(" INSERT INTO evento_mutilazione(id_evento, data_mutilazione  ");

			if (idMedicoEsecutore != -1) {
				sql.append(", id_medico_esecutore");
			}

			if (idVeterinarioASL != -1) {
				sql.append(",id_veterinario_asl");
			}
			
			if (idVeterinarioLLPP != -1) {
				sql.append(",id_veterinario_llpp");
			}
			
			
			if (idInterventoEseguito != -1) {
				sql.append(",id_intervento_eseguito");
			}

			if (idCausale != -1) {
				sql.append(",id_causale");
			}

			sql.append(")VALUES(?,?");

			if (idMedicoEsecutore != -1) {
				sql.append(",?");
			}

			if (idVeterinarioASL != -1) {
				sql.append(",?");
			}
			
			if (idVeterinarioLLPP != -1) {
				sql.append(",?");
			}
			

			if (idInterventoEseguito != -1) {
				sql.append(",?");
			}
			
			if (idCausale != -1) {
				sql.append(", ?");
			}

			sql.append(")");

			int i = 0;
			PreparedStatement pst = db.prepareStatement(sql.toString());

			pst.setInt(++i, idEvento);

			pst.setTimestamp(++i, dataMutilazione);
			
			if (idMedicoEsecutore != -1) {
				pst.setInt(++i, idMedicoEsecutore);
			}

			if (idVeterinarioASL != -1) {
				pst.setInt(++i, idVeterinarioASL);
			}
			
			if (idVeterinarioLLPP != -1) {
				pst.setInt(++i, idVeterinarioLLPP);
			}

			if (idInterventoEseguito != -1) {
				pst.setInt(++i, idInterventoEseguito);
			}
			if (idCausale != -1) {
				pst.setInt(++i, idCausale);
			}

			pst.execute();
			pst.close();

			this.id = DatabaseUtils.getCurrVal(db,
					"evento_mutilazione_id_seq", id);

			

		} catch (SQLException e) {
			
			throw new SQLException(e.getMessage());
		} finally {
			
		}
		return true;

	}

	/*
	 * public static ArrayList getFields(Connection db){
	 * 
	 * ArrayList fields = new ArrayList(); HashMap fields1 = new HashMap();
	 * fields1.put("name", "dataEvento"); fields1.put("type", "data");
	 * fields1.put("label", "Data Mutilazione"); fields.add(fields1);
	 * 
	 * fields1 = new HashMap(); fields1.put("name", "flagContributoRegionale");
	 * fields1.put("type", "checkbox"); fields1.put("label",
	 * "Contributo regionale"); fields.add(fields1);
	 * 
	 * 
	 * 
	 * fields1 = new HashMap(); String html = ""; try { LookupList lookuplist =
	 * new LookupList(db, "lookup_razza"); lookuplist.addItem(-1,
	 * "--Seleziona--"); html =
	 * lookuplist.getHtmlSelect("idMedicoEsecutore", -1); }
	 * catch (SQLException e) { // TODO Auto-generated catch block
	 * e.printStackTrace(); }
	 * 
	 * fields1.put("name", "idMedicoEsecutore");
	 * fields1.put("type", "select"); fields1.put("label",
	 * "Progetto di Mutilazione"); fields1.put("html", html);
	 * fields.add(fields1);
	 * 
	 * fields1 = new HashMap(); fields1.put("name", "idInterventoEseguito");
	 * fields1.put("type", "LP"); fields1.put("label", "Sterilizzatore");
	 * fields.add(fields1);
	 * 
	 * 
	 * 
	 * 
	 * 
	 * return fields; }
	 */

	public EventoMutilazione(Connection db, int idEventoPadre)
			throws SQLException {

		// super(db, idEventoPadre);

		PreparedStatement pst = db
				.prepareStatement("Select *, e.id_evento as idevento, e.id_asl as idaslinserimentoevento from evento e left join evento_mutilazione f on (e.id_evento = f.id_evento) where e.id_evento = ?");
		pst.setInt(1, idEventoPadre);
		ResultSet rs = DatabaseUtils.executeQuery(db, pst);

		if (rs.next()) {
			buildRecord(rs);
		}

		if (idEventoPadre == -1) {
			throw new SQLException(Constants.NOT_FOUND_ERROR);
		}

		rs.close();
		pst.close();
	}

	public int update(Connection conn) throws SQLException {
		try {
			super.update(conn);
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		int result = -1;
		try {
			
			StringBuffer sql = new StringBuffer();

			sql.append("update evento_mutilazione set data_mutilazione = ? where id_evento = ?");
			PreparedStatement pst = conn.prepareStatement(sql.toString());

			int i = 0;
			pst.setTimestamp(++i, this.dataMutilazione);
			pst.setInt(++i, this.getIdEvento());
			
			result = pst.executeUpdate();
			pst.close();
			
			}catch (SQLException e) {
			
			throw new SQLException(e.getMessage());
		} 

		return result;
	}
	
	
	public EventoMutilazione salvaRegistrazione(int userId, int userRole, int userAsl, Animale thisAnimale, Connection db) throws Exception{

		super.salvaRegistrazione(userId, userRole, userAsl, thisAnimale, db);
		
		Animale oldAnimale = new Animale(db, this.getIdAnimale());

		switch (this.getSpecieAnimaleId()) {
		case Cane.idSpecie:
			thisAnimale = new Cane(db, this.getIdAnimale());
			break;
		case Gatto.idSpecie:
			thisAnimale = new Gatto(db, this.getIdAnimale());
			break;
		case Furetto.idSpecie:
			thisAnimale = new Furetto(db, this.getIdAnimale());
			break;
		default:
			break;
		}

		this.insert(db);
		return this;

	}
	
	
	public EventoMutilazione build(ResultSet rs) throws Exception{
		try{	
			
			super.build(rs);
			buildRecord(rs);
		
		}catch (Exception e){
			throw e;
		}
	return this;
		}
	
	
}
