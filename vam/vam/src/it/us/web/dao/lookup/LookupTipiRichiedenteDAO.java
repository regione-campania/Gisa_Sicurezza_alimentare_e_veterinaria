package it.us.web.dao.lookup;

import it.us.web.bean.BUtente;
import it.us.web.bean.SuperUtente;
import it.us.web.bean.sinantropi.lookup.LookupSinantropiEta;
import it.us.web.bean.vam.Animale;
import it.us.web.bean.vam.Clinica;
import it.us.web.bean.vam.lookup.LookupAccettazioneAttivitaEsterna;
import it.us.web.bean.vam.lookup.LookupAsl;
import it.us.web.bean.vam.lookup.LookupAssociazioni;
import it.us.web.bean.vam.lookup.LookupTipiRichiedente;
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

public class LookupTipiRichiedenteDAO extends GenericDAO
{
	private static final Logger logger = LoggerFactory.getLogger( LookupTipiRichiedenteDAO.class );
	
	/**
	 * Obsoleto
	 * @param un
	 * @param pw
	 * @param persistence
	 * @return
	 */
	public static LookupTipiRichiedente getTipoRichiedente( int id, Connection connection ) throws SQLException
	{
		LookupTipiRichiedente tipi = new LookupTipiRichiedente();
		String sql = "select id,description,level,enabled,forza_pubblica from lookup_tipi_richiedente where enabled and id = ? " ;
		PreparedStatement st = connection.prepareStatement(sql);
		st.setInt(1, id);
		ResultSet rs = st.executeQuery();
		
		if(rs.next())
		{
			tipi.setId(rs.getInt("id"));
			tipi.setDescription(rs.getString("description"));
			tipi.setEnabled(rs.getBoolean("enabled"));
			tipi.setLevel(rs.getInt("level"));
			tipi.setForzaPubblica(rs.getBoolean("forza_pubblica"));
		}
		return tipi;
	}
	
	
	
	public static LookupTipiRichiedente getTipoRichiedente( ResultSet rs ) throws SQLException
	{
		LookupTipiRichiedente tipo = new LookupTipiRichiedente();
		tipo.setId(rs.getInt("id"));
		tipo.setDescription(rs.getString("description"));
		tipo.setEnabled(rs.getBoolean("enabled"));
		tipo.setLevel(rs.getInt("level"));
		tipo.setForzaPubblica(rs.getBoolean("forza_pubblica"));
		return tipo;
	}
	
	
	
	public static ArrayList<LookupTipiRichiedente> getTipiRichiedente(Connection connection) throws SQLException
	{
		ArrayList<LookupTipiRichiedente> tipi = new ArrayList<LookupTipiRichiedente>();
		String sql = "select id,description,level,enabled,forza_pubblica from lookup_tipi_richiedente where enabled order by level asc " ;
		PreparedStatement st = connection.prepareStatement(sql);
		ResultSet rs = st.executeQuery();
		
		while(rs.next())
		{
			tipi.add(getTipoRichiedente(rs));
		}
		return tipi;
	}
	
	
}
