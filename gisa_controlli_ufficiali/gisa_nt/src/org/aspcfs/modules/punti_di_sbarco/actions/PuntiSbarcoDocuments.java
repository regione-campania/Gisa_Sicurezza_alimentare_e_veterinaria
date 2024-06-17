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
package org.aspcfs.modules.punti_di_sbarco.actions;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;

import org.aspcfs.controller.SystemStatus;
import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.base.Constants;
import org.aspcfs.modules.punti_di_sbarco.base.Organization;

import com.darkhorseventures.framework.actions.ActionContext;
import com.isavvix.tools.FileInfo;
import com.isavvix.tools.HttpMultiPartParser;
import com.zeroio.iteam.actions.ProjectManagementFileFolders;
import com.zeroio.iteam.base.FileFolderHierarchy;
import com.zeroio.iteam.base.FileFolderList;
import com.zeroio.iteam.base.FileItem;
import com.zeroio.iteam.base.FileItemList;
import com.zeroio.iteam.base.FileItemVersion;
import com.zeroio.webutils.FileDownload;

/**
 * Description of the Class
 *
 * @author chris price
 * @version $Id: AccountsDocuments.java,v 1.13 2002/09/26 13:08:23 mrajkowski
 *          Exp $
 * @created August 9, 2002
 */
public final class PuntiSbarcoDocuments extends CFSModule {

  /**
   * Description of the Method
   *
   * @param context Description of the Parameter
   * @return Description of the Return Value
   */
  public String executeCommandView(ActionContext context) {
    if (!(hasPermission(context, "punti_di_sbarco-documents-view"))) {
      return ("PermissionError");
    }
    String orgId = (String) context.getRequest().getParameter("orgId");
    if (orgId == null && !"".equals(orgId)) {
      orgId = (String) context.getRequest().getAttribute("orgId");
    }
    String folderId = context.getRequest().getParameter("folderId");
    if (folderId == null) {
      folderId = (String) context.getRequest().getAttribute("folderId");
    }

    Exception errorMessage = null;
    Connection db = null;
    Organization thisOrg = null;

    try {
      db = getConnection(context);
      //check permission to record
      if (!isRecordAccessPermitted(context, db, Integer.parseInt(orgId))) {
        return ("PermissionError");
      }
      thisOrg = new Organization(db, Integer.parseInt(orgId));
      context.getRequest().setAttribute("OrgDetails", thisOrg);

      //Build the folder list
      FileFolderList folders = new FileFolderList();
      if (folderId == null || "-1".equals(folderId) || "0".equals(folderId) || "".equals(
          folderId)) {
        folders.setTopLevelOnly(true);
      } else {
        folders.setParentId(Integer.parseInt(folderId));
        //Build array of folder trails
        ProjectManagementFileFolders.buildHierarchy(db, context);
      }
      folders.setLinkModuleId(Constants.ACCOUNTS);
      folders.setLinkItemId(thisOrg.getOrgId());
      folders.setBuildItemCount(true);
      folders.buildList(db);

      //Build the file item list
      FileItemList files = new FileItemList();
      if (folderId == null || "-1".equals(folderId) || "0".equals(folderId) || "".equals(
          folderId)) {
        files.setTopLevelOnly(true);
      } else {
        files.setFolderId(Integer.parseInt(folderId));
      }
      
      files.setBuildPortalRecords(
      		isPortalUser(context) ? Constants.TRUE : Constants.UNDEFINED);
      files.setLinkModuleId(Constants.ACCOUNTS);
      files.setLinkItemId(thisOrg.getOrgId());
      files.buildList(db);

      context.getRequest().setAttribute("OrgDetails", thisOrg);
      context.getRequest().setAttribute("fileItemList", files);
      context.getRequest().setAttribute("fileFolderList", folders);
    } catch (Exception e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }

    addModuleBean(context, "View Accounts", "View Documents");
    if (errorMessage == null) {
      String accountfolders = context.getRequest().getParameter("accountfolders");
      if (accountfolders != null && "true".equals(accountfolders)) {
        return "ViewAccountFolderPopupOK";
      }
      return (getReturn(context, "View"));
    } else {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    }
  }


