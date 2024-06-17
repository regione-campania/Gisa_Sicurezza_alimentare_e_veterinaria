/*
 *  Copyright(c) 2004 Dark Horse Ventures LLC (http://www.centriccrm.com/) All
 *  rights reserved. This material cannot be distributed without written
 *  permission from Dark Horse Ventures LLC. Permission to use, copy, and modify
 *  this material for internal use is hereby granted, provided that the above
 *  copyright notice and this permission notice appear in all copies. DARK HORSE
 *  VENTURES LLC MAKES NO REPRESENTATIONS AND EXTENDS NO WARRANTIES, EXPRESS OR
 *  IMPLIED, WITH RESPECT TO THE SOFTWARE, INCLUDING, BUT NOT LIMITED TO, THE
 *  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR ANY PARTICULAR
 *  PURPOSE, AND THE WARRANTY AGAINST INFRINGEMENT OF PATENTS OR OTHER
 *  INTELLECTUAL PROPERTY RIGHTS. THE SOFTWARE IS PROVIDED "AS IS", AND IN NO
 *  EVENT SHALL DARK HORSE VENTURES LLC OR ANY OF ITS AFFILIATES BE LIABLE FOR
 *  ANY DAMAGES, INCLUDING ANY LOST PROFITS OR OTHER INCIDENTAL OR CONSEQUENTIAL
 *  DAMAGES RELATING TO THE SOFTWARE.
 */
package org.aspcfs.modules.laboratorihaccp.base;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.sql.Types;
import java.text.DateFormat;
import java.util.Iterator;
import java.util.TimeZone;
import java.util.Vector;

import org.apache.log4j.Level;
import org.apache.log4j.Logger;
import org.aspcfs.modules.admin.base.User;
import org.aspcfs.modules.base.Constants;
import org.aspcfs.utils.DatabaseUtils;
import org.aspcfs.utils.DateUtils;
import org.aspcfs.utils.web.PagedListInfo;

import com.darkhorseventures.framework.actions.ActionContext;
import com.darkhorseventures.framework.beans.GenericBean;

/**
 * @author     chris
 * @created    July 12, 2001
 * @version    $Id: Organization.java,v 1.82.2.1 2004/07/26 20:46:39 kbhoopal
 *      Exp $
 */

public class Organization extends GenericBean {
 
  private static final long serialVersionUID =  4320567602597719168L;
  
  private static Logger log = Logger.getLogger(org.aspcfs.modules.laboratorihaccp.base.Organization.class);
    static {
      if (System.getProperty("DEBUG") != null) {
        log.setLevel(Level.DEBUG);
      }
    }
  
  
    private String name	;
  	private static final int TIPOLOGIA_LABHACCP = 152 ;

	private static final int INT = Types.INTEGER;

	private static final int STRING = Types.VARCHAR;

	private static final int DOUBLE = Types.DOUBLE;

	private static final int FLOAT = Types.FLOAT;

	private static final int TIMESTAMP = Types.TIMESTAMP;

	private static final int DATE = Types.DATE;

	private static final int BOOLEAN = Types.BOOLEAN;
  
  //protected double YTD = 0;
  private Vector comuni=new Vector();
  private OrganizationAddressList addressList = new OrganizationAddressList();
  private ElencoProve prove = new ElencoProve();
  private OrganizationList elenco_lab = new OrganizationList();
  private java.sql.Timestamp dataCambioStato = null;
 
  protected PagedListInfo pagedListInfo = null; 
  private String stato = null;
  private int siteId = -1;
  private int enteredBy = -1;
  private java.sql.Timestamp entered = null;
  private java.sql.Timestamp modified = null;
  private int modifiedBy = -1;
  private java.sql.Timestamp trashedDate = null;
  private String note1 = null;
  private java.sql.Timestamp dataVerificaAnnua = null;
  private int orgId ;
  private int categoriaRischio ;
  private int accountSize = -1;
  private String ip_entered;
  private String ip_modified ;
  private String partita_iva;
  private Timestamp dataProssimoControllo;	
  private String cognomeRappresentante = null;
  private String accountNumber = "";
  private boolean lab_originario = false ;
  private int tipologia = -1;
  private Timestamp date2;
  public void setAccountNumber(String accountNumber) {
	    this.accountNumber = accountNumber;
	  }
  
  private Timestamp dataInizio;
  
  public Timestamp getDataInizio()
  {
	  return this.dataInizio;
  }
  
  public void setDataInizio(Timestamp ts)
  {
	  this.dataInizio = ts;
  }
  
  
  private int statoLab = -1;
  public int getStatoLab(){return  this.statoLab;}
  public void setStatoLab(int s){this.statoLab = s;}
  /**
   *  Gets the id attribute of the Organization object
   *
   * @return    The id value
   */
  public int getId() {
    return orgId;
  }

  /**
   *  Gets the AccountNumber attribute of the Organization object
   *
   * @return    The AccountNumber value
   */
  public String getAccountNumber() {
	
	  return accountNumber;
  }

  
  public String getCognomeRappresentante() {
		return cognomeRappresentante;
	}

	public void setCognomeRappresentante(String cognomeRappresentante) {
		this.cognomeRappresentante = cognomeRappresentante;
	}
	
	public Timestamp getDataProssimoControllo() {
	return dataProssimoControllo;
	}

	public void setDataProssimoControllo(Timestamp dataProssimoControllo) {
	this.dataProssimoControllo = dataProssimoControllo;
	}

