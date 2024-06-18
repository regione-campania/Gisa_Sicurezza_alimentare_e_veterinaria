/*
 *  Copyright(c) 2004 Team Elements LLC (http://www.teamelements.com/) All
 *  rights reserved. This material cannot be distributed without written
 *  permission from Team Elements LLC. Permission to use, copy, and modify this
 *  material for internal use is hereby granted, provided that the above
 *  copyright notice and this permission notice appear in all copies. TEAM
 *  ELEMENTS MAKES NO REPRESENTATIONS AND EXTENDS NO WARRANTIES, EXPRESS OR
 *  IMPLIED, WITH RESPECT TO THE SOFTWARE, INCLUDING, BUT NOT LIMITED TO, THE
 *  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR ANY PARTICULAR
 *  PURPOSE, AND THE WARRANTY AGAINST INFRINGEMENT OF PATENTS OR OTHER
 *  INTELLECTUAL PROPERTY RIGHTS. THE SOFTWARE IS PROVIDED "AS IS", AND IN NO
 *  EVENT SHALL TEAM ELEMENTS LLC OR ANY OF ITS AFFILIATES BE LIABLE FOR ANY
 *  DAMAGES, INCLUDING ANY LOST PROFITS OR OTHER INCIDENTAL OR CONSEQUENTIAL
 *  DAMAGES RELATING TO THE SOFTWARE.
 */
package com.zeroio.taglib;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Locale;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;
import javax.servlet.jsp.tagext.TryCatchFinally;

import org.aspcfs.modules.login.beans.UserBean;
import org.aspcfs.utils.DatabaseUtils;
import org.aspcfs.utils.DateUtils;
import org.aspcfs.utils.web.HtmlSelectTimeZone;

/**
 *  This Class outs a calendar field based on the user's locale information for
 *  the current UserBean session.
 *
 * @author     matt rajkowski
 * @created    July 21, 2004
 * @version    $Id: CalendarHandler.java,v 1.1 2004/07/21 19:00:43 mrajkowski
 *      Exp $
 */
public class CalendarHandler extends TagSupport implements TryCatchFinally {

  private int dateFormat = DateFormat.SHORT;
  private String form = null;
  private String field = null;
  private Timestamp timestamp = null;
  private boolean hidden = false;
  private String timeZone = null;
  private boolean showTimeZone = false;
  private boolean required = false;

  public void doCatch(Throwable throwable) throws Throwable {
    // Required but not needed
  }

  public void doFinally() {
    // Reset each property or else the value gets reused
    dateFormat = DateFormat.SHORT;
    form = null;
    field = null;
    timestamp = null;
    hidden = false;
    timeZone = null;
    showTimeZone = false;
    required = false;
  }


  /**
   *  Sets the dateFormat attribute of the CalendarHandler object
   *
   * @param  dateFormat  The new dateFormat value
   */
  public void setDateFormat(int dateFormat) {
    this.dateFormat = dateFormat;
  }


  /**
   *  Sets the dateFormat attribute of the CalendarHandler object
   *
   * @param  dateFormat  The new dateFormat value
   */
  public void setDateFormat(String dateFormat) {
    this.dateFormat = Integer.parseInt(dateFormat);
  }


  /**
   *  Sets the form attribute of the CalendarHandler object
   *
   * @param  tmp  The new form value
   */
  public void setForm(String tmp) {
    this.form = tmp;
  }


  /**
   *  Sets the field attribute of the CalendarHandler object
   *
   * @param  tmp  The new field value
   */
  public void setField(String tmp) {
    this.field = tmp;
  }


  /**
   *  Sets the timeZone attribute of the CalendarHandler object
   *
   * @param  tmp  The new timeZone value
   */
  public void setTimeZone(String tmp) {
    timeZone = tmp;
  }


  /**
   *  Sets the timestamp attribute of the CalendarHandler object
   *
   * @param  tmp  The new timestamp value
   */
  public void setTimestamp(String tmp) {
    this.setTimestamp(DatabaseUtils.parseDateToTimestamp(tmp));
  }


  /**
   *  Sets the timestamp attribute of the CalendarHandler object
   *
   * @param  tmp  The new timestamp value
   */
  public void setTimestamp(java.sql.Timestamp tmp) {
    timestamp = tmp;
  }


