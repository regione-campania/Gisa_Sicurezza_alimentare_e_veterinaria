/**
 * Get_Capi_Allevamento_Cod_STRResponse.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package it.izs.bdn.webservices;

public class Get_Capi_Allevamento_Cod_STRResponse  implements java.io.Serializable {
    private java.lang.String get_Capi_Allevamento_Cod_STRResult;

    public Get_Capi_Allevamento_Cod_STRResponse() {
    }

    public Get_Capi_Allevamento_Cod_STRResponse(
           java.lang.String get_Capi_Allevamento_Cod_STRResult) {
           this.get_Capi_Allevamento_Cod_STRResult = get_Capi_Allevamento_Cod_STRResult;
    }


    /**
     * Gets the get_Capi_Allevamento_Cod_STRResult value for this Get_Capi_Allevamento_Cod_STRResponse.
     * 
     * @return get_Capi_Allevamento_Cod_STRResult
     */
    public java.lang.String getGet_Capi_Allevamento_Cod_STRResult() {
        return get_Capi_Allevamento_Cod_STRResult;
    }


    /**
     * Sets the get_Capi_Allevamento_Cod_STRResult value for this Get_Capi_Allevamento_Cod_STRResponse.
     * 
     * @param get_Capi_Allevamento_Cod_STRResult
     */
    public void setGet_Capi_Allevamento_Cod_STRResult(java.lang.String get_Capi_Allevamento_Cod_STRResult) {
        this.get_Capi_Allevamento_Cod_STRResult = get_Capi_Allevamento_Cod_STRResult;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof Get_Capi_Allevamento_Cod_STRResponse)) return false;
        Get_Capi_Allevamento_Cod_STRResponse other = (Get_Capi_Allevamento_Cod_STRResponse) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.get_Capi_Allevamento_Cod_STRResult==null && other.getGet_Capi_Allevamento_Cod_STRResult()==null) || 
             (this.get_Capi_Allevamento_Cod_STRResult!=null &&
              this.get_Capi_Allevamento_Cod_STRResult.equals(other.getGet_Capi_Allevamento_Cod_STRResult())));
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
        if (getGet_Capi_Allevamento_Cod_STRResult() != null) {
            _hashCode += getGet_Capi_Allevamento_Cod_STRResult().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(Get_Capi_Allevamento_Cod_STRResponse.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", ">Get_Capi_Allevamento_Cod_STRResponse"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("get_Capi_Allevamento_Cod_STRResult");
        elemField.setXmlName(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", "Get_Capi_Allevamento_Cod_STRResult"));
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
