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

public class EventoRiconoscimentoPassaporto extends Evento {
	


	public static final int idTipologiaDB = 64;
	
	// Dati evento rilascio passaporto
	private int id = -1;
	private int idEvento = -1; 
	private java.sql.Timestamp dataRilascioPassaporto;
	private java.sql.Timestamp dataScadenzaPassaporto;
	private String numeroPassaporto;
//	private boolean flagRinnovo = false;
	private boolean flagPassaportoAttivo = true;
//	private boolean flagSmarrimento = false;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	
	public boolean isFlagPassaportoAttivo() {
		return flagPassaportoAttivo;
	}

	public void setFlagPassaportoAttivo(boolean flagPassaportoAttivo) {
		this.flagPassaportoAttivo = flagPassaportoAttivo;
	}

	public int getIdEvento() {
		return idEvento;
	}

	public void setIdEvento(int idEvento) {
		this.idEvento = idEvento;
	}

	public java.sql.Timestamp getDataRilascioPassaporto() {
		return dataRilascioPassaporto;
	}

	public void setDataRilascioPassaporto(java.sql.Timestamp dataRilascioPassaporto) {
		this.dataRilascioPassaporto = dataRilascioPassaporto;
	}

	public void setDataRilascioPassaporto(String data) {
		this.dataRilascioPassaporto = DateUtils.parseDateStringNew(data, "dd/MM/yyyy");
	}

	public java.sql.Timestamp getDataScadenzaPassaporto() {
		return dataScadenzaPassaporto;
	}

	public void setDataScadenzaPassaporto(java.sql.Timestamp dataScadenzaPassaporto) {
		this.dataScadenzaPassaporto = dataScadenzaPassaporto;
	}

	public void setDataScadenzaPassaporto(String dataScadenzaPassaporto) {
		this.dataScadenzaPassaporto = DateUtils.parseDateStringNew(dataScadenzaPassaporto, "dd/MM/yyyy");
	}

	public String getNumeroPassaporto() {
		return numeroPassaporto;
	}

	public void setNumeroPassaporto(String numeroPassaporto) {
		this.numeroPassaporto = numeroPassaporto;
	}

	public boolean insert(Connection db) throws SQLException {
		
		StringBuffer sql = new StringBuffer();
		try {
			
			
			super.insert(db);
			idEvento = super.getIdEvento();

			id = DatabaseUtils.getNextSeq(db, "evento_riconoscimento_passaporto_id_seq");
			// sql.append("INSERT INTO animale (");

			sql.append("INSERT INTO evento_riconoscimento_passaporto( id_evento, data_rilascio_passaporto,  flag_passaporto_attuale ");

			if (dataScadenzaPassaporto != null) {
				sql.append(", data_scadenza_passaporto ");
			}

			if (numeroPassaporto != null && !"".equals(numeroPassaporto)) {
				sql.append(",numero_passaporto ");
			}

			sql.append(")VALUES(?, ?, ?");

			if (dataScadenzaPassaporto != null) {
				sql.append(", ? ");
			}

			if (numeroPassaporto != null && !"".equals(numeroPassaporto)) {
				sql.append(",?");
			}

			sql.append(")");

			int i = 0;
			PreparedStatement pst = db.prepareStatement(sql.toString());

			pst.setInt(++i, idEvento);

			pst.setTimestamp(++i, dataRilascioPassaporto);
			pst.setBoolean(++i, flagPassaportoAttivo);

			if (dataScadenzaPassaporto != null) {
				pst.setTimestamp(++i, dataScadenzaPassaporto);
			}

			if (numeroPassaporto != null && !"".equals(numeroPassaporto)) {
				pst.setString(++i, numeroPassaporto);
			}

			pst.execute();
			pst.close();

			this.id = DatabaseUtils.getCurrVal(db, "evento_riconoscimento_passaporto_id_seq", id);

			

		} catch (SQLException e) {
			
			throw new SQLException(e.getMessage());
		} finally {
			
		}
		return true;

	}

	public EventoRiconoscimentoPassaporto() {
		super();
		// TODO Auto-generated constructor stub
	}

	public EventoRiconoscimentoPassaporto(ResultSet rs) throws SQLException {
		buildRecord(rs);
	}

	protected void buildRecord(ResultSet rs) throws SQLException {

		super.buildRecord(rs);
		this.idEvento = rs.getInt("idevento");
		this.id = rs.getInt("id");
		this.dataRilascioPassaporto = rs.getTimestamp("data_rilascio_passaporto");
		this.dataScadenzaPassaporto = rs.getTimestamp("data_scadenza_passaporto");
		this.numeroPassaporto = rs.getString("numero_passaporto");
		this.flagPassaportoAttivo = rs.getBoolean("flag_passaporto_attuale");


	}


