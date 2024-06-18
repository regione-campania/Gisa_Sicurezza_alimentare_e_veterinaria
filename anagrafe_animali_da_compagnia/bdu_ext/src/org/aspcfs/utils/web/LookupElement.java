/*
 *  Copyright(c) 2004 Concursive Corporation (http://www.concursive.com/) All
 *  rights reserved. This material cannot be distributed without written
 *  permission from Concursive Corporation. Permission to use, copy, and modify
 *  this material for internal use is hereby granted, provided that the above
 *  copyright notice and this permission notice appear in all copies. CONCURSIVE
 *  CORPORATION MAKES NO REPRESENTATIONS AND EXTENDS NO WARRANTIES, EXPRESS OR
 *  IMPLIED, WITH RESPECT TO THE SOFTWARE, INCLUDING, BUT NOT LIMITED TO, THE
 *  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR ANY PARTICULAR
 *  PURPOSE, AND THE WARRANTY AGAINST INFRINGEMENT OF PATENTS OR OTHER
 *  INTELLECTUAL PROPERTY RIGHTS. THE SOFTWARE IS PROVIDED "AS IS", AND IN NO
 *  EVENT SHALL CONCURSIVE CORPORATION OR ANY OF ITS AFFILIATES BE LIABLE FOR
 *  ANY DAMAGES, INCLUDING ANY LOST PROFITS OR OTHER INCIDENTAL OR CONSEQUENTIAL
 *  DAMAGES RELATING TO THE SOFTWARE.
 */
package org.aspcfs.utils.web;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

import org.aspcfs.utils.DatabaseUtils;

/**
 *  Represents an item from a Lookup table, to be used primarily with HtmlSelect
 *  objects and the LookupList object.
 *
 * @author     mrajkowski
 * @version    $Id: LookupElement.java,v 1.13 2003/01/13 14:42:24 mrajkowski Exp
 *      $
 * @created September 5, 2001
 */
public class LookupElement implements Serializable {

  protected String tableName = null;
  protected int code = 0;
  protected String description = "";
  protected String descriptionEstesa = "";
  protected boolean defaultItem = false;
  protected int level = 0;
  protected boolean enabled = true;
  protected java.sql.Timestamp entered = null;
  protected java.sql.Timestamp modified = null;
  protected int fieldId = -1;
  protected int constantId = -1;
  protected boolean group = false;
  protected String title = "";
  protected double occupazioneTaglia = 0.0;


  /**
   *  Constructor for the LookupElement object
   *
   * @since    1.1
   */
  public LookupElement() { }


  /**
   *  Constructor for the LookupElement object
   *
   * @param  db                         Description of the Parameter
   * @param  code                       Description of the Parameter
   * @param  tableName                  Description of the Parameter
   * @exception  java.sql.SQLException  Description of the Exception
   * @throws  java.sql.SQLException     Description of the Exception
   */
  public LookupElement(Connection db, int code, String tableName) throws java.sql.SQLException {
    if (System.getProperty("DEBUG") != null) {
      System.out.println(
          "LookupElement-> Retrieving ID: " + code + " from table: " + tableName);
    }
    String sql = "SELECT code, description, default_item, " + DatabaseUtils.addQuotes(db, "level") + ", enabled, entered, modified ";
    if(tableName.equals("lookup_taglia"))
    	sql += ", description_estesa ";
    sql+="FROM " + DatabaseUtils.getTableName(db, tableName) + " WHERE code = ? ";
    PreparedStatement pst = db.prepareStatement(sql);
    pst.setInt(1, code);
    ResultSet rs = pst.executeQuery();
    if (rs.next()) {
      build(rs);
    } else {
      rs.close();
      pst.close();
      throw new java.sql.SQLException("ID not found");
    }
    rs.close();
    pst.close();
  }


