
package it.izs.apicoltura.apianagraficaattivita.ws;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per searchStoricoDetentoreByPkResponse complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="searchStoricoDetentoreByPkResponse">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="StoricoDetentoreTO" type="{http://ws.apianagrafica.apicoltura.izs.it/}apistodet" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "searchStoricoDetentoreByPkResponse", propOrder = {
    "storicoDetentoreTO"
})
public class SearchStoricoDetentoreByPkResponse {

    @XmlElement(name = "StoricoDetentoreTO")
    protected Apistodet storicoDetentoreTO;

    /**
     * Recupera il valore della proprieta storicoDetentoreTO.
     * 
     * @return
     *     possible object is
     *     {@link Apistodet }
     *     
     */
    public Apistodet getStoricoDetentoreTO() {
        return storicoDetentoreTO;
    }

    /**
     * Imposta il valore della proprieta storicoDetentoreTO.
     * 
     * @param value
     *     allowed object is
     *     {@link Apistodet }
     *     
     */
    public void setStoricoDetentoreTO(Apistodet value) {
        this.storicoDetentoreTO = value;
    }

}
