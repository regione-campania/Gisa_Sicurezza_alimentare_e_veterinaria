/**
 * GetFurtoOvino_STRResponse.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package it.izs.bdn.webservices;

public class GetFurtoOvino_STRResponse  implements java.io.Serializable {
    private java.lang.String getFurtoOvino_STRResult;

    public GetFurtoOvino_STRResponse() {
    }

    public GetFurtoOvino_STRResponse(
           java.lang.String getFurtoOvino_STRResult) {
           this.getFurtoOvino_STRResult = getFurtoOvino_STRResult;
    }


    /**
     * Gets the getFurtoOvino_STRResult value for this GetFurtoOvino_STRResponse.
     * 
     * @return getFurtoOvino_STRResult
     */
    public java.lang.String getGetFurtoOvino_STRResult() {
        return getFurtoOvino_STRResult;
    }


    /**
     * Sets the getFurtoOvino_STRResult value for this GetFurtoOvino_STRResponse.
     * 
     * @param getFurtoOvino_STRResult
     */
    public void setGetFurtoOvino_STRResult(java.lang.String getFurtoOvino_STRResult) {
        this.getFurtoOvino_STRResult = getFurtoOvino_STRResult;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof GetFurtoOvino_STRResponse)) return false;
        GetFurtoOvino_STRResponse other = (GetFurtoOvino_STRResponse) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.getFurtoOvino_STRResult==null && other.getGetFurtoOvino_STRResult()==null) || 
             (this.getFurtoOvino_STRResult!=null &&
              this.getFurtoOvino_STRResult.equals(other.getGetFurtoOvino_STRResult())));
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
        if (getGetFurtoOvino_STRResult() != null) {
            _hashCode += getGetFurtoOvino_STRResult().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(GetFurtoOvino_STRResponse.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", ">getFurtoOvino_STRResponse"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("getFurtoOvino_STRResult");
        elemField.setXmlName(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", "getFurtoOvino_STRResult"));
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