  /**
   * Description of the Method
   *
   * @param context Description of the Parameter
   * @return Description of the Return Value
   */
  public String executeCommandAdd(ActionContext context) {

    if (!(hasPermission(context, "punti_di_sbarco-documents-add"))) {
      return ("PermissionError");
    }
    Exception errorMessage = null;
    Connection db = null;
    Organization thisOrg = null;

    try {
      db = getConnection(context);
      thisOrg = addOrganization(context, db);
      //check permission to record
      if (!isRecordAccessPermitted(context, db, thisOrg.getOrgId())) {
        return ("PermissionError");
      }
      context.getRequest().setAttribute("OrgDetails", thisOrg);
      String folderId = context.getRequest().getParameter("folderId");
      if (folderId != null) {
        context.getRequest().setAttribute("folderId", folderId);
      }
      //Build array of folder trails
      ProjectManagementFileFolders.buildHierarchy(db, context);

    } catch (Exception e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }

    addModuleBean(context, "View Accounts", "Upload Document");
    if (errorMessage == null) {
      return getReturn(context, "Add");
    } else {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    }
  }


  /**
   * Description of the Method
   *
   * @param context Description of the Parameter
   * @return Description of the Return Value
   */
  public String executeCommandUpload(ActionContext context) {
    if (!hasPermission(context, "punti_di_sbarco-documents-add")) {
      return ("PermissionError");
    }
    Connection db = null;
    Organization thisOrg = null;
    boolean recordInserted = false;
    boolean isValid = false;
    try {
      String filePath = this.getPath(context, "accounts");
      //Process the form data
      HttpMultiPartParser multiPart = new HttpMultiPartParser();
      multiPart.setUsePathParam(false);
      multiPart.setUseUniqueName(true);
      multiPart.setUseDateForFolder(true);
      multiPart.setExtensionId(getUserId(context));
      HashMap parts = multiPart.parseData(context.getRequest(), filePath);
      String id = (String) parts.get("id");
      String subject = (String) parts.get("subject");
      String folderId = (String) parts.get("folderId");
      String actionStepWork = (String) parts.get("actionStepWork");
      String allowPortalAccess = (String) parts.get("allowPortalAccess");
      if (folderId != null) {
        context.getRequest().setAttribute("folderId", folderId);
      }
      if (subject != null) {
        context.getRequest().setAttribute("subject", subject);
      }
      if (actionStepWork != null) {
        context.getRequest().setAttribute("actionStepWork", actionStepWork);
      }
      db = getConnection(context);
      thisOrg = addOrganization(context, db, id);
      //check permission to record
      if (!isRecordAccessPermitted(context, db, thisOrg.getOrgId())) {
        return ("PermissionError");
      }
      if ((Object) parts.get("id" + (String) parts.get("id")) instanceof FileInfo) {
        //Update the database with the resulting file
        FileInfo newFileInfo = (FileInfo) parts.get("id" + id);
        //Insert a file description record into the database
        FileItem thisItem = new FileItem();
        thisItem.setLinkModuleId(Constants.ACCOUNTS);
        thisItem.setLinkItemId(thisOrg.getOrgId());
        thisItem.setEnteredBy(getUserId(context));
        thisItem.setModifiedBy(getUserId(context));
        thisItem.setFolderId(Integer.parseInt(folderId));
        thisItem.setSubject(subject);
        thisItem.setClientFilename(newFileInfo.getClientFileName());
        thisItem.setFilename(newFileInfo.getRealFilename());
        thisItem.setVersion(1.0);
        thisItem.setSize(newFileInfo.getSize());
        thisItem.setAllowPortalAccess(allowPortalAccess);
        isValid = this.validateObject(context, db, thisItem);
        if (isValid) {
          recordInserted = thisItem.insert(db);
        }
        if (recordInserted) {
          this.processInsertHook(context, thisItem);
          context.getRequest().setAttribute("fileItem", thisItem);
          context.getRequest().setAttribute("subject", "");
        }
      } else {
        recordInserted = false;
        HashMap errors = new HashMap();
        SystemStatus systemStatus = this.getSystemStatus(context);
        errors.put(
            "actionError", systemStatus.getLabel(
                "object.validation.incorrectFileName"));
        if (subject != null && "".equals(subject.trim())) {
          errors.put(
              "subjectError", systemStatus.getLabel(
                  "object.validation.required"));
        }
        processErrors(context, errors);
      }
    } catch (Exception e) {
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      freeConnection(context, db);
    }

    if (recordInserted) {
      return ("UploadOK");
    }
    return (executeCommandAdd(context));
  }


