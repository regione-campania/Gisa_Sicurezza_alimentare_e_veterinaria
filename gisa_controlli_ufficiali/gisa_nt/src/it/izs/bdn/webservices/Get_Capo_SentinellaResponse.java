/**
 * Get_Capo_SentinellaResponse.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package it.izs.bdn.webservices;

public class Get_Capo_SentinellaResponse  implements java.io.Serializable {
    private it.izs.bdn.webservices.Get_Capo_SentinellaResponseGet_Capo_SentinellaResult get_Capo_SentinellaResult;

    public Get_Capo_SentinellaResponse() {
    }

    public Get_Capo_SentinellaResponse(
           it.izs.bdn.webservices.Get_Capo_SentinellaResponseGet_Capo_SentinellaResult get_Capo_SentinellaResult) {
           this.get_Capo_SentinellaResult = get_Capo_SentinellaResult;
    }


    /**
     * Gets the get_Capo_SentinellaResult value for this Get_Capo_SentinellaResponse.
     * 
     * @return get_Capo_SentinellaResult
     */
    public it.izs.bdn.webservices.Get_Capo_SentinellaResponseGet_Capo_SentinellaResult getGet_Capo_SentinellaResult() {
        return get_Capo_SentinellaResult;
    }


    /**
     * Sets the get_Capo_SentinellaResult value for this Get_Capo_SentinellaResponse.
     * 
     * @param get_Capo_SentinellaResult
     */
    public void setGet_Capo_SentinellaResult(it.izs.bdn.webservices.Get_Capo_SentinellaResponseGet_Capo_SentinellaResult get_Capo_SentinellaResult) {
        this.get_Capo_SentinellaResult = get_Capo_SentinellaResult;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof Get_Capo_SentinellaResponse)) return false;
        Get_Capo_SentinellaResponse other = (Get_Capo_SentinellaResponse) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.get_Capo_SentinellaResult==null && other.getGet_Capo_SentinellaResult()==null) || 
             (this.get_Capo_SentinellaResult!=null &&
              this.get_Capo_SentinellaResult.equals(other.getGet_Capo_SentinellaResult())));
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
        if (getGet_Capo_SentinellaResult() != null) {
            _hashCode += getGet_Capo_SentinellaResult().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(Get_Capo_SentinellaResponse.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", ">get_Capo_SentinellaResponse"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("get_Capo_SentinellaResult");
        elemField.setXmlName(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", "get_Capo_SentinellaResult"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", ">>get_Capo_SentinellaResponse>get_Capo_SentinellaResult"));
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
