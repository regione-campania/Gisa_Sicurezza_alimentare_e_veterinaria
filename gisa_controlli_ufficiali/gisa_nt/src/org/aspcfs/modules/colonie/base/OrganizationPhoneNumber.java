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
package org.aspcfs.modules.colonie.base;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import org.aspcfs.modules.base.PhoneNumber;
import org.aspcfs.utils.DatabaseUtils;

import com.darkhorseventures.framework.actions.ActionContext;

/**
 * Represents an organization phone number, extending the base PhoneNumber
 * class.
 *
 * @author mrajkowski
 * @version $Id: OrganizationPhoneNumber.java,v 1.13 2002/09/20 14:52:45 chris
 *          Exp $
 * @created September 4, 2001
 */
public class OrganizationPhoneNumber extends PhoneNumber {

  /**
   * Constructor for the OrganizationPhoneNumber object
   */
  public OrganizationPhoneNumber() {
  }


  /**
   * Constructor for the OrganizationPhoneNumber object
   *
   * @param rs Description of Parameter
   * @throws SQLException Description of Exception
   */
  public OrganizationPhoneNumber(ResultSet rs) throws SQLException {
    buildRecord(rs);
  }


  /**
   * Constructor for the OrganizationPhoneNumber object
   *
   * @param db            Description of Parameter
   * @param phoneNumberId Description of Parameter
   * @throws SQLException Description of Exception
   */
  public OrganizationPhoneNumber(Connection db, String phoneNumberId) throws SQLException {
    queryRecord(db, Integer.parseInt(phoneNumberId));
  }


  /**
   * Constructor for the OrganizationPhoneNumber object
   *
   * @param db            Description of the Parameter
   * @param phoneNumberId Description of the Parameter
   * @throws SQLException Description of the Exception
   */
  public OrganizationPhoneNumber(Connection db, int phoneNumberId) throws SQLException {
    queryRecord(db, phoneNumberId);
  }


  /**
   * Description of the Method
   *
   * @param db            Description of the Parameter
   * @param phoneNumberId Description of the Parameter
   * @throws SQLException Description of the Exception
   */
  public void queryRecord(Connection db, int phoneNumberId) throws SQLException {
    if (phoneNumberId <= 0) {
      throw new SQLException("Invalid Phone Number ID specified.");
    }

    Statement st = null;
    ResultSet rs = null;
    StringBuffer sql = new StringBuffer();
    sql.append(
        "SELECT * " +
        "FROM organization_phone p, lookup_orgphone_types l " +
        " where p.phone_type = l.code " +
        " AND  phone_id = " + phoneNumberId + " ");
    st = db.createStatement();
    rs = st.executeQuery(sql.toString());
    if (rs.next()) {
      buildRecord(rs);
    }
    rs.close();
    st.close();
    if (this.getId() == -1) {
      throw new SQLException("Phone record not found.");
    }
  }


  /**
   * Description of the Method
   *
   * @param db         Description of the Parameter
   * @param orgId      Description of the Parameter
   * @param enteredBy  Description of the Parameter
   * @param modifiedBy Description of the Parameter
   * @throws SQLException Description of the Exception
   */
  public void process(Connection db, int orgId, int enteredBy, int modifiedBy,ActionContext context) throws SQLException {
    if (this.getEnabled() == true) {
      if (this.getId() == -1) {
        this.setOrgId(orgId);
        this.setEnteredBy(enteredBy);
        this.setModifiedBy(modifiedBy);
        this.insert(db,context);
      } else {
        this.setModifiedBy(modifiedBy);
        this.update(db, modifiedBy);
      }
    } else {
      this.delete(db);
    }
  }


  /**
   * Description of the Method
   *
   * @param db Description of the Parameter
   * @throws SQLException Description of the Exception
   */
  public void insert(Connection db,ActionContext context) throws SQLException {
    insert(db, this.getOrgId(), this.getEnteredBy(),context);
  }


