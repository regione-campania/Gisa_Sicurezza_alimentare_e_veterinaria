/**
 * Get_ListaAllevamenti_STR.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package it.izs.bdn.webservices;

public class Get_ListaAllevamenti_STR  implements java.io.Serializable {
    private java.lang.String p_codice_capo;

    public Get_ListaAllevamenti_STR() {
    }

    public Get_ListaAllevamenti_STR(
           java.lang.String p_codice_capo) {
           this.p_codice_capo = p_codice_capo;
    }


    /**
     * Gets the p_codice_capo value for this Get_ListaAllevamenti_STR.
     * 
     * @return p_codice_capo
     */
    public java.lang.String getP_codice_capo() {
        return p_codice_capo;
    }


    /**
     * Sets the p_codice_capo value for this Get_ListaAllevamenti_STR.
     * 
     * @param p_codice_capo
     */
    public void setP_codice_capo(java.lang.String p_codice_capo) {
        this.p_codice_capo = p_codice_capo;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof Get_ListaAllevamenti_STR)) return false;
        Get_ListaAllevamenti_STR other = (Get_ListaAllevamenti_STR) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.p_codice_capo==null && other.getP_codice_capo()==null) || 
             (this.p_codice_capo!=null &&
              this.p_codice_capo.equals(other.getP_codice_capo())));
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
        if (getP_codice_capo() != null) {
            _hashCode += getP_codice_capo().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(Get_ListaAllevamenti_STR.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", ">Get_ListaAllevamenti_STR"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("p_codice_capo");
        elemField.setXmlName(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", "p_codice_capo"));
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