	public String getIp_entered() {
		return ip_entered;
	}

	public void setIp_entered(String ip_entered) {
		this.ip_entered = ip_entered;
	}

	public String getIp_modified() {
		return ip_modified;
	}
	public void setIp_modified(String ip_modified) {
		this.ip_modified = ip_modified;
	}

  
  public int getAccountSize() {
	return accountSize;
}

  

  public String getName() {
	return name;
}



public void setName(String name) {
	this.name = name;
}

public String getPartitaIva() {
	return partita_iva;
}

public void setPartitaIva(String pIva) {
	this.partita_iva = pIva;
}

public boolean getLab_originario() {
	return lab_originario;
}

public void setLab_originario(boolean l) {
	this.lab_originario = l;
}


public void setAccountSize(String tmp) {
	    this.accountSize = Integer.parseInt(tmp);
	  }



/**
   *  Constructor for the Organization object, creates an empty Organization
   *
   * @since    1.0
   */
  public Organization() { }


  /**
   *  Constructor for the Organization object
   *
   * @param  rs                Description of Parameter
   * @exception  SQLException  Description of the Exception
   * @throws  SQLException     Description of the Exception
   * @throws  SQLException     Description of Exception
   */
  public Organization(ResultSet rs) throws SQLException {
    buildRecord(rs);
    addressList.setOrgId(this.getOrgId());
    prove.setOrgId(this.getOrgId());
  }
  
   
  
  public int getOrgId() {
	return orgId;
}


public void setOrgId(int orgId) {
	this.orgId = orgId;
}


public int getCategoriaRischio() {
	return categoriaRischio;
}


public void setCategoriaRischio(int categoriaRischio) {
	this.categoriaRischio = categoriaRischio;
}


public Organization(Connection db, int orgId) throws SQLException {
	
	  
    if (orgId == -1) {
      throw new SQLException("Invalid Account");
    } 
    PreparedStatement pst = db.prepareStatement(
        "SELECT o.* " +
        "FROM organization o " +
        " where  o.org_id = ? " );
    pst.setInt(1, orgId);
    ResultSet rs = DatabaseUtils.executeQuery(db, pst, log);
    if (rs.next()) {
     
      
      addressList.setOrgId(orgId);
      addressList.buildList(db);
      
      prove.setOrgId(orgId);
      prove.buildList(db);
    
      buildRecord(rs);
    }
    rs.close();
    pst.close();
    if (orgId == -1) {
      throw new SQLException(Constants.NOT_FOUND_ERROR);
    }
     
  }


public Organization(Connection db, int orgId, boolean storico , String tipo, PagedListInfo listInfo) throws SQLException {
	
	  
    if (orgId == -1) {
      throw new SQLException("Invalid Account");
    } 
    
    PreparedStatement pst = db.prepareStatement(
            "SELECT o.* " +
            "FROM laboratorihaccp_storico_elenco_lab o " +
            " where  o.org_id = ? " );
   
    pst.setInt(1, orgId);
    ResultSet rs = DatabaseUtils.executeQuery(db, pst, log);
    if (rs.next()) {
     
      
      addressList.setOrgId(orgId);
      addressList.buildList(db);
      
      //Prepare pagedListInfo
      if(tipo.equals("lab")){
    	  elenco_lab.setPagedListInfo(listInfo);
    	  elenco_lab.buildListStorico(db, orgId);
      }
      else {
    	  prove.setPagedListInfo(listInfo);
          prove.setOrgId(orgId);
    	  prove.buildListStorico(db);  
      }
      
      buildRecord(rs);
    }
    rs.close();
    pst.close();
    if (orgId == -1) {
      throw new SQLException(Constants.NOT_FOUND_ERROR);
    }
     
  }


  

  public Vector getComuni () throws SQLException {
      
    return comuni;
   
  }

  public void setComuni (Connection db) throws SQLException {
		
	  	Statement st = null;
	    ResultSet rs = null;
	    StringBuffer sql = new StringBuffer();
	    
	    //sql.append("select comune from comuni where codiceistatasl= (select codiceistat from lookup_site_id where code= (select site_id from organization where org_id="+ this.getOrgId() + "))");
	    //if(codeUser==-1){
	        sql.append("select comune from comuni order by comune;");
	   /*}else{
	    sql.append("select comune from comuni where codiceistatasl= (select codiceistat from lookup_site_id where code= "+ codeUser + ")");
	    }*/
	    st = db.createStatement();
	    rs = st.executeQuery(sql.toString());
	    
	    while (rs.next()) {
	      comuni.add(rs.getString("comune"));
	    }
	    rs.close();
	    st.close();
	  
	}
  
  /**
   *  Sets the trashedDate attribute of the Organization object
   *
   * @param  tmp  The new trashedDate value
   */
  public void setTrashedDate(Timestamp tmp) {
    this.trashedDate = tmp;
  }


  /**
   *  Sets the trashedDate attribute of the Organization object
   *
   * @param  tmp  The new trashedDate value
   */
  public void setTrashedDate(String tmp) {
    this.trashedDate = DatabaseUtils.parseTimestamp(tmp);
  }

  /**
   *  Gets the trashedDate attribute of the Organization object
   *
   * @return    The trashedDate value
   */
  public Timestamp getTrashedDate() {
    return trashedDate;
  }
  /**
   *  Sets the Entered attribute of the Organization object
   *
   * @param  tmp  The new Entered value
   */
  public void setEntered(java.sql.Timestamp tmp) {
    this.entered = tmp;
  }
  
