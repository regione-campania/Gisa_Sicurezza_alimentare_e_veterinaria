/**
 * GetInfoCapiAllevamento_STRResponse.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package it.izs.bdn.webservices;

public class GetInfoCapiAllevamento_STRResponse  implements java.io.Serializable {
    private java.lang.String getInfoCapiAllevamento_STRResult;

    public GetInfoCapiAllevamento_STRResponse() {
    }

    public GetInfoCapiAllevamento_STRResponse(
           java.lang.String getInfoCapiAllevamento_STRResult) {
           this.getInfoCapiAllevamento_STRResult = getInfoCapiAllevamento_STRResult;
    }


    /**
     * Gets the getInfoCapiAllevamento_STRResult value for this GetInfoCapiAllevamento_STRResponse.
     * 
     * @return getInfoCapiAllevamento_STRResult
     */
    public java.lang.String getGetInfoCapiAllevamento_STRResult() {
        return getInfoCapiAllevamento_STRResult;
    }


    /**
     * Sets the getInfoCapiAllevamento_STRResult value for this GetInfoCapiAllevamento_STRResponse.
     * 
     * @param getInfoCapiAllevamento_STRResult
     */
    public void setGetInfoCapiAllevamento_STRResult(java.lang.String getInfoCapiAllevamento_STRResult) {
        this.getInfoCapiAllevamento_STRResult = getInfoCapiAllevamento_STRResult;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof GetInfoCapiAllevamento_STRResponse)) return false;
        GetInfoCapiAllevamento_STRResponse other = (GetInfoCapiAllevamento_STRResponse) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.getInfoCapiAllevamento_STRResult==null && other.getGetInfoCapiAllevamento_STRResult()==null) || 
             (this.getInfoCapiAllevamento_STRResult!=null &&
              this.getInfoCapiAllevamento_STRResult.equals(other.getGetInfoCapiAllevamento_STRResult())));
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
        if (getGetInfoCapiAllevamento_STRResult() != null) {
            _hashCode += getGetInfoCapiAllevamento_STRResult().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(GetInfoCapiAllevamento_STRResponse.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", ">getInfoCapiAllevamento_STRResponse"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("getInfoCapiAllevamento_STRResult");
        elemField.setXmlName(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", "getInfoCapiAllevamento_STRResult"));
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
