/**
 * GetAllevamento_Latte.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package it.izs.bdn.webservices;

public class GetAllevamento_Latte  implements java.io.Serializable {
    private java.lang.String p_azienda_codice;

    private java.lang.String p_allev_idfiscale;

    private java.lang.String p_spe_codice;

    public GetAllevamento_Latte() {
    }

    public GetAllevamento_Latte(
           java.lang.String p_azienda_codice,
           java.lang.String p_allev_idfiscale,
           java.lang.String p_spe_codice) {
           this.p_azienda_codice = p_azienda_codice;
           this.p_allev_idfiscale = p_allev_idfiscale;
           this.p_spe_codice = p_spe_codice;
    }


    /**
     * Gets the p_azienda_codice value for this GetAllevamento_Latte.
     * 
     * @return p_azienda_codice
     */
    public java.lang.String getP_azienda_codice() {
        return p_azienda_codice;
    }


    /**
     * Sets the p_azienda_codice value for this GetAllevamento_Latte.
     * 
     * @param p_azienda_codice
     */
    public void setP_azienda_codice(java.lang.String p_azienda_codice) {
        this.p_azienda_codice = p_azienda_codice;
    }


    /**
     * Gets the p_allev_idfiscale value for this GetAllevamento_Latte.
     * 
     * @return p_allev_idfiscale
     */
    public java.lang.String getP_allev_idfiscale() {
        return p_allev_idfiscale;
    }


    /**
     * Sets the p_allev_idfiscale value for this GetAllevamento_Latte.
     * 
     * @param p_allev_idfiscale
     */
    public void setP_allev_idfiscale(java.lang.String p_allev_idfiscale) {
        this.p_allev_idfiscale = p_allev_idfiscale;
    }


    /**
     * Gets the p_spe_codice value for this GetAllevamento_Latte.
     * 
     * @return p_spe_codice
     */
    public java.lang.String getP_spe_codice() {
        return p_spe_codice;
    }


    /**
     * Sets the p_spe_codice value for this GetAllevamento_Latte.
     * 
     * @param p_spe_codice
     */
    public void setP_spe_codice(java.lang.String p_spe_codice) {
        this.p_spe_codice = p_spe_codice;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof GetAllevamento_Latte)) return false;
        GetAllevamento_Latte other = (GetAllevamento_Latte) obj;
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
            ((this.p_allev_idfiscale==null && other.getP_allev_idfiscale()==null) || 
             (this.p_allev_idfiscale!=null &&
              this.p_allev_idfiscale.equals(other.getP_allev_idfiscale()))) &&
            ((this.p_spe_codice==null && other.getP_spe_codice()==null) || 
             (this.p_spe_codice!=null &&
              this.p_spe_codice.equals(other.getP_spe_codice())));
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
        if (getP_allev_idfiscale() != null) {
            _hashCode += getP_allev_idfiscale().hashCode();
        }
        if (getP_spe_codice() != null) {
            _hashCode += getP_spe_codice().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(GetAllevamento_Latte.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", ">getAllevamento_Latte"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("p_azienda_codice");
        elemField.setXmlName(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", "p_azienda_codice"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("p_allev_idfiscale");
        elemField.setXmlName(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", "p_allev_idfiscale"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("p_spe_codice");
        elemField.setXmlName(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", "p_spe_codice"));
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
