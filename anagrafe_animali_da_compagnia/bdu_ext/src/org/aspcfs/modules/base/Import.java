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
import java.sql.Timestamp;

import org.aspcfs.controller.ImportManager;
import org.aspcfs.controller.SystemStatus;
import org.aspcfs.modules.accounts.base.Organization;
import org.aspcfs.modules.contacts.base.Contact;
import org.aspcfs.modules.netapps.base.ContractExpiration;
import org.aspcfs.modules.products.base.ProductCatalog;
import org.aspcfs.modules.products.base.ProductCategory;
import org.aspcfs.utils.DatabaseUtils;

import com.darkhorseventures.framework.beans.GenericBean;
import com.zeroio.iteam.base.FileItem;

/**
 *  Represents a base Import
 *
 * @author     Mathur
 * @created    March 30, 2004
 * @version    $Id: Import.java 13827 2006-01-16 11:07:50 -0500 (Mon, 16 Jan
 *      2006) mrajkowski $
 */
public class Import extends GenericBean {
  //status
  public final static int UNPROCESSED = 1;
  public final static int QUEUED = 2;
  public final static int RUNNING = 3;
  public final static int FAILED = 4;
  public final static int CANCELED = 5;
  public final static int PROCESSED_UNAPPROVED = 6;
  public final static int PROCESSED_APPROVED = 7;
  public final static int DELETED = 8;

  public final static int CUSTOM = 7;
  public final static int EXCEL_CSV = 8;
  public final static int ACT = 9;
  public final static int OUTLOOK_CSV = 10;

  public final static double IMPORT_FILE_VERSION = 1.0;
  public final static double ERROR_FILE_VERSION = 1.1;
  
  public final static int TIPOLOGIA_IMPORT_MICROCHIP = 1;
  public final static int TIPOLOGIA_IMPORT_PASSAPORTI = 2;
  

  private int id = -1;
  private int type = -1;
  private int sourceType = -1;
  private int fileType = EXCEL_CSV;
  private int totalImportedRecords = 0;
  private int totalFailedRecords = 0;
  private int statusId = UNPROCESSED;
  private int enteredBy = -1;
  private int modifiedBy = -1;
  private int siteId = -1;
  private int rating = -1;

  private String name = null;
  private String description = null;
  private String source = null;
  private String comments = null;
  private String recordDelimiter = "line";
  private String columnDelimiter = ",";

  private java.sql.Timestamp entered = null;
  private java.sql.Timestamp modified = null;

  private boolean buildFileDetails = false;
  private FileItem file = null;

  //read only
  private SystemStatus systemStatus = null;
  
  private int tipologiaImport = -1;


  /**
   *  Sets the systemStatus attribute of the Import object
   *
   * @param  tmp  The new systemStatus value
   */
  public void setSystemStatus(SystemStatus tmp) {
    this.systemStatus = tmp;
  }


  /**
   *  Gets the systemStatus attribute of the Import object
   *
   * @return    The systemStatus value
   */
  public SystemStatus getSystemStatus() {
    return systemStatus;
  }


  /**
   *  Constructor for the Import object
   */
  public Import() { }


  /**
   *  Constructor for the Import object
   *
   * @param  db                Description of the Parameter
   * @param  importId          Description of the Parameter
   * @exception  SQLException  Description of the Exception
   * @throws  SQLException     Description of the Exception
   */
  public Import(Connection db, int importId) throws SQLException {
    if (importId == -1) {
      throw new SQLException("Import ID not specified");
    }

    PreparedStatement pst = db.prepareStatement(
        "SELECT m.import_id, m." + DatabaseUtils.addQuotes(db, "type")+ ", m.name, m.description, m.source_type, m.source, " +
        "m.record_delimiter, m.column_delimiter, m.total_imported_records, m.total_failed_records, " +
        "m.status_id, m.file_type, m.entered, m.enteredby, m.modified, m.modifiedby, m.site_id, m.rating, m.comments, m.tipologia_import " +
        "FROM import m " +
        "WHERE m.import_id = ? ");
    int i = 0;
    pst.setInt(++i, importId);
    ResultSet rs = pst.executeQuery();
    if (rs.next()) {
      buildRecord(rs);
    }
    rs.close();
    pst.close();
    if (id == -1) {
      throw new SQLException("Import ID not found");
    }

    //build file details
    if (buildFileDetails) {
      file = new FileItem(db, id, type);
      file.buildVersionList(db);
    }
  }


