package it.izs.bdn.anagrafica.ws;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per insertPersoneResponse complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="insertPersoneResponse">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="PersoneTO" type="{http://ws.apianagrafica.apicoltura.izs.it/}persone" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "insertApistoproResponse", propOrder = {
    "storicoProprietarioTO"
})
public class InsertApistoproResponse {

    @XmlElement(name = "StoricoProprietarioTO")
    protected Apistopro storicoProprietarioTO;

    /**
     * Recupera il valore della proprieta personeTO.
     * 
     * @return
     *     possible object is
     *     {@link Persone }
     *     
     */
    public Apistopro getStoricoProprietarioTO() {
        return storicoProprietarioTO;
    }

    /**
     * Imposta il valore della proprieta personeTO.
     * 
     * @param value
     *     allowed object is
     *     {@link Persone }
     *     
     */
    public void setStoricoProprietarioTO(Apistopro value) {
        this.storicoProprietarioTO = value;
    }

}
