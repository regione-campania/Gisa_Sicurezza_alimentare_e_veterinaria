package org.aspcfs.modules.pnaa.actions;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.logging.Logger;

import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.campioni.base.Ticket;
import org.aspcfs.modules.pnaa.base.ModPnaa;
import org.aspcfs.utils.web.LookupList;

import com.darkhorseventures.framework.actions.ActionContext;


public final class GestionePnaa extends CFSModule {
	

	Logger logger = Logger.getLogger("MainLogger");
	
public String executeCommandView(ActionContext context) {
		
		int idCampione = -1;
		
		try { idCampione = Integer.parseInt(context.getRequest().getParameter("idCampione"));} catch (Exception e) {}
		if (idCampione == -1)
			try { idCampione = Integer.parseInt((String)context.getRequest().getAttribute("idCampione"));} catch (Exception e) {}
	
		Connection db = null;
		try {
			db = this.getConnection(context);
			
			Ticket campione = new Ticket (db, idCampione);
			
			String stringRev2024 = new SimpleDateFormat("2024-01-01 00:00:00").format(new java.util.Date()); 
			Timestamp tsRev2024 = Timestamp.valueOf(stringRev2024);
			
			if (campione.getAssignedDate().before( tsRev2024))
				 return executeCommandViewRevOld(context);
			else
				 return executeCommandViewRev2024(context);
		}catch (Exception e) {
			e.printStackTrace();
			context.getRequest().setAttribute("Error", e);
			return ("SystemError");
		} 
		finally
		{
			this.freeConnection(context, db);
		}
	}