  /**
   *  Constructor for the LookupElement object
   *
   * @param  db                         Description of the Parameter
   * @param  description                Description of the Parameter
   * @param  tableName                  Description of the Parameter
   * @exception  java.sql.SQLException  Description of the Exception
   * @throws  java.sql.SQLException     Description of the Exception
   */
  private LookupElement(Connection db, String description, String tableName) throws java.sql.SQLException {
    if (System.getProperty("DEBUG") != null) {
      System.out.println(
          "LookupElement-> Retrieving Description: " + description + " from table: " + tableName);
    }
    String sql =
        (DatabaseUtils.getType(db) == DatabaseUtils.ORACLE ? "SELECT * FROM ( " : "") +
        "SELECT " +
        (DatabaseUtils.getType(db) == DatabaseUtils.MSSQL ? "TOP 1 " : "") +
        (DatabaseUtils.getType(db) == DatabaseUtils.DAFFODILDB ? "TOP (1) " : "") +
        (DatabaseUtils.getType(db) == DatabaseUtils.FIREBIRD ? "FIRST 1 " : "") +
        "code, description, default_item, " + DatabaseUtils.addQuotes(db, "level") + ", enabled, " +
        "entered, modified " +
        "FROM " + DatabaseUtils.getTableName(db, tableName) + " " +
        "WHERE description = ? " +
        (DatabaseUtils.getType(db) == DatabaseUtils.POSTGRESQL ? "LIMIT 1 " : "") +
        (DatabaseUtils.getType(db) == DatabaseUtils.MYSQL ? "LIMIT 1 " : "") +
        (DatabaseUtils.getType(db) == DatabaseUtils.DB2 ? "FETCH FIRST 1 ROWS ONLY " : "") +
        (DatabaseUtils.getType(db) == DatabaseUtils.ORACLE ? ") WHERE ROWNUM <= 1 " : "");
    PreparedStatement pst = db.prepareStatement(sql);
    pst.setString(1, description);
    DatabaseUtils.doManualLimit(db, pst, 1);
    ResultSet rs = pst.executeQuery();
    if (rs.next()) {
      build(rs);
    } else {
      code = -1;
    }
    rs.close();
    pst.close();
  }


  /**
   *  Constructor for the LookupElement object
   *
   * @param  rs                         Description of Parameter
   * @exception  java.sql.SQLException  Description of the Exception
   * @throws  java.sql.SQLException     Description of Exception
   * @since                             1.1
   */
  public LookupElement(ResultSet rs) throws java.sql.SQLException {
    build(rs);
  }


  /**
   *  Description of the Method
   *
   * @param  rs                      Description of the Parameter
   * @throws  java.sql.SQLException  Description of the Exception
   */
  public void build(ResultSet rs) throws java.sql.SQLException {
    code = rs.getInt("code");
    description = rs.getString("description");
    try
    {
    	rs.findColumn("description_estesa");
    	descriptionEstesa = rs.getString("description_estesa");
    }
    catch(Exception e)
    {
    	
    }
  
    defaultItem = rs.getBoolean("default_item");
    level = rs.getInt("level");
    //startDate = rs.getTimestamp("start_date");
    //endDate = rs.getTimestamp("end_date");
    enabled = rs.getBoolean("enabled");

    if (!(this.getEnabled())) {
      description += " (X)";
    }
    entered = rs.getTimestamp("entered");
    modified = rs.getTimestamp("modified");
    
	try {
		rs.findColumn("isgroup");
		this.group = rs.getBoolean("isgroup");
	} catch (SQLException sqlex) {
		//System.out.println("not found");
	}
	try {
		rs.findColumn("title");
		this.title = rs.getString("title");
	} catch (SQLException sqlex) {
		//System.out.println("not found");
	}
	
	try {
		rs.findColumn("occupazione");
		this.occupazioneTaglia = rs.getDouble("occupazione");
	} catch (SQLException sqlex) {
		//System.out.println("not found");
	}
  }


  /**
   *  Sets the tableName attribute of the LookupElement object
   *
   * @param  tmp  The new tableName value
   */
  public void setTableName(String tmp) {
    this.tableName = tmp;
  }
  
  public void setTitle(String tmp) 
  {
	  this.title = tmp;
  }
  
  public String getTitle() 
  {
	  return this.title;
  }
  


