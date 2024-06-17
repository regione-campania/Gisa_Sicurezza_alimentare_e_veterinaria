/**
 * FindAllevamento.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package it.izs.bdn.webservices;

public class FindAllevamento  implements java.io.Serializable {
    private java.lang.String p_azienda_codice;

    private java.lang.String p_denominazione;

    private java.lang.String p_specie_codice;

    public FindAllevamento() {
    }

    public FindAllevamento(
           java.lang.String p_azienda_codice,
           java.lang.String p_denominazione,
           java.lang.String p_specie_codice) {
           this.p_azienda_codice = p_azienda_codice;
           this.p_denominazione = p_denominazione;
           this.p_specie_codice = p_specie_codice;
    }


    /**
     * Gets the p_azienda_codice value for this FindAllevamento.
     * 
     * @return p_azienda_codice
     */
    public java.lang.String getP_azienda_codice() {
        return p_azienda_codice;
    }


    /**
     * Sets the p_azienda_codice value for this FindAllevamento.
     * 
     * @param p_azienda_codice
     */
    public void setP_azienda_codice(java.lang.String p_azienda_codice) {
        this.p_azienda_codice = p_azienda_codice;
    }


    /**
     * Gets the p_denominazione value for this FindAllevamento.
     * 
     * @return p_denominazione
     */
    public java.lang.String getP_denominazione() {
        return p_denominazione;
    }


    /**
     * Sets the p_denominazione value for this FindAllevamento.
     * 
     * @param p_denominazione
     */
    public void setP_denominazione(java.lang.String p_denominazione) {
        this.p_denominazione = p_denominazione;
    }


    /**
     * Gets the p_specie_codice value for this FindAllevamento.
     * 
     * @return p_specie_codice
     */
    public java.lang.String getP_specie_codice() {
        return p_specie_codice;
    }


    /**
     * Sets the p_specie_codice value for this FindAllevamento.
     * 
     * @param p_specie_codice
     */
    public void setP_specie_codice(java.lang.String p_specie_codice) {
        this.p_specie_codice = p_specie_codice;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof FindAllevamento)) return false;
        FindAllevamento other = (FindAllevamento) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.p_azienda_codice==null && other.getP_azienda_codice()==null) || 
             (this.p_azienda_codice!=null &&
              this.p_azienda_codice.equals(other.getP_azienda_codice()))) &&
            ((this.p_denominazione==null && other.getP_denominazione()==null) || 
             (this.p_denominazione!=null &&
              this.p_denominazione.equals(other.getP_denominazione()))) &&
            ((this.p_specie_codice==null && other.getP_specie_codice()==null) || 
             (this.p_specie_codice!=null &&
              this.p_specie_codice.equals(other.getP_specie_codice())));
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
        if (getP_azienda_codice() != null) {
            _hashCode += getP_azienda_codice().hashCode();
        }
        if (getP_denominazione() != null) {
            _hashCode += getP_denominazione().hashCode();
        }
        if (getP_specie_codice() != null) {
            _hashCode += getP_specie_codice().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(FindAllevamento.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", ">FindAllevamento"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("p_azienda_codice");
        elemField.setXmlName(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", "p_azienda_codice"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("p_denominazione");
        elemField.setXmlName(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", "p_denominazione"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("p_specie_codice");
        elemField.setXmlName(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", "p_specie_codice"));
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