  /**
   *  Sets the hidden attribute of the CalendarHandler object
   *
   * @param  tmp  The new hidden value
   */
  public void setHidden(boolean tmp) {
    this.hidden = tmp;
  }


  /**
   *  Sets the showTimeZone attribute of the CalendarHandler object
   *
   * @param  tmp  The new showTimeZone value
   */
  public void setShowTimeZone(boolean tmp) {
    this.showTimeZone = tmp;
  }


  /**
   *  Sets the showTimeZone attribute of the CalendarHandler object
   *
   * @param  tmp  The new showTimeZone value
   */
  public void setShowTimeZone(String tmp) {
    this.showTimeZone = DatabaseUtils.parseBoolean(tmp);
  }


  /**
   *  Sets the hidden attribute of the CalendarHandler object
   *
   * @param  tmp  The new hidden value
   */
  public void setHidden(String tmp) {
    this.hidden = DatabaseUtils.parseBoolean(tmp);
  }


  /**
   *  Gets the required attribute of the CalendarHandler object
   *
   * @return    The required value
   */
  public boolean getRequired() {
    return required;
  }


  /**
   *  Sets the required attribute of the CalendarHandler object
   *
   * @param  tmp  The new required value
   */
  public void setRequired(boolean tmp) {
    this.required = tmp;
  }


  /**
   *  Sets the required attribute of the CalendarHandler object
   *
   * @param  tmp  The new required value
   */
  public void setRequired(String tmp) {
    this.required = DatabaseUtils.parseBoolean(tmp);
  }


  /**
   *  Description of the Method
   *
   * @return                Description of the Return Value
   * @throws  JspException  Description of the Exception
   */
  public int doStartTag() throws JspException {
    String dateString = "";
    String language = "en";
    String country = "US";
    try {
      Locale locale = null;
      // Retrieve the user's timezone from their session
      UserBean thisUser = (UserBean) pageContext.getSession().getAttribute("User");
      if (thisUser != null && thisUser.getUserId() != -1 && thisUser.getUserRecord() != null){
				if (timeZone == null) {
					timeZone = thisUser.getUserRecord().getTimeZone();
				}
				locale = thisUser.getUserRecord().getLocale();
      }
      if (locale == null) {
        locale = Locale.getDefault();
      }
      language = locale.getLanguage();
      country = locale.getCountry();
      if (timestamp != null) {
        //Format the specified value with the retrieved timezone
        SimpleDateFormat formatter = (SimpleDateFormat) SimpleDateFormat.getDateInstance(
            dateFormat, locale);
        formatter.applyPattern(
            DateUtils.get4DigitYearDateFormat(formatter.toPattern()));

        //set the timezone
        if (timeZone != null) {
          java.util.TimeZone tz = java.util.TimeZone.getTimeZone(timeZone);
          formatter.setTimeZone(tz);
        }
        dateString = formatter.format(timestamp);
      }
    } catch (Exception e) {
			e.printStackTrace();
    }
    // Output the result based on the retrieved info (if any)
    try {
      if (pageContext.getRequest().getAttribute(field + "Error") != null) {
        dateString = pageContext.getRequest().getParameter(field);
      }
      if (dateString == null) {
        dateString = "";
      }
      if (!hidden) {
        // TODO: Add onChange="checkDate(this.value)"
        String toWriteOut = "<input type=\"text\" name=\"" + field + "\" size=\"10\" value=\"" + dateString + "\" />" +
            (required?" <font color='red'>*</font>":"") +
            "&nbsp;<a href=\"javascript:popCalendar('" + form + "','" + field + "','" + language + "','" + country + "','"+timeZone+"');\">" +
            "<img src=\"images/icons/stock_form-date-field-16.gif\" border=\"0\" align=\"absmiddle\"></a>";
        if (showTimeZone) {
          toWriteOut = toWriteOut + "&nbsp;" + HtmlSelectTimeZone.getSelect(
              field + "TimeZone", timeZone).getHtml();
        }
        this.pageContext.getOut().write(toWriteOut);
      } else {
        this.pageContext.getOut().write(
            "<input type=\"hidden\" name=\"" + field + "\" value=\"" + dateString + "\" />");
      }
    } catch (Exception e) {
			e.printStackTrace();
    }
    return SKIP_BODY;
  }


  /**
   *  Description of the Method
   *
   * @return    Description of the Return Value
   */
  public int doEndTag() {
    return EVAL_PAGE;
  }

}

