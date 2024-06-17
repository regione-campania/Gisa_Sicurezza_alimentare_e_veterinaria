
package it.izs.ws; 

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlSchemaType;
import javax.xml.bind.annotation.XmlSeeAlso;
import javax.xml.bind.annotation.XmlType;
import javax.xml.datatype.XMLGregorianCalendar;


/**
 * <p>Classe Java per checklistsicurezzaalimentareTO complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="checklistsicurezzaalimentareTO">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="caId" type="{http://www.w3.org/2001/XMLSchema}int" minOccurs="0"/>
 *         &lt;element name="clsaId" type="{http://www.w3.org/2001/XMLSchema}int" minOccurs="0"/>
 *         &lt;element name="dataScadPrescrizioni" type="{http://www.w3.org/2001/XMLSchema}dateTime" minOccurs="0"/>
 *         &lt;element name="dataVerificaSa" type="{http://www.w3.org/2001/XMLSchema}dateTime" minOccurs="0"/>
 *         &lt;element name="flagCopiaCheckList" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="flagPrescrizioneEsitoSa" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="prescrizioni" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="requisitiXml" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="secondoControllore" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "checklistsicurezzaalimentareSA_TO", propOrder = {
    "clsaId", 
    "dataScadPrescrizioni", 
    "dataVerificaSa",
    "flagCopiaCheckList", 
    "flagPrescrizioneEsitoSa", 
    "prescrizioni", 
    "requisitiXml",
    "secondoControllore" ,
    "parametro",
    "critCodice",
    "criterioControlloAltro",
    "numCapiPresenti",
    "numCapiControllati",
    "nomeRappresentante",
    "note",
    "flagIntenzionalitaSa",
    "flagIntenzionalitaTse",
    "prescrizioni2",
    "dataScadPrescrizioni2",
    "nomeRappresentanteVer",
    "flagPrescrizioneEsitoSa2",
    "dataVerificaSa2",
    "secondoControllore2",
    "nomeRappresentanteVer2"
})
@XmlSeeAlso({
    ChecklistsicurezzaalimentareWsTO.class
})
public class ChecklistsicurezzaalimentareSA_TO {

    protected Integer clsaId;
    @XmlSchemaType(name = "dateTime")
    protected XMLGregorianCalendar dataScadPrescrizioni;
    @XmlSchemaType(name = "dateTime")
    protected XMLGregorianCalendar dataVerificaSa;
    protected String flagCopiaCheckList;
    protected String flagPrescrizioneEsitoSa;
    protected String prescrizioni;
    protected String requisitiXml;
    protected String secondoControllore;
    
    protected String parametro;
    protected String critCodice;
    protected String criterioControlloAltro;
    protected String numCapiPresenti;
    protected String numCapiControllati;
    protected String nomeRappresentante;
    protected String note;
    protected String flagIntenzionalitaSa;
    protected String flagIntenzionalitaTse;
    protected String prescrizioni2;
    @XmlSchemaType(name = "dateTime")
    protected XMLGregorianCalendar dataScadPrescrizioni2;
    protected String nomeRappresentanteVer;
    protected String flagPrescrizioneEsitoSa2;
    @XmlSchemaType(name = "dateTime")
    protected XMLGregorianCalendar dataVerificaSa2;
    protected String secondoControllore2;
    protected String nomeRappresentanteVer2;
  

    /**
     * Recupera il valore della proprieta clsaId.
     * 
     * @return
     *     possible object is
     *     {@link Integer }
     *     
     */
    public Integer getClsaId() {
        return clsaId;
    }

    /**
     * Imposta il valore della proprieta clsaId.
     * 
     * @param value
     *     allowed object is
     *     {@link Integer }
     *     
     */
    public void setClsaId(Integer value) {
        this.clsaId = value;
    }

    /**
     * Recupera il valore della proprieta dataScadPrescrizioni.
     * 
     * @return
     *     possible object is
     *     {@link XMLGregorianCalendar }
     *     
     */
    public XMLGregorianCalendar getDataScadPrescrizioni() {
        return dataScadPrescrizioni;
    }

    /**
     * Imposta il valore della proprieta dataScadPrescrizioni.
     * 
     * @param value
     *     allowed object is
     *     {@link XMLGregorianCalendar }
     *     
     */
    public void setDataScadPrescrizioni(XMLGregorianCalendar value) {
        this.dataScadPrescrizioni = value;
    }

    /**
     * Recupera il valore della proprieta dataVerificaSa.
     * 
     * @return
     *     possible object is
     *     {@link XMLGregorianCalendar }
     *     
     */
    public XMLGregorianCalendar getDataVerificaSa() {
        return dataVerificaSa;
    }

    /**
     * Imposta il valore della proprieta dataVerificaSa.
     * 
     * @param value
     *     allowed object is
     *     {@link XMLGregorianCalendar }
     *     
     */
    public void setDataVerificaSa(XMLGregorianCalendar value) {
        this.dataVerificaSa = value;
    }

    /**
     * Recupera il valore della proprieta flagCopiaCheckList.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getFlagCopiaCheckList() {
        return flagCopiaCheckList;
    }

    /**
     * Imposta il valore della proprieta flagCopiaCheckList.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setFlagCopiaCheckList(String value) {
        this.flagCopiaCheckList = value;
    }

    /**
     * Recupera il valore della proprieta flagPrescrizioneEsitoSa.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getFlagPrescrizioneEsitoSa() {
        return flagPrescrizioneEsitoSa;
    }

    /**
     * Imposta il valore della proprieta flagPrescrizioneEsitoSa.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setFlagPrescrizioneEsitoSa(String value) {
        this.flagPrescrizioneEsitoSa = value;
    }

    /**
     * Recupera il valore della proprieta prescrizioni.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPrescrizioni() {
        return prescrizioni;
    }

    /**
     * Imposta il valore della proprieta prescrizioni.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPrescrizioni(String value) {
        this.prescrizioni = value;
    }

    /**
     * Recupera il valore della proprieta requisitiXml.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getRequisitiXml() {
        return requisitiXml;
    }

    /**
     * Imposta il valore della proprieta requisitiXml.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setRequisitiXml(String value) {
        this.requisitiXml = value;
    }

    /**
     * Recupera il valore della proprieta secondoControllore.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSecondoControllore() {
        return secondoControllore;
    }

    /**
     * Imposta il valore della proprieta secondoControllore.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSecondoControllore(String value) {
        this.secondoControllore = value;
    }

	public String getParametro() {
		return parametro;
	}

	public void setParametro(String parametro) {
		this.parametro = parametro;
	}

	public String getCritCodice() {
		return critCodice;
	}

	public void setCritCodice(String critCodice) {
		this.critCodice = critCodice;
	}

	public String getCriterioControlloAltro() {
		return criterioControlloAltro;
	}

	public void setCriterioControlloAltro(String criterioControlloAltro) {
		this.criterioControlloAltro = criterioControlloAltro;
	}

	public String getNumCapiPresenti() {
		return numCapiPresenti;
	}

	public void setNumCapiPresenti(String numCapiPresenti) {
		this.numCapiPresenti = numCapiPresenti;
	}

	public String getNumCapiControllati() {
		return numCapiControllati;
	}

	public void setNumCapiControllati(String numCapiControllati) {
		this.numCapiControllati = numCapiControllati;
	}

	public String getNomeRappresentante() {
		return nomeRappresentante;
	}

	public void setNomeRappresentante(String nomeRappresentante) {
		this.nomeRappresentante = nomeRappresentante;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public String getFlagIntenzionalitaSa() {
		return flagIntenzionalitaSa;
	}

	public void setFlagIntenzionalitaSa(String flagIntenzionalitaSa) {
		this.flagIntenzionalitaSa = flagIntenzionalitaSa;
	}

	public String getFlagIntenzionalitaTse() {
		return flagIntenzionalitaTse;
	}

	public void setFlagIntenzionalitaTse(String flagIntenzionalitaTse) {
		this.flagIntenzionalitaTse = flagIntenzionalitaTse;
	}

	public String getPrescrizioni2() {
		return prescrizioni2;
	}

	public void setPrescrizioni2(String prescrizioni2) {
		this.prescrizioni2 = prescrizioni2;
	}

	public XMLGregorianCalendar getDataScadPrescrizioni2() {
		return dataScadPrescrizioni2;
	}

	public void setDataScadPrescrizioni2(XMLGregorianCalendar dataScadPrescrizioni2) {
		this.dataScadPrescrizioni2 = dataScadPrescrizioni2;
	}

	public String getNomeRappresentanteVer() {
		return nomeRappresentanteVer;
	}

	public void setNomeRappresentanteVer(String nomeRappresentanteVer) {
		this.nomeRappresentanteVer = nomeRappresentanteVer;
	}

	public String getFlagPrescrizioneEsitoSa2() {
		return flagPrescrizioneEsitoSa2;
	}

	public void setFlagPrescrizioneEsitoSa2(String flagPrescrizioneEsitoSa2) {
		this.flagPrescrizioneEsitoSa2 = flagPrescrizioneEsitoSa2;
	}

	public XMLGregorianCalendar getDataVerificaSa2() {
		return dataVerificaSa2;
	}

	public void setDataVerificaSa2(XMLGregorianCalendar dataVerificaSa2) {
		this.dataVerificaSa2 = dataVerificaSa2;
	}

	public String getSecondoControllore2() {
		return secondoControllore2;
	}

	public void setSecondoControllore2(String secondoControllore2) {
		this.secondoControllore2 = secondoControllore2;
	}

	public String getNomeRappresentanteVer2() {
		return nomeRappresentanteVer2;
	}

	public void setNomeRappresentanteVer2(String nomeRappresentanteVer2) {
		this.nomeRappresentanteVer2 = nomeRappresentanteVer2;
	}

}
