/**
 * FindSuiCensimenti_STRResponse.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package it.izs.bdn.webservices;

public class FindSuiCensimenti_STRResponse  implements java.io.Serializable {
    private java.lang.String findSuiCensimenti_STRResult;

    public FindSuiCensimenti_STRResponse() {
    }

    public FindSuiCensimenti_STRResponse(
           java.lang.String findSuiCensimenti_STRResult) {
           this.findSuiCensimenti_STRResult = findSuiCensimenti_STRResult;
    }


    /**
     * Gets the findSuiCensimenti_STRResult value for this FindSuiCensimenti_STRResponse.
     * 
     * @return findSuiCensimenti_STRResult
     */
    public java.lang.String getFindSuiCensimenti_STRResult() {
        return findSuiCensimenti_STRResult;
    }


    /**
     * Sets the findSuiCensimenti_STRResult value for this FindSuiCensimenti_STRResponse.
     * 
     * @param findSuiCensimenti_STRResult
     */
    public void setFindSuiCensimenti_STRResult(java.lang.String findSuiCensimenti_STRResult) {
        this.findSuiCensimenti_STRResult = findSuiCensimenti_STRResult;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof FindSuiCensimenti_STRResponse)) return false;
        FindSuiCensimenti_STRResponse other = (FindSuiCensimenti_STRResponse) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.findSuiCensimenti_STRResult==null && other.getFindSuiCensimenti_STRResult()==null) || 
             (this.findSuiCensimenti_STRResult!=null &&
              this.findSuiCensimenti_STRResult.equals(other.getFindSuiCensimenti_STRResult())));
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
        if (getFindSuiCensimenti_STRResult() != null) {
            _hashCode += getFindSuiCensimenti_STRResult().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(FindSuiCensimenti_STRResponse.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", ">FindSuiCensimenti_STRResponse"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("findSuiCensimenti_STRResult");
        elemField.setXmlName(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", "FindSuiCensimenti_STRResult"));
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
