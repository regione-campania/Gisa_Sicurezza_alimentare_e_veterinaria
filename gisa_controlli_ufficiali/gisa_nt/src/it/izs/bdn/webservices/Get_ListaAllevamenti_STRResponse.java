/**
 * Get_ListaAllevamenti_STRResponse.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package it.izs.bdn.webservices;

public class Get_ListaAllevamenti_STRResponse  implements java.io.Serializable {
    private java.lang.String get_ListaAllevamenti_STRResult;

    public Get_ListaAllevamenti_STRResponse() {
    }

    public Get_ListaAllevamenti_STRResponse(
           java.lang.String get_ListaAllevamenti_STRResult) {
           this.get_ListaAllevamenti_STRResult = get_ListaAllevamenti_STRResult;
    }


    /**
     * Gets the get_ListaAllevamenti_STRResult value for this Get_ListaAllevamenti_STRResponse.
     * 
     * @return get_ListaAllevamenti_STRResult
     */
    public java.lang.String getGet_ListaAllevamenti_STRResult() {
        return get_ListaAllevamenti_STRResult;
    }


    /**
     * Sets the get_ListaAllevamenti_STRResult value for this Get_ListaAllevamenti_STRResponse.
     * 
     * @param get_ListaAllevamenti_STRResult
     */
    public void setGet_ListaAllevamenti_STRResult(java.lang.String get_ListaAllevamenti_STRResult) {
        this.get_ListaAllevamenti_STRResult = get_ListaAllevamenti_STRResult;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof Get_ListaAllevamenti_STRResponse)) return false;
        Get_ListaAllevamenti_STRResponse other = (Get_ListaAllevamenti_STRResponse) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.get_ListaAllevamenti_STRResult==null && other.getGet_ListaAllevamenti_STRResult()==null) || 
             (this.get_ListaAllevamenti_STRResult!=null &&
              this.get_ListaAllevamenti_STRResult.equals(other.getGet_ListaAllevamenti_STRResult())));
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
        if (getGet_ListaAllevamenti_STRResult() != null) {
            _hashCode += getGet_ListaAllevamenti_STRResult().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(Get_ListaAllevamenti_STRResponse.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", ">Get_ListaAllevamenti_STRResponse"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("get_ListaAllevamenti_STRResult");
        elemField.setXmlName(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", "Get_ListaAllevamenti_STRResult"));
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