  /**
   *  Constructor for the Import object
   *
   * @param  rs                Description of the Parameter
   * @exception  SQLException  Description of the Exception
   * @throws  SQLException     Description of the Exception
   */
  public Import(ResultSet rs) throws SQLException {
    buildRecord(rs);
  }


  /**
   *  Sets the id attribute of the Import object
   *
   * @param  tmp  The new id value
   */
  public void setId(int tmp) {
    this.id = tmp;
  }


  /**
   *  Sets the id attribute of the Import object
   *
   * @param  tmp  The new id value
   */
  public void setId(String tmp) {
    this.id = Integer.parseInt(tmp);
  }


  /**
   *  Sets the type attribute of the Import object
   *
   * @param  tmp  The new type value
   */
  public void setType(int tmp) {
    this.type = tmp;
  }


  /**
   *  Sets the type attribute of the Import object
   *
   * @param  tmp  The new type value
   */
  public void setType(String tmp) {
    this.type = Integer.parseInt(tmp);
  }


  /**
   *  Sets the sourceType attribute of the Import object
   *
   * @param  tmp  The new sourceType value
   */
  public void setSourceType(int tmp) {
    this.sourceType = tmp;
  }


  /**
   *  Sets the sourceType attribute of the Import object
   *
   * @param  tmp  The new sourceType value
   */
  public void setSourceType(String tmp) {
    this.sourceType = Integer.parseInt(tmp);
  }


  /**
   *  Sets the totalImportedRecords attribute of the Import object
   *
   * @param  tmp  The new totalImportedRecords value
   */
  public void setTotalImportedRecords(int tmp) {
    this.totalImportedRecords = tmp;
  }


  /**
   *  Sets the totalImportedRecords attribute of the Import object
   *
   * @param  tmp  The new totalImportedRecords value
   */
  public void setTotalImportedRecords(String tmp) {
    this.totalImportedRecords = Integer.parseInt(tmp);
  }


  /**
   *  Sets the totalFailedRecords attribute of the Import object
   *
   * @param  tmp  The new totalFailedRecords value
   */
  public void setTotalFailedRecords(int tmp) {
    this.totalFailedRecords = tmp;
  }


  /**
   *  Sets the totalFailedRecords attribute of the Import object
   *
   * @param  tmp  The new totalFailedRecords value
   */
  public void setTotalFailedRecords(String tmp) {
    this.totalFailedRecords = Integer.parseInt(tmp);
  }


  /**
   *  Sets the statusId attribute of the Import object
   *
   * @param  tmp  The new statusId value
   */
  public void setStatusId(int tmp) {
    this.statusId = tmp;
  }


  /**
   *  Sets the statusId attribute of the Import object
   *
   * @param  tmp  The new statusId value
   */
  public void setStatusId(String tmp) {
    this.statusId = Integer.parseInt(tmp);
  }


  /**
   *  Sets the enteredBy attribute of the Import object
   *
   * @param  tmp  The new enteredBy value
   */
  public void setEnteredBy(int tmp) {
    this.enteredBy = tmp;
  }


  /**
   *  Sets the enteredBy attribute of the Import object
   *
   * @param  tmp  The new enteredBy value
   */
  public void setEnteredBy(String tmp) {
    this.enteredBy = Integer.parseInt(tmp);
  }


  /**
   *  Sets the modifiedBy attribute of the Import object
   *
   * @param  tmp  The new modifiedBy value
   */
  public void setModifiedBy(int tmp) {
    this.modifiedBy = tmp;
  }


  /**
   *  Sets the modifiedBy attribute of the Import object
   *
   * @param  tmp  The new modifiedBy value
   */
  public void setModifiedBy(String tmp) {
    this.modifiedBy = Integer.parseInt(tmp);
  }


  /**
   *  Sets the siteId attribute of the Import object
   *
   * @param  tmp  The new siteId value
   */
  public void setSiteId(int tmp) {
    this.siteId = tmp;
  }


  /**
   *  Sets the siteId attribute of the Import object
   *
   * @param  tmp  The new siteId value
   */
  public void setSiteId(String tmp) {
    this.siteId = Integer.parseInt(tmp);
  }


  /**
   *  Sets the name attribute of the Import object
   *
   * @param  tmp  The new name value
   */
  public void setName(String tmp) {
    this.name = tmp;
  }


