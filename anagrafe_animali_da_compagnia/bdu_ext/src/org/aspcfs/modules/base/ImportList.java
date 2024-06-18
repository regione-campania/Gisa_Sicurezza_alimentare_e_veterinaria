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
package org.aspcfs.modules.base;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;

import org.aspcfs.controller.ImportManager;
import org.aspcfs.controller.SystemStatus;
import org.aspcfs.utils.DatabaseUtils;
import org.aspcfs.utils.web.PagedListInfo;

/**
 * Represents a list of imports
 *
 * @author Mathur
 * @version $Id: ImportList.java 24289 2007-12-09 11:35:15Z srinivasar@cybage.com $
 * @created April 19, 2004
 */
public class ImportList extends ArrayList {

  public final static String tableName = "import";
  public final static String uniqueField = "import_id";
  private java.sql.Timestamp lastAnchor = null;
  private java.sql.Timestamp nextAnchor = null;
  private int syncType = Constants.NO_SYNC;

  private int enteredBy = -1;
  private String enteredIdRange = null;
  private boolean controlledHierarchyOnly = false;
  private PagedListInfo pagedListInfo = null;
  private ImportManager manager = null;
  private int type = -1;
  private int ignoreStatusId = Import.DELETED; //Ignores records with this status
  private SystemStatus systemStatus = null;

  private int siteId = -1;
  private int idTipologiaImport = -1; //Microchip o passaporto??
  private boolean includeImportsApplicableToAllSites = false;
  private boolean buildFileDetails = true;


  /**
   * Sets the systemStatus attribute of the ImportList object
   *
   * @param tmp The new systemStatus value
   */
  public void setSystemStatus(SystemStatus tmp) {
    this.systemStatus = tmp;
  }


  /**
   * Constructor for the ImportList object
   */
  public ImportList() {
  }


  /**
   * Sets the enteredBy attribute of the ImportList object
   *
   * @param tmp The new enteredBy value
   */
  public void setEnteredBy(int tmp) {
    this.enteredBy = tmp;
  }


  /**
   * Sets the manager attribute of the ImportList object
   *
   * @param tmp The new manager value
   */
  public void setManager(ImportManager tmp) {
    this.manager = tmp;
  }


  /**
   * Gets the manager attribute of the ImportList object
   *
   * @return The manager value
   */
  public ImportManager getManager() {
    return manager;
  }


  /**
   * Sets the enteredBy attribute of the ImportList object
   *
   * @param tmp The new enteredBy value
   */
  public void setEnteredBy(String tmp) {
    this.enteredBy = Integer.parseInt(tmp);
  }

  
  

  public int getIdTipologiaImport() {
	return idTipologiaImport;
}


public void setIdTipologiaImport(int idTipologiaImport) {
	this.idTipologiaImport = idTipologiaImport;
}


/**
   * Sets the pagedListInfo attribute of the ImportList object
   *
   * @param tmp The new pagedListInfo value
   */
  public void setPagedListInfo(PagedListInfo tmp) {
    this.pagedListInfo = tmp;
  }


  /**
   * Sets the type attribute of the ImportList object
   *
   * @param tmp The new type value
   */
  public void setType(int tmp) {
    this.type = tmp;
  }


  /**
   * Sets the type attribute of the ImportList object
   *
   * @param tmp The new type value
   */
  public void setType(String tmp) {
    this.type = Integer.parseInt(tmp);
  }


  public void setIgnoreStatusId(int tmp) {
    this.ignoreStatusId = tmp;
  }

  public void setIgnoreStatusId(String tmp) {
    this.ignoreStatusId = Integer.parseInt(tmp);
  }

  public int getIgnoreStatusId() {
    return ignoreStatusId;
  }

  public boolean getBuildFileDetails() {
    return this.buildFileDetails;
  }

  public void setBuildFileDetails(boolean tmp) {
    this.buildFileDetails = tmp;
  }

  public void setBuildFileDetails(String tmp) {
    this.buildFileDetails = DatabaseUtils.parseBoolean(tmp);
  }

  /**
   * Sets the controlledHierarchyOnly attribute of the ImportList object
   *
   * @param tmp The new controlledHierarchyOnly value
   */
  public void setControlledHierarchyOnly(boolean tmp) {
    this.controlledHierarchyOnly = tmp;
  }


  /**
   * Sets the controlledHierarchyOnly attribute of the ImportList object
   *
   * @param tmp The new controlledHierarchyOnly value
   */
  public void setControlledHierarchyOnly(String tmp) {
    this.controlledHierarchyOnly = DatabaseUtils.parseBoolean(tmp);
  }


  /**
   * Gets the controlledHierarchyOnly attribute of the ImportList object
   *
   * @return The controlledHierarchyOnly value
   */
  public boolean getControlledHierarchyOnly() {
    return controlledHierarchyOnly;
  }


  /**
   * Sets the enteredIdRange attribute of the ImportList object
   *
   * @param tmp The new enteredIdRange value
   */
  public void setEnteredIdRange(String tmp) {
    this.enteredIdRange = tmp;
  }