  /**
   * Description of the Method
   *
   * @param context Description of the Parameter
   * @return Description of the Return Value
   */
  public String executeCommandAddVersion(ActionContext context) {
    if (!hasPermission(context, "punti_di_sbarco-documents-add")) {
      return ("PermissionError");
    }
    Exception errorMessage = null;
    Organization thisOrg = null;
    String itemId = (String) context.getRequest().getParameter("fid");
    if (itemId == null) {
      itemId = (String) context.getRequest().getAttribute("fid");
    }
    String folderId = (String) context.getParameter("folderId");
    if (folderId == null) {
      folderId = (String) context.getRequest().getAttribute("folderId");
    }
    if (folderId != null) {
      context.getRequest().setAttribute("folderId", folderId);
    }
    Connection db = null;
    try {
      db = getConnection(context);
      thisOrg = addOrganization(context, db);
      //check permission to record
      if (!isRecordAccessPermitted(context, db, thisOrg.getOrgId())) {
        return ("PermissionError");
      }
      FileItem thisFile = new FileItem(
          db, Integer.parseInt(itemId), thisOrg.getOrgId(), Constants.ACCOUNTS);
      context.getRequest().setAttribute("FileItem", thisFile);

      //Build array of folder trails
      ProjectManagementFileFolders.buildHierarchy(db, context);
    } catch (Exception e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }
    addModuleBean(context, "View Accounts", "Upload New Document Version");
    if (errorMessage == null) {
      return getReturn(context, "AddVersion");
    } else {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    }
  }


