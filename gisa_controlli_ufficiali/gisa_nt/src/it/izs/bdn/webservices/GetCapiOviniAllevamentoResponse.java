/**
 * GetCapiOviniAllevamentoResponse.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package it.izs.bdn.webservices;

public class GetCapiOviniAllevamentoResponse  implements java.io.Serializable {
    private it.izs.bdn.webservices.GetCapiOviniAllevamentoResponseGetCapiOviniAllevamentoResult getCapiOviniAllevamentoResult;

    public GetCapiOviniAllevamentoResponse() {
    }

    public GetCapiOviniAllevamentoResponse(
           it.izs.bdn.webservices.GetCapiOviniAllevamentoResponseGetCapiOviniAllevamentoResult getCapiOviniAllevamentoResult) {
           this.getCapiOviniAllevamentoResult = getCapiOviniAllevamentoResult;
    }


    /**
     * Gets the getCapiOviniAllevamentoResult value for this GetCapiOviniAllevamentoResponse.
     * 
     * @return getCapiOviniAllevamentoResult
     */
    public it.izs.bdn.webservices.GetCapiOviniAllevamentoResponseGetCapiOviniAllevamentoResult getGetCapiOviniAllevamentoResult() {
        return getCapiOviniAllevamentoResult;
    }


    /**
     * Sets the getCapiOviniAllevamentoResult value for this GetCapiOviniAllevamentoResponse.
     * 
     * @param getCapiOviniAllevamentoResult
     */
    public void setGetCapiOviniAllevamentoResult(it.izs.bdn.webservices.GetCapiOviniAllevamentoResponseGetCapiOviniAllevamentoResult getCapiOviniAllevamentoResult) {
        this.getCapiOviniAllevamentoResult = getCapiOviniAllevamentoResult;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof GetCapiOviniAllevamentoResponse)) return false;
        GetCapiOviniAllevamentoResponse other = (GetCapiOviniAllevamentoResponse) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.getCapiOviniAllevamentoResult==null && other.getGetCapiOviniAllevamentoResult()==null) || 
             (this.getCapiOviniAllevamentoResult!=null &&
              this.getCapiOviniAllevamentoResult.equals(other.getGetCapiOviniAllevamentoResult())));
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
        if (getGetCapiOviniAllevamentoResult() != null) {
            _hashCode += getGetCapiOviniAllevamentoResult().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(GetCapiOviniAllevamentoResponse.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", ">getCapiOviniAllevamentoResponse"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("getCapiOviniAllevamentoResult");
        elemField.setXmlName(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", "getCapiOviniAllevamentoResult"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", ">>getCapiOviniAllevamentoResponse>getCapiOviniAllevamentoResult"));
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