  public double getOccupazioneTaglia() {
	return occupazioneTaglia;
}


public void setOccupazioneTaglia(double occupazioneTaglia) {
	this.occupazioneTaglia = occupazioneTaglia;
}


/**
   *  Sets the newOrder attribute of the LookupElement object
   *
   * @param  db             The new newOrder value
   * @param  tableName      The new newOrder value
   * @return                Description of the Returned Value
   * @throws  SQLException  Description of Exception
   */
  public int setNewOrder(Connection db, String tableName) throws SQLException {
    int resultCount = 0;

    if (this.getCode() == 0) {
      throw new SQLException("Element Code not specified.");
    }

    PreparedStatement pst = null;
    StringBuffer sql = new StringBuffer();

    sql.append(
        "UPDATE " + DatabaseUtils.getTableName(db, tableName) + " " +
        "SET " + DatabaseUtils.addQuotes(db, "level") + " = ?, " +
        "modified = " + DatabaseUtils.getCurrentTimestamp(db) + " " +
        "WHERE code = ? ");

    int i = 0;

    pst = db.prepareStatement(sql.toString());
    pst.setInt(++i, this.getLevel());
    pst.setInt(++i, this.getCode());

    resultCount = pst.executeUpdate();
    pst.close();

    return resultCount;
  }


  /**
   *  Sets the newDescription attribute of the LookupElement object
   *
   * @param  db             The new newDescription value
   * @param  tableName      The new newDescription value
   * @return                Description of the Return Value
   * @throws  SQLException  Description of the Exception
   */
  public int setNewDescription(Connection db, String tableName) throws SQLException {
    int resultCount = 0;
    if (this.getCode() == 0) {
      throw new SQLException("Element Code not specified.");
    }
    PreparedStatement pst = null;
    StringBuffer sql = new StringBuffer();
    sql.append(
        "UPDATE " + DatabaseUtils.getTableName(db, tableName) + " " +
        "SET description = ?, " +
        "modified = " + DatabaseUtils.getCurrentTimestamp(db) + " " + 
        "WHERE code = ? ");
    int i = 0;
    pst = db.prepareStatement(sql.toString());
    pst.setString(++i, this.getDescription());
    pst.setInt(++i, this.getCode());
    resultCount = pst.executeUpdate();
    pst.close();
    return resultCount;
  }


  /**
   *  Sets the Code attribute of the LookupElement object
   *
   * @param  tmp  The new Code value
   * @since       1.1
   */
  public void setCode(int tmp) {
    this.code = tmp;
  }


  /**
   *  Sets the code attribute of the LookupElement object
   *
   * @param  tmp  The new code value
   */
  public void setCode(String tmp) {
    this.code = Integer.parseInt(tmp);
  }


  /**
   *  Sets the id attribute of the LookupElement object
   *
   * @param  tmp  The new id value
   */
  public void setId(int tmp) {
    this.code = tmp;
  }


  /**
   *  Sets the id attribute of the LookupElement object
   *
   * @param  tmp  The new id value
   */
  public void setId(String tmp) {
    this.code = Integer.parseInt(tmp);
  }


  /**
   *  Sets the Description attribute of the LookupElement object
   *
   * @param  tmp  The new Description value
   * @since       1.1
   */
  public void setDescription(String tmp) {
    this.description = tmp;
  }
  
  public void setDescriptionEstesa(String tmp) {
	    this.descriptionEstesa = tmp;
	  }


  /**
   *  Sets the DefaultItem attribute of the LookupElement object
   *
   * @param  tmp  The new DefaultItem value
   * @since       1.2
   */
  public void setDefaultItem(boolean tmp) {
    this.defaultItem = tmp;
  }


  /**
   *  Sets the defaultItem attribute of the LookupElement object
   *
   * @param  tmp  The new defaultItem value
   */
  public void setDefaultItem(String tmp) {
    this.defaultItem = DatabaseUtils.parseBoolean(tmp);
  }


  /**
   *  Sets the Level attribute of the LookupElement object
   *
   * @param  tmp  The new Level value
   * @since       1.2
   */
  public void setLevel(int tmp) {
    this.level = tmp;
  }


