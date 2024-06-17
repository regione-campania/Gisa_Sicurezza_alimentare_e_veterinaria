package org.aspcfs.controller;

import java.util.ArrayList;

public class Tree {

	/**
	 * NOME DELLA TABELLA CHE MAPPA L'ALBERO
	 */
	
	private String nomeTabella ;
	private String descrizione ;
	/**
	 * LISTA DEI NODI DI PRIMO LIVELLO DELL'ALBERO
	 */
	private ArrayList<Nodo> listaNodi = null ;
	
	public Tree(String tabella)
	{
		listaNodi = new ArrayList<Nodo>() ;
		nomeTabella = tabella ;
	}
	
	public Tree(String tabella,ArrayList<Nodo> lista)
	{
		if(lista != null)
			listaNodi = lista 	;
		else
			listaNodi = new ArrayList<Nodo>() ;
		
		nomeTabella = tabella ;
	}
	public Tree()
	{
		listaNodi = new ArrayList<Nodo>() ;
		
	}

	public String getNomeTabella() {
		return nomeTabella;
	}

	public void setNomeTabella(String nomeTabella) {
		this.nomeTabella = nomeTabella;
	}

	public ArrayList<Nodo> getListaNodi() {
		return listaNodi;
	}

	public void setListaNodi(ArrayList<Nodo> listaNodi) {
		this.listaNodi = listaNodi;
	}

	public String getDescrizione() {
		return descrizione;
	}

	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}
	



}