  /**
   *  Sets the description attribute of the Import object
   *
   * @param  tmp  The new description value
   */
  public void setDescription(String tmp) {
    this.description = tmp;
  }


  /**
   *  Sets the source attribute of the Import object
   *
   * @param  tmp  The new source value
   */
  public void setSource(String tmp) {
    this.source = tmp;
  }


  /**
   *  Sets the recordDelimiter attribute of the Import object
   *
   * @param  tmp  The new recordDelimiter value
   */
  public void setRecordDelimiter(String tmp) {
    this.recordDelimiter = tmp;
  }


  /**
   *  Sets the columnDelimiter attribute of the Import object
   *
   * @param  tmp  The new columnDelimiter value
   */
  public void setColumnDelimiter(String tmp) {
    this.columnDelimiter = tmp;
  }


  /**
   *  Sets the entered attribute of the Import object
   *
   * @param  tmp  The new entered value
   */
  public void setEntered(java.sql.Timestamp tmp) {
    this.entered = tmp;
  }


  /**
   *  Sets the entered attribute of the Import object
   *
   * @param  tmp  The new entered value
   */
  public void setEntered(String tmp) {
    this.entered = DatabaseUtils.parseTimestamp(tmp);
  }


  /**
   *  Sets the modified attribute of the Import object
   *
   * @param  tmp  The new modified value
   */
  public void setModified(java.sql.Timestamp tmp) {
    this.modified = tmp;
  }


  /**
   *  Sets the modified attribute of the Import object
   *
   * @param  tmp  The new modified value
   */
  public void setModified(String tmp) {
    this.modified = DatabaseUtils.parseTimestamp(tmp);
  }


  /**
   *  Sets the fileType attribute of the Import object
   *
   * @param  tmp  The new fileType value
   */
  public void setFileType(int tmp) {
    this.fileType = tmp;
  }


  /**
   *  Sets the fileType attribute of the Import object
   *
   * @param  tmp  The new fileType value
   */
  public void setFileType(String tmp) {
    this.fileType = Integer.parseInt(tmp);
  }


  /**
   *  Sets the buildFileDetails attribute of the Import object
   *
   * @param  tmp  The new buildFileDetails value
   */
  public void setBuildFileDetails(boolean tmp) {
    this.buildFileDetails = tmp;
  }


  /**
   *  Sets the buildFileDetails attribute of the Import object
   *
   * @param  tmp  The new buildFileDetails value
   */
  public void setBuildFileDetails(String tmp) {
    this.buildFileDetails = DatabaseUtils.parseBoolean(tmp);
  }


  /**
   *  Sets the file attribute of the Import object
   *
   * @param  tmp  The new file value
   */
  public void setFile(FileItem tmp) {
    this.file = tmp;
  }


  /**
   *  Gets the file attribute of the Import object
   *
   * @return    The file value
   */
  public FileItem getFile() {
    return file;
  }


  /**
   *  Gets the buildFileDetails attribute of the Import object
   *
   * @return    The buildFileDetails value
   */
  public boolean getBuildFileDetails() {
    return buildFileDetails;
  }


  /**
   *  Gets the fileType attribute of the Import object
   *
   * @return    The fileType value
   */
  public int getFileType() {
    return fileType;
  }


  /**
   *  Gets the id attribute of the Import object
   *
   * @return    The id value
   */
  public int getId() {
    return id;
  }


  /**
   *  Gets the type attribute of the Import object
   *
   * @return    The type value
   */
  public int getType() {
    return type;
  }


  /**
   *  Gets the sourceType attribute of the Import object
   *
   * @return    The sourceType value
   */
  public int getSourceType() {
    return sourceType;
  }


  /**
   *  Gets the totalImportedRecords attribute of the Import object
   *
   * @return    The totalImportedRecords value
   */
  public int getTotalImportedRecords() {
    return totalImportedRecords;
  }


  /**
   *  Gets the totalFailedRecords attribute of the Import object
   *
   * @return    The totalFailedRecords value
   */
  public int getTotalFailedRecords() {
    return totalFailedRecords;
  }


  /**
   *  Gets the statusId attribute of the Import object
   *
   * @return    The statusId value
   */
  public int getStatusId() {
    return statusId;
  }
  
  
  
  


