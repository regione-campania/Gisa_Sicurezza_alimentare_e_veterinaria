/**
 * GetSoccidari_STRResponse.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package it.izs.bdn.webservices;

public class GetSoccidari_STRResponse  implements java.io.Serializable {
    private java.lang.String getSoccidari_STRResult;

    public GetSoccidari_STRResponse() {
    }

    public GetSoccidari_STRResponse(
           java.lang.String getSoccidari_STRResult) {
           this.getSoccidari_STRResult = getSoccidari_STRResult;
    }


    /**
     * Gets the getSoccidari_STRResult value for this GetSoccidari_STRResponse.
     * 
     * @return getSoccidari_STRResult
     */
    public java.lang.String getGetSoccidari_STRResult() {
        return getSoccidari_STRResult;
    }


    /**
     * Sets the getSoccidari_STRResult value for this GetSoccidari_STRResponse.
     * 
     * @param getSoccidari_STRResult
     */
    public void setGetSoccidari_STRResult(java.lang.String getSoccidari_STRResult) {
        this.getSoccidari_STRResult = getSoccidari_STRResult;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof GetSoccidari_STRResponse)) return false;
        GetSoccidari_STRResponse other = (GetSoccidari_STRResponse) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.getSoccidari_STRResult==null && other.getGetSoccidari_STRResult()==null) || 
             (this.getSoccidari_STRResult!=null &&
              this.getSoccidari_STRResult.equals(other.getGetSoccidari_STRResult())));
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
        if (getGetSoccidari_STRResult() != null) {
            _hashCode += getGetSoccidari_STRResult().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(GetSoccidari_STRResponse.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", ">GetSoccidari_STRResponse"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("getSoccidari_STRResult");
        elemField.setXmlName(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", "GetSoccidari_STRResult"));
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
