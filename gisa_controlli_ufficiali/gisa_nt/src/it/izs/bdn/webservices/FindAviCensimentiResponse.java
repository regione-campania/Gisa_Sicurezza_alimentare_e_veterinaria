/**
 * FindAviCensimentiResponse.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package it.izs.bdn.webservices;

public class FindAviCensimentiResponse  implements java.io.Serializable {
    private it.izs.bdn.webservices.FindAviCensimentiResponseFindAviCensimentiResult findAviCensimentiResult;

    public FindAviCensimentiResponse() {
    }

    public FindAviCensimentiResponse(
           it.izs.bdn.webservices.FindAviCensimentiResponseFindAviCensimentiResult findAviCensimentiResult) {
           this.findAviCensimentiResult = findAviCensimentiResult;
    }


    /**
     * Gets the findAviCensimentiResult value for this FindAviCensimentiResponse.
     * 
     * @return findAviCensimentiResult
     */
    public it.izs.bdn.webservices.FindAviCensimentiResponseFindAviCensimentiResult getFindAviCensimentiResult() {
        return findAviCensimentiResult;
    }


    /**
     * Sets the findAviCensimentiResult value for this FindAviCensimentiResponse.
     * 
     * @param findAviCensimentiResult
     */
    public void setFindAviCensimentiResult(it.izs.bdn.webservices.FindAviCensimentiResponseFindAviCensimentiResult findAviCensimentiResult) {
        this.findAviCensimentiResult = findAviCensimentiResult;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof FindAviCensimentiResponse)) return false;
        FindAviCensimentiResponse other = (FindAviCensimentiResponse) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.findAviCensimentiResult==null && other.getFindAviCensimentiResult()==null) || 
             (this.findAviCensimentiResult!=null &&
              this.findAviCensimentiResult.equals(other.getFindAviCensimentiResult())));
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
        if (getFindAviCensimentiResult() != null) {
            _hashCode += getFindAviCensimentiResult().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(FindAviCensimentiResponse.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", ">FindAviCensimentiResponse"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("findAviCensimentiResult");
        elemField.setXmlName(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", "FindAviCensimentiResult"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", ">>FindAviCensimentiResponse>FindAviCensimentiResult"));
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
