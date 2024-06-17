package org.aspcfs.modules.mu.base;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.sql.Types;
import java.util.Vector;

import com.darkhorseventures.framework.beans.GenericBean;

public class Organo extends GenericBean {

	private static final long serialVersionUID = -906599187340806298L;

	private static final int INT = Types.INTEGER;
	private static final int STRING = Types.VARCHAR;
	private static final int DOUBLE = Types.DOUBLE;
	private static final int FLOAT = Types.FLOAT;
	private static final int TIMESTAMP = Types.TIMESTAMP;
	private static final int DATE = Types.DATE;
	private static final int BOOLEAN = Types.BOOLEAN;

	private int id = -1;
	private int id_capo = -1;
	private int id_patologia = -1;
	private String patologia_altro = "";
	private int id_stadio = -1;
	private int id_organo = -1;

	private String istopatologico_topografia = "";
	private String istopatologico_interessamento_altri_organi = "";
	private int istopatologico_id_richiesta = -1;
	private String identificativo_campione_organo = "";
	private int id_esito_istopatologico = -1;
	private int id_classificazione_istopatologico = -1;
	private int id_valore_classificazione_istopatologico = -1;

	// informazioni di sistema
	private Timestamp entered;
	private Timestamp modified;
	private Timestamp trashed_date;
	private int entered_by;
	private int modified_by;
	private int trashed_by;
	private boolean enabled = true;

	public Timestamp getEntered() {
		return entered;
	}

	public void setEntered(Timestamp entered) {
		this.entered = entered;
	}

	public Timestamp getModified() {
		return modified;
	}

	public void setModified(Timestamp modified) {
		this.modified = modified;
	}

	public Timestamp getTrashed_date() {
		return trashed_date;
	}

	public void setTrashed_date(Timestamp trashed_date) {
		this.trashed_date = trashed_date;
	}

	public int getEntered_by() {
		return entered_by;
	}

	public void setEntered_by(int entered_by) {
		this.entered_by = entered_by;
	}

	public int getModified_by() {
		return modified_by;
	}

	public void setModified_by(int modified_by) {
		this.modified_by = modified_by;
	}

	public int getTrashed_by() {
		return trashed_by;
	}

