package org.aspcfs.modules.izsmibr.service;

public class WsPianoIBRSoapProxy implements org.aspcfs.modules.izsmibr.service.WsPianoIBRSoap {
  private String _endpoint = null;
  private org.aspcfs.modules.izsmibr.service.WsPianoIBRSoap wsPianoIBRSoap = null;
  
  public WsPianoIBRSoapProxy() {
    _initWsPianoIBRSoapProxy();
  }
  
  public WsPianoIBRSoapProxy(String endpoint) {
    _endpoint = endpoint;
    _initWsPianoIBRSoapProxy();
  }
  
  private void _initWsPianoIBRSoapProxy() {
    try {
      wsPianoIBRSoap = (new org.aspcfs.modules.izsmibr.service.WsPianoIBRLocator()).getwsPianoIBRSoap();
      if (wsPianoIBRSoap != null) {
        if (_endpoint != null)
          ((javax.xml.rpc.Stub)wsPianoIBRSoap)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
        else
          _endpoint = (String)((javax.xml.rpc.Stub)wsPianoIBRSoap)._getProperty("javax.xml.rpc.service.endpoint.address");
      }
      
    }
    catch (javax.xml.rpc.ServiceException serviceException) {}
  }
  
  public String getEndpoint() {
    return _endpoint;
  }
  
  public void setEndpoint(String endpoint) {
    _endpoint = endpoint;
    if (wsPianoIBRSoap != null)
      ((javax.xml.rpc.Stub)wsPianoIBRSoap)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
    
  }
  
  public org.aspcfs.modules.izsmibr.service.WsPianoIBRSoap getWsPianoIBRSoap() {
    if (wsPianoIBRSoap == null)
      _initWsPianoIBRSoapProxy();
    return wsPianoIBRSoap;
  }
  
  public java.lang.String insertEsitoPrelievoIBR_STR(java.lang.String strRecord) throws java.rmi.RemoteException{
    if (wsPianoIBRSoap == null)
      _initWsPianoIBRSoapProxy();
    return wsPianoIBRSoap.insertEsitoPrelievoIBR_STR(strRecord);
  }
  
  public org.aspcfs.modules.izsmibr.service.InsertEsitoPrelievoIBRResponseInsertEsitoPrelievoIBRResult insertEsitoPrelievoIBR(java.lang.String strRecord) throws java.rmi.RemoteException{
    if (wsPianoIBRSoap == null)
      _initWsPianoIBRSoapProxy();
    return wsPianoIBRSoap.insertEsitoPrelievoIBR(strRecord);
  }
  
  
}