	public String executeCommandViewRevOld(ActionContext context) {
		
		int idCampione = -1;
		
		try { idCampione = Integer.parseInt(context.getRequest().getParameter("idCampione"));} catch (Exception e) {}
		if (idCampione == -1)
			try { idCampione = Integer.parseInt((String)context.getRequest().getAttribute("idCampione"));} catch (Exception e) {}
	
		Connection db = null;
		try {
			db = this.getConnection(context);
			
			Ticket campione = new Ticket (db, idCampione);
			context.getRequest().setAttribute("Campione", campione);

			ModPnaa mod = new ModPnaa(db, idCampione);
			context.getRequest().setAttribute("Mod", mod);
			
			LookupList DpaList = new LookupList(db, "lookup_dpa");
		    context.getRequest().setAttribute("DpaList", DpaList);
		    
		    LookupList StrategiaCampionamentoList = new LookupList(db, "lookup_pnaa_strategia_campionamento");
		    context.getRequest().setAttribute("StrategiaCampionamentoList", StrategiaCampionamentoList);
		    
		    LookupList MetodoCampionamentoList = new LookupList(db, "lookup_metodo_campionamento");
		    context.getRequest().setAttribute("MetodoCampionamentoList", MetodoCampionamentoList);
		    
		    LookupList ProgrammaControlloList = new LookupList(db, "(select * from pnaa_get_lookup_programma_controllo('"+campione.getAssignedDate()+"'))");
		    context.getRequest().setAttribute("ProgrammaControlloList", ProgrammaControlloList);
		    
		    LookupList PrincipiAdditiviList = new LookupList(db, "lookup_principi_farm_attivi_additivi");
		    context.getRequest().setAttribute("PrincipiAdditiviList", PrincipiAdditiviList);
		    
		    LookupList PrincipiAdditiviCOList = new LookupList(db, "lookup_principi_farm_attivi_additivi_carryover");
		    context.getRequest().setAttribute("PrincipiAdditiviCOList", PrincipiAdditiviCOList);
		    
		    LookupList ContaminantiList = new LookupList(db, "(select * from pnaa_get_lookup_contaminanti('"+campione.getAssignedDate()+"'))");
		    context.getRequest().setAttribute("ContaminantiList", ContaminantiList);
		    
		    LookupList LuogoPrelievoList = new LookupList(db, "lookup_luogo_prelievo");
		    context.getRequest().setAttribute("LuogoPrelievoList", LuogoPrelievoList);
		    
		    LookupList MatriceCampioneList = new LookupList(db, "lookup_matrice_campione_sinvsa_new");
		    context.getRequest().setAttribute("MatriceCampioneList", MatriceCampioneList);
		     
		    LookupList SpecieVegetaleList = new LookupList(db, "lookup_specie_vegetale_pnaa");
		    context.getRequest().setAttribute("SpecieVegetaleList", SpecieVegetaleList);
		    
		    LookupList MetodoProduzioneList = new LookupList(db, "lookup_circuito_pna");
		    context.getRequest().setAttribute("MetodoProduzioneList", MetodoProduzioneList);
		    
		    LookupList StatoProdottoList = new LookupList(db, "lookup_prodotti_pnaa");
		    context.getRequest().setAttribute("StatoProdottoList", StatoProdottoList);
		    
		    LookupList SpecieAlimentoList = new LookupList(db, "lookup_specie_alimento");
		    context.getRequest().setAttribute("SpecieAlimentoList", SpecieAlimentoList);
		    
		    LookupList PremiscelaAdditiviList = new LookupList(db, "lookup_pnaa_premiscela_additivi");
		    context.getRequest().setAttribute("PremiscelaAdditiviList", PremiscelaAdditiviList);
		    
		    LookupList MangimeCompostoList = new LookupList(db, "lookup_pnaa_mangime_composto");
		    context.getRequest().setAttribute("MangimeCompostoList", MangimeCompostoList);
		    
		    LookupList SiNoList = new LookupList(db, "lookup_pnaa_si_no");
		    context.getRequest().setAttribute("SiNoList", SiNoList);
		    
		    LookupList CampioneFinaleList = new LookupList(db, "lookup_pnaa_campione_finale");
		    context.getRequest().setAttribute("CampioneFinaleList", CampioneFinaleList);
		    
		    LookupList ConfezionamentoList = new LookupList(db, "lookup_pnaa_confezionamento");
		    context.getRequest().setAttribute("ConfezionamentoList", ConfezionamentoList);
		    
		    LookupList CgRidottoList = new LookupList(db, "lookup_pnaa_cg_ridotto");
		    context.getRequest().setAttribute("CgRidottoList", CgRidottoList);
		    
		    LookupList CgCrList = new LookupList(db, "lookup_pnaa_cg_cr");
		    context.getRequest().setAttribute("CgCrList", CgCrList);
		    
		    LookupList SequestroPartitaList = new LookupList(db, "lookup_pnaa_sequestro_partita");
		    context.getRequest().setAttribute("SequestroPartitaList", SequestroPartitaList);
		    
		    LookupList SottoprodottiList = new LookupList(db, "lookup_pnaa_categoria_sottoprodotti");
		    context.getRequest().setAttribute("SottoprodottiList", SottoprodottiList);
			    
		}catch (Exception e) {
			e.printStackTrace();
			context.getRequest().setAttribute("Error", e);
			return ("SystemError");
		} 
		finally
		{
			this.freeConnection(context, db);
		}
		
		return "ModPnaaOK";
	}

public String executeCommandViewRev2024(ActionContext context) {
		
		int idCampione = -1;
		
		try { idCampione = Integer.parseInt(context.getRequest().getParameter("idCampione"));} catch (Exception e) {}
		if (idCampione == -1)
			try { idCampione = Integer.parseInt((String)context.getRequest().getAttribute("idCampione"));} catch (Exception e) {}
	
		Connection db = null;
		try {
			db = this.getConnection(context);
			
			Ticket campione = new Ticket (db, idCampione);
			context.getRequest().setAttribute("Campione", campione);

			ModPnaa mod = new ModPnaa(db, idCampione);
			context.getRequest().setAttribute("Mod", mod);
			
			LookupList DpaList = new LookupList(db, "lookup_dpa");
		    context.getRequest().setAttribute("DpaList", DpaList);
		    
		    LookupList StrategiaCampionamentoList = new LookupList(db, "lookup_pnaa_strategia_campionamento");
		    context.getRequest().setAttribute("StrategiaCampionamentoList", StrategiaCampionamentoList);
		    
		    LookupList MetodoCampionamentoList = new LookupList(db, "lookup_metodo_campionamento");
		    context.getRequest().setAttribute("MetodoCampionamentoList", MetodoCampionamentoList);
		    
		    LookupList ProgrammaControlloList = new LookupList(db, "(select * from pnaa_get_lookup_programma_controllo('"+campione.getAssignedDate()+"'))");
		    context.getRequest().setAttribute("ProgrammaControlloList", ProgrammaControlloList);
		    
		    LookupList PrincipiAdditiviList = new LookupList(db, "lookup_principi_farm_attivi_additivi");
		    context.getRequest().setAttribute("PrincipiAdditiviList", PrincipiAdditiviList);
		    
		    LookupList PrincipiAdditiviCOList = new LookupList(db, "lookup_principi_farm_attivi_additivi_carryover");
		    context.getRequest().setAttribute("PrincipiAdditiviCOList", PrincipiAdditiviCOList);
		    
		    LookupList ContaminantiList = new LookupList(db, "(select * from pnaa_get_lookup_contaminanti('"+campione.getAssignedDate()+"'))");
		    context.getRequest().setAttribute("ContaminantiList", ContaminantiList);
		    
		    LookupList LuogoPrelievoList = new LookupList(db, "lookup_luogo_prelievo");
		    context.getRequest().setAttribute("LuogoPrelievoList", LuogoPrelievoList);
		    
		    LookupList MatriceCampioneList = new LookupList(db, "lookup_matrice_campione_sinvsa_new");
		    context.getRequest().setAttribute("MatriceCampioneList", MatriceCampioneList);
		     
		    LookupList SpecieVegetaleList = new LookupList(db, "lookup_specie_vegetale_pnaa");
		    context.getRequest().setAttribute("SpecieVegetaleList", SpecieVegetaleList);
		    
		    LookupList MetodoProduzioneList = new LookupList(db, "lookup_circuito_pna");
		    context.getRequest().setAttribute("MetodoProduzioneList", MetodoProduzioneList);
		    
		    LookupList StatoProdottoList = new LookupList(db, "lookup_prodotti_pnaa");
		    context.getRequest().setAttribute("StatoProdottoList", StatoProdottoList);
		    
		    LookupList SpecieAlimentoList = new LookupList(db, "lookup_specie_alimento");
		    context.getRequest().setAttribute("SpecieAlimentoList", SpecieAlimentoList);
		    
		    LookupList PremiscelaAdditiviList = new LookupList(db, "lookup_pnaa_premiscela_additivi");
		    context.getRequest().setAttribute("PremiscelaAdditiviList", PremiscelaAdditiviList);
		    
		    LookupList MangimeCompostoList = new LookupList(db, "lookup_pnaa_mangime_composto");
		    context.getRequest().setAttribute("MangimeCompostoList", MangimeCompostoList);
		    
		    LookupList SiNoList = new LookupList(db, "lookup_pnaa_si_no");
		    context.getRequest().setAttribute("SiNoList", SiNoList);
		    
		    LookupList CampioneFinaleList = new LookupList(db, "lookup_pnaa_campione_finale");
		    context.getRequest().setAttribute("CampioneFinaleList", CampioneFinaleList);
		    
		    LookupList ConfezionamentoList = new LookupList(db, "lookup_pnaa_confezionamento");
		    context.getRequest().setAttribute("ConfezionamentoList", ConfezionamentoList);
		    
		    LookupList CgRidottoList = new LookupList(db, "lookup_pnaa_cg_ridotto");
		    context.getRequest().setAttribute("CgRidottoList", CgRidottoList);
		    
		    LookupList CgCrList = new LookupList(db, "lookup_pnaa_cg_cr");
		    context.getRequest().setAttribute("CgCrList", CgCrList);
		    
		    LookupList SequestroPartitaList = new LookupList(db, "lookup_pnaa_sequestro_partita");
		    context.getRequest().setAttribute("SequestroPartitaList", SequestroPartitaList);
		    
		    LookupList SottoprodottiList = new LookupList(db, "lookup_pnaa_categoria_sottoprodotti");
		    context.getRequest().setAttribute("SottoprodottiList", SottoprodottiList);
		    
		    ArrayList<Boolean> previstiConoscitivi = new ArrayList<Boolean>();
		    PreparedStatement pst = db.prepareStatement("select * from pnaa_previsti_conoscitivi(?)");
		    pst.setInt(1, idCampione);
		    ResultSet rs = pst.executeQuery();
		    if (rs.next()){
		    	previstiConoscitivi.add(rs.getBoolean("cromo"));
		    	previstiConoscitivi.add(rs.getBoolean("micotossine"));
		    	previstiConoscitivi.add(rs.getBoolean("nitrati"));
		    	previstiConoscitivi.add(rs.getBoolean("radionuclidi"));
		    }
		    context.getRequest().setAttribute("PrevistiConoscitivi", previstiConoscitivi);
		    
		    LookupList MicotossineList = new LookupList(db, "lookup_pnaa_micotossine");
		    context.getRequest().setAttribute("MicotossineList", MicotossineList);
			    
		}catch (Exception e) {
			e.printStackTrace();
			context.getRequest().setAttribute("Error", e);
			return ("SystemError");
		} 
		finally
		{
			this.freeConnection(context, db);
		}
		
		return "ModPnaaRev2024OK";
	}


public String executeCommandSave(ActionContext context) {
		
		int idCampione = Integer.parseInt(context.getRequest().getParameter("idCampione"));
				
		Connection db = null;
		try {
			db = this.getConnection(context);
			ModPnaa mod = new ModPnaa();
			mod.buildDaRequest(context);
			mod.setIdCampione(idCampione);
			mod.setEnteredBy(getUserId(context));
			mod.upsert(db);
			
			context.getRequest().setAttribute("idCampione", idCampione);

		}catch (Exception e) {
			e.printStackTrace();
			context.getRequest().setAttribute("Error", e);
			return ("SystemError");
		} 
		finally
		{
			this.freeConnection(context, db);
		}
		
		return executeCommandView(context);
	}




}