  /**
   *  Sets the level attribute of the LookupElement object
   *
   * @param  tmp  The new level value
   */
  public void setLevel(String tmp) {
    this.level = Integer.parseInt(tmp);
  }


  /**
   *  Sets the Enabled attribute of the LookupElement object
   *
   * @param  tmp  The new Enabled value
   * @since       1.1
   */
  public void setEnabled(boolean tmp) {
    this.enabled = tmp;
  }


  /**
   *  Sets the enabled attribute of the LookupElement object
   *
   * @param  tmp  The new enabled value
   */
  public void setEnabled(String tmp) {
    this.enabled = DatabaseUtils.parseBoolean(tmp);
  }


  /**
   *  Sets the fieldId attribute of the LookupElement object
   *
   * @param  tmp  The new fieldId value
   */
  public void setFieldId(int tmp) {
    this.fieldId = tmp;
  }


  /**
   *  Sets the fieldId attribute of the LookupElement object
   *
   * @param  tmp  The new fieldId value
   */
  public void setFieldId(String tmp) {
    this.fieldId = Integer.parseInt(tmp);
  }


  /**
   *  Sets the constantId attribute of the LookupElement object
   *
   * @param  constantId  The new constantId value
   */
  public void setConstantId(int constantId) {
    this.constantId = constantId;
  }


  /**
   *  Sets the constantId attribute of the LookupElement object
   *
   * @param  constantId  The new constantId value
   */
  public void setConstantId(String constantId) {
    this.constantId = Integer.parseInt(constantId);
  }


  /**
   *  Sets the group attribute of the LookupElement object
   *
   * @param  tmp  The new group value
   */
  public void setGroup(boolean tmp) {
    this.group = tmp;
  }


  public void setEntered(Timestamp entered) {
    this.entered = entered;
  }

  public void setModified(Timestamp modified) {
    this.modified = modified;
  }

  /**
   *  Sets the group attribute of the LookupElement object
   *
   * @param  tmp  The new group value
   */
  public void setGroup(String tmp) {
    this.group = DatabaseUtils.parseBoolean(tmp);
  }


  /**
   *  Gets the tableName attribute of the LookupElement object
   *
   * @return    The tableName value
   */
  public String getTableName() {
    return tableName;
  }


  /**
   *  Gets the Code attribute of the LookupElement object
   *
   * @return    The Code value
   * @since     1.1
   */
  public int getCode() {
    return code;
  }


  /**
   *  Returns the code in String form for use in reflection.
   *
   * @return    The codeString value
   */
  public String getCodeString() {
    return String.valueOf(code);
  }


  /**
   *  Gets the id attribute of the LookupElement object, id is a required name
   *  for some reflection parsing
   *
   * @return    The id value
   */
  public int getId() {
    return code;
  }


  /**
   *  Gets the Description attribute of the LookupElement object
   *
   * @return    The Description value
   * @since     1.1
   */
  public String getDescription() {
    return description;
  }
  
  public String getDescriptionEstesa() {
	    return descriptionEstesa;
	  }



  /**
   *  Gets the DefaultItem attribute of the LookupElement object
   *
   * @return    The DefaultItem value
   * @since     1.2
   */
  public boolean getDefaultItem() {
    return defaultItem;
  }


  /**
   *  Gets the Level attribute of the LookupElement object
   *
   * @return    The Level value
   * @since     1.2
   */
  public int getLevel() {
    return level;
  }


  /**
   *  Gets the Enabled attribute of the LookupElement object
   *
   * @return    The Enabled value
   * @since     1.1
   */
  public boolean getEnabled() {
    return enabled;
  }


  /**
   *  Gets the entered attribute of the LookupElement object
   *
   * @return    The entered value
   */
  public java.sql.Timestamp getEntered() {
    return entered;
  }


  /**
   *  Gets the modified attribute of the LookupElement object
   *
   * @return    The modified value
   */
  public java.sql.Timestamp getModified() {
    if (modified == null) {
      return (new java.sql.Timestamp(new java.util.Date().getTime()));
    } else {
      return modified;
    }
  }