  /**
   * Gets the enteredIdRange attribute of the ImportList object
   *
   * @return The enteredIdRange value
   */
  public String getEnteredIdRange() {
    return enteredIdRange;
  }


  /**
   * Gets the enteredBy attribute of the ImportList object
   *
   * @return The enteredBy value
   */
  public int getEnteredBy() {
    return enteredBy;
  }


  /**
   * Gets the pagedListInfo attribute of the ImportList object
   *
   * @return The pagedListInfo value
   */
  public PagedListInfo getPagedListInfo() {
    return pagedListInfo;
  }


  /**
   * Gets the type attribute of the ImportList object
   *
   * @return The type value
   */
  public int getType() {
    return type;
  }


  /**
   * Sets the siteId attribute of the ImportList object
   *
   * @param tmp The new siteId value
   */
  public void setSiteId(int tmp) {
    this.siteId = tmp;
  }


  /**
   * Sets the siteId attribute of the ImportList object
   *
   * @param tmp The new siteId value
   */
  public void setSiteId(String tmp) {
    this.siteId = Integer.parseInt(tmp);
  }


  /**
   * Sets the includeImportsApplicableToAllSites attribute of the ImportList
   * object
   *
   * @param tmp The new includeImportsApplicableToAllSites value
   */
  public void setIncludeImportsApplicableToAllSites(boolean tmp) {
    this.includeImportsApplicableToAllSites = tmp;
  }


  /**
   * Sets the includeImportsApplicableToAllSites attribute of the ImportList
   * object
   *
   * @param tmp The new includeImportsApplicableToAllSites value
   */
  public void setIncludeImportsApplicableToAllSites(String tmp) {
    this.includeImportsApplicableToAllSites = DatabaseUtils.parseBoolean(tmp);
  }


  /**
   * Gets the siteId attribute of the ImportList object
   *
   * @return The siteId value
   */
  public int getSiteId() {
    return siteId;
  }


  /**
   * Gets the includeImportsApplicableToAllSites attribute of the ImportList
   * object
   *
   * @return The includeImportsApplicableToAllSites value
   */
  public boolean getIncludeImportsApplicableToAllSites() {
    return includeImportsApplicableToAllSites;
  }

  
  

  /**
   * Description of the Method
   *
   * @param db Description of the Parameter
   * @throws SQLException Description of the Exception
   */
  public void buildList(Connection db) throws SQLException {
    PreparedStatement pst = null;
    ResultSet rs = null;
    int items = -1;
    StringBuffer sqlSelect = new StringBuffer();
    StringBuffer sqlCount = new StringBuffer();
    StringBuffer sqlFilter = new StringBuffer();
    StringBuffer sqlOrder = new StringBuffer();
    //Build a base SQL statement for counting records
    sqlCount.append(
        "SELECT COUNT(*) AS recordcount " +
            "FROM import m " +
            "WHERE m.import_id > -1 ");
    createFilter(db, sqlFilter);
    if (pagedListInfo != null) {
      //Get the total number of records matching filter
      pst = db.prepareStatement(sqlCount.toString() + sqlFilter.toString());
      items = prepareFilter(pst);
      rs = pst.executeQuery();
      if (rs.next()) {
        int maxRecords = rs.getInt("recordcount");
        pagedListInfo.setMaxRecords(maxRecords);
      }
      rs.close();
      pst.close();
      //Determine the offset, based on the filter, for the first record to show
      if (!pagedListInfo.getCurrentLetter().equals("")) {
        pst = db.prepareStatement(
            sqlCount.toString() +
                sqlFilter.toString() +
                "AND m.entered > ? ");
        items = prepareFilter(pst);
        pst.setString(++items, pagedListInfo.getCurrentLetter().toLowerCase());
        rs = pst.executeQuery();
        if (rs.next()) {
          int offsetCount = rs.getInt("recordcount");
          pagedListInfo.setCurrentOffset(offsetCount);
        }
        rs.close();
        pst.close();
      }
      //Determine column to sort by
      pagedListInfo.setDefaultSort("m.entered", "DESC");
      pagedListInfo.appendSqlTail(db, sqlOrder);
    } else {
      sqlOrder.append(" ORDER BY m.entered DESC ");
    }
    //Build a base SQL statement for returning records
    if (pagedListInfo != null) {
      pagedListInfo.appendSqlSelectHead(db, sqlSelect);
    } else {
      sqlSelect.append("SELECT ");
    }
    sqlSelect.append(
        "m.import_id, m." + DatabaseUtils.addQuotes(db, "type") + ", m.name, m.description, m.source_type, m.source, " +
            "m.record_delimiter, m.column_delimiter, m.total_imported_records, m.total_failed_records, " +
            "m.status_id, m.file_type, m.entered, m.enteredby, m.modified, m.modifiedby, m.site_id, m.rating, m.comments, m.tipologia_import " +
            "FROM import m " +
            "WHERE m.import_id > -1 ");
    pst = db.prepareStatement(
        sqlSelect.toString() + sqlFilter.toString() + sqlOrder.toString());
    items = prepareFilter(pst);
    if (pagedListInfo != null) {
      pagedListInfo.doManualOffset(db, pst);
    }
    rs = pst.executeQuery();
    if (pagedListInfo != null) {
      pagedListInfo.doManualOffset(db, rs);
    }
    while (rs.next()) {
      Import thisImport = new Import(rs);
      //Read only access to systemStatus required for translating Import Status
      thisImport.setSystemStatus(systemStatus);
      this.add(thisImport);
    }
    rs.close();
    pst.close();

    //build the file items
    Iterator i = this.iterator();
    while (i.hasNext()) {
      Import thisImport = (Import) i.next();
      if (buildFileDetails) {
        thisImport.buildFileDetails(db);
      }

      //check for dead imports
      if (manager != null) {
        Object activeImport = manager.getImport(thisImport.getId());
        if (thisImport.isRunning() && activeImport == null) {
          thisImport.updateStatus(db, Import.FAILED);
        }
      }
    }
  }


