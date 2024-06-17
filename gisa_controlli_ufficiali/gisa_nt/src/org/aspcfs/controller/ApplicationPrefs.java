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
package org.aspcfs.controller;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.prefs.Preferences;

import javax.servlet.ServletContext;

import org.aspcfs.modules.setup.utils.Prefs;
import org.aspcfs.modules.system.base.ApplicationVersion;
import org.aspcfs.utils.Dictionary;
import org.aspcfs.utils.XMLUtils;
import org.w3c.dom.Element;
import org.w3c.dom.Node;

import com.darkhorseventures.database.ConnectionPool;
import com.darkhorseventures.framework.hooks.CustomHook;

/**
 * Loads and saves the build.properties file for application settings; each
 * application instance can have its own properties on the same server
 *
 * @author matt rajkowski
 * @version $Id: ApplicationPrefs.java,v 1.1.2.2 2003/08/28 21:03:45
 *          mrajkowski Exp $
 * @created August 27, 2003
 */
public class ApplicationPrefs {

  public final static String fs = System.getProperty("file.separator");
  public final static String ls = System.getProperty("line.separator");
  public final static String GENERATED_MESSAGE =
      "### GENERATED BY org.aspcfs.controller.ApplicationPrefs";
  private Map prefs = new LinkedHashMap();
  private String filename = null;
  private Map dictionaries = new HashMap();


  /**
   * Constructor for the ApplicationPrefs object
   */
  public ApplicationPrefs() {
  }


  
  
  
  public static void main(String [] arg)
  {
	  
	  
      
      Preferences prefs = Preferences.userNodeForPackage(
          org.aspcfs.modules.setup.utils.Prefs.class);
      
      
      System.out.println(prefs);
      String fileLibrary = prefs.get("SetupUtils", null);
      
      System.out.println(fileLibrary);

  }
 
  /**
   * Constructor for the ApplicationPrefs object
   *
   * @param context Description of the Parameter
   */
  public ApplicationPrefs(ServletContext context) {
    try {
      String dir = Prefs.retrieveContextPrefName(context);
      
      Preferences prefs = Preferences.userNodeForPackage(
          org.aspcfs.modules.setup.utils.Prefs.class);
      
      // When prefs are saved, the MAX_KEY_LENGTH is used for long names
      if (dir.length() > Preferences.MAX_KEY_LENGTH) {
        dir = dir.substring(dir.length() - Preferences.MAX_KEY_LENGTH);
      }
      // Check "dir" prefs first, based on the installed directory of this webapp
      String fileLibrary = prefs.get(dir, null);
      if (fileLibrary == null) {
        System.out.println("ApplicationPrefs-> prefs not found...");
        // Check for a hard-coded location
        String os = System.getProperty("os.name");
        File systemOverrideFile = null;
        if (os.startsWith("Windows")) {
          //Windows
          systemOverrideFile = new File("c:\\CentricCRM\\fileLibrary\\path.txt");
        } else if (os.startsWith("Mac")) {
          //Mac OSX
          systemOverrideFile = new File("/Library/Application Support/CentricCRM/fileLibrary/path.txt");
        } else {
          File testDirectory = new File("/opt");
          if (testDirectory.exists()) {
            //Linux, Solaris, SunOS, OS/2, HP-UX, AIX, FreeBSD, etc
            systemOverrideFile = new File("/opt/centric_crm/fileLibrary/path.txt");
          } else {
            //Linux, Solaris, SunOS, OS/2, HP-UX, AIX, FreeBSD, etc
            systemOverrideFile = new File("/var/lib/centric_crm/fileLibrary/path.txt");
          }
        }
        if (systemOverrideFile.exists()) {
          // Load the fileLibrary path as specified...
          try {
            BufferedReader in = new BufferedReader(new FileReader(systemOverrideFile));
            String line = in.readLine();
            if (line != null && line.startsWith("#")) {
              line = in.readLine();
            }
            fileLibrary = line;
            in.close();
          } catch (Exception e) {
            System.out.println("ApplicationPrefs-> Using systemOverrideFile EXCEPTION: " + e.getMessage());
          }
        } else {
          // Check in the current dir of the webapp (for backwards compatibility)
          fileLibrary = context.getRealPath("/") + "WEB-INF" + fs + "fileLibrary" + fs;
          File propertyFile = new File(fileLibrary + "build.properties");
          if (propertyFile.exists()) {
            Prefs.savePref(dir, fileLibrary);
          } else {
            // check in "root", for backwards compatibility
            fileLibrary = prefs.get("cfs.fileLibrary", null);
            if (fileLibrary != null) {
              // Save these prefs under the "dir" prefs for next time
              Prefs.savePref(dir, fileLibrary);
              // erase "root" since a "dir" pref has been configured and saved
              Prefs.savePref("cfs.fileLibrary", null);
            }
          }
        }
      }
      context.setAttribute(
          "SiteCode", prefs.get("cfs.gatekeeper.sitecode", "cfs"));
      System.out.println(
          "ApplicationPrefs-> Using file library at: " + fileLibrary);
      // Now load the default properties
      if (fileLibrary != null) {
        this.load(fileLibrary + "build.properties");
        this.add("FILELIBRARY", fileLibrary);
      }
      this.populateContext(context);
      // Load the localization prefs
      this.loadApplicationDictionary(context);
    } catch (Exception e) {
      e.printStackTrace(System.out);
    }
  }


