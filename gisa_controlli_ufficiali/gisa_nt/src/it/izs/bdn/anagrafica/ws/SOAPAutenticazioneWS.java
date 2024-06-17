
package it.izs.bdn.anagrafica.ws;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per SOAPAutenticazioneWS complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="SOAPAutenticazioneWS">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="username" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *         &lt;element name="password" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *         &lt;element name="ruoloCodice" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *         &lt;element name="ruoloValoreCodice" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "SOAPAutenticazioneWS", propOrder = {
    "username",
    "password",
    "ruoloCodice",
    "ruoloValoreCodice"
})
public class SOAPAutenticazioneWS {

    @XmlElement(required = true)
    protected String username;
    @XmlElement(required = true)
    protected String password;
    @XmlElement(required = true)
    protected String ruoloCodice;
    @XmlElement(required = true)
    protected String ruoloValoreCodice;

    /**
     * Recupera il valore della proprieta username.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getUsername() {
        return username;
    }

    /**
     * Imposta il valore della proprieta username.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setUsername(String value) {
        this.username = value;
    }

    /**
     * Recupera il valore della proprieta password.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPassword() {
        return password;
    }

    /**
     * Imposta il valore della proprieta password.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPassword(String value) {
        this.password = value;
    }

    /**
     * Recupera il valore della proprieta ruoloCodice.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getRuoloCodice() {
        return ruoloCodice;
    }

    /**
     * Imposta il valore della proprieta ruoloCodice.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setRuoloCodice(String value) {
        this.ruoloCodice = value;
    }

    /**
     * Recupera il valore della proprieta ruoloValoreCodice.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getRuoloValoreCodice() {
        return ruoloValoreCodice;
    }

    /**
     * Imposta il valore della proprieta ruoloValoreCodice.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setRuoloValoreCodice(String value) {
        this.ruoloValoreCodice = value;
    }

}
