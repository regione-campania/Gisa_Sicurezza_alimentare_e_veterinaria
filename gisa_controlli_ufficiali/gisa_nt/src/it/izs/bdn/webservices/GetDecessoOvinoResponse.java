/**
 * GetDecessoOvinoResponse.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package it.izs.bdn.webservices;

public class GetDecessoOvinoResponse  implements java.io.Serializable {
    private it.izs.bdn.webservices.GetDecessoOvinoResponseGetDecessoOvinoResult getDecessoOvinoResult;

    public GetDecessoOvinoResponse() {
    }

    public GetDecessoOvinoResponse(
           it.izs.bdn.webservices.GetDecessoOvinoResponseGetDecessoOvinoResult getDecessoOvinoResult) {
           this.getDecessoOvinoResult = getDecessoOvinoResult;
    }


    /**
     * Gets the getDecessoOvinoResult value for this GetDecessoOvinoResponse.
     * 
     * @return getDecessoOvinoResult
     */
    public it.izs.bdn.webservices.GetDecessoOvinoResponseGetDecessoOvinoResult getGetDecessoOvinoResult() {
        return getDecessoOvinoResult;
    }


    /**
     * Sets the getDecessoOvinoResult value for this GetDecessoOvinoResponse.
     * 
     * @param getDecessoOvinoResult
     */
    public void setGetDecessoOvinoResult(it.izs.bdn.webservices.GetDecessoOvinoResponseGetDecessoOvinoResult getDecessoOvinoResult) {
        this.getDecessoOvinoResult = getDecessoOvinoResult;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof GetDecessoOvinoResponse)) return false;
        GetDecessoOvinoResponse other = (GetDecessoOvinoResponse) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.getDecessoOvinoResult==null && other.getGetDecessoOvinoResult()==null) || 
             (this.getDecessoOvinoResult!=null &&
              this.getDecessoOvinoResult.equals(other.getGetDecessoOvinoResult())));
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
        if (getGetDecessoOvinoResult() != null) {
            _hashCode += getGetDecessoOvinoResult().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(GetDecessoOvinoResponse.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", ">getDecessoOvinoResponse"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("getDecessoOvinoResult");
        elemField.setXmlName(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", "getDecessoOvinoResult"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", ">>getDecessoOvinoResponse>getDecessoOvinoResult"));
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
