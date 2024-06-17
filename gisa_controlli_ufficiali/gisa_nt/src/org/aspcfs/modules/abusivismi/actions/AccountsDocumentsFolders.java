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
package org.aspcfs.modules.abusivismi.actions;

import java.sql.Connection;
import java.util.Iterator;

import org.aspcfs.modules.abusivismi.base.Organization;
import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.base.Constants;

import com.darkhorseventures.framework.actions.ActionContext;
import com.zeroio.iteam.actions.ProjectManagementFileFolders;
import com.zeroio.iteam.base.FileFolder;
import com.zeroio.iteam.base.FileFolderHierarchy;

/**
 * Description of the Class
 *
 * @author partha
 * @version $Id: AccountsDocumentsFolders.java 15633 2006-08-09 20:17:34Z matt $
 * @created July 26, 2004
 */
public final class AccountsDocumentsFolders extends CFSModule {

  /**
   * Description of the Method
   *
   * @param context Description of the Parameter
   * @return Description of the Return Value
   */
  public String executeCommandAdd(ActionContext context) {
    Exception errorMessage = null;
    //Load project
    String orgId = (String) context.getRequest().getParameter("orgId");
    Connection db = null;
    try {
      FileFolder thisFolder = (FileFolder) context.getFormBean();
      thisFolder.setParentId(context.getRequest().getParameter("parentId"));
      db = getConnection(context);
      if (!isRecordAccessPermitted(context, db, Integer.parseInt(orgId))) {
        return ("PermissionError");
      }
      //Load the project
      Organization orgDetails = new Organization(db, Integer.parseInt(orgId));
      context.getRequest().setAttribute("OrgDetails", orgDetails);
      //Build array of folder trails
      ProjectManagementFileFolders.buildHierarchy(db, context);
      context.getRequest().setAttribute("fileFolder", thisFolder);
    } catch (Exception e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }
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
  public String executeCommandSave(ActionContext context) {
    Connection db = null;
    int resultCount = 0;
    boolean recordInserted = false;
    boolean isValid = false;
    String orgId = (String) context.getRequest().getParameter("orgId");
    Organization orgDetails = null;
    try {
      db = this.getConnection(context);
      if (!isRecordAccessPermitted(context, db, Integer.parseInt(orgId))) {
        return ("PermissionError");
      }
      orgDetails = new Organization(db, Integer.parseInt(orgId));
      //Insert or update the folder
      FileFolder thisFolder = (FileFolder) context.getFormBean();
      boolean newFolder = (thisFolder.getId() == -1);
      if (newFolder) {
        thisFolder.setEnteredBy(getUserId(context));
      }
      thisFolder.setModifiedBy(getUserId(context));
      thisFolder.setLinkModuleId(Constants.ACCOUNTS);
      thisFolder.setLinkItemId(orgDetails.getId());
      isValid = this.validateObject(context, db, thisFolder);
      if (newFolder) {
        if (isValid) {
          recordInserted = thisFolder.insert(db);
        }
      } else {
        if (isValid) {
          resultCount = thisFolder.update(db);
        }
      }
      //Build array of folder trails
      ProjectManagementFileFolders.buildHierarchy(db, context);
    } catch (Exception e) {
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    if (recordInserted) {
      return ("InsertOK");
    } else if (resultCount == 1) {
      return ("UpdateOK");
    }
    return (executeCommandAdd(context));
  }


  /**
   * Description of the Method
   *
   * @param context Description of the Parameter
   * @return Description of the Return Value
   */
  public String executeCommandDelete(ActionContext context) {
    Exception errorMessage = null;
    boolean recordDeleted = false;
    String orgId = (String) context.getRequest().getParameter("orgId");
    //Delete the itemId, and the folderId will be the location to return to
    String itemId = (String) context.getRequest().getParameter("id");
    String folderId = (String) context.getRequest().getParameter("folderId");
    Organization orgDetails = null;
    Connection db = null;
    try {
      db = getConnection(context);
      if (!isRecordAccessPermitted(context, db, Integer.parseInt(orgId))) {
        return ("PermissionError");
      }
      //Load the project
      orgDetails = new Organization(db, Integer.parseInt(orgId));
      context.getRequest().setAttribute("OrgDetails", orgDetails);
      //Load the file folder
      FileFolder thisFolder = new FileFolder(db, Integer.parseInt(itemId));
//      thisFolder.setParentId(Integer.parseInt(folderId));
      recordDeleted = thisFolder.delete(db);
      //indexDeleteItem(context, thisFolder);
    } catch (Exception e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }
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
   * Description of the Method
   *
   * @param context Description of the Parameter
   * @return Description of the Return Value
   */
  public String executeCommandModify(ActionContext context) {
    Exception errorMessage = null;
    boolean recordDeleted = false;
    String orgId = (String) context.getRequest().getParameter("orgId");
    //TODO: Add some permissions to get here!
    //Modify the itemId, and the folderId will be the location to return to
    String itemId = (String) context.getRequest().getParameter("id");
    String folderId = (String) context.getRequest().getParameter("folderId");
    Connection db = null;
    try {
      db = getConnection(context);
      if (!isRecordAccessPermitted(context, db, Integer.parseInt(orgId))) {
        return ("PermissionError");
      }
      //Load the file folder to be modified
      FileFolder thisFolder = (FileFolder) context.getFormBean();
      thisFolder.setId(Integer.parseInt(itemId));
      thisFolder.queryRecord(db, Integer.parseInt(itemId));
    } catch (Exception e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }
    if (errorMessage == null) {
      return (executeCommandAdd(context));
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
  public String executeCommandMove(ActionContext context) {
    //Parameters
    String orgId = (String) context.getRequest().getParameter("orgId");
    String itemId = (String) context.getRequest().getParameter("id");
    Organization orgDetails = null;
    Connection db = null;
    try {
      db = getConnection(context);
      if (!isRecordAccessPermitted(context, db, Integer.parseInt(orgId))) {
        return ("PermissionError");
      }
      //Load the Organization
      orgDetails = new Organization(db, Integer.parseInt(orgId));
      context.getRequest().setAttribute("OrgDetails", orgDetails);
      //Load the folder
      FileFolder thisFolder = new FileFolder(db, Integer.parseInt(itemId));
      context.getRequest().setAttribute("FileFolder", thisFolder);
      //Load the current folders
      FileFolderHierarchy hierarchy = new FileFolderHierarchy();
      hierarchy.setLinkModuleId(Constants.ACCOUNTS);
      hierarchy.setLinkItemId(orgDetails.getId());
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
    //Parameters
    String orgId = (String) context.getRequest().getParameter("orgId");
    String newFolderId = (String) context.getRequest().getParameter(
        "folderId");
    String itemId = (String) context.getRequest().getParameter("id");
    Organization orgDetails = null;
    Connection db = null;
    try {
      db = getConnection(context);
      if (!isRecordAccessPermitted(context, db, Integer.parseInt(orgId))) {
        return ("PermissionError");
      }
      //Load the Organization
      orgDetails = new Organization(db, Integer.parseInt(orgId));
      context.getRequest().setAttribute("OrgDetails", orgDetails);
      //Load the current folder
      FileFolder thisFolder = new FileFolder(db, Integer.parseInt(itemId));
      int folderId = Integer.parseInt(newFolderId);
      if (folderId != 0 && folderId != -1) {
        FileFolder newParent = new FileFolder(db, folderId);
        FileFolderHierarchy thisHierarchy = new FileFolderHierarchy();
        thisHierarchy.setLinkModuleId(Constants.DOCUMENTS_ACCOUNTS);
        thisHierarchy.setLinkItemId(orgDetails.getOrgId());
        thisHierarchy.build(db, thisFolder.getId());
        if (thisHierarchy.getHierarchy().hasFolder(
            Integer.parseInt(newFolderId))) {
          thisFolder.buildSubFolders(db);
          Iterator iterator = (Iterator) thisFolder.getSubFolders().iterator();
          while (iterator.hasNext()) {
            FileFolder childFolder = (FileFolder) iterator.next();
            childFolder.updateParentId(db, thisFolder.getParentId());
          }
        }
      }
      thisFolder.updateParentId(db, folderId);
      return "PopupCloseOK";
    } catch (Exception e) {
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
  }
}