  public void setDataCambioStato(java.sql.Timestamp tmp) {
	    this.dataCambioStato = tmp;
	  }

  public void setDataVerificaAnnua(java.sql.Timestamp tmp) {
	    this.dataVerificaAnnua = tmp;
	  }
  /**
   *  Sets the Modified attribute of the Organization object
   *
   * @param  tmp  The new Modified value
   */
  public void setModified(java.sql.Timestamp tmp) {
    this.modified = tmp;
  }

  public void setDataCambioStato(String tmp) {
	    this.dataCambioStato = DateUtils.parseDateStringNew(tmp, "dd/MM/yyyy");
	  }


public void setDataVerificaAnnua(String tmp) {
    this.dataVerificaAnnua = DateUtils.parseTimestampString(tmp);
  }

  /**
   *  Sets the entered attribute of the Organization object
   *
   * @param  tmp  The new entered value
   */
  public void setEntered(String tmp) {
    this.entered = DateUtils.parseTimestampString(tmp);
  }


  /**
   *  Sets the modified attribute of the Organization object
   *
   * @param  tmp  The new modified value
   */
  public void setModified(String tmp) {
    this.modified = DateUtils.parseTimestampString(tmp);
  }

  /**
   *  Sets the YTD attribute of the Organization object
   *
   * @param  YTD  The new YTD value
   */
  /*public void setYTD(double YTD) {
    this.YTD = YTD;
  }*/

  /**
   *  Sets the ModifiedBy attribute of the Organization object
   *
   * @param  modifiedBy  The new ModifiedBy value
   */
  public void setModifiedBy(int modifiedBy) {
    this.modifiedBy = modifiedBy;
  }


  /**
   *  Sets the ModifiedBy attribute of the Organization object
   *
   * @param  modifiedBy  The new ModifiedBy value
   */
  public void setModifiedBy(String modifiedBy) {
    this.modifiedBy = Integer.parseInt(modifiedBy);
  }

  /**
   *  Sets the Notes attribute of the Organization object
   *
   * @param  tmp  The new Notes value
   */
  public void setNote1(String tmp) {
    this.note1 = tmp;
  }
  
  public void setSiteId(int siteId) {
	    this.siteId = siteId;
	  }


	  /**
	   *  Sets the siteId attribute of the Organization object
	   *
	   * @param  tmp  The new siteId value
	   */
public void setSiteId(String tmp) {
	if (!tmp.equals(""))
	    this.siteId = Integer.parseInt(tmp);
	  }
public int getSiteId() {
	    return siteId;
	  }
  
public void setStato(String tmp) {
		    this.stato = tmp;
		  }

  /**
   *  Sets the Enteredby attribute of the Organization object
   *
   * @param  tmp  The new Enteredby value
   */
  public void setEnteredBy(int tmp) {
    this.enteredBy = tmp;
  }

  /**
   *  Sets the EnteredBy attribute of the Organization object
   *
   * @param  tmp  The new EnteredBy value
   */
  public void setEnteredBy(String tmp) {
    this.enteredBy = Integer.parseInt(tmp);
  }
 
  public String getStato() {
		    return stato;
		  }

  /**
   *  Gets the EnteredBy attribute of the Organization object
   *
   * @return    The EnteredBy value
   */
  public int getEnteredBy() {
    return enteredBy;
  }


  /**
   *  Gets the Entered attribute of the Organization object
   *
   * @return    The Entered value
   */
  public java.sql.Timestamp getEntered() {
    return entered;
  }

  public java.sql.Timestamp getDataCambioStato() {
	    return dataCambioStato;
	  }
 
  public String getDataCambioStatoFormat() {
	  
	  String anno = dataCambioStato.toString().substring(0,4);
	  String mese = dataCambioStato.toString().substring(6,8);
	  String giorno = dataCambioStato.toString().substring(8,10) ;	  
	 
	    return giorno+"-"+mese+anno;
	  }
  
  
  public java.sql.Timestamp getDataVerificaAnnua() {
	    return dataVerificaAnnua;
	  }
  /**
   *  Gets the Modified attribute of the Organization object
   *
   * @return    The Modified value
   */
  public java.sql.Timestamp getModified() {
    return modified;
  }


  /**
   *  Gets the ModifiedString attribute of the Organization object
   *
   * @return    The ModifiedString value
   */
  public String getModifiedString() {
    String tmp = "";
    try {
      return DateFormat.getDateTimeInstance(DateFormat.SHORT, DateFormat.LONG).format(
          modified);
    } catch (NullPointerException e) {
    }
    return tmp;
  }


  /**
   *  Gets the EnteredString attribute of the Organization object
   *
   * @return    The EnteredString value
   */
  public String getEnteredString() {
    String tmp = "";
    try {
      return DateFormat.getDateTimeInstance(DateFormat.SHORT, DateFormat.LONG).format(
          entered);
    } catch (NullPointerException e) {
    }
    return tmp;
  }


  /**
   *  Gets the nameSalutation attribute of the Organization object
   *
   * @return    The nameSalutation value
   */
  public String getNote1() {
    return note1;
  }

  /**
   *  Gets the Enteredby attribute of the Organization object
   *
   * @return    The Enteredby value
   */
  public int getEnteredby() {
    return enteredBy;
  }


  /**
   *  Gets the ModifiedBy attribute of the Organization object
   *
   * @return    The ModifiedBy value
   */
  public int getModifiedBy() {
    return modifiedBy;
  }