  /**
   * Description of the Method
   *
   * @param db        Description of the Parameter
   * @param orgId     Description of the Parameter
   * @param enteredBy Description of the Parameter
   * @throws SQLException Description of the Exception
   */
  public void insert(Connection db, int orgId, int enteredBy,ActionContext context) throws SQLException {
    StringBuffer sql = new StringBuffer();
    
    int id = DatabaseUtils.getNextSeq(db,context, "organization_phone","phone_id");
    sql.append(
        "INSERT INTO organization_phone " +
        "(org_id, phone_type, " + DatabaseUtils.addQuotes(db, "number")+ ", extension, primary_number, ");
    if (id > -1) {
      sql.append("phone_id, ");
    }
    if (this.getEntered() != null) {
      sql.append("entered, ");
    }
    if (this.getModified() != null) {
      sql.append("modified, ");
    }
    sql.append("enteredBy, modifiedBy ) ");
    sql.append("VALUES (?, ?, ?, ?, ?, ");
    if (id > -1) {
      sql.append("?,");
    }
    if (this.getEntered() != null) {
      sql.append("?, ");
    }
    if (this.getModified() != null) {
      sql.append("?, ");
    }
    sql.append("?, ?) ");

    int i = 0;
    PreparedStatement pst = db.prepareStatement(sql.toString());

    if (orgId > -1) {
      pst.setInt(++i, this.getOrgId());
    } else {
      pst.setNull(++i, java.sql.Types.INTEGER);
    }
    if (this.getType() > -1) {
      pst.setInt(++i, this.getType());
    } else {
      pst.setNull(++i, java.sql.Types.INTEGER);
    }
    pst.setString(++i, this.getNumber());
    pst.setString(++i, this.getExtension());
    pst.setBoolean(++i, this.getPrimaryNumber());
    if (id > -1) {
      pst.setInt(++i, id);
    }
    if (this.getEntered() != null) {
      pst.setTimestamp(++i, this.getEntered());
    }
    if (this.getModified() != null) {
      pst.setTimestamp(++i, this.getModified());
    }
    pst.setInt(++i, this.getEnteredBy());
    pst.setInt(++i, this.getModifiedBy());

    pst.execute();
    pst.close();

    }


  /**
   * Description of the Method
   *
   * @param db         Description of the Parameter
   * @param modifiedBy Description of the Parameter
   * @throws SQLException Description of the Exception
   */
  public void update(Connection db, int modifiedBy) throws SQLException {
    PreparedStatement pst = db.prepareStatement(
        "UPDATE organization_phone " +
        "SET phone_type = ?, " + DatabaseUtils.addQuotes(db, "number")+ " = ?, extension = ?, primary_number = ?, modifiedby = ?, " +
        "modified = CURRENT_TIMESTAMP " +
        " where phone_id = ? ");
    int i = 0;
    if (this.getType() > -1) {
      pst.setInt(++i, this.getType());
    } else {
      pst.setNull(++i, java.sql.Types.INTEGER);
    }
    pst.setString(++i, this.getNumber());
    pst.setString(++i, this.getExtension());
    pst.setBoolean(++i, this.getPrimaryNumber());
    pst.setInt(++i, this.getModifiedBy());
    pst.setInt(++i, this.getId());
    pst.execute();
    pst.close();
  }


  /**
   * Description of the Method
   *
   * @param db Description of the Parameter
   * @throws SQLException Description of the Exception
   */
  public void delete(Connection db) throws SQLException {
    PreparedStatement pst = db.prepareStatement(
        "DELETE FROM organization_phone " +
        " where phone_id = ? ");
    int i = 0;
    pst.setInt(++i, this.getId());
    pst.execute();
    pst.close();
  }

  /**
   *  Gets the userIdParams attribute of the Contact class
   *
   * @return    The userIdParams value
   */
  public static ArrayList getUserIdParams() {
    ArrayList thisList = new ArrayList();
    thisList.add("enteredBy");
    thisList.add("modifiedBy");
    return thisList;
  }
}