  /**
   * Constructor for the ApplicationPrefs object
   *
   * @param filename Description of the Parameter
   */
  public ApplicationPrefs(String filename) {
    load(filename);
  }


  /**
   * Sets the filename attribute of the ApplicationPrefs object
   *
   * @param tmp The new filename value
   */
  public void setFilename(String tmp) {
    this.filename = tmp;
  }


  /**
   * Gets the filename attribute of the ApplicationPrefs object
   *
   * @return The filename value
   */
  public String getFilename() {
    return filename;
  }


  /**
   * Gets the prefs attribute of the ApplicationPrefs object
   *
   * @return The prefs value
   */
  public Map getPrefs() {
    return prefs;
  }


  /**
   * Gets the localizationPrefs attribute of the ApplicationPrefs object
   *
   * @return The localizationPrefs value
   */
  public Map getLocalizationPrefs(String language) {
    if (dictionaries == null) {
      return new HashMap();
    }
    if (dictionaries.containsKey(language)) {
      return ((Dictionary) dictionaries.get(language)).getLocalizationPrefs();
    } else {
      return ((Dictionary) dictionaries.get("en_US")).getLocalizationPrefs();
    }
  }


  /**
   * Description of the Method
   *
   * @param filename Description of the Parameter
   */
  public void load(String filename) {
    if (System.getProperty("DEBUG") != null) {
      System.out.println("ApplicationPrefs-> Loading prefs: " + filename);
    }
    this.filename = filename;
    try {
      prefs.clear();
      BufferedReader in = new BufferedReader(new FileReader(filename));
      String line = null;
      int count = 0;
      while ((line = in.readLine()) != null) {
        ++count;
        if (!line.startsWith("#") && line.indexOf("=") > 0) {
          String param = line.substring(0, line.indexOf("="));
          String value = "";
          if (line.indexOf("=") + 1 < line.length()) {
            value = line.substring(line.indexOf("=") + 1);
          }
          this.add(param, value);
        } else if (!line.startsWith(GENERATED_MESSAGE)) {
          this.add("#" + count, line);
        }
      }
      in.close();
    } catch (Exception e) {
      System.out.println("ApplicationPrefs-> EXCEPTION: " + e.getMessage());
    }
    if (System.getProperty("DEBUG") != null) {
      System.out.println("ApplicationPrefs-> Loaded items: " + prefs.size());
    }
  }


  /**
   * Description of the Method
   *
   * @param param Description of the Parameter
   * @return Description of the Return Value
   */
  public String get(String param) {
    return (String) prefs.get(param);
  }


  /**
   * Description of the Method
   *
   * @param param Description of the Parameter
   * @return Description of the Return Value
   */
  public boolean has(String param) {
    return (prefs.containsKey(param));
  }


