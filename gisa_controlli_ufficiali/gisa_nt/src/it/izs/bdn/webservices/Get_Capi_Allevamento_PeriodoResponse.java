/**
 * Get_Capi_Allevamento_PeriodoResponse.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package it.izs.bdn.webservices;

public class Get_Capi_Allevamento_PeriodoResponse  implements java.io.Serializable {
    private it.izs.bdn.webservices.Get_Capi_Allevamento_PeriodoResponseGet_Capi_Allevamento_PeriodoResult get_Capi_Allevamento_PeriodoResult;

    public Get_Capi_Allevamento_PeriodoResponse() {
    }

    public Get_Capi_Allevamento_PeriodoResponse(
           it.izs.bdn.webservices.Get_Capi_Allevamento_PeriodoResponseGet_Capi_Allevamento_PeriodoResult get_Capi_Allevamento_PeriodoResult) {
           this.get_Capi_Allevamento_PeriodoResult = get_Capi_Allevamento_PeriodoResult;
    }


    /**
     * Gets the get_Capi_Allevamento_PeriodoResult value for this Get_Capi_Allevamento_PeriodoResponse.
     * 
     * @return get_Capi_Allevamento_PeriodoResult
     */
    public it.izs.bdn.webservices.Get_Capi_Allevamento_PeriodoResponseGet_Capi_Allevamento_PeriodoResult getGet_Capi_Allevamento_PeriodoResult() {
        return get_Capi_Allevamento_PeriodoResult;
    }


    /**
     * Sets the get_Capi_Allevamento_PeriodoResult value for this Get_Capi_Allevamento_PeriodoResponse.
     * 
     * @param get_Capi_Allevamento_PeriodoResult
     */
    public void setGet_Capi_Allevamento_PeriodoResult(it.izs.bdn.webservices.Get_Capi_Allevamento_PeriodoResponseGet_Capi_Allevamento_PeriodoResult get_Capi_Allevamento_PeriodoResult) {
        this.get_Capi_Allevamento_PeriodoResult = get_Capi_Allevamento_PeriodoResult;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof Get_Capi_Allevamento_PeriodoResponse)) return false;
        Get_Capi_Allevamento_PeriodoResponse other = (Get_Capi_Allevamento_PeriodoResponse) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.get_Capi_Allevamento_PeriodoResult==null && other.getGet_Capi_Allevamento_PeriodoResult()==null) || 
             (this.get_Capi_Allevamento_PeriodoResult!=null &&
              this.get_Capi_Allevamento_PeriodoResult.equals(other.getGet_Capi_Allevamento_PeriodoResult())));
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
        if (getGet_Capi_Allevamento_PeriodoResult() != null) {
            _hashCode += getGet_Capi_Allevamento_PeriodoResult().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(Get_Capi_Allevamento_PeriodoResponse.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", ">Get_Capi_Allevamento_PeriodoResponse"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("get_Capi_Allevamento_PeriodoResult");
        elemField.setXmlName(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", "Get_Capi_Allevamento_PeriodoResult"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", ">>Get_Capi_Allevamento_PeriodoResponse>Get_Capi_Allevamento_PeriodoResult"));
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
