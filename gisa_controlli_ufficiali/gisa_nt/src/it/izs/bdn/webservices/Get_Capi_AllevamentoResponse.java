/**
 * Get_Capi_AllevamentoResponse.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package it.izs.bdn.webservices;

public class Get_Capi_AllevamentoResponse  implements java.io.Serializable {
    private it.izs.bdn.webservices.Get_Capi_AllevamentoResponseGet_Capi_AllevamentoResult get_Capi_AllevamentoResult;

    public Get_Capi_AllevamentoResponse() {
    }

    public Get_Capi_AllevamentoResponse(
           it.izs.bdn.webservices.Get_Capi_AllevamentoResponseGet_Capi_AllevamentoResult get_Capi_AllevamentoResult) {
           this.get_Capi_AllevamentoResult = get_Capi_AllevamentoResult;
    }


    /**
     * Gets the get_Capi_AllevamentoResult value for this Get_Capi_AllevamentoResponse.
     * 
     * @return get_Capi_AllevamentoResult
     */
    public it.izs.bdn.webservices.Get_Capi_AllevamentoResponseGet_Capi_AllevamentoResult getGet_Capi_AllevamentoResult() {
        return get_Capi_AllevamentoResult;
    }


    /**
     * Sets the get_Capi_AllevamentoResult value for this Get_Capi_AllevamentoResponse.
     * 
     * @param get_Capi_AllevamentoResult
     */
    public void setGet_Capi_AllevamentoResult(it.izs.bdn.webservices.Get_Capi_AllevamentoResponseGet_Capi_AllevamentoResult get_Capi_AllevamentoResult) {
        this.get_Capi_AllevamentoResult = get_Capi_AllevamentoResult;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof Get_Capi_AllevamentoResponse)) return false;
        Get_Capi_AllevamentoResponse other = (Get_Capi_AllevamentoResponse) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.get_Capi_AllevamentoResult==null && other.getGet_Capi_AllevamentoResult()==null) || 
             (this.get_Capi_AllevamentoResult!=null &&
              this.get_Capi_AllevamentoResult.equals(other.getGet_Capi_AllevamentoResult())));
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
        if (getGet_Capi_AllevamentoResult() != null) {
            _hashCode += getGet_Capi_AllevamentoResult().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(Get_Capi_AllevamentoResponse.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", ">Get_Capi_AllevamentoResponse"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("get_Capi_AllevamentoResult");
        elemField.setXmlName(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", "Get_Capi_AllevamentoResult"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", ">>Get_Capi_AllevamentoResponse>Get_Capi_AllevamentoResult"));
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
