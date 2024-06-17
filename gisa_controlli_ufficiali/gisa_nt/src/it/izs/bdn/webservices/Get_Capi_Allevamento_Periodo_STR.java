/**
 * Get_Capi_Allevamento_Periodo_STR.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package it.izs.bdn.webservices;

public class Get_Capi_Allevamento_Periodo_STR  implements java.io.Serializable {
    private java.lang.String p_allev_id;

    private java.lang.String p_cod_capo;

    private java.lang.String p_data_dal;

    private java.lang.String p_data_al;

    public Get_Capi_Allevamento_Periodo_STR() {
    }

    public Get_Capi_Allevamento_Periodo_STR(
           java.lang.String p_allev_id,
           java.lang.String p_cod_capo,
           java.lang.String p_data_dal,
           java.lang.String p_data_al) {
           this.p_allev_id = p_allev_id;
           this.p_cod_capo = p_cod_capo;
           this.p_data_dal = p_data_dal;
           this.p_data_al = p_data_al;
    }


    /**
     * Gets the p_allev_id value for this Get_Capi_Allevamento_Periodo_STR.
     * 
     * @return p_allev_id
     */
    public java.lang.String getP_allev_id() {
        return p_allev_id;
    }


    /**
     * Sets the p_allev_id value for this Get_Capi_Allevamento_Periodo_STR.
     * 
     * @param p_allev_id
     */
    public void setP_allev_id(java.lang.String p_allev_id) {
        this.p_allev_id = p_allev_id;
    }


    /**
     * Gets the p_cod_capo value for this Get_Capi_Allevamento_Periodo_STR.
     * 
     * @return p_cod_capo
     */
    public java.lang.String getP_cod_capo() {
        return p_cod_capo;
    }


    /**
     * Sets the p_cod_capo value for this Get_Capi_Allevamento_Periodo_STR.
     * 
     * @param p_cod_capo
     */
    public void setP_cod_capo(java.lang.String p_cod_capo) {
        this.p_cod_capo = p_cod_capo;
    }


    /**
     * Gets the p_data_dal value for this Get_Capi_Allevamento_Periodo_STR.
     * 
     * @return p_data_dal
     */
    public java.lang.String getP_data_dal() {
        return p_data_dal;
    }


    /**
     * Sets the p_data_dal value for this Get_Capi_Allevamento_Periodo_STR.
     * 
     * @param p_data_dal
     */
    public void setP_data_dal(java.lang.String p_data_dal) {
        this.p_data_dal = p_data_dal;
    }


    /**
     * Gets the p_data_al value for this Get_Capi_Allevamento_Periodo_STR.
     * 
     * @return p_data_al
     */
    public java.lang.String getP_data_al() {
        return p_data_al;
    }


    /**
     * Sets the p_data_al value for this Get_Capi_Allevamento_Periodo_STR.
     * 
     * @param p_data_al
     */
    public void setP_data_al(java.lang.String p_data_al) {
        this.p_data_al = p_data_al;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof Get_Capi_Allevamento_Periodo_STR)) return false;
        Get_Capi_Allevamento_Periodo_STR other = (Get_Capi_Allevamento_Periodo_STR) obj;
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
              this.p_allev_id.equals(other.getP_allev_id()))) &&
            ((this.p_cod_capo==null && other.getP_cod_capo()==null) || 
             (this.p_cod_capo!=null &&
              this.p_cod_capo.equals(other.getP_cod_capo()))) &&
            ((this.p_data_dal==null && other.getP_data_dal()==null) || 
             (this.p_data_dal!=null &&
              this.p_data_dal.equals(other.getP_data_dal()))) &&
            ((this.p_data_al==null && other.getP_data_al()==null) || 
             (this.p_data_al!=null &&
              this.p_data_al.equals(other.getP_data_al())));
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
        if (getP_cod_capo() != null) {
            _hashCode += getP_cod_capo().hashCode();
        }
        if (getP_data_dal() != null) {
            _hashCode += getP_data_dal().hashCode();
        }
        if (getP_data_al() != null) {
            _hashCode += getP_data_al().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(Get_Capi_Allevamento_Periodo_STR.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", ">Get_Capi_Allevamento_Periodo_STR"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("p_allev_id");
        elemField.setXmlName(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", "p_allev_id"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("p_cod_capo");
        elemField.setXmlName(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", "p_cod_capo"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("p_data_dal");
        elemField.setXmlName(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", "p_data_dal"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("p_data_al");
        elemField.setXmlName(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", "p_data_al"));
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
