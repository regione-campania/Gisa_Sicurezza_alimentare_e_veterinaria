/**
 * GetDecessoOvino_STRResponse.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package it.izs.bdn.webservices;

public class GetDecessoOvino_STRResponse  implements java.io.Serializable {
    private java.lang.String getDecessoOvino_STRResult;

    public GetDecessoOvino_STRResponse() {
    }

    public GetDecessoOvino_STRResponse(
           java.lang.String getDecessoOvino_STRResult) {
           this.getDecessoOvino_STRResult = getDecessoOvino_STRResult;
    }


    /**
     * Gets the getDecessoOvino_STRResult value for this GetDecessoOvino_STRResponse.
     * 
     * @return getDecessoOvino_STRResult
     */
    public java.lang.String getGetDecessoOvino_STRResult() {
        return getDecessoOvino_STRResult;
    }


    /**
     * Sets the getDecessoOvino_STRResult value for this GetDecessoOvino_STRResponse.
     * 
     * @param getDecessoOvino_STRResult
     */
    public void setGetDecessoOvino_STRResult(java.lang.String getDecessoOvino_STRResult) {
        this.getDecessoOvino_STRResult = getDecessoOvino_STRResult;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof GetDecessoOvino_STRResponse)) return false;
        GetDecessoOvino_STRResponse other = (GetDecessoOvino_STRResponse) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.getDecessoOvino_STRResult==null && other.getGetDecessoOvino_STRResult()==null) || 
             (this.getDecessoOvino_STRResult!=null &&
              this.getDecessoOvino_STRResult.equals(other.getGetDecessoOvino_STRResult())));
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
        if (getGetDecessoOvino_STRResult() != null) {
            _hashCode += getGetDecessoOvino_STRResult().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(GetDecessoOvino_STRResponse.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", ">getDecessoOvino_STRResponse"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("getDecessoOvino_STRResult");
        elemField.setXmlName(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", "getDecessoOvino_STRResult"));
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
