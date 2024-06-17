/**
 * WsAnagraficaCapoQryLocator.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package it.izs.bdn.webservices;

import org.aspcfs.modules.util.imports.ApplicationProperties;

public class WsAnagraficaCapoQryLocator extends org.apache.axis.client.Service implements it.izs.bdn.webservices.WsAnagraficaCapoQry {

/**
 * Estrazione dati anagrafici dei capi.
 */

    public WsAnagraficaCapoQryLocator() {
    }


    public WsAnagraficaCapoQryLocator(org.apache.axis.EngineConfiguration config) {
        super(config);
    }

    public WsAnagraficaCapoQryLocator(java.lang.String wsdlLoc, javax.xml.namespace.QName sName) throws javax.xml.rpc.ServiceException {
        super(wsdlLoc, sName);
    }

    // Use to get a proxy class for wsAnagraficaCapoQrySoap
    private java.lang.String wsAnagraficaCapoQrySoap_address = ApplicationProperties.getProperty("END_POINT_ANAGRAFICA_CAPO_BDN");
    //private java.lang.String wsAnagraficaCapoQrySoap_address = "http://bdrtest.izs.it/wsBDNInterrogazioni/wsAnagraficaCapoQry.asmx";

    public java.lang.String getwsAnagraficaCapoQrySoapAddress() {
        return wsAnagraficaCapoQrySoap_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String wsAnagraficaCapoQrySoapWSDDServiceName = "wsAnagraficaCapoQrySoap";

    public java.lang.String getwsAnagraficaCapoQrySoapWSDDServiceName() {
        return wsAnagraficaCapoQrySoapWSDDServiceName;
    }

    public void setwsAnagraficaCapoQrySoapWSDDServiceName(java.lang.String name) {
        wsAnagraficaCapoQrySoapWSDDServiceName = name;
    }

    public it.izs.bdn.webservices.WsAnagraficaCapoQrySoap getwsAnagraficaCapoQrySoap() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
        	
        	System.out.println("WSDL ALLEVAMENTI --> "+wsAnagraficaCapoQrySoap_address);
            endpoint = new java.net.URL(wsAnagraficaCapoQrySoap_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getwsAnagraficaCapoQrySoap(endpoint);
    }

    public it.izs.bdn.webservices.WsAnagraficaCapoQrySoap getwsAnagraficaCapoQrySoap(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            it.izs.bdn.webservices.WsAnagraficaCapoQrySoapStub _stub = new it.izs.bdn.webservices.WsAnagraficaCapoQrySoapStub(portAddress, this);
            _stub.setPortName(getwsAnagraficaCapoQrySoapWSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setwsAnagraficaCapoQrySoapEndpointAddress(java.lang.String address) {
        wsAnagraficaCapoQrySoap_address = address;
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        try {
            if (it.izs.bdn.webservices.WsAnagraficaCapoQrySoap.class.isAssignableFrom(serviceEndpointInterface)) {
                it.izs.bdn.webservices.WsAnagraficaCapoQrySoapStub _stub = new it.izs.bdn.webservices.WsAnagraficaCapoQrySoapStub(new java.net.URL(wsAnagraficaCapoQrySoap_address), this);
                _stub.setPortName(getwsAnagraficaCapoQrySoapWSDDServiceName());
                return _stub;
            }
        }
        catch (java.lang.Throwable t) {
            throw new javax.xml.rpc.ServiceException(t);
        }
        throw new javax.xml.rpc.ServiceException("There is no stub implementation for the interface:  " + (serviceEndpointInterface == null ? "null" : serviceEndpointInterface.getName()));
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(javax.xml.namespace.QName portName, Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        if (portName == null) {
            return getPort(serviceEndpointInterface);
        }
        java.lang.String inputPortName = portName.getLocalPart();
        if ("wsAnagraficaCapoQrySoap".equals(inputPortName)) {
            return getwsAnagraficaCapoQrySoap();
        }
        else  {
            java.rmi.Remote _stub = getPort(serviceEndpointInterface);
            ((org.apache.axis.client.Stub) _stub).setPortName(portName);
            return _stub;
        }
    }

    public javax.xml.namespace.QName getServiceName() {
        return new javax.xml.namespace.QName("http://bdr.izs.it/webservices", "wsAnagraficaCapoQry");
    }

    private java.util.HashSet ports = null;

    public java.util.Iterator getPorts() {
        if (ports == null) {
            ports = new java.util.HashSet();
            ports.add(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", "wsAnagraficaCapoQrySoap"));
        }
        return ports.iterator();
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(java.lang.String portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        
if ("wsAnagraficaCapoQrySoap".equals(portName)) {
            setwsAnagraficaCapoQrySoapEndpointAddress(address);
        }
        else 
{ // Unknown Port Name
            throw new javax.xml.rpc.ServiceException(" Cannot set Endpoint Address for Unknown Port" + portName);
        }
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(javax.xml.namespace.QName portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        setEndpointAddress(portName.getLocalPart(), address);
    }

}
