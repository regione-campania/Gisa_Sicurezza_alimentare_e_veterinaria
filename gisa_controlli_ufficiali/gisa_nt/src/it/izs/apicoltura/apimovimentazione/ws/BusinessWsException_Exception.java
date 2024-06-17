
package it.izs.apicoltura.apimovimentazione.ws;

import javax.xml.ws.WebFault;


/**
 * This class was generated by the JAX-WS RI.
 * JAX-WS RI 2.2.9-b130926.1035
 * Generated source version: 2.2
 * 
 */
@WebFault(name = "BusinessFault", targetNamespace = "http://ws.apimovimentazione.apicoltura.izs.it/")
public class BusinessWsException_Exception
    extends Exception
{

    /**
     * Java type that goes as soapenv:Fault detail element.
     * 
     */
    private BusinessWsException faultInfo;

    /**
     * 
     * @param faultInfo
     * @param message
     */
    public BusinessWsException_Exception(String message, BusinessWsException faultInfo) {
        super(message);
        this.faultInfo = faultInfo;
    }

    /**
     * 
     * @param faultInfo
     * @param cause
     * @param message
     */
    public BusinessWsException_Exception(String message, BusinessWsException faultInfo, Throwable cause) {
        super(message, cause);
        this.faultInfo = faultInfo;
    }

    /**
     * 
     * @return
     *     returns fault bean: it.izs.apicoltura.apimovimentazione.ws.BusinessWsException
     */
    public BusinessWsException getFaultInfo() {
        return faultInfo;
    }

}