  /**
   * Description of the Method
   */
  public void clear() {
    prefs.clear();
  }


  /**
   * Description of the Method
   *
   * @param param Description of the Parameter
   * @param value Description of the Parameter
   */
  public void add(String param, String value) {
    if (param != null) {
      if (value != null) {
        prefs.put(param, value);
      } else {
        prefs.remove(param);
      }
    }
  }


  /**
   * Description of the Method
   *
   * @return Description of the Return Value
   */
  public boolean save() {
    if (filename != null) {
      return save(filename);
    }
    return false;
  }


  /**
   * Saves the preferences to a file to be reloaded
   *
   * @param filename Description of the Parameter
   * @return Description of the Return Value
   */
  public boolean save(String filename) {
    try {
      System.out.println("ApplicationPrefs-> Saving prefs: " + filename);
      BufferedWriter out = new BufferedWriter(new FileWriter(filename));
      out.write(
          GENERATED_MESSAGE + " on " + new java.util.Date() + " ###" + ls);
      add("VERSION", ApplicationVersion.VERSION);
      add("APP_VERSION", ApplicationVersion.APP_VERSION);
      add("DB_VERSION", ApplicationVersion.DB_VERSION);
      Iterator i = prefs.keySet().iterator();
      while (i.hasNext()) {
        String param = (String) i.next();
        String value = (String) prefs.get(param);
        if (param.startsWith("#")) {
          out.write(value + ls);
        } else {
          out.write(param + "=" + value + ls);
        }
      }
      out.close();
      return true;
    } catch (Exception e) {
      return false;
    }
  }