  /**
   *  Gets the trashed attribute of the Organization object
   *
   * @return    The trashed value
   */
  public boolean isTrashed() {
    return (trashedDate != null);
  }

 
  /**
   *  Description of the Method
   *
   * @param  db             Description of Parameter
   * @return                Description of the Returned Value
   * @throws  SQLException  Description of Exception
   */
  public boolean disable(Connection db) throws SQLException {
    if (this.getOrgId() == -1) {
      throw new SQLException("Farmaco ID not specified");
    }

    PreparedStatement pst = null;
    StringBuffer sql = new StringBuffer();
    boolean success = false;

    sql.append(
        "UPDATE farmaci set enabled = ? " +
        " where id_farmacia = ? ");

    sql.append(" AND  modified " + ((this.getModified() == null)?"IS NULL ":"= ? "));

    int i = 0;
    pst = db.prepareStatement(sql.toString());
    pst.setBoolean(++i, false);
    pst.setInt(++i, orgId);

    if(this.getModified() != null){
      pst.setTimestamp(++i, this.getModified());
    }

    int resultCount = pst.executeUpdate();
    pst.close();

    if (resultCount == 1) {
      success = true;
    }

    return success;
  }


  /**
   *  Description of the Method
   *
   * @param  db             Description of Parameter
   * @return                Description of the Returned Value
   * @throws  SQLException  Description of Exception
   */
  public boolean enable(Connection db) throws SQLException {
    if (this.getOrgId() == -1) {
      throw new SQLException("Farmaco ID not specified");
    }

    PreparedStatement pst = null;
    StringBuffer sql = new StringBuffer();
    boolean success = false;

    sql.append(
        "UPDATE farmaci SET enabled = ? " +
        " where id_farmacia = ? ");
    sql.append(" AND  modified " + ((this.getModified() == null)?"IS NULL ":"= ? "));
    int i = 0;
    pst = db.prepareStatement(sql.toString());
    pst.setBoolean(++i, true);
    pst.setInt(++i, orgId);
    if(this.getModified() != null){
      pst.setTimestamp(++i, this.getModified());
    }
    int resultCount = pst.executeUpdate();
    pst.close();
    if (resultCount == 1) {
      success = true;
    }
    return success;
  }


  /**
   *  Description of the Method
   *
   * @param  db             Description of Parameter
   * @param  checkName      Description of Parameter
   * @return                Description of the Returned Value
   * @throws  SQLException  Description of Exception
   */
  public boolean checkIfExists(Connection db, String checkName) throws SQLException {
    PreparedStatement pst = null;
    ResultSet rs = null;
    String sqlSelect =
        "SELECT ragione_sociale, id_farmacia " +
        "FROM farmacie " +
        " where " + DatabaseUtils.toLowerCase(db) + "(farmacie.ragione_sociale) = ? ";
    int i = 0;
    pst = db.prepareStatement(sqlSelect);
    pst.setString(++i, checkName.toLowerCase());
    rs = pst.executeQuery();
    if (rs.next()) {
      rs.close();
      pst.close();
      return true;
    } else {
      rs.close();
      pst.close();
      return false;
    }
  }
  
  /**
   *  Description of the Method
   *
   * @param  db             Description of Parameter
   * @return                Description of the Returned Value
   * @throws  SQLException  Description of the Exception
   */
  public boolean insert(Connection db,ActionContext context) throws SQLException {
    StringBuffer sql = new StringBuffer();
    boolean doCommit = false;
    try {
      modifiedBy = enteredBy;
      
      if (doCommit = db.getAutoCommit()) {
        db.setAutoCommit(false);
      }
      
      orgId =  DatabaseUtils.getNextSeq(db,context, "organization","org_id");
      
      //idFarmacia = DatabaseUtils.getNextSeq(db, "farmacia_id_seq");
      sql.append(
          "INSERT INTO organization (org_id, name, account_number, site_id, ");
      if (dataCambioStato != null) {
          sql.append("data_cambio_stato, ");
        }
      
      if (cognomeRappresentante != null) {
          sql.append("cognome_rappresentante, ");
        }
      
      if (partita_iva != null) {
          sql.append("partita_iva, ");
      }
      
      if (stato != null) {
          sql.append("stato, ");
        }
      
      if (entered != null) {
        sql.append("entered, ");
      }
      if (modified != null) {
        sql.append("modified, ");
      }
      
      sql.append("enteredby, modifiedby, trashed_date, pregresso,tipologia,ip_entered,ip_modified ");
      
      sql.append(")");
      sql.append(" VALUES (?, ?, ?, ?, ");
         
      if (dataCambioStato != null) {
          sql.append("?, ");
        }
      
      if (cognomeRappresentante != null) {
          sql.append("?, ");
        }
      
      if (partita_iva != null) {
          sql.append("?, ");
      }
      
      if (stato != null) {
          sql.append("?, ");
        }
     
      
      if (entered != null) {
        sql.append("?, ");
      }
      if (modified != null) {
        sql.append("?, ");
      }
      
      sql.append("?, ?, ?, ?,"+TIPOLOGIA_LABHACCP + ",?,?)");
      int i = 0;
      PreparedStatement pst = db.prepareStatement(sql.toString());
      pst.setInt(++i, orgId);
      pst.setString(++i, name);
      pst.setString(++i, accountNumber);
      pst.setInt(++i, siteId);
        
      if (dataCambioStato != null) {
    	  pst.setTimestamp(++i,dataCambioStato);
        }
     
      if (cognomeRappresentante != null) {
    	  pst.setString(++i,cognomeRappresentante);
        }
      
      if (partita_iva != null) {
    	  pst.setString(++i,partita_iva);
        }
      
      if (stato != null) {
          pst.setString(++i, stato);
        }
     
      if (entered != null) {
        pst.setTimestamp(++i, entered);
      }
      if (modified != null) {
        pst.setTimestamp(++i, modified);
      }
      pst.setInt(++i, this.getModifiedBy());
      pst.setInt(++i, this.getModifiedBy());
      DatabaseUtils.setTimestamp(pst, ++i, this.getTrashedDate());
      pst.setBoolean(++i, false);
      pst.setString(++i, ip_entered);
      pst.setString(++i, ip_modified);
      pst.execute();
      pst.close();
      log.info("query: "+pst.toString());
     
      Iterator iaddress = getAddressList().iterator();
      while (iaddress.hasNext()) {
    	  
          OrganizationAddress thisAddress = (OrganizationAddress) iaddress.next();
          //thisAddress.insert(db, this.getOrgId(), this.getEnteredBy());
          
          
          if((thisAddress.getCity()!=null) && !(thisAddress.getCity().equals(""))) {
              thisAddress.process(
                  db, orgId, this.getEnteredBy(), this.getModifiedBy(),context);
              }
        }
      
      
      //this.update(db, true);
      if (doCommit) {
        db.commit();
      }
    } catch (SQLException e) {
    	e.printStackTrace();
      if (doCommit) {
        db.rollback();
      }
      throw new SQLException(e.getMessage());
    } finally {
      if (doCommit) {
        db.setAutoCommit(true);
      }
    }
    return true;
  }

