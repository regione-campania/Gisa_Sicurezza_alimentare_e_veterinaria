/**
 * GetCanc_Amm_Ovini.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package it.izs.bdn.webservices;

public class GetCanc_Amm_Ovini  implements java.io.Serializable {
    private java.lang.String p_capo_codice;

    public GetCanc_Amm_Ovini() {
    }

    public GetCanc_Amm_Ovini(
           java.lang.String p_capo_codice) {
           this.p_capo_codice = p_capo_codice;
    }


    /**
     * Gets the p_capo_codice value for this GetCanc_Amm_Ovini.
     * 
     * @return p_capo_codice
     */
    public java.lang.String getP_capo_codice() {
        return p_capo_codice;
    }


    /**
     * Sets the p_capo_codice value for this GetCanc_Amm_Ovini.
     * 
     * @param p_capo_codice
     */
    public void setP_capo_codice(java.lang.String p_capo_codice) {
        this.p_capo_codice = p_capo_codice;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof GetCanc_Amm_Ovini)) return false;
        GetCanc_Amm_Ovini other = (GetCanc_Amm_Ovini) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.p_capo_codice==null && other.getP_capo_codice()==null) || 
             (this.p_capo_codice!=null &&
              this.p_capo_codice.equals(other.getP_capo_codice())));
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
        if (getP_capo_codice() != null) {
            _hashCode += getP_capo_codice().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(GetCanc_Amm_Ovini.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", ">getCanc_Amm_Ovini"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("p_capo_codice");
        elemField.setXmlName(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", "p_capo_codice"));
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
