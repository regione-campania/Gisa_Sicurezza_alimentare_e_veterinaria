/**
 * FindOviCensimenti_STRResponse.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package it.izs.bdn.webservices;

public class FindOviCensimenti_STRResponse  implements java.io.Serializable {
    private java.lang.String findOviCensimenti_STRResult;

    public FindOviCensimenti_STRResponse() {
    }

    public FindOviCensimenti_STRResponse(
           java.lang.String findOviCensimenti_STRResult) {
           this.findOviCensimenti_STRResult = findOviCensimenti_STRResult;
    }


    /**
     * Gets the findOviCensimenti_STRResult value for this FindOviCensimenti_STRResponse.
     * 
     * @return findOviCensimenti_STRResult
     */
    public java.lang.String getFindOviCensimenti_STRResult() {
        return findOviCensimenti_STRResult;
    }


    /**
     * Sets the findOviCensimenti_STRResult value for this FindOviCensimenti_STRResponse.
     * 
     * @param findOviCensimenti_STRResult
     */
    public void setFindOviCensimenti_STRResult(java.lang.String findOviCensimenti_STRResult) {
        this.findOviCensimenti_STRResult = findOviCensimenti_STRResult;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof FindOviCensimenti_STRResponse)) return false;
        FindOviCensimenti_STRResponse other = (FindOviCensimenti_STRResponse) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.findOviCensimenti_STRResult==null && other.getFindOviCensimenti_STRResult()==null) || 
             (this.findOviCensimenti_STRResult!=null &&
              this.findOviCensimenti_STRResult.equals(other.getFindOviCensimenti_STRResult())));
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
        if (getFindOviCensimenti_STRResult() != null) {
            _hashCode += getFindOviCensimenti_STRResult().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(FindOviCensimenti_STRResponse.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", ">FindOviCensimenti_STRResponse"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("findOviCensimenti_STRResult");
        elemField.setXmlName(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", "FindOviCensimenti_STRResult"));
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