  public boolean insertStorico(Connection db,ActionContext context) throws SQLException {
	    StringBuffer sql = new StringBuffer();
	    boolean doCommit = false;
	    try {
	      modifiedBy = enteredBy;
	      
	      if (doCommit = db.getAutoCommit()) {
	        db.setAutoCommit(false);
	      }
	      
	      //idFarmacia = DatabaseUtils.getNextSeq(db, "farmacia_id_seq");
	      sql.append(
	          "INSERT INTO laboratorihaccp_storico_elenco_lab (org_id, name, account_number, site_id, lab_originario, ");
	      if (dataCambioStato != null) {
	          sql.append("data_cambio_stato, ");
	        }
	      
	      if (cognomeRappresentante != null) {
	          sql.append("cognome_rappresentante, ");
	        }
	      
	      if (stato != null) {
	          sql.append("stato, ");
	        }
	      
	      if (entered != null) {
	        sql.append("entered, ");
	      }
	      if (modified != null) {
	        sql.append("modified, ");
	      }
	      
	      sql.append("enteredby, modifiedby, trashed_date, pregresso,tipologia,ip_entered,ip_modified ");
	      
	      sql.append(")");
	      sql.append(" VALUES (?, ?, ?, ?, ?,  ");
	         
	      if (dataCambioStato != null) {
	          sql.append("?, ");
	        }
	      
	      if (cognomeRappresentante != null) {
	          sql.append("?, ");
	        }
	      
	      if (stato != null) {
	          sql.append("?, ");
	        }
	     
	      
	      if (entered != null) {
	        sql.append("?, ");
	      }
	      if (modified != null) {
	        sql.append("?, ");
	      }
	      
	      sql.append("?, ?, ?, ?,"+TIPOLOGIA_LABHACCP + ",?,?)");
	      int i = 0;
	      PreparedStatement pst = db.prepareStatement(sql.toString());
	      pst.setInt(++i, orgId);
	      pst.setString(++i, name);
	      pst.setString(++i, accountNumber);
	      pst.setInt(++i, siteId);
	      pst.setBoolean(++i, true);  
	      if (dataCambioStato != null) {
	    	  pst.setTimestamp(++i,dataCambioStato);
	        }
	     
	      if (cognomeRappresentante != null) {
	    	  pst.setString(++i,cognomeRappresentante);
	        }
	      
	      if (stato != null) {
	          pst.setString(++i, stato);
	        }
	     
	      if (entered != null) {
	        pst.setTimestamp(++i, entered);
	      }
	      if (modified != null) {
	        pst.setTimestamp(++i, modified);
	      }
	      pst.setInt(++i, this.getModifiedBy());
	      pst.setInt(++i, this.getModifiedBy());
	      DatabaseUtils.setTimestamp(pst, ++i, this.getTrashedDate());
	      pst.setBoolean(++i, false);
	      pst.setString(++i, ip_entered);
	      pst.setString(++i, ip_modified);
	      pst.execute();
	      pst.close();
	      
	     
	      Iterator iaddress = getAddressList().iterator();
	      while (iaddress.hasNext()) {
	    	  
	          OrganizationAddress thisAddress = (OrganizationAddress) iaddress.next();
	          //thisAddress.insert(db, this.getOrgId(), this.getEnteredBy());
	          
	          
	          if((thisAddress.getCity()!=null) && !(thisAddress.getCity().equals(""))) {
	              thisAddress.process(
	                  db, orgId, this.getEnteredBy(), this.getModifiedBy(),context);
	              }
	        }
	      
	      
	      //this.update(db, true);
	      if (doCommit) {
	        db.commit();
	      }
	    } catch (SQLException e) {
	    	e.printStackTrace();
	      if (doCommit) {
	        db.rollback();
	      }
	      throw new SQLException(e.getMessage());
	    } finally {
	      if (doCommit) {
	        db.setAutoCommit(true);
	      }
	    }
	    return true;
	  }

  
  
