/**
 * GetCapiOviniAllevamento_STRResponse.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package it.izs.bdn.webservices;

public class GetCapiOviniAllevamento_STRResponse  implements java.io.Serializable {
    private java.lang.String getCapiOviniAllevamento_STRResult;

    public GetCapiOviniAllevamento_STRResponse() {
    }

    public GetCapiOviniAllevamento_STRResponse(
           java.lang.String getCapiOviniAllevamento_STRResult) {
           this.getCapiOviniAllevamento_STRResult = getCapiOviniAllevamento_STRResult;
    }


    /**
     * Gets the getCapiOviniAllevamento_STRResult value for this GetCapiOviniAllevamento_STRResponse.
     * 
     * @return getCapiOviniAllevamento_STRResult
     */
    public java.lang.String getGetCapiOviniAllevamento_STRResult() {
        return getCapiOviniAllevamento_STRResult;
    }


    /**
     * Sets the getCapiOviniAllevamento_STRResult value for this GetCapiOviniAllevamento_STRResponse.
     * 
     * @param getCapiOviniAllevamento_STRResult
     */
    public void setGetCapiOviniAllevamento_STRResult(java.lang.String getCapiOviniAllevamento_STRResult) {
        this.getCapiOviniAllevamento_STRResult = getCapiOviniAllevamento_STRResult;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof GetCapiOviniAllevamento_STRResponse)) return false;
        GetCapiOviniAllevamento_STRResponse other = (GetCapiOviniAllevamento_STRResponse) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.getCapiOviniAllevamento_STRResult==null && other.getGetCapiOviniAllevamento_STRResult()==null) || 
             (this.getCapiOviniAllevamento_STRResult!=null &&
              this.getCapiOviniAllevamento_STRResult.equals(other.getGetCapiOviniAllevamento_STRResult())));
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
        if (getGetCapiOviniAllevamento_STRResult() != null) {
            _hashCode += getGetCapiOviniAllevamento_STRResult().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(GetCapiOviniAllevamento_STRResponse.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", ">getCapiOviniAllevamento_STRResponse"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("getCapiOviniAllevamento_STRResult");
        elemField.setXmlName(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", "getCapiOviniAllevamento_STRResult"));
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
