package it.us.web.bean;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;


public class UserOperation {
	private int id;
	private int user_id;
	private String username;
	private String ip;
	private String url;
	private String parameter;
	private Timestamp data;
	private Boolean automatico = false;
	private String userBrowser;
	private String action;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getParameter() {
		return parameter;
	}
	public void setParameter(String parameter) {
		this.parameter = parameter;
	}
	public Timestamp getData() {
		return data;
	}
	public void setData(Timestamp data) {
		this.data = data;
	}
	public Boolean getAutomatico() {
		return automatico;
	}
	public void setAutomatico(Boolean automatico) {
		this.automatico = automatico;
	}
	public String getUserBrowser() {
		return userBrowser;
	}
	public void setUserBrowser(String userBrowser) {
		this.userBrowser = userBrowser;
	}
	
	public String getAction() {
		return action;
	}
	public void setAction(String action) {
		this.action = action;
	}
	
	public void insert(Connection db, Boolean automatico) throws Exception{
		String insertStoricoOperazioniUtenti = "INSERT INTO sca_storico_operazioni_utenti(user_id, username, ip, data, path, parametri, automatico,browser,action) VALUES (?, ?, ?, ?, ?, ?, ?, ?,?)"; 
			
			PreparedStatement pst = db.prepareStatement(insertStoricoOperazioniUtenti);
			pst.setInt(1, this.getUser_id());
			pst.setString(2, this.getUsername());
			pst.setString(3, this.getIp());
			pst.setTimestamp(4, this.getData());
			pst.setString(5, this.getUrl());
			pst.setString(6, this.getParameter());
			pst.setBoolean(7, automatico);
			pst.setString(8, this.getUserBrowser());
			pst.setString(9, this.getAction());
			pst.executeUpdate(); 
			pst.close();
	}
	
	public static UserOperation lastOperation(int user_id, Connection db) throws Exception
	{
		String selectStoricoOperazioniUtenti = "SELECT * FROM sca_storico_operazioni_utenti where user_id = ? order by data desc limit 1 "; 
		UserOperation uo = null;
		
		try
		{
			
			PreparedStatement pst = db.prepareStatement(selectStoricoOperazioniUtenti);
			pst.setInt(1, user_id);
			ResultSet res = pst.executeQuery();
			if(res.next())
			{
				uo = new UserOperation();
				uo.setData(res.getTimestamp("data"));
				uo.setId(res.getInt("id"));
				uo.setIp(res.getString("ip"));
				uo.setParameter(res.getString("parametri"));
				uo.setUrl(res.getString("path"));
				uo.setUser_id(res.getInt("user_id"));
				uo.setUserBrowser(res.getString("browser"));
				uo.setUsername(res.getString("username"));
				uo.setAction(res.getString("action"));
			}
			
			pst.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return null;
		}
		return uo;
	}
}