  public static Vector<Organization> load( String ragione_sociale, String citta,
			int asl, Connection db )
	{
		Vector<Organization>	ret		= new Vector<Organization>();
		PreparedStatement			stat	= null;
		ResultSet					res		= null;
		
		ragione_sociale	= (ragione_sociale == null)	? ("") : (ragione_sociale.trim());
		citta		= (citta == null)		? ("") : (citta.trim());
		asl	= (asl == -2)	? (-2) : (asl);
		
		String sql = "SELECT * FROM farmacie ";
		
		try
		{
			boolean where = false;
			
			if( ragione_sociale.length() > 0 )
			{
				sql += ( " WHERE ragione_sociale ILIKE '%" + ragione_sociale.replaceAll( "'", "''" ) + "%' " );
				where = true;
			}
			if( citta.length() > 0 )
			{
				if(!where)
				{
					sql += " WHERE ";
				}
				else
				{
					sql += " AND ";
				}
				sql += ( " citta ILIKE '%" + citta.replaceAll( "'", "''" ) + "%' " );
			}
			if( asl > -1 )
			{
				if(!where)
				{
					sql += " WHERE ";
				}
				else
				{
					sql += " AND ";
				}
				sql += ( " site_id =" + asl + " " );
			}
			
			
			stat = db.prepareStatement( sql );
			
			res		= stat.executeQuery();
			while( res.next() )
			{
				ret.add( loadResultSet( res ) );
			}
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			try
			{
				if( res != null )
				{
					res.close();
					res = null;
				}
				
				if( stat != null )
				{
					stat.close();
					stat = null;
				}
			}
			catch (Exception e)
			{
				e.printStackTrace();
			}
		}
		
		return ret;
	}
  
  private static Organization loadResultSet( ResultSet res ) 
	throws SQLException, IllegalArgumentException, IllegalAccessException, InvocationTargetException
{
	  Organization ret = new Organization();
	
   Field[]	f = ret.getClass().getDeclaredFields();
   Method[]	m = ret.getClass().getMethods();
   for( int i = 0; i < f.length; i++ )
   {
  	 Method getter	= null;
  	 Method setter	= null;
  	 Field	campo	= f[i];
       String field = f[i].getName();
       for( int j = 0; j < m.length; j++ )
       {
           String met = m[j].getName();
           if( met.equalsIgnoreCase( "GET" + field ) || met.equalsIgnoreCase( "IS" + field ) )
           {
                getter = m[j];
           }
           else if( met.equalsIgnoreCase( "SET" + field ) )
           {
               setter = m[j];
           }
       }
       
       
       if( (getter != null) && (setter != null) && (campo != null) )
       {
      	 Object o = null;
           
           switch ( parseType( campo.getType() ) )
           {
           case INT:
               o = res.getInt( field );
               break;
           case STRING:
               o = res.getString( field );
               break;
           case BOOLEAN:
               o = res.getBoolean( field );
               break;
           case TIMESTAMP:
               o = res.getTimestamp( field );
               break;
           case DATE:
               o = res.getDate( field );
               break;
           case FLOAT:
               o = res.getFloat( field );
               break;
           case DOUBLE:
               o = res.getDouble( field );
               break;
           }
           
           setter.invoke( ret, o );
           
       }
   }
	
	return ret;
}
  
  protected static int parseType(Class<?> type)
  {
      int ret = -1;
      
      String name = type.getSimpleName();
      
      if( name.equalsIgnoreCase( "int" ) || name.equalsIgnoreCase("integer") )
      {
          ret = INT;
      }
      else if( name.equalsIgnoreCase( "string" ) )
      {
          ret = STRING;
      }
      else if( name.equalsIgnoreCase( "double" ) )
      {
          ret = DOUBLE;
      }
      else if( name.equalsIgnoreCase( "float" ) )
      {
          ret = FLOAT;
      }
      else if( name.equalsIgnoreCase( "timestamp" ) )
      {
          ret = TIMESTAMP;
      }
      else if( name.equalsIgnoreCase( "date" ) )
      {
          ret = DATE;
      }
      else if( name.equalsIgnoreCase( "boolean" ) )
      {
          ret = BOOLEAN;
      }
      
      return ret;
  }	

  /**
   *  Description of the Method
   *
   * @param  db             Description of Parameter
   * @return                Description of the Returned Value
   * @throws  SQLException  Description of Exception
   */
  public int update(Connection db,ActionContext context) throws SQLException {
    int i = -1;
    boolean doCommit = false;
    try {
      if (doCommit = db.getAutoCommit()) {
        db.setAutoCommit(false);
      }
      i = this.update(db, false);
      
      Iterator iaddress = getAddressList().iterator();
      while (iaddress.hasNext()) {
    	  
        OrganizationAddress thisAddress = (OrganizationAddress) iaddress.next();
        //thisAddress.insert(db, this.getOrgId(), this.getEnteredBy());
        
        //Solo se la provincia viene selezionata allora avviene il salvataggio       
        if(thisAddress.getCity()!=null ) {
        thisAddress.process(
            db, orgId, this.getEnteredBy(), this.getModifiedBy(),context);
        }
        
      }
      
      if (doCommit) {
        db.commit();
      }
    } catch (SQLException e) {
      if (doCommit) {
        db.rollback();
      }
      throw new SQLException(e.getMessage());
    } finally {
      if (doCommit) {
        db.setAutoCommit(true);
      }
    }
    return i;
  }
  public OrganizationAddressList getAddressList() {
	    return addressList;
	  }
  