  public int getTipologiaImport() {
	return tipologiaImport;
}


public void setTipologiaImport(int tipologiaImport) {
	this.tipologiaImport = tipologiaImport;
}


/**
   *  Gets the statusString attribute of the Import object
   *
   * @return    The statusString value
   */
  public String getStatusString() {
    String tmp = null;
    switch (statusId) {
      case UNPROCESSED:
        tmp = (systemStatus != null ? systemStatus.getLabel(
            "contact.import.status.pending") : "Import Pending");
        break;
      case QUEUED:
        tmp = (systemStatus != null ? systemStatus.getLabel(
            "contact.import.status.queued") : "Queued");
        break;
      case RUNNING:
        tmp = (systemStatus != null ? systemStatus.getLabel(
            "contact.import.status.running") : "Running");
        break;
      case FAILED:
        tmp = (systemStatus != null ? systemStatus.getLabel(
            "contact.import.status.failed") : "Failed");
        break;
      case CANCELED:
        tmp = (systemStatus != null ? systemStatus.getLabel(
            "contact.import.status.cancelled") : "Cancelled");
        break;
      case PROCESSED_UNAPPROVED:
        tmp = (systemStatus != null ? systemStatus.getLabel(
            "contact.import.status.pendingApproval") : "Pending Approval");
        break;
      case PROCESSED_APPROVED:
        tmp = (systemStatus != null ? systemStatus.getLabel(
            "contact.import.status.approved") : "Approved");
        break;
      default:
        break;
    }
    return tmp;
  }


  /**
   *  Gets the enteredBy attribute of the Import object
   *
   * @return    The enteredBy value
   */
  public int getEnteredBy() {
    return enteredBy;
  }


  /**
   *  Gets the modifiedBy attribute of the Import object
   *
   * @return    The modifiedBy value
   */
  public int getModifiedBy() {
    return modifiedBy;
  }


  /**
   *  Gets the siteId attribute of the Import object
   *
   * @return    The siteId value
   */
  public int getSiteId() {
    return siteId;
  }


  /**
   *  Gets the name attribute of the Import object
   *
   * @return    The name value
   */
  public String getName() {
    return name;
  }


  /**
   *  Gets the description attribute of the Import object
   *
   * @return    The description value
   */
  public String getDescription() {
    return description;
  }


  /**
   *  Gets the source attribute of the Import object
   *
   * @return    The source value
   */
  public String getSource() {
    return source;
  }


  /**
   *  Gets the rating attribute of the Import object
   *
   * @return    The rating value
   */
  public int getRating() {
    return rating;
  }


  /**
   *  Sets the rating attribute of the Import object
   *
   * @param  tmp  The new rating value
   */
  public void setRating(int tmp) {
    this.rating = tmp;
  }


  /**
   *  Sets the rating attribute of the Import object
   *
   * @param  tmp  The new rating value
   */
  public void setRating(String tmp) {
    this.rating = Integer.parseInt(tmp);
  }


  /**
   *  Gets the comments attribute of the Import object
   *
   * @return    The comments value
   */
  public String getComments() {
    return comments;
  }


  /**
   *  Sets the comments attribute of the Import object
   *
   * @param  tmp  The new comments value
   */
  public void setComments(String tmp) {
    this.comments = tmp;
  }


  /**
   *  Description of the Method
   */
  public void incrementTotalImportedRecords() {
    this.totalImportedRecords++;
  }


  /**
   *  Description of the Method
   */
  public void incrementTotalFailedRecords() {
    this.totalFailedRecords++;
  }


  /**
   *  Gets the recordDelimiter attribute of the Import object
   *
   * @return    The recordDelimiter value
   */
  public String getRecordDelimiter() {
    return recordDelimiter;
  }


  /**
   *  Description of the Method
   *
   * @param  db             Description of the Parameter
   * @throws  SQLException  Description of the Exception
   */
  public void buildFileDetails(Connection db) throws SQLException {
    file = new FileItem(db, id, type);
    file.buildVersionList(db);
  }


  /**
   *  Description of the Method
   *
   * @return    Description of the Return Value
   */
  public boolean canDelete() {
    if (statusId != RUNNING && statusId < PROCESSED_APPROVED) {
      return true;
    }
    return false;
  }


  /**
   *  Gets the running attribute of the Import object
   *
   * @return    The running value
   */
  public boolean isRunning() {
    if (statusId == RUNNING) {
      return true;
    }
    return false;
  }


