package it.us.web.util.vam;


import it.us.web.bean.vam.EsameIstopatologico;
import it.us.web.dao.hibernate.Persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DecimalFormat;
import java.util.ArrayList;

public class IstopatologicoUtil {
	
private static final DecimalFormat decimalFormat = new DecimalFormat( "00000" );
	
	public static String getNumero (Connection conn) throws Exception {
		
		int numero = 1;
		
		int lastId = getLastIstopatologico(conn);
		
		if (lastId > 0) {			
			numero = lastId + 1;
		}
		else {
			numero = 1;
		}
		
		return "IST"+decimalFormat.format(numero);
	}
	
	public static int getLastIstopatologico(Connection connection) {
		PreparedStatement stat = null;
		ResultSet rs = null;
		int nextProgressivo = 0;

		try {
			stat = connection.prepareStatement("select max(id) as progressivo "
					+ " from esame_istopatologico ");
			rs = stat.executeQuery();

			if (rs.next()) 
			{
				nextProgressivo = rs.getInt("progressivo");
			}

		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
		} 
		finally 
		{
			close(rs, stat, null);
		}

		return nextProgressivo;
	}
	
	
	
	public static void close( ResultSet rs, Statement st, Connection conn )
	{
		close( rs );
		close( st );
		close( conn );
	}
	
	
	public static void close( ResultSet rs )
	{
		if( rs != null )
		{
			try
			{
				rs.clearWarnings();
				rs.close();
			}
			catch (Exception e)
			{
				e.printStackTrace();
			}
		}
	}

	public static void close( Statement st )
	{
		if( st != null )
		{
			try
			{
				st.clearWarnings();
				st.close();
			}
			catch (SQLException e)
			{
				e.printStackTrace();
			}
		}
	}
	
	public static void close( Connection conn )
	{
		if( conn != null )
		{
			try
			{
				conn.clearWarnings();
				conn.close();
			}
			catch (SQLException e)
			{
				e.printStackTrace();
			}
		}
	}

}