  public ElencoProve getProveList() {
	    return prove;
	  }

  public OrganizationList getLabList() {
	    return elenco_lab;
   }
  
  /**
   *  Description of the Method
   *
   * @param  db             Description of Parameter
   * @param  override       Description of Parameter
   * @return                Description of the Returned Value
   * @throws  SQLException  Description of Exception
   */
  public int update(Connection db, boolean override) throws SQLException {
    int resultCount = 0;
    PreparedStatement pst = null;
    StringBuffer sql = new StringBuffer();
    sql.append(
        "UPDATE organization " +
        "SET name = ?, account_number = ? , site_id  = ?, " +
         " cognome_rappresentante = ?, partita_iva = ?, stato = ?, " +
        "data_cambio_stato = ?, ip_modified = ? , ");
   
    if (!override) {
      sql.append("modified = " + DatabaseUtils.getCurrentTimestamp(db) + ", ");
    }

    sql.append(
        "modifiedby = ?" );
    sql.append(" WHERE org_id = ? ");
  
    int i = 0;
    pst = db.prepareStatement(sql.toString());
    pst.setString(++i, name);
    pst.setString(++i, accountNumber);
    pst.setInt(++i, siteId);
    pst.setString(++i, cognomeRappresentante);
    pst.setString(++i, partita_iva);
    pst.setString(++i, stato);
    DatabaseUtils.setTimestamp(pst, ++i,dataCambioStato);
    pst.setString(++i, ip_modified);
    pst.setInt(++i, this.getModifiedBy());
    pst.setInt(++i, this.getOrgId());
    resultCount=pst.executeUpdate();
    pst.close();

    return resultCount;
  }


  /**
   *  Renames the organization running this database
   *
   * @param  db             Description of the Parameter
   * @param  newName        Description of the Parameter
   * @throws  SQLException  Description of the Exception
   */
  public static void renameMyCompany(Connection db, String newName) throws SQLException {
    PreparedStatement pst = db.prepareStatement(
        "UPDATE farmacie " +
        "SET ragione_sociale = ? " +
        " where id_farmacia = 0 ");
    pst.setString(1, newName);
    pst.execute();
    pst.close();
  }


  /**
   *  Description of the Method
   *
   * @param  db             Description of Parameter
   * @param  baseFilePath   Description of Parameter
   * @param  context        Description of the Parameter
   * @return                Description of the Returned Value
   * @throws  SQLException  Description of Exception
   */
  public boolean delete(Connection db, ActionContext context, String baseFilePath) throws SQLException {
    if (this.getOrgId() == -1) {
      throw new SQLException("Farmacia ID not specified.");
    }
    boolean commit = db.getAutoCommit();
    try { 
      if (commit) {
        db.setAutoCommit(false);
      }
 
      Statement st = db.createStatement();
      st.executeUpdate(
          "DELETE FROM farmacie WHERE id_farmacia = " + this.getOrgId());
      st.close();
      if (commit) {
        db.commit();
      }
    } catch (SQLException e) {
      e.printStackTrace(System.out);
      if (commit) {
        db.rollback();
      }
      throw new SQLException(e.getMessage());
    } finally {
      if (commit) {
        db.setAutoCommit(true);
      }
    }
    return true;
  }
  
  public void setRequestItems(ActionContext context) {
	   
	    addressList = new OrganizationAddressList(context.getRequest());
	 
	  }

  /**
   *  Description of the Method
   *
   * @param  db             Description of the Parameter
   * @param  thisImportId   Description of the Parameter
   * @return                Description of the Return Value
   * @throws  SQLException  Description of the Exception
   */
  public static boolean deleteImportedRecords(Connection db, int thisImportId) throws SQLException {
    boolean commit = true;
    try {
      commit = db.getAutoCommit();
      if (commit) {
        db.setAutoCommit(false);
      }
      PreparedStatement pst = db.prepareStatement(
          
          "DELETE FROM farmacie " +
          " where import_id = ?");
      pst.setInt(1, thisImportId);
      pst.executeUpdate();
      pst.close();
      if (commit) {
        db.commit();
      }
    } catch (SQLException e) {
      if (commit) {
        db.rollback();
      }
      throw new SQLException(e.getMessage());
    } finally {
      if (commit) {
        db.setAutoCommit(true);
      }
    }
    return true;
  }
  
  /**
   *  Description of the Method
   *
   * @return    Description of the Returned Value
   */
  public String toString() {
    StringBuffer out = new StringBuffer();
    out.append("=================================================\r\n");
    out.append("Laboratorio Nome: " + this.getName() + "\r\n");
    out.append("ID: " + this.getOrgId() + "\r\n");
    return out.toString();
  }