  /**
   * Description of the Method
   *
   * @param context Description of the Parameter
   * @return Description of the Return Value
   */
  public String executeCommandUploadVersion(ActionContext context) {
    if (!hasPermission(context, "punti_di_sbarco-documents-add")) {
      return ("PermissionError");
    }
    Connection db = null;
    Organization thisOrg = null;
    boolean recordInserted = false;
    boolean isValid = false;
    try {
      String filePath = this.getPath(context, "accounts");
      //Process the form data
      HttpMultiPartParser multiPart = new HttpMultiPartParser();
      multiPart.setUsePathParam(false);
      multiPart.setUseUniqueName(true);
      multiPart.setUseDateForFolder(true);
      multiPart.setExtensionId(getUserId(context));
      HashMap parts = multiPart.parseData(context.getRequest(), filePath);
      String id = (String) parts.get("id");
      String itemId = (String) parts.get("fid");
      String subject = (String) parts.get("subject");
      String versionId = (String) parts.get("versionId");
      String folderId = (String) parts.get("folderId");
      String allowPortalAccess = (String) parts.get("allowPortalAccess");
      if (folderId != null) {
        context.getRequest().setAttribute("folderId", folderId);
      }
      if (subject != null) {
        context.getRequest().setAttribute("subject", subject);
      }
      db = getConnection(context);
      thisOrg = addOrganization(context, db, id);
      //check permission to record
      if (!isRecordAccessPermitted(context, db, thisOrg.getOrgId())) {
        return ("PermissionError");
      }
      if ((Object) parts.get("id" + (String) parts.get("id")) instanceof FileInfo) {
        //Update the database with the resulting file
        FileInfo newFileInfo = (FileInfo) parts.get("id" + id);

        FileItem previousItem = null;
        FileItem thisItem = new FileItem();
        thisItem.setLinkModuleId(Constants.ACCOUNTS);
        thisItem.setLinkItemId(thisOrg.getOrgId());
        thisItem.setId(Integer.parseInt(itemId));
        previousItem = new FileItem(
            db, Integer.parseInt(itemId),thisItem.getLinkItemId(), thisItem.getLinkModuleId());
        thisItem.setEnteredBy(getUserId(context));
        thisItem.setModifiedBy(getUserId(context));
        thisItem.setSubject(subject);
        thisItem.setClientFilename(newFileInfo.getClientFileName());
        thisItem.setFilename(newFileInfo.getRealFilename());
        thisItem.setVersion(Double.parseDouble(versionId));
        thisItem.setSize(newFileInfo.getSize());
        thisItem.setAllowPortalAccess(allowPortalAccess);
        isValid = this.validateObject(context, db, thisItem);
        if (isValid) {
          recordInserted = thisItem.insertVersion(db);
        }
        if (recordInserted) {
          this.processUpdateHook(context, previousItem, thisItem);
        }
      } else {
        recordInserted = false;
        HashMap errors = new HashMap();
        SystemStatus systemStatus = this.getSystemStatus(context);
        errors.put(
            "actionError", systemStatus.getLabel(
                "object.validation.incorrectFileName"));
        if (subject != null && "".equals(subject.trim())) {
          errors.put(
              "subjectError", systemStatus.getLabel(
                  "object.validation.required"));
        }
        processErrors(context, errors);
      }
      context.getRequest().setAttribute("fid", itemId);
    } catch (Exception e) {
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      freeConnection(context, db);
    }

    if (recordInserted) {
      return ("UploadOK");
    }
    return (executeCommandAddVersion(context));
  }


  /**
   * Description of the Method
   *
   * @param context Description of the Parameter
   * @return Description of the Return Value
   */
  public String executeCommandDetails(ActionContext context) {

    if (!(hasPermission(context, "punti_di_sbarco-documents-view"))) {
      return ("PermissionError");
    }
    Exception errorMessage = null;
    Connection db = null;
    String folderId = context.getRequest().getParameter("folderId");
    String itemId = (String) context.getRequest().getParameter("fid");

    try {
      db = getConnection(context);
      Organization thisOrg = addOrganization(context, db);
      //check permission to record
      if (!isRecordAccessPermitted(context, db, thisOrg.getOrgId())) {
        return ("PermissionError");
      }

      FileItem thisItem = new FileItem(
          db, Integer.parseInt(itemId), thisOrg.getOrgId(), Constants.ACCOUNTS);
      thisItem.buildVersionList(db, isPortalUser(context));
      if (folderId == null) {
        folderId = "" + thisItem.getFolderId();
      }
      if (folderId != null) {
        context.getRequest().setAttribute("folderId", folderId);
      }
      if (folderId != null && !"-1".equals(folderId) && !"0".equals(folderId) && !"".equals(
          folderId.trim())) {
        //Build array of folder trails
        ProjectManagementFileFolders.buildHierarchy(db, context);
      }
      context.getRequest().setAttribute("FileItem", thisItem);

    } catch (Exception e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }

    addModuleBean(context, "View Accounts", "Document Details");
    if (errorMessage == null) {
      return getReturn(context, "Details");
    } else {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    }
  }