  /**
   * When preferences are loaded, some values are not easily accessible so they
   * are stored in the System context.
   *
   * @param context Description of the Parameter
   */
  public void populateContext(ServletContext context) {
    //Configure debug mode
    if (this.has("DEBUGLEVEL")) {
      System.setProperty("DEBUG", this.get("DEBUGLEVEL"));
    }
    // Set color scheme
    context.setAttribute("SKIN", "blue");
    //Turn off Setup if setup is complete
    if (this.has("CONTROL")) {
      context.setAttribute("cfs.setup", "true");
    }
    // Verify the WEB-INF if set
    if (this.has("WEB-INF")) {
      if (!this.get("WEB-INF").equals(
          context.getRealPath("/") + "WEB-INF" + fs)) {
        add("WEB-INF", context.getRealPath("/") + "WEB-INF" + fs);
        save();
      }
    }
    //Define the ConnectionPool, else defaults from the ContextListener will be used
    ConnectionPool cp = (ConnectionPool) context.getAttribute(
        "ConnectionPool");
    if (cp != null) {
      if (this.has("CONNECTION_POOL.DEBUG")) {
        cp.setDebug(this.get("CONNECTION_POOL.DEBUG"));
      }
      if (this.has("CONNECTION_POOL.TEST_CONNECTIONS")) {
        cp.setTestConnections(this.get("CONNECTION_POOL.TEST_CONNECTIONS"));
      }
      if (this.has("CONNECTION_POOL.ALLOW_SHRINKING")) {
        cp.setAllowShrinking(this.get("CONNECTION_POOL.ALLOW_SHRINKING"));
      }
      if (this.has("CONNECTION_POOL.MAX_CONNECTIONS")) {
        cp.setMaxConnections(this.get("CONNECTION_POOL.MAX_CONNECTIONS"));
      }
      if (this.has("CONNECTION_POOL.MAX_IDLE_TIME.SECONDS")) {
        cp.setMaxIdleTimeSeconds(
            this.get("CONNECTION_POOL.MAX_IDLE_TIME.SECONDS"));
      }
      if (this.has("CONNECTION_POOL.MAX_DEAD_TIME.SECONDS")) {
        cp.setMaxDeadTimeSeconds(
            this.get("CONNECTION_POOL.MAX_DEAD_TIME.SECONDS"));
      }
    }
    // Tell system if proxy is set
    if (this.has("PROXYSERVER") && "true".equals(this.get("PROXYSERVER"))) {
      System.getProperties().put("proxySet", "true");
      System.getProperties().put(
          "http.proxyHost", this.get("PROXYSERVER.HOST"));
      System.getProperties().put(
          "http.proxyPort", this.get("PROXYSERVER.PORT"));
    } else {
      System.getProperties().put("proxySet", "false");
    }
    // Upgrade outdated templates
    if ("template0".equals(this.get("LAYOUT.TEMPLATE"))) {
      this.add("LAYOUT.TEMPLATE", "template1");
    }
    // Default LAYOUT prefs
    if (!this.has("LAYOUT.TEMPLATE")) {
      this.add("LAYOUT.TEMPLATE", "template1");
    }
    if (!this.has("LAYOUT.JSP.WELCOME")) {
      this.add("LAYOUT.JSP.WELCOME", "utils23/welcome.jsp");
    }
    if (!this.has("LAYOUT.JSP.LOGIN")) {
      this.add("LAYOUT.JSP.LOGIN", "login.jsp");
    }
    // Default i18n
    if (!this.has("SYSTEM.CURRENCY")) {
      this.add("SYSTEM.CURRENCY", "USD");
    }
    if (!this.has("SYSTEM.LANGUAGE")) {
      this.add("SYSTEM.LANGUAGE", "en_US");
    }
    if (!this.has("SYSTEM.COUNTRY")) {
      this.add("SYSTEM.COUNTRY", "UNITED STATES");
    }

    // TODO: WARNING: THIS NEEDS TO BE REMOVED
    System.setProperty("CURRENCY", this.get("SYSTEM.CURRENCY"));
    String[] locale = this.get("SYSTEM.LANGUAGE").split("_");
    if (locale[0] != null) {
      System.setProperty("LANGUAGE", locale[0]);
    }
    if (locale.length > 1) {
      if (locale[1] != null) {
        System.setProperty("COUNTRY", locale[1]);
      }
    }
    //Define whether the app requires SSL for browser clients
    addParameter(context, "ForceSSL", this.get("FORCESSL"), "false");
    //Define the developer's debug code
    addParameter(
        context, "GlobalPWInfo", this.get("WEBSERVER.PASSWORD"), "#notspecified");
    //Define the web server operation mode
    addParameter(context, "WEBSERVER.ASPMODE", this.get("WEBSERVER.ASPMODE"));
    //Define the mail server to be used
    addParameter(context, "MailServer", this.get("MAILSERVER"));
    addParameter(context, "FaxServer", this.get("FAXSERVER"));
    addParameter(context, "FaxEnabled", this.get("FAXENABLED"));
    CustomHook.populateApplicationPrefs(context, this);
    //initialize the import manager
//    ImportManager importManager = (ImportManager) context.getAttribute(
//        "ImportManager");
//    if (importManager == null) {
//      if (this.has("IMPORT_QUEUE_MAX")) {
//        importManager = new ImportManager(
//            cp, Integer.parseInt(this.get("IMPORT_QUEUE_MAX")));
//        context.setAttribute("ImportManager", importManager);
//      } else {
//        importManager = new ImportManager(cp, 1);
//        context.setAttribute("ImportManager", importManager);
//      }
//    }

  
    
  }


  /**
   * Adds a feature to the Parameter attribute of the InitHook object
   *
   * @param context The feature to be added to the Parameter attribute
   * @param param   The feature to be added to the Parameter attribute
   * @param value   The feature to be added to the Parameter attribute
   */
  private void addParameter(ServletContext context, String param, String value) {
    addParameter(context, param, value, null);
  }


  /**
   * Adds a feature to the Parameter attribute of the InitHook object
   *
   * @param context      The feature to be added to the Parameter attribute
   * @param param        The feature to be added to the Parameter attribute
   * @param value        The feature to be added to the Parameter attribute
   * @param defaultValue The feature to be added to the Parameter attribute
   */
  private void addParameter(ServletContext context, String param, String value, String defaultValue) {
    if (value != null) {
      context.setAttribute(param, value);
    } else {
      if (defaultValue != null) {
        context.setAttribute(param, defaultValue);
      } else {
        context.removeAttribute(param);
      }
    }
  }


