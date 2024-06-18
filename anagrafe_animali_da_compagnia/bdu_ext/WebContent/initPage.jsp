<%@ page import="java.util.*,java.text.*,org.aspcfs.controller.SystemStatus,com.darkhorseventures.database.ConnectionPool,org.aspcfs.utils.*" %>
<%@ page import="org.aspcfs.modules.admin.base.*, org.aspcfs.modules.login.beans.UserBean,org.aspcfs.modules.contacts.base.*,org.aspcfs.modules.quotes.base.*,java.sql.*" %>
<%@ page import="org.aspcfs.controller.ApplicationPrefs" %>
<%@ page import="java.awt.Color, java.awt.Graphics2D, java.awt.image.BufferedImage, com.lowagie.text.pdf.Barcode128, java.io.IOException, com.sun.org.apache.xerces.internal.impl.dv.util.Base64,java.io.ByteArrayOutputStream,javax.imageio.ImageIO" %>
<%! 
    

public static String toDateasString(Timestamp time)
{
	  String toRet = "";
	  try
	  { 
		  if (time != null){
		  	java.sql.Date d = new java.sql.Date(time.getTime());
		  
		  	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		  	toRet=sdf.format(d);
	  }
	  }
	  catch(Exception e)
	  {
		  System.out.println(e);
	  }
	  return toRet;
}

