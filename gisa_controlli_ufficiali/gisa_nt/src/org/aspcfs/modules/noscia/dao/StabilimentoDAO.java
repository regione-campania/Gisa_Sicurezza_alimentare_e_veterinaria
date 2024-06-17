package org.aspcfs.modules.noscia.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.aspcfs.modules.gestioneanagrafica.base.Stabilimento;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;



public class StabilimentoDAO extends GenericDAO
{
	
	private static final Logger logger = LoggerFactory.getLogger( StabilimentoDAO.class );
	
	public Stabilimento stabilimento;
	
	//Costruttore 1: tutti i filtri vuoti - utile per tirare fuori tutti i record
	public StabilimentoDAO(){}
	
	
	public StabilimentoDAO(Integer id)
	{
		stabilimento = new Stabilimento(id);
	}
	
	public StabilimentoDAO(Stabilimento stabilimento) 
	{
		this.stabilimento=stabilimento;
	}


	
	
	public Integer getStabEsistente(Connection conn) throws SQLException 
	{
		Integer idStabilimento = null;
		String sql = "select * from public_functions.cerca_verifica_esistenza_stabilimento(?,?,?,?,?,?)";
				
		
		PreparedStatement st = conn.prepareStatement(sql);
		st.setString( 1 ,stabilimento.getImpresa().getPiva() );
		st.setString( 2 ,stabilimento.getImpresa().getCodfisc());
		st.setObject( 3 ,stabilimento.getIndirizzo().getComune().getId() );
		st.setString( 4 ,stabilimento.getIndirizzo().getVia() );
		st.setString( 5 ,stabilimento.getIndirizzo().getCivico() );
		st.setObject( 6 ,stabilimento.getIndirizzo().getToponimo().getCode() );
		
		ResultSet rs = st.executeQuery();
		
		if(rs.next())
		{
			idStabilimento = rs.getInt(1);
		}
		
		return idStabilimento;
	}
	
	public boolean exist(Connection conn) throws SQLException
	{
		Integer stab = getStabEsistente(conn);
		return stab!=null && stab>0;
	}


    @Override
    public ArrayList<?> getItems(Connection connection) throws SQLException {
        // TODO Auto-generated method stub
        return null;
    }
	
}