  /**
   *  Gets the fieldId attribute of the LookupElement object
   *
   * @return    The fieldId value
   */
  public int getFieldId() {
    return fieldId;
  }


  /**
   *  Gets the constantId attribute of the LookupElement object
   *
   * @return    The constantId value
   */
  public int getConstantId() {
    return constantId;
  }


  /**
   *  Gets the group attribute of the LookupElement object
   *
   * @return    The group value
   */
  public boolean isGroup() {
    return group;
  }


  /**
   *  Gets the group attribute of the LookupElement object
   *
   * @return    The group value
   */
  public boolean getGroup() {
    return group;
  }

  public boolean isDefaultItem() {
    return defaultItem;
  }

  public boolean isEnabled() {
    return enabled;
  }

  /**
   *  Description of the Method
   *
   * @param  db             Description of Parameter
   * @param  tableName      Description of Parameter
   * @return                Description of the Returned Value
   * @throws  SQLException  Description of Exception
   */
  public int disableElement(Connection db, String tableName) throws SQLException {
    int resultCount = 0;
    if (this.getCode() == 0) {
      throw new SQLException("Element Code not specified.");
    }
    PreparedStatement pst = null;
    StringBuffer sql = new StringBuffer();
    sql.append(
        "UPDATE " + DatabaseUtils.getTableName(db, tableName) + " " +
        "SET enabled = ?, " +
        "modified = " + DatabaseUtils.getCurrentTimestamp(db) + " " + 
        "WHERE code = ? ");
    int i = 0;
    pst = db.prepareStatement(sql.toString());
    pst.setBoolean(++i, false);
    pst.setInt(++i, this.getCode());
    resultCount = pst.executeUpdate();
    pst.close();
    return resultCount;
  }


  /**
   *  Description of the Method
   *
   * @param  db             Description of the Parameter
   * @param  tableName      Description of the Parameter
   * @return                Description of the Return Value
   * @throws  SQLException  Description of the Exception
   */
  public int enableElement(Connection db, String tableName) throws SQLException {
    int resultCount = 0;
    if (this.getCode() == 0) {
      throw new SQLException("Element Code not specified.");
    }
    PreparedStatement pst = null;
    StringBuffer sql = new StringBuffer();
    sql.append(
        "UPDATE " + DatabaseUtils.getTableName(db, tableName) + " " +
        "SET enabled = ?, " +
        "modified = " + DatabaseUtils.getCurrentTimestamp(db) + " " + 
        "WHERE code = ? ");
    int i = 0;
    pst = db.prepareStatement(sql.toString());
    pst.setBoolean(++i, true);
    pst.setInt(++i, this.getCode());
    resultCount = pst.executeUpdate();
    pst.close();
    return resultCount;
  }


  /**
   *  Gets the disabled attribute of the LookupElement object
   *
   * @param  db             Description of the Parameter
   * @param  tableName      Description of the Parameter
   * @return                The disabled value
   * @throws  SQLException  Description of the Exception
   */
  public int isDisabled(Connection db, String tableName) throws SQLException {
    if (this.getDescription() == null) {
      throw new SQLException("Element description not specified");
    }
    PreparedStatement pst = null;
    ResultSet rs = null;
    int tmpCode = -1;
    StringBuffer sql = new StringBuffer();
    sql.append(
        "SELECT * " +
        "FROM " + DatabaseUtils.getTableName(db, tableName) + " " +
        "WHERE description = ? " +
        "AND enabled = ? ");
    int i = 0;
    pst = db.prepareStatement(sql.toString());
    pst.setString(++i, this.description);
    pst.setBoolean(++i, false);
    rs = pst.executeQuery();
    if (rs.next()) {
      tmpCode = rs.getInt("code");
    }
    rs.close();
    pst.close();
    return tmpCode;
  }


  /**
   *  Description of the Method
   *
   * @param  db             Description of Parameter
   * @param  tableName      Description of Parameter
   * @return                Description of the Returned Value
   * @throws  SQLException  Description of Exception
   */
  public boolean insertElement(Connection db, String tableName) throws SQLException {
    return insertElement(db, tableName, -1);
  }


