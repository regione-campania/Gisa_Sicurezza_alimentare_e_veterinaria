/**
 * FindAllev_Tipologie_Prod_STRResponse.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package it.izs.bdn.webservices;

public class FindAllev_Tipologie_Prod_STRResponse  implements java.io.Serializable {
    private java.lang.String findAllev_Tipologie_Prod_STRResult;

    public FindAllev_Tipologie_Prod_STRResponse() {
    }

    public FindAllev_Tipologie_Prod_STRResponse(
           java.lang.String findAllev_Tipologie_Prod_STRResult) {
           this.findAllev_Tipologie_Prod_STRResult = findAllev_Tipologie_Prod_STRResult;
    }


    /**
     * Gets the findAllev_Tipologie_Prod_STRResult value for this FindAllev_Tipologie_Prod_STRResponse.
     * 
     * @return findAllev_Tipologie_Prod_STRResult
     */
    public java.lang.String getFindAllev_Tipologie_Prod_STRResult() {
        return findAllev_Tipologie_Prod_STRResult;
    }


    /**
     * Sets the findAllev_Tipologie_Prod_STRResult value for this FindAllev_Tipologie_Prod_STRResponse.
     * 
     * @param findAllev_Tipologie_Prod_STRResult
     */
    public void setFindAllev_Tipologie_Prod_STRResult(java.lang.String findAllev_Tipologie_Prod_STRResult) {
        this.findAllev_Tipologie_Prod_STRResult = findAllev_Tipologie_Prod_STRResult;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof FindAllev_Tipologie_Prod_STRResponse)) return false;
        FindAllev_Tipologie_Prod_STRResponse other = (FindAllev_Tipologie_Prod_STRResponse) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.findAllev_Tipologie_Prod_STRResult==null && other.getFindAllev_Tipologie_Prod_STRResult()==null) || 
             (this.findAllev_Tipologie_Prod_STRResult!=null &&
              this.findAllev_Tipologie_Prod_STRResult.equals(other.getFindAllev_Tipologie_Prod_STRResult())));
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
        if (getFindAllev_Tipologie_Prod_STRResult() != null) {
            _hashCode += getFindAllev_Tipologie_Prod_STRResult().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(FindAllev_Tipologie_Prod_STRResponse.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", ">FindAllev_Tipologie_Prod_STRResponse"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("findAllev_Tipologie_Prod_STRResult");
        elemField.setXmlName(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", "FindAllev_Tipologie_Prod_STRResult"));
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