  /**
   * Description of the Method
   *
   * @param context Description of the Parameter
   * @return Description of the Return Value
   */
  public String executeCommandDownload(ActionContext context) {
    if (!hasPermission(context, "punti_di_sbarco-documents-view")) {
      return ("PermissionError");
    }
    SystemStatus systemStatus = this.getSystemStatus(context);
    Exception errorMessage = null;
    String itemId = (String) context.getRequest().getParameter("fid");
    String version = (String) context.getRequest().getParameter("ver");
    String view = (String) context.getRequest().getParameter("view");
    FileItem thisItem = null;
    Connection db = null;
    Organization thisOrg = null;
    try {
      db = getConnection(context);
      thisOrg = addOrganization(context, db);
      //check permission to record
      if (!isRecordAccessPermitted(context, db, thisOrg.getOrgId())) {
        return ("PermissionError");
      }
      thisItem = new FileItem(
          db, Integer.parseInt(itemId), thisOrg.getOrgId(), Constants.ACCOUNTS);
      if (version != null) {
        thisItem.buildVersionList(db);
      }
    } catch (Exception e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }
    //Start the download
    try {
      if (version == null) {
        FileItem itemToDownload = thisItem;
        itemToDownload.setEnteredBy(this.getUserId(context));
        String filePath = this.getPath(context, "accounts") + getDatePath(
            itemToDownload.getModified()) + itemToDownload.getFilename();
        FileDownload fileDownload = new FileDownload();
        fileDownload.setFullPath(filePath);
        fileDownload.setDisplayName(itemToDownload.getClientFilename());
        if (fileDownload.fileExists()) {
          if (view != null && "true".equals(view)) {
            fileDownload.setFileTimestamp(thisItem.getModificationDate().getTime());
            fileDownload.streamContent(context);
          } else {
            fileDownload.sendFile(context);
          }
          //Get a db connection now that the download is complete
          db = getConnection(context);
          itemToDownload.updateCounter(db);
        } else {
          db = null;
          System.err.println(
              "LeadsDocuments-> Trying to send a file that does not exist");
          context.getRequest().setAttribute(
              "actionError", systemStatus.getLabel(
                  "object.validation.actionError.downloadDoesNotExist"));
          return (executeCommandView(context));
        }
      } else {
        FileItemVersion itemToDownload = thisItem.getVersion(
        Double.parseDouble(version));
        itemToDownload.setEnteredBy(this.getUserId(context));
        String filePath = this.getPath(context, "accounts") + getDatePath(
        itemToDownload.getModified()) + itemToDownload.getFilename();
        FileDownload fileDownload = new FileDownload();
        fileDownload.setFullPath(filePath);
        fileDownload.setDisplayName(itemToDownload.getClientFilename());
        if (fileDownload.fileExists()) {
          if (view != null && "true".equals(view)) {
            fileDownload.setFileTimestamp(itemToDownload.getModificationDate().getTime());
            fileDownload.streamContent(context);
          } else {
            fileDownload.sendFile(context);
          }
          //Get a db connection now that the download is complete
          db = getConnection(context);
          itemToDownload.updateCounter(db);
        } else {
          db = null;
          System.err.println(
              "LeadsDocuments-> Trying to send a file that does not exist");
          context.getRequest().setAttribute(
              "actionError", systemStatus.getLabel(
                  "object.validation.actionError.downloadDoesNotExist"));
          return (executeCommandView(context));
        }
      }
    } catch (java.net.SocketException se) {
      //User either canceled the download or lost connection
      if (System.getProperty("DEBUG") != null) {
        System.out.println(se.toString());
      }
    } catch (Exception e) {
      errorMessage = e;
      System.out.println(e.toString());
    } finally {
      if (db != null) {
        this.freeConnection(context, db);
      }
    }

    if (errorMessage == null) {
      return ("-none-");
    } else {
      context.getRequest().setAttribute("Error", errorMessage);
      addModuleBean(context, "View Accounts", "");
      return ("SystemError");
    }
  }


