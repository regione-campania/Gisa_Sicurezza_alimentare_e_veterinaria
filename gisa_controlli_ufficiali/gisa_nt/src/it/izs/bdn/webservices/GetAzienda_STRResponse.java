/**
 * GetAzienda_STRResponse.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package it.izs.bdn.webservices;

public class GetAzienda_STRResponse  implements java.io.Serializable {
    private java.lang.String getAzienda_STRResult;

    public GetAzienda_STRResponse() {
    }

    public GetAzienda_STRResponse(
           java.lang.String getAzienda_STRResult) {
           this.getAzienda_STRResult = getAzienda_STRResult;
    }


    /**
     * Gets the getAzienda_STRResult value for this GetAzienda_STRResponse.
     * 
     * @return getAzienda_STRResult
     */
    public java.lang.String getGetAzienda_STRResult() {
        return getAzienda_STRResult;
    }


    /**
     * Sets the getAzienda_STRResult value for this GetAzienda_STRResponse.
     * 
     * @param getAzienda_STRResult
     */
    public void setGetAzienda_STRResult(java.lang.String getAzienda_STRResult) {
        this.getAzienda_STRResult = getAzienda_STRResult;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof GetAzienda_STRResponse)) return false;
        GetAzienda_STRResponse other = (GetAzienda_STRResponse) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.getAzienda_STRResult==null && other.getGetAzienda_STRResult()==null) || 
             (this.getAzienda_STRResult!=null &&
              this.getAzienda_STRResult.equals(other.getGetAzienda_STRResult())));
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
        if (getGetAzienda_STRResult() != null) {
            _hashCode += getGetAzienda_STRResult().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(GetAzienda_STRResponse.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", ">getAzienda_STRResponse"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("getAzienda_STRResult");
        elemField.setXmlName(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", "getAzienda_STRResult"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
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
