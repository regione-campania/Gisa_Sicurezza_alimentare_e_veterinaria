package org.aspcfs.modules.registrazioniAnimali.base;

import java.net.UnknownHostException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.aspcfs.modules.anagrafe_animali.base.Animale;
import org.aspcfs.modules.anagrafe_animali.base.Cane;
import org.aspcfs.modules.anagrafe_animali.base.Furetto;
import org.aspcfs.modules.anagrafe_animali.base.Gatto;
import org.aspcfs.modules.base.Constants;
import org.aspcfs.modules.opu.base.LineaProduttiva;
import org.aspcfs.modules.opu.base.Operatore;
import org.aspcfs.modules.opu.base.Stabilimento;
import org.aspcfs.utils.DatabaseUtils;
import org.aspcfs.utils.DateUtils;
import org.aspcfs.utils.GestoreConnessioni;

public class EventoAdozioneDaCanile extends Evento {

	public static final int idTipologiaDB = 13;
	public static final int idTipologiaAdozionePerCaniliDB = 61;

	private int id = -1;
	private int idEvento = -1;
	private java.sql.Timestamp dataAdozione;
	private int idComuneDestinazione = -1;
	private int idAslDestinatariaAdozione = -1;
	private int idProprietario = -1;
	private int idVecchioProprietario = -1; // sindaco o canile
	private int idVecchioDetentore = -1; // canile
	private String luogoAdozione;