  /**
   * Description of the Method
   *
   * @param context Description of the Parameter
   * @return Description of the Return Value
   */
  public String executeCommandModify(ActionContext context) {
    if (!hasPermission(context, "punti_di_sbarco-documents-edit")) {
      return ("PermissionError");
    }
    Exception errorMessage = null;
    String itemId = (String) context.getRequest().getParameter("fid");
    String folderId = context.getRequest().getParameter("folderId");
    if (folderId != null) {
      context.getRequest().setAttribute("folderId", folderId);
    }
    Connection db = null;
    Organization thisOrg = null;
    try {
      db = getConnection(context);
      thisOrg = addOrganization(context, db);
      //check permission to record
      if (!isRecordAccessPermitted(context, db, thisOrg.getOrgId())) {
        return ("PermissionError");
      }
      FileItem thisItem = new FileItem(
          db, Integer.parseInt(itemId), thisOrg.getOrgId(), Constants.ACCOUNTS);
      thisItem.buildVersionList(db);
      context.getRequest().setAttribute("FileItem", thisItem);

      //Build array of folder trails
      ProjectManagementFileFolders.buildHierarchy(db, context);
    } catch (Exception e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }
    addModuleBean(context, "View Accounts", "Modify Document Information");
    if (errorMessage == null) {
      return getReturn(context, "Modify");
    } else {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    }
  }