	public EventoRiconoscimentoPassaporto(Connection db, int idEventoPadre) throws SQLException {

		// super(db, idEventoPadre);

		PreparedStatement pst = db
				.prepareStatement("Select *, e.id_evento as idevento, e.id_asl as idaslinserimentoevento from evento e left join evento_riconoscimento_passaporto f on (e.id_evento = f.id_evento) where e.id_evento = ?");
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

	public void GetPassaportoAttivoByIdAnimale(Connection db, int idAnimale) throws SQLException {

		// super(db, idEventoPadre);

		PreparedStatement pst = db
				.prepareStatement("Select *, e.id_evento as idevento, e.id_asl as idaslinserimentoevento from evento e left join evento_riconoscimento_passaporto f on (e.id_evento = f.id_evento) where e.id_animale = ? and f.flag_passaporto_attuale = true");
		pst.setInt(1, idAnimale);
		ResultSet rs = DatabaseUtils.executeQuery(db, pst);
		if (rs.next()) {
			buildRecord(rs);
		}

		if (idAnimale == -1) {
			throw new SQLException(Constants.NOT_FOUND_ERROR);
		}

		rs.close();
		pst.close();

	}

	public int updateRegistrazione(Connection conn) {
		int result = -1;

		try {
			StringBuffer sql = new StringBuffer();

			sql.append("update evento_riconoscimento_passaporto set flag_passaporto_attuale = ? where id = ?");
			PreparedStatement pst = conn.prepareStatement(sql.toString());

			int i = 0;
			pst.setBoolean(++i, this.flagPassaportoAttivo);
			pst.setInt(++i, this.getId());

			result = pst.executeUpdate();
			pst.close();

		} catch (Exception e) {
			System.out.println(e);
		}

		return result;
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

			sql.append("update evento_riconoscimento_passaporto set numero_passaporto = ?, data_rilascio_passaporto = ?, data_scadenza_passaporto = ? where id_evento = ?");
			PreparedStatement pst = conn.prepareStatement(sql.toString());

			int i = 0;
			pst.setString(++i, this.numeroPassaporto);
			pst.setTimestamp(++i, this.dataRilascioPassaporto);
			pst.setTimestamp(++i, this.dataScadenzaPassaporto);
			pst.setInt(++i, this.getIdEvento());

			result = pst.executeUpdate();
			pst.close();
			
		} catch (SQLException e) {
			
			throw new SQLException(e.getMessage());
		}

		return result;
	}

	public EventoRiconoscimentoPassaporto salvaRegistrazione(int userId, int userRole, int userAsl, Animale thisAnimale,
			Connection db) throws Exception {
		try {

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

//			if (this.getIdTipologiaEvento() == this.idTipologiaDB) {
//
//				// SETTO COME NON ATTIVA ULTIMA REGISTRAZIONE DI RILASCIO
//				// PASSAPORTO
//				EventoRilascioPassaporto oldRegistrazionePassaporto = new EventoRilascioPassaporto();
//				oldRegistrazionePassaporto.GetPassaportoAttivoByIdAnimale(db, thisAnimale.getIdAnimale());
//				oldRegistrazionePassaporto.setFlagPassaportoAttivo(false);
//				oldRegistrazionePassaporto.updateRegistrazione(db);
//
//				//this.setFlagRinnovo(true);
//
//			}
			this.insert(db);
			thisAnimale.setDataRilascioPassaporto(this.getDataRilascioPassaporto());
			thisAnimale.setNumeroPassaporto(this.getNumeroPassaporto());
			
			//Aggiorno BANCA DATI APRIORI PASSAPORTI
			
//			Passaporto thisPassaporto = new Passaporto();
//			
//			thisPassaporto = thisPassaporto.load(this.getNumeroPassaporto(), db);
//			if (thisPassaporto != null && thisPassaporto.getId() > 0){
//			thisPassaporto.setIdUtenteUtilizzo(this.getEnteredby()); 
//			thisPassaporto.setIdAnimale(this.getIdAnimale());
//			thisPassaporto.setIdSpecie(this.getSpecieAnimaleId());
//			thisPassaporto.setPassaportoUtilizzato(db);
//			}

			aggiornaFlagFuoriDominioAsl(db, thisAnimale, userAsl, oldAnimale);
			aggiornaStatoAnimale(db, thisAnimale);

		} catch (Exception e) {
			throw e;
		}

		return this;

	}
	
	public EventoRiconoscimentoPassaporto build(ResultSet rs) throws Exception {
		try {

			super.build(rs);
			buildRecord(rs);

		} catch (Exception e) {
			throw e;
		}
		return this;
	}
	
	
//	public static EsitoControllo checkValorePassaporto(String valore, int idAsl, int idAnimale)
//	{
//		EsitoControllo controllo = new EsitoControllo();
//		Connection conn = null;
//		ResultSet rs = null;
//		PreparedStatement pst = null;
//
//		try {
//			conn = GestoreConnessioni.getConnection();
//
//			pst = conn
//					.prepareStatement("select * from public_functions.check_passaporto('"
//							+ valore + "'," + idAsl + ", "+ idAnimale +")");
//			
//			rs = pst.executeQuery();
//			
//			if (rs.next()) {
//				controllo.setIdEsito(rs.getInt(1));
//				controllo.setDescrizione(rs.getString(2));
//			}
//
//
//		} catch (Exception e) {
//			e.printStackTrace();
//		} finally {
//			GestoreConnessioni.freeConnection(conn);
//			// DbUtil.chiudiConnessioneJDBC(rs, pst, conn);
//
//		}
//
//	
//		return controllo;
//	}


}
