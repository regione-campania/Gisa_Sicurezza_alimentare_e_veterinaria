/**
 * FindControlli_Allevamento_STRResponse.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package it.izs.bdn.webservices;

public class FindControlli_Allevamento_STRResponse  implements java.io.Serializable {
    private java.lang.String findControlli_Allevamento_STRResult;

    public FindControlli_Allevamento_STRResponse() {
    }

    public FindControlli_Allevamento_STRResponse(
           java.lang.String findControlli_Allevamento_STRResult) {
           this.findControlli_Allevamento_STRResult = findControlli_Allevamento_STRResult;
    }


    /**
     * Gets the findControlli_Allevamento_STRResult value for this FindControlli_Allevamento_STRResponse.
     * 
     * @return findControlli_Allevamento_STRResult
     */
    public java.lang.String getFindControlli_Allevamento_STRResult() {
        return findControlli_Allevamento_STRResult;
    }


    /**
     * Sets the findControlli_Allevamento_STRResult value for this FindControlli_Allevamento_STRResponse.
     * 
     * @param findControlli_Allevamento_STRResult
     */
    public void setFindControlli_Allevamento_STRResult(java.lang.String findControlli_Allevamento_STRResult) {
        this.findControlli_Allevamento_STRResult = findControlli_Allevamento_STRResult;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof FindControlli_Allevamento_STRResponse)) return false;
        FindControlli_Allevamento_STRResponse other = (FindControlli_Allevamento_STRResponse) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.findControlli_Allevamento_STRResult==null && other.getFindControlli_Allevamento_STRResult()==null) || 
             (this.findControlli_Allevamento_STRResult!=null &&
              this.findControlli_Allevamento_STRResult.equals(other.getFindControlli_Allevamento_STRResult())));
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
        if (getFindControlli_Allevamento_STRResult() != null) {
            _hashCode += getFindControlli_Allevamento_STRResult().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(FindControlli_Allevamento_STRResponse.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", ">FindControlli_Allevamento_STRResponse"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("findControlli_Allevamento_STRResult");
        elemField.setXmlName(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", "FindControlli_Allevamento_STRResult"));
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