  /**
   *  Description of the Method
   *
   * @param  db             Description of Parameter
   * @param  tableName      Description of Parameter
   * @param  fieldId        Description of Parameter
   * @return                Description of the Returned Value
   * @throws  SQLException  Description of Exception
   */
  public boolean insertElement(Connection db, String tableName, int fieldId) throws SQLException {
    this.tableName = tableName;
    this.fieldId = fieldId;
    return insert(db);
  }


  /**
   *  Description of the Method
   *
   * @param  db             Description of the Parameter
   * @return                Description of the Return Value
   * @throws  SQLException  Description of the Exception
   */
  public boolean insert(Connection db) throws SQLException {
    StringBuffer sql = new StringBuffer();
    String seqName = null;
    if (tableName.length() > 22) {
      seqName = tableName.substring(0, 22);
    } else {
      seqName = tableName;
    }
    int id = DatabaseUtils.getNextSeq(db, seqName + "_code_seq");
    sql.append(
        "INSERT INTO " + DatabaseUtils.getTableName(db, tableName) + " " +
        "(" + (id > -1 ? "code, " : "") + "description, " + DatabaseUtils.addQuotes(db, "level") + ", enabled" +
        (fieldId > -1 ? ", field_id" : "") + (constantId > -1 ? ", constant_id" : "") + ") " +
        "VALUES (" + (id > -1 ? "?, " : "") + "?, ?, ?" + (fieldId > -1 ? ", ?" : "") + (constantId > -1 ? ", ?" : "") + ") ");
    int i = 0;
    PreparedStatement pst = db.prepareStatement(sql.toString());
    if (id > -1) {
      pst.setInt(++i, id);
    }
    pst.setString(++i, this.getDescription());
    pst.setInt(++i, this.getLevel());
    pst.setBoolean(++i, true);
    if (fieldId > -1) {
      pst.setInt(++i, fieldId);
    }
    if (constantId > -1) {
      pst.setInt(++i, constantId);
    }
    pst.execute();
    pst.close();
    code = DatabaseUtils.getCurrVal(db, seqName + "_code_seq", id);
    return true;
  }


  /**
   *  Description of the Method
   *
   * @param  db                Description of the Parameter
   * @param  tableName         Description of the Parameter
   * @return                   Description of the Return Value
   * @exception  SQLException  Description of the Exception
   */
  public static int retrieveMaxLevel(Connection db, String tableName) throws SQLException {
    int maxLevel = 0;
    PreparedStatement pst = db.prepareStatement(
        "SELECT MAX(" + DatabaseUtils.addQuotes(db, "level") + ") AS max_level " +
        "FROM " + DatabaseUtils.getTableName(db, tableName) + " ");
    ResultSet rs = pst.executeQuery();
    if (rs.next()) {
      maxLevel = rs.getInt("max_level");
    }
    rs.close();
    pst.close();
    return maxLevel;
  }


  /**
   *  Description of the Method
   *
   * @param  db                Description of the Parameter
   * @exception  SQLException  Description of the Exception
   */
  public void delete(Connection db) throws SQLException {
    StringBuffer sql = new StringBuffer();
    sql.append(
        "DELETE FROM " + tableName + " " +
        "WHERE code = ? ");
    int i = 0;
    PreparedStatement pst = db.prepareStatement(sql.toString());
    pst.setInt(++i, code);
    pst.execute();
    pst.close();
  }


  /**
   *  Description of the Method
   *
   * @return    Description of the Return Value
   */
  public String toString() {
    return String.valueOf(code + "-" + description);
  }


  /**
   *  Gets the codeByDescription attribute of the LookupElement class
   *
   * @param  db                         Description of the Parameter
   * @param  description                Description of the Parameter
   * @param  tableName                  Description of the Parameter
   * @return                            The codeByDescription value
   * @exception  java.sql.SQLException  Description of the Exception
   */
  public static int getCodeByDescription(Connection db, String description, String tableName) throws java.sql.SQLException {
    LookupElement lookupElement = new LookupElement(db, description, tableName);
    return lookupElement.getCode();
  }

}