  /**
   *  Description of the Method
   *
   * @param  rs             Description of Parameter
   * @throws  SQLException  Description of Exception
   */
  protected void buildRecord(ResultSet rs) throws SQLException {
    
    this.setOrgId(rs.getInt("org_id"));
    name = rs.getString("name");
    accountNumber = rs.getString("account_number");
    cognomeRappresentante = rs.getString("cognome_rappresentante");
    partita_iva =rs.getString("partita_iva");
    siteId = rs.getInt("site_id");
    stato = rs.getString("stato");
    entered = rs.getTimestamp("entered");
    enteredBy = rs.getInt("enteredby");
    modified = rs.getTimestamp("modified");
    modifiedBy = rs.getInt("modifiedby");
    trashedDate = rs.getTimestamp("trashed_date");
    dataCambioStato = rs.getTimestamp("data_cambio_stato");
    tipologia = rs.getInt("tipologia");
    this.statoLab = DatabaseUtils.getInt(rs,"stato_lab");
    
    boolean esiste_colonna_lab= existColumnRs(rs,"lab_originario") ;
    if(esiste_colonna_lab == true)
    {
    	lab_originario = rs.getBoolean("lab_originario");
    }
    
    try
    {
    	this.dataInizio = rs.getTimestamp("data_inizio");
    }
    catch(Exception ex){}
    
  }
    
 
 
private boolean existColumnRs(ResultSet rs,String nomeColumn) throws SQLException
{
	int num_col = rs.getMetaData().getColumnCount();
    boolean esiste_campo = false ;
    for (int i = 1 ; i<=num_col; i++)
    {
  	  if(rs.getMetaData().getColumnName(i).equals(nomeColumn))
  	   {
  		  esiste_campo = true ;
  		  break ;
  	   }
    }
    return esiste_campo ;
}
  
  public int selectLab(Connection db, int org_id) {
		// TODO Auto-generated method stub
		   PreparedStatement count = null;
		   StringBuffer sql = new StringBuffer();
		   sql.append("SELECT COUNT(*) as count_lab FROM laboratorihaccp_storico_elenco_lab WHERE org_id = ? and lab_originario = ? ");
		   ResultSet rs = null;
		   int result = 0;
		   try {
			   count = db.prepareStatement(sql.toString());
			   count.setInt(1, org_id);
			   count.setBoolean(2, true);
			   rs = count.executeQuery();
			   if(rs.next()){
					result = rs.getInt("count_lab");
			   }
		   } catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		   
		return result;
		
  }
  
  
  
  public boolean updateStatus(Connection db, ActionContext context, boolean toTrash, int tmpUserId) throws SQLException {
	    int count = 0;

	    boolean commit = true;

	    try {
	      commit = db.getAutoCommit();
	      if (commit) {
	        db.setAutoCommit(false);
	      }
	      StringBuffer sql = new StringBuffer();
	      sql.append(
	          "UPDATE organization " +
	          "SET trashed_date = ?, " +
	          "modified = " + DatabaseUtils.getCurrentTimestamp(db) + " , " +
	          "modifiedby = ? " +
	          " where org_id = ? ");
	      int i = 0;
	      PreparedStatement pst = db.prepareStatement(sql.toString());
	      if (toTrash) {
	        DatabaseUtils.setTimestamp(
	            pst, ++i, new Timestamp(System.currentTimeMillis()));
	      } else {
	        DatabaseUtils.setTimestamp(pst, ++i, (Timestamp) null);
	      }
	      pst.setInt(++i, tmpUserId);
	      pst.setInt(++i, this.getId());
	      count = pst.executeUpdate();
	      pst.close();

	      if (commit) {
	        db.commit();
	      }
	    } catch (SQLException e) {
	      e.printStackTrace();
	      if (commit) {
	        db.rollback();
	      }
	      throw new SQLException(e.getMessage());
	    } finally {
	      if (commit) {
	        db.setAutoCommit(true);
	      }
	    }
	    return true;
	  }


  /**
   *  Description of the Method
   *
   * @param  tz         Description of the Parameter
   * @param  created    Description of the Parameter
   * @param  alertDate  Description of the Parameter
   * @param  user       Description of the Parameter
   * @param  category   Description of the Parameter
   * @param  type       Description of the Parameter
   * @return            Description of the Return Value
   */
  public String generateWebcalEvent(TimeZone tz, Timestamp created, Timestamp alertDate,
      User user, String category, int type) {

    StringBuffer webcal = new StringBuffer();
    String CRLF = System.getProperty("line.separator");

    String description = "";
    if (name != null) {
      description += "Nome: " + name;
    }

    if (user != null && user.getContact() != null) {
      description += "\\nOwner: " + user.getContact().getNameFirstLast();
    }

    //write the event
    webcal.append("BEGIN:VEVENT" + CRLF);
    
    webcal.append("END:VEVENT" + CRLF);

    return webcal.toString();
  }

public int getTipologia() {
	return tipologia;
}

public void setTipologia(int tipologia) {
	this.tipologia = tipologia;
}


//public void cessazioneAttivita(Connection db,String noteCessazione,int userId) throws SQLException
//{
//	PreparedStatement pst = db.prepareStatement("UPDATE organization set modified=current_timestamp,modifiedby=?,date2 = ? ,stato_lab=4,data_cessazione_attivita=?,note_cessazione_attivita=? , cessato = 1, stato = 'Cessato',data_cambio_stato = CURRENT_TIMESTAMP where org_id=?");
//	pst.setInt(1, userId);
//	pst.setTimestamp(2, date2);
//	pst.setTimestamp(3, date2);
//	pst.setString(4, noteCessazione);
//	pst.setInt(5, this.orgId);
//	pst.execute();
//	
//}

public Timestamp getDate2(){return this.date2;}
public void setDate2(Timestamp date2){this.date2 = date2;}
public void setDate2(String date2){this.date2 = DatabaseUtils.parseDateToTimestamp(date2);}

}