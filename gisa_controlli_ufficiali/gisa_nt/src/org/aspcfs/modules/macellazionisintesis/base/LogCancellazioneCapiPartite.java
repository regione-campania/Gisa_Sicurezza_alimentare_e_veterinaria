package org.aspcfs.modules.macellazionisintesis.base;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import com.darkhorseventures.framework.beans.GenericBean;

public class LogCancellazioneCapiPartite extends GenericBean
{
	private static final long serialVersionUID = 8313006891554941893L;
	
	private int idCapo = -1;
	private int idPartita = -1;
	private String matricola = null;
	private String numero = null;
	private int idUtente = -1;
	private Timestamp dataOperazione = null;
	private String tipoOperazione = null;
	private String note = null;
	
	
	public LogCancellazioneCapiPartite(ResultSet rs) throws SQLException {
		buildRecord(rs);	
		}


	public LogCancellazioneCapiPartite() {
		// TODO Auto-generated constructor stub
	}


	private void buildRecord(ResultSet rs) throws SQLException {
		this.idCapo = rs.getInt("id_capo");		
		this.idPartita = rs.getInt("id_partita");		
		this.matricola = rs.getString("matricola");		
		this.numero = rs.getString("numero");		
		this.idUtente = rs.getInt("id_utente");		
		this.dataOperazione = rs.getTimestamp("data_operazione");		
		this.tipoOperazione = rs.getString("tipo_operazione");		
		this.note = rs.getString("note");		

	}


	public int getIdCapo() {
		return idCapo;
	}


	public void setIdCapo(int idCapo) {
		this.idCapo = idCapo;
	}


	public int getIdPartita() {
		return idPartita;
	}


	public void setIdPartita(int idPartita) {
		this.idPartita = idPartita;
	}


	public String getMatricola() {
		return matricola;
	}


	public void setMatricola(String matricola) {
		this.matricola = matricola;
	}


	public String getNumero() {
		return numero;
	}


	public void setNumero(String numero) {
		this.numero = numero;
	}


	public int getIdUtente() {
		return idUtente;
	}


	public void setIdUtente(int idUtente) {
		this.idUtente = idUtente;
	}


	public Timestamp getDataOperazione() {
		return dataOperazione;
	}


	public void setDataOperazione(Timestamp dataOperazione) {
		this.dataOperazione = dataOperazione;
	}


	public String getTipoOperazione() {
		return tipoOperazione;
	}


	public void setTipoOperazione(String tipoOperazione) {
		this.tipoOperazione = tipoOperazione;
	}


	public String getNote() {
		return note;
	}


	public void setNote(String note) {
		this.note = note;
	}


	public void insert(Connection db) throws SQLException{
		PreparedStatement pst = null;
		String sql = "insert into m_log_operazioni_cancellazione (id_capo, id_partita, matricola, numero, id_utente, data_operazione, note, tipo_operazione) values (?, ?, ?, ?, ?, ?, ?, ?)";
		pst = db.prepareStatement(sql);
		int i = 0;
		pst.setInt(++i, idCapo);
		pst.setInt(++i, idPartita);
		pst.setString(++i, matricola);
		pst.setString(++i, numero);
		pst.setInt(++i, idUtente);
		pst.setTimestamp(++i, dataOperazione);
		pst.setString(++i, note);
		pst.setString(++i, tipoOperazione);
		pst.executeUpdate();
	}
	
	public static ArrayList<LogCancellazioneCapiPartite> loadCapiPartiteCancellati (Connection db) throws SQLException {
		ArrayList<LogCancellazioneCapiPartite> lista = new ArrayList<LogCancellazioneCapiPartite>();
		
		PreparedStatement pst = null;
		String sql = "select * from m_log_operazioni_cancellazione order by data_operazione DESC";
		pst = db.prepareStatement(sql);
		ResultSet rs = pst.executeQuery();
		while (rs.next()){
			LogCancellazioneCapiPartite log = new LogCancellazioneCapiPartite(rs);
			lista.add(log);
		}
		return lista;
	}
	
}
