/**
 * FindSuiTipologieProduttiveResponse.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package it.izs.bdn.webservices;

public class FindSuiTipologieProduttiveResponse  implements java.io.Serializable {
    private it.izs.bdn.webservices.FindSuiTipologieProduttiveResponseFindSuiTipologieProduttiveResult findSuiTipologieProduttiveResult;

    public FindSuiTipologieProduttiveResponse() {
    }

    public FindSuiTipologieProduttiveResponse(
           it.izs.bdn.webservices.FindSuiTipologieProduttiveResponseFindSuiTipologieProduttiveResult findSuiTipologieProduttiveResult) {
           this.findSuiTipologieProduttiveResult = findSuiTipologieProduttiveResult;
    }


    /**
     * Gets the findSuiTipologieProduttiveResult value for this FindSuiTipologieProduttiveResponse.
     * 
     * @return findSuiTipologieProduttiveResult
     */
    public it.izs.bdn.webservices.FindSuiTipologieProduttiveResponseFindSuiTipologieProduttiveResult getFindSuiTipologieProduttiveResult() {
        return findSuiTipologieProduttiveResult;
    }


    /**
     * Sets the findSuiTipologieProduttiveResult value for this FindSuiTipologieProduttiveResponse.
     * 
     * @param findSuiTipologieProduttiveResult
     */
    public void setFindSuiTipologieProduttiveResult(it.izs.bdn.webservices.FindSuiTipologieProduttiveResponseFindSuiTipologieProduttiveResult findSuiTipologieProduttiveResult) {
        this.findSuiTipologieProduttiveResult = findSuiTipologieProduttiveResult;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof FindSuiTipologieProduttiveResponse)) return false;
        FindSuiTipologieProduttiveResponse other = (FindSuiTipologieProduttiveResponse) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.findSuiTipologieProduttiveResult==null && other.getFindSuiTipologieProduttiveResult()==null) || 
             (this.findSuiTipologieProduttiveResult!=null &&
              this.findSuiTipologieProduttiveResult.equals(other.getFindSuiTipologieProduttiveResult())));
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
        if (getFindSuiTipologieProduttiveResult() != null) {
            _hashCode += getFindSuiTipologieProduttiveResult().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(FindSuiTipologieProduttiveResponse.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", ">FindSuiTipologieProduttiveResponse"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("findSuiTipologieProduttiveResult");
        elemField.setXmlName(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", "FindSuiTipologieProduttiveResult"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", ">>FindSuiTipologieProduttiveResponse>FindSuiTipologieProduttiveResult"));
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
