/**
 * GetCapoMacellatoResponse.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package it.izs.bdn.webservices;

public class GetCapoMacellatoResponse  implements java.io.Serializable {
    private it.izs.bdn.webservices.GetCapoMacellatoResponseGetCapoMacellatoResult getCapoMacellatoResult;

    public GetCapoMacellatoResponse() {
    }

    public GetCapoMacellatoResponse(
           it.izs.bdn.webservices.GetCapoMacellatoResponseGetCapoMacellatoResult getCapoMacellatoResult) {
           this.getCapoMacellatoResult = getCapoMacellatoResult;
    }


    /**
     * Gets the getCapoMacellatoResult value for this GetCapoMacellatoResponse.
     * 
     * @return getCapoMacellatoResult
     */
    public it.izs.bdn.webservices.GetCapoMacellatoResponseGetCapoMacellatoResult getGetCapoMacellatoResult() {
        return getCapoMacellatoResult;
    }


    /**
     * Sets the getCapoMacellatoResult value for this GetCapoMacellatoResponse.
     * 
     * @param getCapoMacellatoResult
     */
    public void setGetCapoMacellatoResult(it.izs.bdn.webservices.GetCapoMacellatoResponseGetCapoMacellatoResult getCapoMacellatoResult) {
        this.getCapoMacellatoResult = getCapoMacellatoResult;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof GetCapoMacellatoResponse)) return false;
        GetCapoMacellatoResponse other = (GetCapoMacellatoResponse) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.getCapoMacellatoResult==null && other.getGetCapoMacellatoResult()==null) || 
             (this.getCapoMacellatoResult!=null &&
              this.getCapoMacellatoResult.equals(other.getGetCapoMacellatoResult())));
        __equalsCalc = null;
        return _equals;
    }

    private boolean __hashCodeCalc = false;
    public synchronized int hashCode() {
        if (__hashCodeCalc) {
            return 0;
        }
        __hashCodeCalc = true;
        int _hashCode = 1;
        if (getGetCapoMacellatoResult() != null) {
            _hashCode += getGetCapoMacellatoResult().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(GetCapoMacellatoResponse.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", ">getCapoMacellatoResponse"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("getCapoMacellatoResult");
        elemField.setXmlName(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", "getCapoMacellatoResult"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", ">>getCapoMacellatoResponse>getCapoMacellatoResult"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
    }

    /**
     * Return type metadata object
     */
    public static org.apache.axis.description.TypeDesc getTypeDesc() {
        return typeDesc;
    }

    /**
     * Get Custom Serializer
     */
    public static org.apache.axis.encoding.Serializer getSerializer(
           java.lang.String mechType, 
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType) {
        return 
          new  org.apache.axis.encoding.ser.BeanSerializer(
            _javaType, _xmlType, typeDesc);
    }

    /**
     * Get Custom Deserializer
     */
    public static org.apache.axis.encoding.Deserializer getDeserializer(
           java.lang.String mechType, 
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType) {
        return 
          new  org.apache.axis.encoding.ser.BeanDeserializer(
            _javaType, _xmlType, typeDesc);
    }

}