  /**
   * Description of the Method
   *
   * @param sqlFilter Description of the Parameter
   */
  protected void createFilter(Connection db, StringBuffer sqlFilter) {
    if (sqlFilter == null) {
      sqlFilter = new StringBuffer();
    }

    if (ignoreStatusId != -1) {
      sqlFilter.append("AND m.status_id != ? ");
    }

    if (enteredBy != -1) {
      sqlFilter.append("AND m.enteredby = ? ");
    }

    if (controlledHierarchyOnly) {
      sqlFilter.append("AND m.enteredby IN (" + enteredIdRange + ") ");
    }

    if (type != -1) {
      sqlFilter.append("AND m." + DatabaseUtils.addQuotes(db, "type") + " = ? ");
    }

    // includes only those imports with the specified site
    // and those that have no site associated with it
    if (siteId != -1) {
      sqlFilter.append("AND ");
      if (includeImportsApplicableToAllSites) {
        sqlFilter.append(" ( ");
      }
      sqlFilter.append("m.site_id = ? ");
      if (includeImportsApplicableToAllSites) {
        sqlFilter.append(" OR m.site_id IS NULL ) ");
      }
    }

    // includes only those imports with no site.
    if (siteId == -1) {
      if (includeImportsApplicableToAllSites) {
        sqlFilter.append("AND m.site_id IS NULL ");
      }
    }
    if (syncType == Constants.SYNC_INSERTS) {
      if (lastAnchor != null) {
        sqlFilter.append("AND m.entered > ? ");
      }
      sqlFilter.append("AND m.entered < ? ");
    }
    if (syncType == Constants.SYNC_UPDATES) {
      sqlFilter.append("AND m.modified > ? ");
      sqlFilter.append("AND m.entered < ? ");
      sqlFilter.append("AND m.modified < ? ");
    }
    
    
    if (idTipologiaImport > 0){
    	sqlFilter.append("AND m.tipologia_import = ?");
    }
  }


  /**
   * Description of the Method
   *
   * @param pst Description of the Parameter
   * @return Description of the Return Value
   * @throws SQLException Description of the Exception
   */
  protected int prepareFilter(PreparedStatement pst) throws SQLException {
    int i = 0;

    if (ignoreStatusId != -1) {
      pst.setInt(++i, ignoreStatusId);
    }

    if (enteredBy != -1) {
      pst.setInt(++i, enteredBy);
    }

    if (type != -1) {
      pst.setInt(++i, type);
    }

    if (siteId != -1) {
      pst.setInt(++i, siteId);
    }
    if (syncType == Constants.SYNC_INSERTS) {
      if (lastAnchor != null) {
        pst.setTimestamp(++i, lastAnchor);
      }
      pst.setTimestamp(++i, nextAnchor);
    }
    if (syncType == Constants.SYNC_UPDATES) {
      pst.setTimestamp(++i, lastAnchor);
      pst.setTimestamp(++i, lastAnchor);
      pst.setTimestamp(++i, nextAnchor);
    }
    
    
    if (idTipologiaImport > 0){
    	 pst.setInt(++i, idTipologiaImport);
    }
    return i;
  }


  /**
   * Constructor for the updateRecordCounts object
   */
  public void updateRecordCounts() {
    Iterator i = this.iterator();
    if (manager != null) {
      while (i.hasNext()) {
        Import thisImport = (Import) i.next();
        Object tmpObj = manager.getImport(thisImport.getId());
        if (tmpObj != null) {
          Import activeImport = (Import) tmpObj;
          thisImport.setTotalImportedRecords(
              activeImport.getTotalImportedRecords());
          thisImport.setTotalFailedRecords(
              activeImport.getTotalFailedRecords());

          //check if status is queued
          if (activeImport.getStatusId() == Import.QUEUED) {
            thisImport.setStatusId(Import.QUEUED);
          }

          //check if status is running
          if (activeImport.getStatusId() == Import.RUNNING) {
            thisImport.setStatusId(Import.RUNNING);
          }
        }
      }
    }
  }
}
