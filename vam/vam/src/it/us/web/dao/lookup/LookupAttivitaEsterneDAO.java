package it.us.web.dao.lookup;

import it.us.web.bean.BUtente;
import it.us.web.bean.SuperUtente;
import it.us.web.bean.sinantropi.lookup.LookupSinantropiEta;
import it.us.web.bean.vam.Animale;
import it.us.web.bean.vam.Clinica;
import it.us.web.bean.vam.lookup.LookupAccettazioneAttivitaEsterna;
import it.us.web.bean.vam.lookup.LookupAsl;
import it.us.web.bean.vam.lookup.LookupTipoTrasferimento;
import it.us.web.constants.Sql;
import it.us.web.dao.GenericDAO;
import it.us.web.dao.hibernate.Persistence;
import it.us.web.util.Md5;
import it.us.web.util.bean.Bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.apache.commons.beanutils.BeanUtils;
import org.hibernate.criterion.Restrictions;
import org.infinispan.loaders.modifications.Prepare;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class LookupAttivitaEsterneDAO extends GenericDAO
{
	private static final Logger logger = LoggerFactory.getLogger( LookupAttivitaEsterneDAO.class );
	
	/**
	 * Obsoleto
	 * @param un
	 * @param pw
	 * @param persistence
	 * @return
	 */
	public static LookupAccettazioneAttivitaEsterna getAttivitaEsterna( int id, Connection connection ) throws SQLException
	{
		LookupAccettazioneAttivitaEsterna att = new LookupAccettazioneAttivitaEsterna();
		String sql = "select id,description,enabled from lookup_accettazione_attivita_esterna where enabled and id = ? " ;
		PreparedStatement st = connection.prepareStatement(sql);
		st.setInt(1, id);
		ResultSet rs = st.executeQuery();
		
		if(rs.next())
		{
			att.setDescription(rs.getString("description"));
			att.setId(rs.getInt("id"));
			att.setEnabled(rs.getBoolean("enabled"));
		}
		return att;
	}
	
	public static LookupAccettazioneAttivitaEsterna getAttivitaEsterna( ResultSet rs ) throws SQLException
	{
		LookupAccettazioneAttivitaEsterna att = new LookupAccettazioneAttivitaEsterna();
		att.setDescription(rs.getString("description"));
		att.setId(rs.getInt("id"));
		att.setEnabled(rs.getBoolean("enabled"));
		return att;
	}
	
	
	
	public static ArrayList<LookupAccettazioneAttivitaEsterna> getAttivitaEsterne(Connection connection) throws SQLException
	{
		ArrayList<LookupAccettazioneAttivitaEsterna> atts = new ArrayList<LookupAccettazioneAttivitaEsterna>();
		String sql = "select id, description,enabled from lookup_accettazione_attivita_esterna where enabled order by id asc " ;
		PreparedStatement st = connection.prepareStatement(sql);
		ResultSet rs = st.executeQuery();
		
		while(rs.next())
		{
			atts.add(getAttivitaEsterna(rs));
		}
		return atts;
	}
	
	
}
