/**
 * GetInfoCapiAllevamento_STR.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package it.izs.bdn.webservices;

public class GetInfoCapiAllevamento_STR  implements java.io.Serializable {
    private java.lang.String p_allev_id;

    public GetInfoCapiAllevamento_STR() {
    }

    public GetInfoCapiAllevamento_STR(
           java.lang.String p_allev_id) {
           this.p_allev_id = p_allev_id;
    }


    /**
     * Gets the p_allev_id value for this GetInfoCapiAllevamento_STR.
     * 
     * @return p_allev_id
     */
    public java.lang.String getP_allev_id() {
        return p_allev_id;
    }


    /**
     * Sets the p_allev_id value for this GetInfoCapiAllevamento_STR.
     * 
     * @param p_allev_id
     */
    public void setP_allev_id(java.lang.String p_allev_id) {
        this.p_allev_id = p_allev_id;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof GetInfoCapiAllevamento_STR)) return false;
        GetInfoCapiAllevamento_STR other = (GetInfoCapiAllevamento_STR) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.p_allev_id==null && other.getP_allev_id()==null) || 
             (this.p_allev_id!=null &&
              this.p_allev_id.equals(other.getP_allev_id())));
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
        if (getP_allev_id() != null) {
            _hashCode += getP_allev_id().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(GetInfoCapiAllevamento_STR.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", ">getInfoCapiAllevamento_STR"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("p_allev_id");
        elemField.setXmlName(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", "p_allev_id"));
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