	public EventoAdozioneDaCanile() {
		super();
		// TODO Auto-generated constructor stub
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getIdEvento() {
		return idEvento;
	}

	public void setIdEvento(int idEvento) {
		this.idEvento = idEvento;
	}

	public java.sql.Timestamp getDataAdozione() {
		return dataAdozione;
	}

	public void setDataAdozione(java.sql.Timestamp dataAdozione) {
		this.dataAdozione = dataAdozione;
	}

	public void setDataAdozione(String dataAdozione) {
		this.dataAdozione = DateUtils.parseDateStringNew(dataAdozione,
				"dd/MM/yyyy");
	}

	public int getIdComuneDestinazione() {
		return idComuneDestinazione;
	}

	public void setIdComuneDestinazione(int idComuneDestinazione) {
		this.idComuneDestinazione = idComuneDestinazione;
	}

	public void setIdComuneDestinazione(String idComuneDestinazione) {
		this.idComuneDestinazione = new Integer(idComuneDestinazione)
				.intValue();
	}

	public int getIdAslDestinatariaAdozione() {
		return idAslDestinatariaAdozione;
	}

	public void setIdAslDestinatariaAdozione(int idAsl) {
		this.idAslDestinatariaAdozione = idAsl;
	}

	public void setIdAslDestinatariaAdozione(String idAsl) {
		this.idAslDestinatariaAdozione = new Integer(idAsl).intValue();
	}

	public int getIdProprietario() {
		return idProprietario;
	}

	public void setIdProprietario(int idProprietario) {
		this.idProprietario = idProprietario;
	}

	public void setIdProprietario(String idProprietario) {
		this.idProprietario = new Integer(idProprietario).intValue();
	}

	public int getIdVecchioProprietario() {
		return idVecchioProprietario;
	}

	public void setIdVecchioProprietario(int idVecchioProprietario) {
		this.idVecchioProprietario = idVecchioProprietario;
	}

	public void setIdVecchioProprietario(String idVecchioProprietario) {
		this.idVecchioProprietario = new Integer(idVecchioProprietario)
				.intValue();
	}

	public String getLuogoAdozione() {
		return luogoAdozione;
	}

	public void setLuogoAdozione(String luogoAdozione) {
		this.luogoAdozione = luogoAdozione;
	}

	public int getIdVecchioDetentore() {
		return idVecchioDetentore;
	}

	public void setIdVecchioDetentore(int idVecchioDetentore) {
		this.idVecchioDetentore = idVecchioDetentore;
	}

	public boolean insert(Connection db) throws SQLException {

		StringBuffer sql = new StringBuffer();
	
		try {

			super.insert(db);
			idEvento = super.getIdEvento();

			

			id = DatabaseUtils.getNextSeq(db,
					"evento_adozione_da_canile_id_seq");
			// sql.append("INSERT INTO animale (");

			sql.append(" INSERT INTO evento_adozione_da_canile("
					+ "id_evento, data_adozione");

			if (idComuneDestinazione > -1) {
				sql.append(", id_comune_destinazione");
			}

			if (idAslDestinatariaAdozione > -1) {
				sql.append(",id_asl_destinataria_adozione");
			}

			if (idProprietario > -1) {
				sql.append(",id_proprietario_adozione");
			}

			if (idVecchioProprietario > -1) {

				sql.append(",id_vecchio_proprietario_adozione");
			}

			if (idVecchioDetentore > -1) {
				sql.append(", id_vecchio_detentore_adozione");
			}

			sql.append(")VALUES(?,?");

			if (idComuneDestinazione != -1) {
				sql.append(",?");
			}

			if (idAslDestinatariaAdozione > -1) {
				sql.append(",?");
			}

			if (idProprietario > -1) {
				sql.append(",?");
			}

			if (idVecchioProprietario > -1) {

				sql.append(",?");
			}

			if (idVecchioDetentore > -1) {
				sql.append(", ?");
			}

			sql.append(")");

			int i = 0;
			PreparedStatement pst = db.prepareStatement(sql.toString());

			pst.setInt(++i, idEvento);

			pst.setTimestamp(++i, dataAdozione);

			if (idComuneDestinazione != -1) {
				pst.setInt(++i, idComuneDestinazione);
			}

			if (idAslDestinatariaAdozione > -1) {
				pst.setInt(++i, idAslDestinatariaAdozione);
			}

			if (idProprietario > -1) {
				pst.setInt(++i, idProprietario);
			}

			if (idVecchioProprietario > -1) {

				pst.setInt(++i, idVecchioProprietario);
			}

			if (idVecchioDetentore > -1) {
				pst.setInt(++i, idVecchioDetentore);
			}

			pst.execute();
			pst.close();

			this.id = DatabaseUtils.getCurrVal(db,
					"evento_adozione_da_canile_id_seq", id);


		} catch (SQLException e) {
		
			throw new SQLException(e.getMessage());
		} finally {
		
		}
		return true;

	}

	public EventoAdozioneDaCanile(ResultSet rs) throws SQLException {
		buildRecord(rs);
	}

	protected void buildRecord(ResultSet rs) throws SQLException {

		super.buildRecord(rs);
		this.idEvento = rs.getInt("idevento");
		this.dataAdozione = rs.getTimestamp("data_adozione");
		this.idAslDestinatariaAdozione = rs
				.getInt("id_asl_destinataria_adozione");
		this.idProprietario = rs.getInt("id_proprietario_adozione");
		this.idVecchioProprietario = rs.getInt("id_vecchio_proprietario_adozione");
		this.idVecchioDetentore = rs.getInt("id_vecchio_detentore_adozione");

		// buildSede(rs);
		// buildRappresentanteLegale(rs);

	}
	
	public EventoAdozioneDaCanile(Connection db, int idEventoPadre) throws SQLException {

	//	super(db, idEventoPadre);

		PreparedStatement pst = db
				.prepareStatement("Select *, e.id_evento as idevento, e.id_asl as idaslinserimentoevento from evento e left join evento_adozione_da_canile f on (e.id_evento = f.id_evento) where e.id_evento = ?");
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

	
	public Operatore getCanileProvenienza() throws UnknownHostException {
		
		Connection conn = null;
		int idOperatore = -1;
		Operatore operatore = null;
		try {
			//Thread t = Thread.currentThread();
			conn = GestoreConnessioni.getConnection();
//			String dbName = ApplicationProperties.getProperty("dbnameBdu");
//			String username = ApplicationProperties
//					.getProperty("usernameDbbdu");
//			String pwd = ApplicationProperties.getProperty("passwordDbbdu");
//			String host = InetAddress.getByName("hostDbBdu").getHostAddress();
//
//			conn = DbUtil.getConnection(dbName, username, pwd, host);



		
				idOperatore = this.getIdVecchioDetentore();
				

			

			if (idOperatore != -1 && idOperatore != 0) {
			//	
				operatore = new Operatore();
				operatore
						.queryRecordOperatorebyIdLineaProduttiva(conn,
								idOperatore);
			}

			//GestoreConnessioni.freeConnection(conn);
			//DbUtil.chiudiConnessioneJDBC(null, null, conn);
			//conn = null;
		} catch (SQLException e) {
			
			e.printStackTrace();
		}finally{
			GestoreConnessioni.freeConnection(conn);
		}

		return operatore;
	}
	
	
	public Operatore getSindacoProvenienza() throws UnknownHostException {
		
		Connection conn = null;
		int idOperatore = -1;
		Operatore operatore = null;
		try {
			//Thread t = Thread.currentThread();
			conn = GestoreConnessioni.getConnection();
//			String dbName = ApplicationProperties.getProperty("dbnameBdu");
//			String username = ApplicationProperties
//					.getProperty("usernameDbbdu");
//			String pwd = ApplicationProperties.getProperty("passwordDbbdu");
//			String host = InetAddress.getByName("hostDbBdu").getHostAddress();
//
//			conn = DbUtil.getConnection(dbName, username, pwd, host);



		
				idOperatore = this.getIdVecchioProprietario();
				

			

			if (idOperatore != -1 && idOperatore != 0) {
			//	
				operatore = new Operatore();
				operatore
						.queryRecordOperatorebyIdLineaProduttiva(conn,
								idOperatore);
			}

			//GestoreConnessioni.freeConnection(conn);
			//DbUtil.chiudiConnessioneJDBC(null, null, conn);
		//	conn = null;
		} catch (SQLException e) {
			
			e.printStackTrace();
		}finally{
			GestoreConnessioni.freeConnection(conn);
		}

		return operatore;
	}
	
	
	public Operatore getNuovoProprietario() throws UnknownHostException {
		
		Connection conn = null;
		int idOperatore = -1;
		Operatore operatore = null;
		try {
			//Thread t = Thread.currentThread();
			conn = GestoreConnessioni.getConnection();
//			String dbName = ApplicationProperties.getProperty("dbnameBdu");
//			String username = ApplicationProperties
//					.getProperty("usernameDbbdu");
//			String pwd = ApplicationProperties.getProperty("passwordDbbdu");
//			String host = InetAddress.getByName("hostDbBdu").getHostAddress();
//
//			conn = DbUtil.getConnection(dbName, username, pwd, host);



		
				idOperatore = this.getIdProprietario();
				

			

			if (idOperatore != -1 && idOperatore != 0) {
			//	
				operatore = new Operatore();
				operatore.queryRecordOperatorebyIdLineaProduttiva(conn,idOperatore);
			}

			//GestoreConnessioni.freeConnection(conn);
			//DbUtil.chiudiConnessioneJDBC(null, null, conn);
			//conn = null;
		} catch (SQLException e) {
			
			e.printStackTrace();
		}finally{
			GestoreConnessioni.freeConnection(conn);
		}

		return operatore;
	}
	
	public void getEventoAdozione(Connection db, int idAnimale) throws SQLException {

		//	super(db, idEventoPadre);

			PreparedStatement pst = db
					.prepareStatement("Select f.*, e.*, e.id_evento as idevento,  e.id_asl as idaslinserimentoevento  from animale a left join  evento e on  (a.id = e.id_animale) left join evento_adozione_da_canile f on (e.id_evento = f.id_evento) where a.id = ? and e.id_tipologia_evento = ?");
			pst.setInt(1, idAnimale);
			pst.setInt(2, idTipologiaDB);
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
	
	public EventoAdozioneDaCanile salvaRegistrazione(int userId,
			int userRole, int userAsl, Animale thisAnimale, Connection db)
			throws Exception {
		try {

			super.salvaRegistrazione(userId, userRole, userAsl, thisAnimale, db);
		//	
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


			// Animale oldAnimale = new Animale(db, dettagli_base
			// .getIdAnimale());
			// Mi conservo l'informazione sul vecchio proprietario, che
			// sar�
			// in questo caso o di tipo sindaco o di tipo canile
			if (oldAnimale.getProprietario() != null
					&& (oldAnimale.getProprietario()
							.getListaStabilimenti().size()) > 0) {
				Stabilimento stab = (Stabilimento) oldAnimale
						.getProprietario().getListaStabilimenti()
						.get(0);
				LineaProduttiva lineaP = (LineaProduttiva) stab
						.getListaLineeProduttive().get(0);
				this.setIdVecchioProprietario(lineaP.getId());
			}

			// thisCane = new Cane(db, oldAnimale.getIdAnimale());
			if (oldAnimale.getDetentore() != null
					&& oldAnimale.getDetentore()
							.getListaStabilimenti().size() > 0) {
				Stabilimento stab = (Stabilimento) oldAnimale
						.getDetentore().getListaStabilimenti().get(0);
				LineaProduttiva lineaP = (LineaProduttiva) stab
						.getListaLineeProduttive().get(0);
				this.setIdVecchioDetentore(lineaP.getId());

			
			}
			// thisAnimale.setIdProprietario(adozione.getIdProprietario());
			Operatore newProp = new Operatore();
			newProp.queryRecordOperatorebyIdLineaProduttiva(db,
					this.getIdProprietario());
			Stabilimento stabProp = (Stabilimento) newProp
					.getListaStabilimenti().get(0);
			int idAsl = stabProp.getIdAsl();
			// LineaProduttiva lineaProp = (LineaProduttiva)
			// stabProp.getListaLineeProduttive().get(0);
			this.setIdAslDestinatariaAdozione(idAsl);
			thisAnimale.setIdAslRiferimento(idAsl);
			thisAnimale.setIdProprietario(this.getIdProprietario());
			thisAnimale.setIdDetentore(this.getIdProprietario());
			this.insert(db);
			
			aggiornaFlagFuoriDominioAsl(db, thisAnimale,  userAsl,  oldAnimale);
			aggiornaStatoAnimale(db, thisAnimale);

		} catch (Exception e) {
			throw e;
		}

		return this;

	}
	
	public EventoAdozioneDaCanile build(ResultSet rs) throws Exception{
		try{	
			
			super.build(rs);
			buildRecord(rs);
		
		}catch (Exception e){
			throw e;
		}
	return this;
		}
	
}
