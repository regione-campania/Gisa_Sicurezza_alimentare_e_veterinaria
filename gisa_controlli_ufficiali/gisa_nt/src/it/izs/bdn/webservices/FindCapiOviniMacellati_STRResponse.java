/**
 * FindCapiOviniMacellati_STRResponse.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package it.izs.bdn.webservices;

public class FindCapiOviniMacellati_STRResponse  implements java.io.Serializable {
    private java.lang.String findCapiOviniMacellati_STRResult;

    public FindCapiOviniMacellati_STRResponse() {
    }

    public FindCapiOviniMacellati_STRResponse(
           java.lang.String findCapiOviniMacellati_STRResult) {
           this.findCapiOviniMacellati_STRResult = findCapiOviniMacellati_STRResult;
    }


    /**
     * Gets the findCapiOviniMacellati_STRResult value for this FindCapiOviniMacellati_STRResponse.
     * 
     * @return findCapiOviniMacellati_STRResult
     */
    public java.lang.String getFindCapiOviniMacellati_STRResult() {
        return findCapiOviniMacellati_STRResult;
    }


    /**
     * Sets the findCapiOviniMacellati_STRResult value for this FindCapiOviniMacellati_STRResponse.
     * 
     * @param findCapiOviniMacellati_STRResult
     */
    public void setFindCapiOviniMacellati_STRResult(java.lang.String findCapiOviniMacellati_STRResult) {
        this.findCapiOviniMacellati_STRResult = findCapiOviniMacellati_STRResult;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof FindCapiOviniMacellati_STRResponse)) return false;
        FindCapiOviniMacellati_STRResponse other = (FindCapiOviniMacellati_STRResponse) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.findCapiOviniMacellati_STRResult==null && other.getFindCapiOviniMacellati_STRResult()==null) || 
             (this.findCapiOviniMacellati_STRResult!=null &&
              this.findCapiOviniMacellati_STRResult.equals(other.getFindCapiOviniMacellati_STRResult())));
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
        if (getFindCapiOviniMacellati_STRResult() != null) {
            _hashCode += getFindCapiOviniMacellati_STRResult().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(FindCapiOviniMacellati_STRResponse.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", ">FindCapiOviniMacellati_STRResponse"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("findCapiOviniMacellati_STRResult");
        elemField.setXmlName(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", "FindCapiOviniMacellati_STRResult"));
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
