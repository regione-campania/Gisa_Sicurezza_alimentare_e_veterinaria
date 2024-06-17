
package it.izs.bdn.anagrafica.ws;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per updateUnitaproduttiva complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="updateUnitaproduttiva">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="UnitaProduttivaTO" type="{http://ws.anagrafica.bdn.izs.it/}unipro"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "updateUnitaproduttiva", propOrder = {
    "unitaProduttivaTO"
})
public class UpdateUnitaproduttiva {

    @XmlElement(name = "UnitaProduttivaTO", required = true)
    protected Unipro unitaProduttivaTO;

    /**
     * Recupera il valore della proprieta unitaProduttivaTO.
     * 
     * @return
     *     possible object is
     *     {@link Unipro }
     *     
     */
    public Unipro getUnitaProduttivaTO() {
        return unitaProduttivaTO;
    }

    /**
     * Imposta il valore della proprieta unitaProduttivaTO.
     * 
     * @param value
     *     allowed object is
     *     {@link Unipro }
     *     
     */
    public void setUnitaProduttivaTO(Unipro value) {
        this.unitaProduttivaTO = value;
    }

}