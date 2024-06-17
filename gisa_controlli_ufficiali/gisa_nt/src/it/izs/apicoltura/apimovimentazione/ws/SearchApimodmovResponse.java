
package it.izs.apicoltura.apimovimentazione.ws;

import java.util.ArrayList;
import java.util.List;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per searchApimodmovResponse complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="searchApimodmovResponse">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="ApimodmovTO" type="{http://ws.apimovimentazione.apicoltura.izs.it/}apimodmov" maxOccurs="unbounded" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "searchApimodmovResponse", propOrder = {
    "apimodmovTO"
})
public class SearchApimodmovResponse {

    @XmlElement(name = "ApimodmovTO")
    protected List<Apimodmov> apimodmovTO;

    /**
     * Gets the value of the apimodmovTO property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the apimodmovTO property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getApimodmovTO().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link Apimodmov }
     * 
     * 
     */
    public List<Apimodmov> getApimodmovTO() {
        if (apimodmovTO == null) {
            apimodmovTO = new ArrayList<Apimodmov>();
        }
        return this.apimodmovTO;
    }

}
