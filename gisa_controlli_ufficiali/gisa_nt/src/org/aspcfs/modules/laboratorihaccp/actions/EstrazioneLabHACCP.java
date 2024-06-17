package org.aspcfs.modules.laboratorihaccp.actions;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.DynaBean;
import org.apache.commons.beanutils.RowSetDynaClass;
import org.aspcfs.modules.actions.CFSModule;

import com.darkhorseventures.framework.actions.ActionContext;

public final class EstrazioneLabHACCP extends CFSModule {

	private static final String squote = "<tr><td align=center>";
	private static final String equote = "</td></tr>";
	private static final String dquote = "</td><td align=center>";
	private static final String initialBold="<b>";
	private static final String endBold="</b>";
	
	
	private static final String blueFont = "<font color='blue'>";
	private static final String redFont = "<font color='red'>";
	private static final String endFont  = "</font>";
  
  public String executeCommandToElencoPerAnno(ActionContext context)
  {
	  if (!(hasPermission(context, "statistiche-view"))) {
		    return ("PermissionError");
		  }
	  
	     return "ToElencoOK";
  }
  
  
  
  public String executeCommandExcel(ActionContext context)
  {
	  if (!(hasPermission(context, "statistiche-view"))) {
		    return ("PermissionError");
		  }
	  
	     return "Excel";
  }
  
    
  private String resolveAsl (Connection conn, int siteId) throws SQLException {
	  
	   
	  PreparedStatement stat =null;
	  
	  stat= conn.prepareStatement("select description from lookup_site_id where code= ? " );
	  stat.setInt(1,siteId);
	  	  
	  ResultSet			rs		= stat.executeQuery();
	  	
	  String aslName="";
	  
	  if (rs.next()) {
		  aslName = rs.getString(1);
	  }
	  
	  
	  return aslName;
	 
	  
	  
  }
  
  public String executeCommandElenco(ActionContext context) throws SQLException
  {
	if (!(hasPermission(context, "laboratori-estrazione-view")))
	{
		return ("PermissionError");
	}

    Connection		db		= null;
    RowSetDynaClass	rsdc	= null;
    String			fileName=null;
    
    try
	{
		db = getConnection(context);
		
		int siteId=this.getUserSiteId(context);
	    
		String aslName="";
	    
		//Se siteId!=-1 allora e' una ASL
	    if (siteId!=-1)
	    	aslName=this.resolveAsl(db, siteId);
		
	    		
		PreparedStatement	stat = null;
		
				
		//Se e' richiesta una estrazione depositi
		stat= db.prepareStatement( "select * from laboratorihaccp_view ORDER BY denom;" );
			
			
			fileName="LabHACCP_" +System.currentTimeMillis()+ ".xls";
	
		
		
		ResultSet			rs		= stat.executeQuery();
							rsdc	= new RowSetDynaClass(rs);
				
		HttpServletResponse res = context.getResponse();
	 	res.setContentType( "application/xls" );
	 	
	 	res.setHeader( "Content-Disposition","attachment; filename=\"" + fileName + "\";" ); 

	 	ServletOutputStream sout = res.getOutputStream();
	 	sout.write( "<table border=1>".getBytes() );
	 		 		 	
	 	List<DynaBean> l = rsdc.getRows();
	 	
	 	//stampa i nomi delle colonne
	 	dynamicHeader(rs, sout);
	 	
	 	for( int i = 0; i < l.size(); i++ )
	 	{
	 		//Stampa ogni riga sul file
	 		this.dynamicRow(l.get(i), rs, sout);
	 	}
	 	sout.write( "</table>".getBytes() );
	 	sout.flush();
		
	}
	catch ( Exception e )
	{
		e.printStackTrace();
		context.getRequest().setAttribute("Error", e);
		return ("SystemError");
    }
	finally
	{
		this.freeConnection(context, db);
		System.gc();
	}
	
	return "-none-";
  }

  /* Questo metodo serve a stampare, sulla prima riga del file 
   * XLS, i nomi degli attrbuti della tabella di riferimento.*/
  private void dynamicHeader (ResultSet rs , ServletOutputStream sout) throws IOException, SQLException {
	  
	  //Lo String Buffer
	  StringBuffer sb = new StringBuffer(); 
	  
	  //Serve ad ottenere i meta-dati del ResultSet
	  ResultSetMetaData rsmd=rs.getMetaData();
	  
	  //Il numero di attributi
	  int columnNumber=rsmd.getColumnCount();
	  
	  sb.append(squote);
		 
	  for (int i=1;i<=columnNumber;i++) {
		sb.append(initialBold);
		sb.append(blueFont);
		sb.append( rsmd.getColumnName(i) );
		sb.append(endFont);
		sb.append(endBold);
		if( i < columnNumber )
		{
			sb.append( dquote );
		}			
	 }
	  		
		sb.append( equote );
		sb.append( "\r\n" );
		
		sout.write( sb.toString().getBytes() );
	  
  }
  
  /* Questo metodo serve a stampare ogni tupla sul file*/
  private void dynamicRow (DynaBean dynaBean, ResultSet rs, ServletOutputStream sout) throws IOException, SQLException {
	  
	  //Lo String Buffer
	  StringBuffer sb = new StringBuffer(); 
	  
	  //Serve ad ottenere i meta-dati del ResultSet
	  ResultSetMetaData rsmd=rs.getMetaData();
	  
	  //Il numero di attributi
	  int columnNumber=rsmd.getColumnCount();
	  	  
	  sb.append(squote);
		 
	  for (int i=1;i<=columnNumber;i++) {
			
		sb.append( nullCheck( dynaBean, rsmd.getColumnName(i) ) );
		if( i < columnNumber )
		{
			sb.append( dquote );
		}
				
		}
	  		
		sb.append( equote );
		sb.append( "\r\n" );
		
		sout.write( sb.toString().getBytes() );
	  
	  
  }
  
  
private Object nullCheck( DynaBean dynaBean, String string )
{
	return (dynaBean.get( string ) == null) ? ("") : (dynaBean.get( string ));
}

	
}

