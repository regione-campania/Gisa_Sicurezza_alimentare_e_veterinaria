/**
 * Find_Capi_Equini_Macellati_STRResponse.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package it.izs.bdn.webservices;

public class Find_Capi_Equini_Macellati_STRResponse  implements java.io.Serializable {
    private java.lang.String find_Capi_Equini_Macellati_STRResult;

    public Find_Capi_Equini_Macellati_STRResponse() {
    }

    public Find_Capi_Equini_Macellati_STRResponse(
           java.lang.String find_Capi_Equini_Macellati_STRResult) {
           this.find_Capi_Equini_Macellati_STRResult = find_Capi_Equini_Macellati_STRResult;
    }


    /**
     * Gets the find_Capi_Equini_Macellati_STRResult value for this Find_Capi_Equini_Macellati_STRResponse.
     * 
     * @return find_Capi_Equini_Macellati_STRResult
     */
    public java.lang.String getFind_Capi_Equini_Macellati_STRResult() {
        return find_Capi_Equini_Macellati_STRResult;
    }


    /**
     * Sets the find_Capi_Equini_Macellati_STRResult value for this Find_Capi_Equini_Macellati_STRResponse.
     * 
     * @param find_Capi_Equini_Macellati_STRResult
     */
    public void setFind_Capi_Equini_Macellati_STRResult(java.lang.String find_Capi_Equini_Macellati_STRResult) {
        this.find_Capi_Equini_Macellati_STRResult = find_Capi_Equini_Macellati_STRResult;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof Find_Capi_Equini_Macellati_STRResponse)) return false;
        Find_Capi_Equini_Macellati_STRResponse other = (Find_Capi_Equini_Macellati_STRResponse) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.find_Capi_Equini_Macellati_STRResult==null && other.getFind_Capi_Equini_Macellati_STRResult()==null) || 
             (this.find_Capi_Equini_Macellati_STRResult!=null &&
              this.find_Capi_Equini_Macellati_STRResult.equals(other.getFind_Capi_Equini_Macellati_STRResult())));
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
        if (getFind_Capi_Equini_Macellati_STRResult() != null) {
            _hashCode += getFind_Capi_Equini_Macellati_STRResult().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(Find_Capi_Equini_Macellati_STRResponse.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", ">find_Capi_Equini_Macellati_STRResponse"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("find_Capi_Equini_Macellati_STRResult");
        elemField.setXmlName(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", "find_Capi_Equini_Macellati_STRResult"));
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
