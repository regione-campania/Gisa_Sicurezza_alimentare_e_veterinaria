/**
 * GetCapoALibroResponse.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package it.izs.bdn.webservices;

public class GetCapoALibroResponse  implements java.io.Serializable {
    private it.izs.bdn.webservices.GetCapoALibroResponseGetCapoALibroResult getCapoALibroResult;

    public GetCapoALibroResponse() {
    }

    public GetCapoALibroResponse(
           it.izs.bdn.webservices.GetCapoALibroResponseGetCapoALibroResult getCapoALibroResult) {
           this.getCapoALibroResult = getCapoALibroResult;
    }


    /**
     * Gets the getCapoALibroResult value for this GetCapoALibroResponse.
     * 
     * @return getCapoALibroResult
     */
    public it.izs.bdn.webservices.GetCapoALibroResponseGetCapoALibroResult getGetCapoALibroResult() {
        return getCapoALibroResult;
    }


    /**
     * Sets the getCapoALibroResult value for this GetCapoALibroResponse.
     * 
     * @param getCapoALibroResult
     */
    public void setGetCapoALibroResult(it.izs.bdn.webservices.GetCapoALibroResponseGetCapoALibroResult getCapoALibroResult) {
        this.getCapoALibroResult = getCapoALibroResult;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof GetCapoALibroResponse)) return false;
        GetCapoALibroResponse other = (GetCapoALibroResponse) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.getCapoALibroResult==null && other.getGetCapoALibroResult()==null) || 
             (this.getCapoALibroResult!=null &&
              this.getCapoALibroResult.equals(other.getGetCapoALibroResult())));
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
        if (getGetCapoALibroResult() != null) {
            _hashCode += getGetCapoALibroResult().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(GetCapoALibroResponse.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", ">getCapoALibroResponse"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("getCapoALibroResult");
        elemField.setXmlName(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", "getCapoALibroResult"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", ">>getCapoALibroResponse>getCapoALibroResult"));
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
