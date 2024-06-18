package org.aspcfs.modules.opu.base;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.aspcfs.modules.base.Constants;
import org.aspcfs.utils.DatabaseUtils;

public class ImportatoreInformazioni extends LineaProduttiva {
	 //Table opu_informazioni_importatore
	
	private int idInformazioni = -1;
	private String codiceUvac = "";

	public String getCodiceUvac() {
		return codiceUvac;
	}

	public void setCodiceUvac(String codiceUvac) {
		this.codiceUvac = codiceUvac;
	}

	public ImportatoreInformazioni() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	
	

  
  public boolean insert(Connection db) throws SQLException {
	  
//	  System.out.println("insert informazioni");

		StringBuffer sql = new StringBuffer();
		try {
			

			super.insert(db);

			int idAnimale = super.getId();

			idInformazioni = DatabaseUtils.getNextSeqPostgres(db, "opu_informazioni_importatore_id_seq");
			// sql.append("INSERT INTO animale (");

			sql
					.append("INSERT INTO opu_informazioni_importatore(id_relazione_stabilimento_lp, codice_uvac ");

			

			
			sql.append(")");
			sql.append("VALUES ( ?,? ");


			sql.append(")");

			int i = 0;
			PreparedStatement pst = db.prepareStatement(sql.toString());

			pst.setInt(++i, super.getId());
			pst.setString(++i, codiceUvac);
			
			pst.execute();
			pst.close();

			this.idInformazioni = DatabaseUtils.getCurrVal(db, "opu_informazioni_importatore_id_seq",
					idInformazioni);

			

		} catch (SQLException e) {
			
			throw new SQLException(e.getMessage());
		} finally {
			
		}
		return true;

	}

  
  public static ImportatoreInformazioni getInfoAddizionali(LineaProduttiva lp, Connection db){
	 ImportatoreInformazioni info = new ImportatoreInformazioni();
	 Field[] campi = lp.getClass().getDeclaredFields();
	 Method metodoGet = null;
	 Method metodoSet= null;
		
	 
	 for (int i = 0; i < campi.length; i++) {
			int k = 0;

			String nameToUpperCase = (campi[i].getName().substring(0, 1)
					.toUpperCase() + campi[i].getName().substring(1,
					campi[i].getName().length()));
			

				// (nameToUpperCase.equals("IdTipoMantello")){
				try {
					
					metodoGet = lp.getClass().getMethod(
							"get" + nameToUpperCase, null);
					metodoSet = info.getClass().getSuperclass().getMethod(
							"set" + nameToUpperCase, String.class);
					
				

				if (metodoGet != null && metodoSet != null)	{		
					if (("DataInizio").equals(nameToUpperCase)){
					//	System.out.println(nameToUpperCase);
					}
						metodoSet.invoke(info, (metodoGet.invoke(lp) != null)?metodoGet.invoke(lp).toString():null);
				}
						
					
				}catch (Exception e) {
				//	System.out.println(metodoGet + "   " + metodoSet + "   " + nameToUpperCase + " Non trovato ");
				//	e.printStackTrace();
				}	
				
				
				
	 
	 
	 
  }
	 
	 info.getInformazioni(db);
	 
	 return info;
	 
  }
  
  
  
	public void getInformazioni(Connection db)  {

		//	super(db, idEventoPadre);

			PreparedStatement pst;
			try {
				pst = db
						.prepareStatement("Select * from opu_informazioni_importatore  where id_relazione_stabilimento_lp = ?");
				pst.setInt(1, this.getId());
				ResultSet rs = DatabaseUtils.executeQuery(db, pst);
				if (rs.next()) {
					this.buildRecord(rs);
				}
				
				rs.close();
				pst.close();
				
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}



			
		}
	
	
	public void buildRecord(ResultSet rs) throws SQLException{
		this.codiceUvac = rs.getString("codice_uvac");
	}
}