  /**
   * Description of the Method
   *
   * @param context Description of the Parameter
   * @return Description of the Return Value
   */
  public String executeCommandUpdate(ActionContext context) {
    if (!hasPermission(context, "punti_di_sbarco-documents-edit")) {
      return ("PermissionError");
    }
    boolean recordInserted = false;
    boolean isValid = false;
    String itemId = (String) context.getRequest().getParameter("fid");
    String subject = (String) context.getRequest().getParameter("subject");
    String filename = (String) context.getRequest().getParameter(
        "clientFilename");
    String allowPortalAccess = (String) context.getRequest().getParameter(
    		"allowPortalAccess");
    Connection db = null;
    Organization thisOrg = null;
    try {
      db = getConnection(context);
      thisOrg = addOrganization(context, db);
      //check permission to record
      if (!isRecordAccessPermitted(context, db, thisOrg.getOrgId())) {
        return ("PermissionError");
      }
      FileItem thisItem = new FileItem(
          db, Integer.parseInt(itemId), thisOrg.getOrgId(), Constants.ACCOUNTS);
      FileItem previousItem = new FileItem(
          db, Integer.parseInt(itemId), thisOrg.getOrgId(), Constants.ACCOUNTS);
      thisItem.setClientFilename(filename);
      thisItem.setSubject(subject);
      thisItem.setAllowPortalAccess(allowPortalAccess);
      isValid = this.validateObject(context, db, thisItem);
      if (isValid) {
        recordInserted = thisItem.update(db);
      }
      if (recordInserted) {
        this.processUpdateHook(context, previousItem, thisItem);
      }
    } catch (Exception e) {
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    addModuleBean(context, "View Accounts", "");
    if (recordInserted && isValid) {
      return ("UpdateOK");
    } else {
      context.getRequest().setAttribute("fid", itemId);
      return (executeCommandModify(context));
    }
  }


  /**
   * Description of the Method
   *
   * @param context Description of the Parameter
   * @return Description of the Return Value
   */
  public String executeCommandDelete(ActionContext context) {
    if (!hasPermission(context, "punti_di_sbarco-documents-delete")) {
      return ("PermissionError");
    }
    Exception errorMessage = null;
    boolean recordDeleted = false;
    String itemId = (String) context.getRequest().getParameter("fid");
    Connection db = null;
    Organization thisOrg = null;
    try {
      db = getConnection(context);
      thisOrg = addOrganization(context, db);
      
      PreparedStatement pst = db.prepareStatement("select ticketid from ticket where tipologia = 3 and trashed_date is null and id_file_allegato = "+itemId);
      ResultSet rs = pst.executeQuery();
     int ticketid = -1 ;
      boolean isDelete = true;
      if(rs.next())
      {
    	  isDelete = false ; 
    	  ticketid = rs.getInt(1);
      }
      
      //check permission to record
      if (!isRecordAccessPermitted(context, db, thisOrg.getOrgId())) {
        return ("PermissionError");
      }
      if(isDelete == true)
      {
      FileItem thisItem = new FileItem(
          db, Integer.parseInt(itemId), thisOrg.getOrgId(), Constants.ACCOUNTS);
      recordDeleted = thisItem.delete(db, this.getPath(context, "accounts"));
      }
      context.getRequest().setAttribute("isDelete", isDelete);
      context.getRequest().setAttribute("idControllo", ticketid);
    } catch (Exception e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }
    addModuleBean(context, "View Accounts", "Delete Document");
    if (errorMessage == null) {
      if (recordDeleted) {
        return ("DeleteOK");
      } else {
        return ("DeleteERROR");
      }
    } else {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    }
  }


  /**
   * Adds a feature to the Organization attribute of the AccountsDocuments
   * object
   *
   * @param context The feature to be added to the Organization
   *                attribute
   * @param db      The feature to be added to the Organization
   *                attribute
   * @return Description of the Return Value
   * @throws SQLException Description of the Exception
   */
  private Organization addOrganization(ActionContext context, Connection db) throws SQLException {
    String organizationId = (String) context.getRequest().getParameter(
        "orgId");
    if (organizationId == null) {
      organizationId = (String) context.getRequest().getAttribute("orgId");
    }
    return addOrganization(context, db, organizationId);
  }


  /**
   * Adds a feature to the Organization attribute of the AccountsDocuments
   * object
   *
   * @param context        The feature to be added to the Organization
   *                       attribute
   * @param db             The feature to be added to the Organization
   *                       attribute
   * @param organizationId The feature to be added to the Organization
   *                       attribute
   * @return Description of the Return Value
   * @throws SQLException Description of the Exception
   */
  private Organization addOrganization(ActionContext context, Connection db, String organizationId) throws SQLException {
    context.getRequest().setAttribute("orgId", organizationId);
    Organization thisOrganization = new Organization(
        db, Integer.parseInt(organizationId));
    context.getRequest().setAttribute("OrgDetails", thisOrganization);
    return thisOrganization;
  }


  /**
   * Description of the Method
   *
   * @param context Description of the Parameter
   * @return Description of the Return Value
   */
  public String executeCommandMove(ActionContext context) {
    if (!hasPermission(context, "punti_di_sbarco-documents-edit")) {
      return ("PermissionError");
    }
    Connection db = null;
    //Parameters
    String itemId = (String) context.getRequest().getParameter("fid");
    Organization thisOrg = null;
    try {
      db = getConnection(context);
      thisOrg = addOrganization(context, db);
      //check permission to record
      if (!isRecordAccessPermitted(context, db, thisOrg.getOrgId())) {
        return ("PermissionError");
      }
      //Load the file
      FileItem thisItem = new FileItem(
          db, Integer.parseInt(itemId), thisOrg.getOrgId(), Constants.ACCOUNTS);
      context.getRequest().setAttribute("FileItem", thisItem);
      //Load the folders
      FileFolderHierarchy hierarchy = new FileFolderHierarchy();
      hierarchy.setLinkModuleId(Constants.ACCOUNTS);
      hierarchy.setLinkItemId(thisOrg.getOrgId());
      hierarchy.build(db);
      context.getRequest().setAttribute("folderHierarchy", hierarchy);
      return "MoveOK";
    } catch (Exception e) {
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
  }


  /**
   * Description of the Method
   *
   * @param context Description of the Parameter
   * @return Description of the Return Value
   */
  public String executeCommandSaveMove(ActionContext context) {
    if (!hasPermission(context, "punti_di_sbarco-documents-edit")) {
      return ("PermissionError");
    }
    Connection db = null;
    //Parameters
    String newFolderId = (String) context.getRequest().getParameter(
        "folderId");
    String itemId = (String) context.getRequest().getParameter("fid");
    Organization thisOrg = null;
    try {
      db = getConnection(context);
      thisOrg = addOrganization(context, db);
      //check permission to record
      if (!isRecordAccessPermitted(context, db, thisOrg.getOrgId())) {
        return ("PermissionError");
      }
      //Load the file
      FileItem thisItem = new FileItem(
          db, Integer.parseInt(itemId), thisOrg.getOrgId(), Constants.ACCOUNTS);
      thisItem.updateFolderId(db, Integer.parseInt(newFolderId));
      return "PopupCloseOK";
    } catch (Exception e) {
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
  }

}

