/**
 * GetCancellazione_AmministrativaResponse.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package it.izs.bdn.webservices;

public class GetCancellazione_AmministrativaResponse  implements java.io.Serializable {
    private it.izs.bdn.webservices.GetCancellazione_AmministrativaResponseGetCancellazione_AmministrativaResult getCancellazione_AmministrativaResult;

    public GetCancellazione_AmministrativaResponse() {
    }

    public GetCancellazione_AmministrativaResponse(
           it.izs.bdn.webservices.GetCancellazione_AmministrativaResponseGetCancellazione_AmministrativaResult getCancellazione_AmministrativaResult) {
           this.getCancellazione_AmministrativaResult = getCancellazione_AmministrativaResult;
    }


    /**
     * Gets the getCancellazione_AmministrativaResult value for this GetCancellazione_AmministrativaResponse.
     * 
     * @return getCancellazione_AmministrativaResult
     */
    public it.izs.bdn.webservices.GetCancellazione_AmministrativaResponseGetCancellazione_AmministrativaResult getGetCancellazione_AmministrativaResult() {
        return getCancellazione_AmministrativaResult;
    }


    /**
     * Sets the getCancellazione_AmministrativaResult value for this GetCancellazione_AmministrativaResponse.
     * 
     * @param getCancellazione_AmministrativaResult
     */
    public void setGetCancellazione_AmministrativaResult(it.izs.bdn.webservices.GetCancellazione_AmministrativaResponseGetCancellazione_AmministrativaResult getCancellazione_AmministrativaResult) {
        this.getCancellazione_AmministrativaResult = getCancellazione_AmministrativaResult;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof GetCancellazione_AmministrativaResponse)) return false;
        GetCancellazione_AmministrativaResponse other = (GetCancellazione_AmministrativaResponse) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.getCancellazione_AmministrativaResult==null && other.getGetCancellazione_AmministrativaResult()==null) || 
             (this.getCancellazione_AmministrativaResult!=null &&
              this.getCancellazione_AmministrativaResult.equals(other.getGetCancellazione_AmministrativaResult())));
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
        if (getGetCancellazione_AmministrativaResult() != null) {
            _hashCode += getGetCancellazione_AmministrativaResult().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(GetCancellazione_AmministrativaResponse.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", ">getCancellazione_AmministrativaResponse"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("getCancellazione_AmministrativaResult");
        elemField.setXmlName(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", "getCancellazione_AmministrativaResult"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", ">>getCancellazione_AmministrativaResponse>getCancellazione_AmministrativaResult"));
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
