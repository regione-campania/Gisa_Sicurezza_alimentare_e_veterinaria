/**
 * GetInfoCapiOviniAllevamento_STRResponse.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package it.izs.bdn.webservices;

public class GetInfoCapiOviniAllevamento_STRResponse  implements java.io.Serializable {
    private java.lang.String getInfoCapiOviniAllevamento_STRResult;

    public GetInfoCapiOviniAllevamento_STRResponse() {
    }

    public GetInfoCapiOviniAllevamento_STRResponse(
           java.lang.String getInfoCapiOviniAllevamento_STRResult) {
           this.getInfoCapiOviniAllevamento_STRResult = getInfoCapiOviniAllevamento_STRResult;
    }


    /**
     * Gets the getInfoCapiOviniAllevamento_STRResult value for this GetInfoCapiOviniAllevamento_STRResponse.
     * 
     * @return getInfoCapiOviniAllevamento_STRResult
     */
    public java.lang.String getGetInfoCapiOviniAllevamento_STRResult() {
        return getInfoCapiOviniAllevamento_STRResult;
    }


    /**
     * Sets the getInfoCapiOviniAllevamento_STRResult value for this GetInfoCapiOviniAllevamento_STRResponse.
     * 
     * @param getInfoCapiOviniAllevamento_STRResult
     */
    public void setGetInfoCapiOviniAllevamento_STRResult(java.lang.String getInfoCapiOviniAllevamento_STRResult) {
        this.getInfoCapiOviniAllevamento_STRResult = getInfoCapiOviniAllevamento_STRResult;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof GetInfoCapiOviniAllevamento_STRResponse)) return false;
        GetInfoCapiOviniAllevamento_STRResponse other = (GetInfoCapiOviniAllevamento_STRResponse) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.getInfoCapiOviniAllevamento_STRResult==null && other.getGetInfoCapiOviniAllevamento_STRResult()==null) || 
             (this.getInfoCapiOviniAllevamento_STRResult!=null &&
              this.getInfoCapiOviniAllevamento_STRResult.equals(other.getGetInfoCapiOviniAllevamento_STRResult())));
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
        if (getGetInfoCapiOviniAllevamento_STRResult() != null) {
            _hashCode += getGetInfoCapiOviniAllevamento_STRResult().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(GetInfoCapiOviniAllevamento_STRResponse.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", ">getInfoCapiOviniAllevamento_STRResponse"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("getInfoCapiOviniAllevamento_STRResult");
        elemField.setXmlName(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", "getInfoCapiOviniAllevamento_STRResult"));
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
