/**
 * GetAllevamento_Latte_STRResponse.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package it.izs.bdn.webservices;

public class GetAllevamento_Latte_STRResponse  implements java.io.Serializable {
    private java.lang.String getAllevamento_Latte_STRResult;

    public GetAllevamento_Latte_STRResponse() {
    }

    public GetAllevamento_Latte_STRResponse(
           java.lang.String getAllevamento_Latte_STRResult) {
           this.getAllevamento_Latte_STRResult = getAllevamento_Latte_STRResult;
    }


    /**
     * Gets the getAllevamento_Latte_STRResult value for this GetAllevamento_Latte_STRResponse.
     * 
     * @return getAllevamento_Latte_STRResult
     */
    public java.lang.String getGetAllevamento_Latte_STRResult() {
        return getAllevamento_Latte_STRResult;
    }


    /**
     * Sets the getAllevamento_Latte_STRResult value for this GetAllevamento_Latte_STRResponse.
     * 
     * @param getAllevamento_Latte_STRResult
     */
    public void setGetAllevamento_Latte_STRResult(java.lang.String getAllevamento_Latte_STRResult) {
        this.getAllevamento_Latte_STRResult = getAllevamento_Latte_STRResult;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof GetAllevamento_Latte_STRResponse)) return false;
        GetAllevamento_Latte_STRResponse other = (GetAllevamento_Latte_STRResponse) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.getAllevamento_Latte_STRResult==null && other.getGetAllevamento_Latte_STRResult()==null) || 
             (this.getAllevamento_Latte_STRResult!=null &&
              this.getAllevamento_Latte_STRResult.equals(other.getGetAllevamento_Latte_STRResult())));
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
        if (getGetAllevamento_Latte_STRResult() != null) {
            _hashCode += getGetAllevamento_Latte_STRResult().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(GetAllevamento_Latte_STRResponse.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", ">getAllevamento_Latte_STRResponse"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("getAllevamento_Latte_STRResult");
        elemField.setXmlName(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", "getAllevamento_Latte_STRResult"));
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