public static String replace(String str, String o, String n) {
      boolean all = true;
      if (str != null && o != null && o.length() > 0 && n != null) { 
        StringBuffer result = null;
        int oldpos = 0;
        do {
            int pos = str.indexOf(o, oldpos);
            if (pos < 0)
                break;
            if (result == null)
                result = new StringBuffer();
            result.append(str.substring(oldpos, pos));
            result.append(n);
            pos += o.length();
            oldpos = pos;
        } while (all);
        if (oldpos == 0) {
            return str;
        } else {
            result.append(str.substring(oldpos));
            return new String(result);
        }
      } else {
        return str;
      }
    }
    
  public static String toString(String s) {
    if (s != null) {
      return(s);
    } else {
      return("");
    }
  }
  
  public static String toHtml(String s) {
    return StringUtils.toHtml(s);
  }
    
  public static String toHtmlValue(String s) {
    return StringUtils.toHtmlValue(s);
  }
    
  public static String toJavaScript(String s) {
      return StringUtils.jsStringEscape(s);
  }
  
  public static String toHtmlValue(int tmp) {
    return (toHtmlValue(String.valueOf(tmp)));
  }

  public static String toDateString(java.sql.Timestamp inDate) {
	    try {
	    	 SimpleDateFormat formatter = new SimpleDateFormat ("dd/MM/yyyy");
	         return(formatter.format(inDate));
	    } catch (NullPointerException e) {
	    }
	    return "";
	  }
  
  public static String toDateString(java.sql.Date inDate) {
    try {
      return java.text.DateFormat.getDateInstance(java.text.DateFormat.SHORT).format(inDate);
    } catch (NullPointerException e) {
    }
    return "";
  }
  
  public static String toLongDateString(java.util.Date inDate) {
    try {
      return java.text.DateFormat.getDateInstance(java.text.DateFormat.LONG).format(inDate);
    } catch (NullPointerException e) {
    }
    return "";
  }
  
  public static String toFullDateString(java.util.Date inDate) {
    try {
      return java.text.DateFormat.getDateInstance(java.text.DateFormat.FULL).format(inDate);
    } catch (NullPointerException e) {
    }
    return "";
  }
  
  public static String toMediumDateString(java.util.Date inDate) {
    try {
      return java.text.DateFormat.getDateInstance(java.text.DateFormat.MEDIUM).format(inDate);
    } catch (NullPointerException e) {
    }
    return "";
  }
  
  public static String sqlReplace(String s) {
    //s = replace(s, "<br>", "\r");
      String newString = "";
      char[] input = s.toCharArray();
      int arraySize = input.length;
      for (int i=0; i < arraySize; i++) {
        if (input[i] == '\'') {
          newString += "\\\'";
        } else if (input[i] == '\\') {
          newString += "\\\\";
        } else {
          newString += input[i];
        }
      }
      return newString;
    }
    
    private static String getLongTimestamp(java.sql.Timestamp tmp) {
      SimpleDateFormat formatter = new SimpleDateFormat ("MMMMM d, yyyy 'at' hh:mm a");
      return(formatter.format(tmp));
    }
    
    private static String getShortDate(java.sql.Date tmp) {
      SimpleDateFormat formatter = new SimpleDateFormat ("MM/dd/yy");
      return(formatter.format(tmp));
    }
    
    private static String getShortDate(java.sql.Timestamp tmpTimestamp) {
      SimpleDateFormat formatter1 = new SimpleDateFormat ("MM/dd/yy");
      return(formatter1.format(tmpTimestamp));
    }
    
    public static String showAttribute(HttpServletRequest request, String errorEntry) {
      return "<font color='#006699'>" + toHtml((String)request.getAttribute(errorEntry)) + "</font>";
    }
    
    public static String showError(HttpServletRequest request, String errorEntry) {
      return showError(request, errorEntry, true);
    }
    
    public static String showMessage(HttpServletRequest request, String errorEntry) {
        return showMessage(request, errorEntry, true);
      }


    
    public static String showError(HttpServletRequest request, String errorEntry, boolean showSpace) {
      if (request.getAttribute(errorEntry) != null) {
        return (showSpace ? "&nbsp;<br />" : "") + "<img src=\"images/error.gif\" border=\"0\" align=\"absmiddle\"/> <font color='red'>" + toHtml((String)request.getAttribute(errorEntry)) + "</font><br />&nbsp;<br />";
      } else if (request.getParameter(errorEntry) != null) {
        return (showSpace ? "&nbsp;<br />" : "") + "<img src=\"images/error.gif\" border=\"0\" align=\"absmiddle\"/> <font color='red'>" + toHtml((String)request.getParameter(errorEntry)) + "</font><br />&nbsp;<br />";
      } else {
        return (showSpace ? "&nbsp;" : "");
      }
    }
    
    
    public static String showMessage(HttpServletRequest request, String errorEntry, boolean showSpace) {
        if (request.getAttribute(errorEntry) != null) {
          return (showSpace ? "&nbsp;<br />" : "") + " <font color='green'>" + toHtml((String)request.getAttribute(errorEntry)) + "</font><br />&nbsp;<br />";
        } else if (request.getParameter(errorEntry) != null) {
          return (showSpace ? "&nbsp;<br />" : "") + "<font color='green'>" + toHtml((String)request.getParameter(errorEntry)) + "</font><br />&nbsp;<br />";
        } else {
          return (showSpace ? "&nbsp;" : "");
        }
      }
    
    public static boolean hasText(String in) {
      return (in != null && !("".equals(in.trim())));
    }

    public static boolean hasText(Object object, String in) {
      StringTokenizer st = new StringTokenizer(in, ",");
      while (st.hasMoreTokens()) {
        String token = st.nextToken();
        if (hasText(ObjectUtils.getParam(object, token.trim()))) {
          return true;
        }
      }
      return false;
    }
    
    public static String toDateTimeString(java.sql.Timestamp inDate) {
      return toDateTimeString(inDate, "");
    }
    
    public static String toDateTimeString(java.sql.Timestamp inDate, String defaultText) {
      try {
        return java.text.DateFormat.getDateTimeInstance(java.text.DateFormat.SHORT, java.text.DateFormat.LONG).format(inDate);
      } catch (NullPointerException e) {
      }
      return defaultText;
    }

  public static String addHiddenParams(HttpServletRequest request, String tmp){
    StringBuffer sb = new StringBuffer();
    StringTokenizer tokens = new StringTokenizer(tmp, "|");
    while (tokens.hasMoreTokens()){
       String param = tokens.nextToken();
       if (request.getParameter(param) != null){
        sb.append("<input type=\"hidden\" name=\"" + param + "\" value=\"" + request.getParameter(param) + "\">");
       }
    }
    return sb.toString();
  }
  
  public static String addLinkParams(HttpServletRequest request, String tmp){
    StringBuffer sb = new StringBuffer();
    StringTokenizer tokens = new StringTokenizer(tmp, "|");
    while(tokens.hasMoreTokens()){
     String param = tokens.nextToken();
     if (request.getParameter(param) != null){
       sb.append("&" + param + "=" + request.getParameter(param));
     }
    }
    return sb.toString();
  }
    
  public static boolean isPopup(HttpServletRequest request){
      return (request.getParameter("popup") != null && "true".equals(request.getParameter("popup")));
    }

  public static boolean isInLinePopup(HttpServletRequest request){
    return "inline".equals(request.getParameter("popupType"));
  }
  
  public static String addContainerParams(HttpServletRequest request, String tmp){
    StringBuffer sb = new StringBuffer();
    StringTokenizer tokens = new StringTokenizer(tmp, "|");
    while(tokens.hasMoreTokens()){
     String param = tokens.nextToken();
     if (request.getParameter(param) != null){
       sb.append("|" + param + "=" + request.getParameter(param));
     }
    }
    return sb.toString();
  }
    
    public static String getServerPort(HttpServletRequest request) {
      int port = request.getServerPort();
      if (port != 80 && port != 443) {
        return ":" + String.valueOf(port);
      }
      return "";
    }
    
    public static String getServerUrl(HttpServletRequest request) {
      return request.getServerName() + getServerPort(request) + request.getContextPath();
    }
  
  public static String getPref(ServletContext context, String param) {
    ApplicationPrefs prefs = (ApplicationPrefs) context.getAttribute("applicationPrefs");
    if (prefs != null) {
      return prefs.get(param);
    } else {
      return null;
    }
  }
  
  public boolean allowMultipleComponents(javax.servlet.jsp.PageContext context, String config, String param) {
    java.util.Hashtable globalStatus = (java.util.Hashtable)context.getServletConfig().getServletContext().getAttribute("SystemStatus");
    ConnectionPool ce = (ConnectionPool)context.getSession().getAttribute("ConnectionPool");
    SystemStatus systemStatus = (SystemStatus) ((java.util.Hashtable)context.getServletConfig().getServletContext().getAttribute("SystemStatus")).get(ce.getUrl());
    String multiple =  systemStatus.getValue(config, param);
    if(multiple != null && "false".equals(multiple)){
      return false;
    }else{
      return true;
    }
  }
  public boolean allowMultipleQuote(javax.servlet.jsp.PageContext context) {
	ConnectionPool ce = (ConnectionPool)context.getSession().getAttribute("ConnectionPool");
    SystemStatus systemStatus = (SystemStatus) ((java.util.Hashtable)context.getServletConfig().getServletContext().getAttribute("SystemStatus")).get(ce.getUrl());
    String multiple =  systemStatus.getValue(Quote.QUOTE_CONFIG_NAME, Quote.MULTIPLE_QUOTE_CONFIG_PARAM);
    if(multiple != null && "false".equals(multiple)){
      return false;
    }else{
      return true;
    }
  }
  public boolean allowMultipleVersion(javax.servlet.jsp.PageContext context) {
	ConnectionPool ce = (ConnectionPool)context.getSession().getAttribute("ConnectionPool");
    SystemStatus systemStatus = (SystemStatus) ((java.util.Hashtable)context.getServletConfig().getServletContext().getAttribute("SystemStatus")).get(ce.getUrl());
    String multiple =  systemStatus.getValue(Quote.QUOTE_CONFIG_NAME, Quote.MULTIPLE_VERSION_CONFIG_PARAM);
    if(multiple != null && "false".equals(multiple)){
      return false;
    }else{
      return true;
    }
  }

  public String getTime(javax.servlet.jsp.PageContext context, Timestamp timestamp, String timeZone, int dateFormat, boolean showTimeZone, boolean userTimeZone, boolean dateOnly, String defaultValue) {
    String result = null;
    int timeFormat = DateFormat.SHORT;
    if (timestamp != null && !"".equals(timestamp)) {
      Locale locale = null;
      // Retrieve the user's timezone from their session
      UserBean thisUser = (UserBean) context.getSession().getAttribute("User");
      if (thisUser != null) {
        if (userTimeZone) {
          if (timeZone == null) {
            timeZone = thisUser.getUserRecord().getTimeZone();
          }
        }
        // Still use the user's locale
        locale = thisUser.getUserRecord().getLocale();
      }
      if (locale == null) {
        locale = Locale.getDefault();
      }

      //Format the specified timestamp with the retrieved timezone
      SimpleDateFormat formatter = null;
      if (dateOnly) {
        formatter = (SimpleDateFormat) SimpleDateFormat.getDateInstance(dateFormat, locale);
      } else {
        formatter = (SimpleDateFormat) SimpleDateFormat.getDateTimeInstance(
            dateFormat, timeFormat, locale);
      }

      //set the pattern
      if (dateOnly) {
        if ((showTimeZone) && (timeZone != null)) {
          formatter.applyPattern(DateUtils.get4DigitYearDateFormat(formatter.toPattern()) + " z");
        } else {
          formatter.applyPattern(DateUtils.get4DigitYearDateFormat(formatter.toPattern()));
        }
      } else {
        SimpleDateFormat dateFormatter = (SimpleDateFormat) SimpleDateFormat.getDateInstance(
            dateFormat, locale);
        dateFormatter.applyPattern(DateUtils.get4DigitYearDateFormat(dateFormatter.toPattern()));

        SimpleDateFormat timeFormatter = (SimpleDateFormat) SimpleDateFormat.getTimeInstance(
            timeFormat, locale);

        if ((showTimeZone) && (timeZone != null)) {
          formatter.applyPattern(dateFormatter.toPattern() + " " + timeFormatter.toPattern() + " z");
        } else {
          formatter.applyPattern(dateFormatter.toPattern() + " " + timeFormatter.toPattern());
        }
      }
      //set the timezone
      if (timeZone != null) {
        java.util.TimeZone tz = java.util.TimeZone.getTimeZone(timeZone);
        formatter.setTimeZone(tz);
      }
      result = formatter.format(timestamp);
    } else {
      //no date found, output default
      if (defaultValue == null || "".equals(defaultValue)) {
        defaultValue="&nbsp;";
      }
      result = defaultValue;
    }
    return result;
  }

  public String getUsername(javax.servlet.jsp.PageContext context, int userId, boolean lastFirst, boolean firstInitialLast, String defaultText) {
    String result = null;
    Hashtable globalStatus = (Hashtable)context.getServletConfig().getServletContext().getAttribute("SystemStatus");
    ConnectionPool ce = (ConnectionPool)context.getSession().getAttribute("ConnectionPool");
    SystemStatus systemStatus = (SystemStatus) ((Hashtable)context.getServletConfig().getServletContext().getAttribute("SystemStatus")).get(ce.getUrl());
    User thisUser = systemStatus.getUser(userId);
    if (thisUser != null) {
      Contact thisContact = thisUser.getContact();
      if (thisContact != null) {
        if (lastFirst) {
          result = StringUtils.toHtml(thisContact.getNameLastFirst());
        } else if (firstInitialLast) {
          result = StringUtils.toHtml(thisContact.getNameFirstInitialLast());
        } else {
          result = StringUtils.toHtml(thisContact.getNameFirstLast());
        }
      }
    } else {
      //NOTE: the default text will already be in the output format
      if (defaultText == null || "".equals(defaultText)) {
        return "&nbsp;";
      }
      String temp = systemStatus.getLabel(defaultText);
      if ( temp != null || !"".equals(temp)) {
        result = StringUtils.toHtml(systemStatus.getLabel(defaultText));
      } else {
        result = defaultText;
      }
    }
    return result;
  }
  
  public boolean hasAuthority(javax.servlet.jsp.PageContext context, String owner) {
    boolean result = false;
    Hashtable globalStatus = (Hashtable)context.getServletConfig().getServletContext().getAttribute("SystemStatus");
    ConnectionPool ce = (ConnectionPool)context.getSession().getAttribute("ConnectionPool");
    SystemStatus systemStatus = (SystemStatus) ((Hashtable)context.getServletConfig().getServletContext().getAttribute("SystemStatus")).get(ce.getUrl());
    int userId = ((UserBean) context.getSession().getAttribute("User")).getUserId();
    String[] owners = owner.split(",");
    for (int i = 0; i < owners.length; i++) {
      String oneOwner = owners[i];
      if (userId == Integer.parseInt(oneOwner)) {
        result = true;
        break;
      }
      User userRecord = systemStatus.getUser(userId);
      User childRecord = null;
      if (oneOwner != null && !"".equals(oneOwner.trim())) {
        childRecord = userRecord.getChild(Integer.parseInt(oneOwner));
      }
      if (childRecord != null) {
        result = true;
        break;
      }
    }
    return result;
  }
  
	public static String createBarcodeImage(String code){  
	    
	    Barcode128 code128 = new Barcode128();
	         code128.setCode(code);
	         java.awt.Image im = code128.createAwtImage(Color.BLACK, Color.WHITE);
	         int w = im.getWidth(null);
	     int h = im.getHeight(null);
	     BufferedImage img = new BufferedImage(w, h+12, BufferedImage.TYPE_INT_ARGB);
	     Graphics2D g2d = img.createGraphics();
	     g2d.drawImage(im, 0, 0, null);
	     g2d.drawRect(0, h, w, 12);
	     g2d.fillRect(0, h+1, w, 12);
	     g2d.setColor(Color.WHITE);
	     String s = code128.getCode();
	     g2d.setColor(Color.BLACK);
	     g2d.drawString(s,0,34);
	     g2d.dispose();
	     
	     ByteArrayOutputStream out = new ByteArrayOutputStream();
	     try {
				ImageIO.write(img, "PNG", out);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	     byte[] bytes = out.toByteArray();

	     String base64bytes = Base64.encode(bytes);
	     String src = "data:image/png;base64," + base64bytes;
	     
	     return src;
	}
	
	
	public long checkDifferenceDays(Timestamp ts1, Timestamp ts2){
		
		 long milliseconds1 = ts1.getTime();
		 long milliseconds2 = ts2.getTime();

		 long diff = milliseconds2 - milliseconds1;
		 long diffDays = diff / (24 * 60 * 60 * 1000);
		 
		 return diffDays;
	}
	
	
	public static String dataToString( java.sql.Date data )
	{
		String ret = null;
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		try
		{
			if( data != null )
			{
				ret = sdf.format( data );
			}
		}
		catch ( Exception e )
		{
			e.printStackTrace();
		}
		
		return ret;
	}
	
	 public static String showWarning(HttpServletRequest request, String warningEntry, boolean showSpace) {
	      if (request.getAttribute(warningEntry) != null) {
	        return  (showSpace ? "&nbsp;<br />" : "") + "<img src=\"images/box-hold.gif\" border=\"0\" align=\"absmiddle\"/> <font color='#FF9933'>" + toHtml((String)request.getAttribute(warningEntry)) + "</font><br />&nbsp;<br />";
	      } else if(request.getParameter(warningEntry) != null){
	        return (showSpace ? "&nbsp;<br />" : "") + "<img src=\"images/box-hold.gif\" border=\"0\" align=\"absmiddle\"/> <font color='#FF9933'>" + toHtml((String)request.getParameter(warningEntry)) + "</font><br />&nbsp;<br />";
	      } else{
	        return (showSpace ? "&nbsp;" : "");
	      }
	    }

	    public static String showWarning(HttpServletRequest request, String warningEntry) {
			return showWarning(request, warningEntry, true);
	    }

	    public static String showWarningAttribute(HttpServletRequest request, String warningEntry) {

	      if (request.getAttribute(warningEntry) != null) {
	        return "<font color='#FF9933'>" + toHtml((String)request.getAttribute(warningEntry)) + "</font>";
	      } else if(request.getParameter(warningEntry) != null){
	        return "<font color='#FF9933'>" + toHtml((String)request.getParameter(warningEntry)) + "</font>";
	      } else{
	        return "";
	      }
	    }
%>