  /**
   *  Description of the Method
   *
   * @return    Description of the Return Value
   */
  public boolean hasBeenProcessed() {
    if (statusId == PROCESSED_APPROVED || statusId == PROCESSED_UNAPPROVED) {
      return true;
    }
    return false;
  }


  /**
   *  Description of the Method
   *
   * @return    Description of the Return Value
   */
  public boolean canProcess() {
    if (statusId == UNPROCESSED) {
      return true;
    }
    return false;
  }


  /**
   *  Description of the Method
   *
   * @return    Description of the Return Value
   */
  public boolean canApprove() {
    if (statusId == PROCESSED_UNAPPROVED) {
      return true;
    }
    return false;
  }


  /**
   *  Description of the Method
   *
   * @return    Description of the Return Value
   */
  public boolean canModify() {
    if (statusId == UNPROCESSED) {
      return true;
    }
    return false;
  }


  /**
   *  Gets the columnDelimiter attribute of the Import object
   *
   * @return    The columnDelimiter value
   */
  public String getColumnDelimiter() {
    if (columnDelimiter == null) {
      switch (fileType) {
        case ACT:
          //TODO: use delimiter for ACT
          break;
        case EXCEL_CSV:
          columnDelimiter = ",";
          break;
        case OUTLOOK_CSV:
          //TODO: use delimiter for OUTLOOK_CSV
          break;
        default:
          //TODO: Add checks to make sure the custom delimter is valid
          break;
      }
    }
    return columnDelimiter;
  }


  /**
   *  Gets the entered attribute of the Import object
   *
   * @return    The entered value
   */
  public java.sql.Timestamp getEntered() {
    return entered;
  }


  /**
   *  Gets the modified attribute of the Import object
   *
   * @return    The modified value
   */
  public java.sql.Timestamp getModified() {
    return modified;
  }


  /**
   *  Updates records counts if this is a running import
   *
   * @param  manager  Description of the Parameter
   */
  public void updateRecordCounts(ImportManager manager) {
    if (manager != null) {
      Object tmp = manager.getImport(this.getId());
      if (tmp != null) {
        Import activeImport = (Import) tmp;
        this.setTotalImportedRecords(activeImport.getTotalImportedRecords());
        this.setTotalFailedRecords(activeImport.getTotalFailedRecords());

        //check if status is queued
        if (activeImport.getStatusId() == Import.QUEUED) {
          this.setStatusId(Import.QUEUED);
        }
      }
    }
  }


  /**
   *  Updates the status of the import
   *
   * @param  db             Description of the Parameter
   * @param  status         Description of the Parameter
   * @return                Description of the Return Value
   * @throws  SQLException  Description of the Exception
   */
  public int updateStatus(Connection db, int status) throws SQLException {
    int count = 0;
    int previousStatus = this.getStatusId();

    try {
     
      String sql = "UPDATE import " +
          "SET status_id = ? " +
          "WHERE import_id = ? ";
      int i = 0;
      PreparedStatement pst = db.prepareStatement(sql);
      pst.setInt(++i, status);
      pst.setInt(++i, this.getId());
      count = pst.executeUpdate();
      pst.close();
      this.statusId = status;

      if (previousStatus == PROCESSED_UNAPPROVED && status == PROCESSED_APPROVED) {
        if (type == Constants.IMPORT_CONTACTS || type == Constants.IMPORT_ACCOUNT_CONTACTS || type == Constants.IMPORT_SALES) {
          Contact.updateImportStatus(db, this.getId(), PROCESSED_APPROVED);
          if (type == Constants.IMPORT_ACCOUNT_CONTACTS) {
            Organization.updateImportStatus(
                db, this.getId(), PROCESSED_APPROVED);
          }
        }
        if (type == Constants.IMPORT_PRODUCT_CATALOG) {
          ProductCatalog.updateImportStatus(
              db, this.getId(), PROCESSED_APPROVED);
          ProductCategory.updateImportStatus(
                  db, this.getId(), PROCESSED_APPROVED);
        }
        if (type == Constants.IMPORT_NETAPP_EXPIRATION) {
          ContractExpiration.updateImportStatus(db, this.getId(), PROCESSED_APPROVED);
        }
      }
     
    } catch (SQLException e) {
      e.printStackTrace();
     
      throw new SQLException(e.getMessage());
    } finally {
      
    }
    return count;
  }