  /**
   * Gets the pref attribute of the ApplicationPrefs class
   *
   * @param context Description of the Parameter
   * @param param   Description of the Parameter
   * @return The pref value
   */
  public static String getPref(ServletContext context, String param) {
    ApplicationPrefs prefs = (ApplicationPrefs) context.getAttribute(
        "applicationPrefs");
    if (prefs != null) {
      return prefs.get(param);
    } else {
      return null;
    }
  }


  /**
   * Shows all of the preferences that have been cached
   *
   * @return Description of the Return Value
   */
  public String toString() {
    StringBuffer sb = new StringBuffer();
    Iterator i = prefs.keySet().iterator();
    while (i.hasNext()) {
      String name = (String) i.next();
      String value = (String) prefs.get(name);
      sb.append(name + "=" + value + ls);
    }
    return sb.toString();
  }


  /**
   * Determines if this system is upgradeable (not an ASP)
   *
   * @return The upgradeable value
   */
  public boolean isUpgradeable() {
    return (ApplicationVersion.isOutOfDate(this));
  }


  /**
   * Description of the Method
   *
   * @param context Description of the Parameter
   */
  public void loadApplicationDictionary(ServletContext context) {
    String language = this.get("SYSTEM.LANGUAGE");
    if (language == null) {
      language = "en_US";
    }
    addDictionary(context, language);
  }


  /**
   * Adds a feature to the Dictionary attribute of the ApplicationPrefs object
   *
   * @param context  The feature to be added to the Dictionary attribute
   * @param language The feature to be added to the Dictionary attribute
   */
  public synchronized void addDictionary(ServletContext context, String language) {
    if (language == null) {
      System.out.println("ApplicationPrefs-> addDictionary: language cannot be null");
    } else {
      if (!dictionaries.containsKey(language)) {
        if (System.getProperty("DEBUG") != null) {
          System.out.println(
              "ApplicationPrefs-> Loading dictionary: " + language);
        }
        try {
          //Create a dictionary with the default language
          String languagePath = "/WEB-INF/languages/";
          Dictionary dictionary = new Dictionary(context, languagePath, "en_US");
          if (!"en_US".equals(language)) {
            // Override the text with a selected language
            dictionary.load(context, languagePath, language);
          }
          dictionaries.put(language, dictionary);
        } catch (Exception e) {
          e.printStackTrace(System.out);
          System.out.println(
              "ApplicationPrefs-> Language Error: " + e.getMessage());
        }
      }
    }
  }


  /**
   * Gets the label attribute of the ApplicationPrefs object
   *
   * @param section   Description of the Parameter
   * @param parameter Description of the Parameter
   * @return The label value
   */
  public String getLabel(String section, String parameter, String language) {
    return getValue(section, parameter, "value", language);
  }


  /**
   * Gets the label attribute of the ApplicationPrefs object
   *
   * @param parameter Description of the Parameter
   * @param language  Description of the Parameter
   * @return The label value
   */
  public String getLabel(String parameter, String language) {
    return getLabel("system.fields.label", parameter, language);
  }


  /**
   * Gets the value attribute of the ApplicationPrefs object
   *
   * @param parameter Description of the Parameter
   * @param tagName   Description of the Parameter
   * @param section   Description of the Parameter
   * @param language  Description of the Parameter
   * @return The value value
   */
  public String getValue(String section, String parameter, String tagName, String language) {
    if (dictionaries == null) {
      return null;
    }
    Dictionary dictionary = (Dictionary) dictionaries.get(language);
    if (dictionary == null) {
      return null;
    }
    Map prefGroup = (Map) dictionary.getLocalizationPrefs().get(section);
    if (prefGroup != null) {
      Node param = (Node) prefGroup.get(parameter);
      if (param != null) {
        return XMLUtils.getNodeText(
            XMLUtils.getFirstChild((Element) param, tagName));
      }
    }
    return null;
  }


  public static String getRealPath(ServletContext context) {
    String dir = context.getRealPath("/");
    if (dir != null && !dir.endsWith(fs)) {
      dir += fs;
    }
    return dir;
  }
}