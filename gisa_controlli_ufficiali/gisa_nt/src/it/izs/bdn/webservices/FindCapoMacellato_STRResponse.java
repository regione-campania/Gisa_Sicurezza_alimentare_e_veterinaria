/**
 * FindCapoMacellato_STRResponse.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package it.izs.bdn.webservices;

public class FindCapoMacellato_STRResponse  implements java.io.Serializable {
    private java.lang.String findCapoMacellato_STRResult;

    public FindCapoMacellato_STRResponse() {
    }

    public FindCapoMacellato_STRResponse(
           java.lang.String findCapoMacellato_STRResult) {
           this.findCapoMacellato_STRResult = findCapoMacellato_STRResult;
    }


    /**
     * Gets the findCapoMacellato_STRResult value for this FindCapoMacellato_STRResponse.
     * 
     * @return findCapoMacellato_STRResult
     */
    public java.lang.String getFindCapoMacellato_STRResult() {
        return findCapoMacellato_STRResult;
    }


    /**
     * Sets the findCapoMacellato_STRResult value for this FindCapoMacellato_STRResponse.
     * 
     * @param findCapoMacellato_STRResult
     */
    public void setFindCapoMacellato_STRResult(java.lang.String findCapoMacellato_STRResult) {
        this.findCapoMacellato_STRResult = findCapoMacellato_STRResult;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof FindCapoMacellato_STRResponse)) return false;
        FindCapoMacellato_STRResponse other = (FindCapoMacellato_STRResponse) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.findCapoMacellato_STRResult==null && other.getFindCapoMacellato_STRResult()==null) || 
             (this.findCapoMacellato_STRResult!=null &&
              this.findCapoMacellato_STRResult.equals(other.getFindCapoMacellato_STRResult())));
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
        if (getFindCapoMacellato_STRResult() != null) {
            _hashCode += getFindCapoMacellato_STRResult().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(FindCapoMacellato_STRResponse.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", ">FindCapoMacellato_STRResponse"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("findCapoMacellato_STRResult");
        elemField.setXmlName(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", "FindCapoMacellato_STRResult"));
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