  /**
   *  Records the results on successful completion of import
   *
   * @param  db             Description of the Parameter
   * @return                Description of the Return Value
   * @throws  SQLException  Description of the Exception
   */
  public int recordResults(Connection db) throws SQLException {
    int count = 0;
   

    try {
    
      String sql = "UPDATE import " +
          "SET status_id = ?, total_imported_records = ?, total_failed_records = ?, modified = ? " +
          "WHERE import_id = ? ";
      int i = 0;
      PreparedStatement pst = db.prepareStatement(sql);
      pst.setInt(++i, statusId);
      pst.setInt(++i, totalImportedRecords);
      pst.setInt(++i, totalFailedRecords);
      pst.setTimestamp(++i, new Timestamp(System.currentTimeMillis()));
      pst.setInt(++i, this.getId());
      count = pst.executeUpdate();
      pst.close();
     
    } catch (SQLException e) {
      
      throw new SQLException(e.getMessage());
    } finally {
      
    }
    return count;
  }


  /**
   *  Description of the Method
   *
   * @param  db             Description of the Parameter
   * @return                Description of the Return Value
   * @throws  SQLException  Description of the Exception
   */
  public boolean insert(Connection db) throws SQLException {
    String sql = null;
    try {
    
      id = DatabaseUtils.getNextSeq(db, "import_import_id_seq");
      sql = "INSERT INTO import " +
          "(" + (id > -1 ? "import_id, " : "") + "" + DatabaseUtils.addQuotes(db, "type")+ ", name, description, file_type, source_type, rating, comments, record_delimiter, column_delimiter, status_id, enteredby, modifiedby, site_id, modified, tipologia_import ) " +
          "VALUES (" + (id > -1 ? "?, " : "") + "?,?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, " +
          ((this.getModified()!=null)?"?":DatabaseUtils.getCurrentTimestamp(db)) +
          ", ?) ";
      int i = 0;
      PreparedStatement pst = db.prepareStatement(sql);
      if (id > -1) {
        pst.setInt(++i, id);
      }
      pst.setInt(++i, this.getType());
      pst.setString(++i, this.getName());
      pst.setString(++i, this.getDescription());
      pst.setInt(++i, this.getFileType());
      DatabaseUtils.setInt(pst, ++i, this.getSourceType());
      DatabaseUtils.setInt(pst, ++i, this.getRating());
      pst.setString(++i, this.getComments());
      pst.setString(++i, this.getRecordDelimiter());
      pst.setString(++i, this.getColumnDelimiter());
      pst.setInt(++i, this.getStatusId());
      pst.setInt(++i, this.getEnteredBy());
      pst.setInt(++i, this.getModifiedBy());
      DatabaseUtils.setInt(pst, ++i, this.getSiteId());
      if(this.getModified()!=null){
        pst.setTimestamp(++i, this.getModified());
      }
      pst.setInt(++i, tipologiaImport);
      pst.execute();
      id = DatabaseUtils.getCurrVal(db, "import_import_id_seq", id);
      pst.close();
      
    } catch (SQLException e) {
     
      throw new SQLException(e.getMessage());
    } finally {
      
    }
    return true;
  }


  /**
   *  Description of the Method
   *
   * @param  rs             Description of the Parameter
   * @throws  SQLException  Description of the Exception
   */
  protected void buildRecord(ResultSet rs) throws SQLException {
    //import table
    id = rs.getInt("import_id");
    type = rs.getInt("type");
    name = rs.getString("name");
    description = rs.getString("description");
    sourceType = DatabaseUtils.getInt(rs,"source_type");
    source = rs.getString("source");
    recordDelimiter = rs.getString("record_delimiter");
    columnDelimiter = rs.getString("column_delimiter");
    totalImportedRecords = rs.getInt("total_imported_records");
    totalFailedRecords = rs.getInt("total_failed_records");
    statusId = rs.getInt("status_id");
    fileType = rs.getInt("file_type");
    entered = rs.getTimestamp("entered");
    enteredBy = rs.getInt("enteredby");
    modified = rs.getTimestamp("modified");
    modifiedBy = rs.getInt("modifiedby");
    siteId = DatabaseUtils.getInt(rs, "site_id");
    rating = DatabaseUtils.getInt(rs, "rating");
    comments = rs.getString("comments");
    tipologiaImport = rs.getInt("tipologia_import");
  }
}
