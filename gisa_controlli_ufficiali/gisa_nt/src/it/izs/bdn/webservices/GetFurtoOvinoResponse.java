/**
 * GetFurtoOvinoResponse.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package it.izs.bdn.webservices;

public class GetFurtoOvinoResponse  implements java.io.Serializable {
    private it.izs.bdn.webservices.GetFurtoOvinoResponseGetFurtoOvinoResult getFurtoOvinoResult;

    public GetFurtoOvinoResponse() {
    }

    public GetFurtoOvinoResponse(
           it.izs.bdn.webservices.GetFurtoOvinoResponseGetFurtoOvinoResult getFurtoOvinoResult) {
           this.getFurtoOvinoResult = getFurtoOvinoResult;
    }


    /**
     * Gets the getFurtoOvinoResult value for this GetFurtoOvinoResponse.
     * 
     * @return getFurtoOvinoResult
     */
    public it.izs.bdn.webservices.GetFurtoOvinoResponseGetFurtoOvinoResult getGetFurtoOvinoResult() {
        return getFurtoOvinoResult;
    }


    /**
     * Sets the getFurtoOvinoResult value for this GetFurtoOvinoResponse.
     * 
     * @param getFurtoOvinoResult
     */
    public void setGetFurtoOvinoResult(it.izs.bdn.webservices.GetFurtoOvinoResponseGetFurtoOvinoResult getFurtoOvinoResult) {
        this.getFurtoOvinoResult = getFurtoOvinoResult;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof GetFurtoOvinoResponse)) return false;
        GetFurtoOvinoResponse other = (GetFurtoOvinoResponse) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.getFurtoOvinoResult==null && other.getGetFurtoOvinoResult()==null) || 
             (this.getFurtoOvinoResult!=null &&
              this.getFurtoOvinoResult.equals(other.getGetFurtoOvinoResult())));
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
        if (getGetFurtoOvinoResult() != null) {
            _hashCode += getGetFurtoOvinoResult().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(GetFurtoOvinoResponse.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", ">getFurtoOvinoResponse"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("getFurtoOvinoResult");
        elemField.setXmlName(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", "getFurtoOvinoResult"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", ">>getFurtoOvinoResponse>getFurtoOvinoResult"));
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
