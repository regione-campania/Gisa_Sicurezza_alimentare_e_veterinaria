/**
 * GetInfoAllevamento_STRResponse.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package it.izs.bdn.webservices;

public class GetInfoAllevamento_STRResponse  implements java.io.Serializable {
    private java.lang.String getInfoAllevamento_STRResult;

    public GetInfoAllevamento_STRResponse() {
    }

    public GetInfoAllevamento_STRResponse(
           java.lang.String getInfoAllevamento_STRResult) {
           this.getInfoAllevamento_STRResult = getInfoAllevamento_STRResult;
    }


    /**
     * Gets the getInfoAllevamento_STRResult value for this GetInfoAllevamento_STRResponse.
     * 
     * @return getInfoAllevamento_STRResult
     */
    public java.lang.String getGetInfoAllevamento_STRResult() {
        return getInfoAllevamento_STRResult;
    }


    /**
     * Sets the getInfoAllevamento_STRResult value for this GetInfoAllevamento_STRResponse.
     * 
     * @param getInfoAllevamento_STRResult
     */
    public void setGetInfoAllevamento_STRResult(java.lang.String getInfoAllevamento_STRResult) {
        this.getInfoAllevamento_STRResult = getInfoAllevamento_STRResult;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof GetInfoAllevamento_STRResponse)) return false;
        GetInfoAllevamento_STRResponse other = (GetInfoAllevamento_STRResponse) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.getInfoAllevamento_STRResult==null && other.getGetInfoAllevamento_STRResult()==null) || 
             (this.getInfoAllevamento_STRResult!=null &&
              this.getInfoAllevamento_STRResult.equals(other.getGetInfoAllevamento_STRResult())));
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
        if (getGetInfoAllevamento_STRResult() != null) {
            _hashCode += getGetInfoAllevamento_STRResult().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(GetInfoAllevamento_STRResponse.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", ">getInfoAllevamento_STRResponse"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("getInfoAllevamento_STRResult");
        elemField.setXmlName(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", "getInfoAllevamento_STRResult"));
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
