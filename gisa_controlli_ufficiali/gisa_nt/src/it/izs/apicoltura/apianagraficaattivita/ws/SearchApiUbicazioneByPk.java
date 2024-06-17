
package it.izs.apicoltura.apianagraficaattivita.ws;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per searchApiUbicazioneByPk complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="searchApiUbicazioneByPk">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="apiubiId" type="{http://www.w3.org/2001/XMLSchema}long"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "searchApiUbicazioneByPk", propOrder = {
    "apiubiId"
})
public class SearchApiUbicazioneByPk {

    protected long apiubiId;

    /**
     * Recupera il valore della proprieta apiubiId.
     * 
     */
    public long getApiubiId() {
        return apiubiId;
    }

    /**
     * Imposta il valore della proprieta apiubiId.
     * 
     */
    public void setApiubiId(long value) {
        this.apiubiId = value;
    }

}