	public void setTrashed_by(int trashed_by) {
		this.trashed_by = trashed_by;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public int getId_capo() {
		return id_capo;
	}

	public void setId_capo(int id_capo) {
		this.id_capo = id_capo;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getId_patologia() {
		return id_patologia;
	}

	public void setId_patologia(int id_patologia) {
		this.id_patologia = id_patologia;
	}

	public String getPatologia_altro() {
		return patologia_altro;
	}

	public void setPatologia_altro(String patologia_altro) {
		this.patologia_altro = patologia_altro;
	}

	public int getId_stadio() {
		return id_stadio;
	}

	public void setId_stadio(int id_stadio) {
		this.id_stadio = id_stadio;
	}

	public int getId_organo() {
		return id_organo;
	}

	public void setId_organo(int id_organo) {
		this.id_organo = id_organo;
	}

	public String getIstopatologico_topografia() {
		return istopatologico_topografia;
	}

	public void setIstopatologico_topografia(String istopatologico_topografia) {
		this.istopatologico_topografia = istopatologico_topografia;
	}

	public String getIstopatologico_interessamento_altri_organi() {
		return istopatologico_interessamento_altri_organi;
	}

	public void setIstopatologico_interessamento_altri_organi(String istopatologico_interessamento_altri_organi) {
		this.istopatologico_interessamento_altri_organi = istopatologico_interessamento_altri_organi;
	}

	public int getIstopatologico_id_richiesta() {
		return istopatologico_id_richiesta;
	}

	public void setIstopatologico_id_richiesta(int istopatologico_id_richiesta) {
		this.istopatologico_id_richiesta = istopatologico_id_richiesta;
	}

	public String getIdentificativo_campione_organo() {
		return identificativo_campione_organo;
	}

	public void setIdentificativo_campione_organo(String identificativo_campione_organo) {
		this.identificativo_campione_organo = identificativo_campione_organo;
	}

	public int getId_classificazione_istopatologico() {
		return id_classificazione_istopatologico;
	}

	public void setId_classificazione_istopatologico(int id_classificazione_istopatologico) {
		this.id_classificazione_istopatologico = id_classificazione_istopatologico;
	}

	public int getId_valore_classificazione_istopatologico() {
		return id_valore_classificazione_istopatologico;
	}

	public void setId_valore_classificazione_istopatologico(int id_valore_classificazione_istopatologico) {
		this.id_valore_classificazione_istopatologico = id_valore_classificazione_istopatologico;
	}

	public void setId_classificazione_istopatologico(String id_classificazione) {
		if (id_classificazione != null)
			this.id_classificazione_istopatologico = Integer.valueOf(id_classificazione);
	}

	public void setId_valore_classificazione_istopatologico(String id_valore_classificazione) {
		if (id_valore_classificazione != null)
			this.id_valore_classificazione_istopatologico = Integer.valueOf(id_valore_classificazione);
	}

	public int getId_esito_istopatologico() {
		return id_esito_istopatologico;
	}

	public void setId_esito_istopatologico(int id_esito_istopatologico) {
		this.id_esito_istopatologico = id_esito_istopatologico;
	}

	public void setId_esito_istopatologico(String id_esito_istopatologico) {
		this.id_esito_istopatologico = Integer.valueOf(id_esito_istopatologico);
	}

	public Organo() {
		super();
	}

	public void store(Connection db) throws SQLException, IllegalArgumentException, IllegalAccessException,
			InvocationTargetException {
		String sql = "INSERT INTO mu_vp_organi_patologie( ";

		Field[] f = this.getClass().getDeclaredFields();
		Method[] m = this.getClass().getMethods();
		Vector<Method> v = new Vector<Method>();
		Vector<Field> v2 = new Vector<Field>();
		boolean firstField = true;

		for (int i = 0; i < f.length; i++) {
			String field = f[i].getName();
			for (int j = 0; j < m.length; j++) {
				String met = m[j].getName();
				if (!field.equalsIgnoreCase("id")
						&& (met.equalsIgnoreCase("GET" + field) || met.equalsIgnoreCase("IS" + field))) {
					v.add(m[j]);
					v2.add(f[i]);
					sql += (firstField) ? ("") : (",");
					firstField = false;
					sql += " " + field;
				}
			}

		}

		sql += " ) VALUES (";
		firstField = true;

		for (int i = 0; i < v.size(); i++) {
			{
				sql += (firstField) ? ("") : (",");
				sql += " ?";
				firstField = false;
			}
		}

		sql += " )";

		PreparedStatement stat = db.prepareStatement(sql);

		for (int i = 1; i <= v.size(); i++) {
			Object o = v.elementAt(i - 1).invoke(this);

			if (o == null) {
				stat.setNull(i, parseType(v2.elementAt(i - 1).getType()));
			} else {
				switch (parseType(o.getClass())) {
				case INT:
					stat.setInt(i, (Integer) o);
					break;
				case STRING:
					stat.setString(i, (String) o);
					break;
				case BOOLEAN:
					stat.setBoolean(i, (Boolean) o);
					break;
				case TIMESTAMP:
					stat.setTimestamp(i, (Timestamp) o);
					break;
				case DATE:
					stat.setDate(i, (Date) o);
					break;
				case FLOAT:
					stat.setFloat(i, (Float) o);
					break;
				case DOUBLE:
					stat.setDouble(i, (Double) o);
					break;
				}
			}
		}
		stat.execute();
		stat.close();
	}

	protected static int parseType(Class<?> type) {
		int ret = -1;

		String name = type.getSimpleName();

		if (name.equalsIgnoreCase("int") || name.equalsIgnoreCase("integer")) {
			ret = INT;
		} else if (name.equalsIgnoreCase("string")) {
			ret = STRING;
		} else if (name.equalsIgnoreCase("double")) {
			ret = DOUBLE;
		} else if (name.equalsIgnoreCase("float")) {
			ret = FLOAT;
		} else if (name.equalsIgnoreCase("timestamp")) {
			ret = TIMESTAMP;
		} else if (name.equalsIgnoreCase("date")) {
			ret = DATE;
		} else if (name.equalsIgnoreCase("boolean")) {
			ret = BOOLEAN;
		}

		return ret;
	}

	public void update(Connection db) throws SQLException, IllegalArgumentException, IllegalAccessException,
			InvocationTargetException {
		String sql = "UPDATE m_lcso_organi SET ";

		Field[] f = this.getClass().getDeclaredFields();
		Method[] m = this.getClass().getMethods();
		Vector<Method> v = new Vector<Method>();
		Vector<Field> v2 = new Vector<Field>();
		boolean firstField = true;

		for (int i = 0; i < f.length; i++) {
			String field = f[i].getName();
			for (int j = 0; j < m.length; j++) {
				String met = m[j].getName();
				if (!field.equalsIgnoreCase("id")
						&& (met.equalsIgnoreCase("GET" + field) || met.equalsIgnoreCase("IS" + field))) {
					v.add(m[j]);
					v2.add(f[i]);
					sql += (firstField) ? ("") : (",");
					firstField = false;
					sql += " " + field + " = ?";
				}
			}

		}

		sql += " WHERE id = ?";

		PreparedStatement stat = db.prepareStatement(sql);

		for (int i = 1; i <= v.size(); i++) {
			Object o = v.elementAt(i - 1).invoke(this);

			if (o == null) {
				stat.setNull(i, parseType(v2.elementAt(i - 1).getType()));
			} else {
				switch (parseType(o.getClass())) {
				case INT:
					stat.setInt(i, (Integer) o);
					break;
				case STRING:
					stat.setString(i, (String) o);
					break;
				case BOOLEAN:
					stat.setBoolean(i, (Boolean) o);
					break;
				case TIMESTAMP:
					stat.setTimestamp(i, (Timestamp) o);
					break;
				case DATE:
					stat.setDate(i, (Date) o);
					break;
				case FLOAT:
					stat.setFloat(i, (Float) o);
					break;
				case DOUBLE:
					stat.setDouble(i, (Double) o);
					break;
				}
			}
		}

		stat.setInt(v.size() + 1, id);

		stat.execute();
		stat.close();

	}

	public static void delete(int id, int user_id, Connection db) {
		PreparedStatement stat = null;
		try {
			stat = db
					.prepareStatement("UPDATE m_lcso_organi SET modified = CURRENT_TIMESTAMP, trashed_date = CURRENT_TIMESTAMP, modified_by = ? "
							+ " where id = ? AND trashed_date IS NULL");

			stat.setInt(1, user_id);
			stat.setInt(2, id);

			stat.execute();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (stat != null) {
					stat.close();
					stat = null;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	
	public  void loadResultSet( ResultSet res ) 
			throws SQLException, IllegalArgumentException, IllegalAccessException, InvocationTargetException
		{
			//Organo ret = new Organo();
		
			Field[]	f = this.getClass().getDeclaredFields();
			Method[]	m = this.getClass().getMethods();
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
		            	 if (!(( parseType( campo.getType() ) == INT)   && m[j].getParameterTypes() [0] == String.class))
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
		             
		             setter.invoke( this, o );
		         
		         }
			}
		
		//	return ret;
		}
	
	
//	public void loadResultSet(ResultSet res) throws SQLException, IllegalArgumentException, IllegalAccessException,
//			InvocationTargetException {
//
//		HashMap<String, Integer> campi = new HashMap<String, Integer>();
//		int k = 0;
//
//		for (Field f : Organo.class.getDeclaredFields()) {
//			Column column = f.getAnnotation(Column.class);
//			if (column != null) {
//				System.out.println(column.columnName());
//				// if (column.table() == null ||
//				// (nome_tabella).equals(column.table()) )
//				campi.put(column.columnName(), column.columnType());
//			}
//		}
//
//		Method[] m = this.getClass().getMethods();
//
//		Iterator it = campi.entrySet().iterator();
//		while (it.hasNext()) {
//
//			Map.Entry pairs = (Map.Entry) it.next();
//			System.out.println(pairs.getKey() + " = " + pairs.getValue());
//
//			// for( int i = 0; i < campi.length; i++ )
//			// {
//			String field = (String) pairs.getKey();
//			Method getter = null;
//			Method setter = null;
//			for (int j = 0; j < m.length; j++) {
//				String met = m[j].getName();
//				if (met.equalsIgnoreCase("GET" + field.replaceAll("_", ""))
//						|| met.equalsIgnoreCase("IS" + field.replaceAll("_", ""))) {
//					getter = m[j];
//				} else if (met.equalsIgnoreCase("SET" + field.replaceAll("_", ""))) {
//					if (!(((Integer) pairs.getValue()) == INT && m[j].getParameterTypes()[0] == String.class)
//							&& !(((Integer) pairs.getValue()) == TIMESTAMP && m[j].getParameterTypes()[0] == String.class)
//							&& !(((Integer) pairs.getValue()) == DOUBLE && m[j].getParameterTypes()[0] == String.class))
//						setter = m[j];
//				}
//			}
//
//			if ((getter != null) && (setter != null) && (field != null)) {
//				Object o = null;
//
//				switch (((Integer) pairs.getValue())) {
//				case INT:
//					o = res.getInt(field);
//					break;
//				case STRING:
//					o = res.getString(field);
//					break;
//				case BOOLEAN:
//					o = res.getBoolean(field);
//					break;
//				case TIMESTAMP:
//					o = res.getTimestamp(field);
//					break;
//				case DATE:
//					o = res.getDate(field);
//					break;
//				case FLOAT:
//					o = res.getFloat(field);
//					break;
//				case DOUBLE:
//					o = res.getDouble(field);
//					break;
//				}
//
//				setter.invoke(this, o);
//
//			}
//		}
//
//		// }
//	}

}