package org.aspcfs.modules.dpat2019.base;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;

import org.json.JSONArray;
import org.json.JSONObject;

public abstract class SezioneInterface<T extends PianoAttivitaInterface> implements Cloneable
{
	Long oid;
	String descrizione;
	Integer anno;
	Integer ordine;
	Integer codiceRaggruppamento;
	Timestamp scadenza;
	String color;
	ArrayList<T> pianiAttivitaFigli = new ArrayList<T>();
	
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}

	public ArrayList<T> getPianiAttivitaFigli() {
		return pianiAttivitaFigli;
	}
	public void setPianiAttivitaFigli(ArrayList<T> pianiAttivitaFigli) {
		this.pianiAttivitaFigli = pianiAttivitaFigli;
	}

	public Long getOid() {
		return oid;
	}
	public void setOid(Long oid) {
		this.oid = oid;
	}
	public String getDescrizione() {
		return descrizione;
	}
	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}
	public Integer getAnno() {
		return anno;
	}
	public void setAnno(Integer anno) {
		this.anno = anno;
	}
	public Integer getOrdine() {
		return ordine;
	}
	public void setOrdine(Integer ordine) {
		this.ordine = ordine;
	}
	public Integer getCodiceRaggruppamento() {
		return codiceRaggruppamento;
	}
	public void setCodiceRaggruppamento(Integer codiceInternoUnivoco) {
		this.codiceRaggruppamento = codiceInternoUnivoco;
	}
	public Timestamp getScadenza() {
		return scadenza;
	}
	public void setScadenza(Timestamp scadenza) {
		this.scadenza = scadenza;
	}
	
	
	public JSONObject getJsonObj()
	{
		JSONObject toRet = new JSONObject();
		toRet.put("id", getOid()+"");
		toRet.put("descrizione", getDescrizione()+"");
		toRet.put("anno", getAnno()+"");
		toRet.put("ordine", getOrdine()+"");
		toRet.put("codiceRaggruppamento", getCodiceRaggruppamento()+"");
		toRet.put("scadenza", getScadenza()+"");
		toRet.put("color", getColor());
		JSONArray figli = new JSONArray();
		for(T bean : pianiAttivitaFigli)
		{
			figli.put(bean.getJsonObj());
		}
		toRet.put("figli", figli);
		
		return toRet;
	}
	
	
	public Object clone() throws CloneNotSupportedException {
		// TODO Auto-generated method stub
		return super.clone();
	}
	
	public abstract ArrayList<? extends SezioneInterface<T>> buildList(Connection conn, ResultSet rs,boolean nonscaduti,boolean withChilds, String statoFigli, String statoSezione) throws Exception;
	public abstract SezioneInterface<T> buildByOid(Connection conn, Integer oid, boolean nonscaduti,boolean withChilds, String stato, String statoFigli, String statoSezione) throws Exception;
	public abstract SezioneInterface<T> build(Connection conn, ResultSet rs, boolean nonscaduti, boolean withChilds, String statoFigli, String statoSezione) throws Exception;
}
