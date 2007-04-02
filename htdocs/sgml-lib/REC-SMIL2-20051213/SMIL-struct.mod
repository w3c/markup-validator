<!-- ====================================================================== -->
<!-- SMIL Structure Module  =============================================== -->
<!-- file: SMIL-struct.mod

     This is SMIL 2.1.

        Copyright: 1998-2005 W3C (MIT, ERCIM, Keio), All Rights
        Reserved.  See http://www.w3.org/Consortium/Legal/.

        Author: Warner ten Kate, Jacco van Ossenbruggen
        Editor for SMIL 2.1: Sjoerd Mullender, CWI
        $Revision: 1.1 $
        $Date: 2007-04-02 05:08:39 $

     This DTD module is identified by the PUBLIC and SYSTEM identifiers:

     PUBLIC "-//W3C//ELEMENTS SMIL 2.1 Document Structure//EN"
     SYSTEM "http://www.w3.org/2005/SMIL21/SMIL-struct.mod"

     ===================================================================== -->

<!-- ================== SMIL Document Root =============================== -->
<!ENTITY % SMIL.smil.attrib  "" >
<!ENTITY % SMIL.smil.content "EMPTY" >
<!ENTITY % SMIL.smil.qname   "smil" >

<!ELEMENT %SMIL.smil.qname; %SMIL.smil.content;>
<!ATTLIST %SMIL.smil.qname; %SMIL.smil.attrib;
        %Core.attrib;
        %I18n.attrib;
        xmlns %URI.datatype; #REQUIRED 
>

<!-- ================== The Document Head ================================ -->
<!ENTITY % SMIL.head.content "EMPTY" >
<!ENTITY % SMIL.head.attrib  "" >
<!ENTITY % SMIL.head.qname   "head" >

<!ELEMENT %SMIL.head.qname; %SMIL.head.content;>
<!ATTLIST %SMIL.head.qname; %SMIL.head.attrib;
        %Core.attrib;
        %I18n.attrib;
>

<!--=================== The Document Body - Timing Root ================== -->
<!ENTITY % SMIL.body.content "EMPTY" >
<!ENTITY % SMIL.body.attrib  "" >
<!ENTITY % SMIL.body.qname   "body" >

<!ELEMENT %SMIL.body.qname; %SMIL.body.content;>
<!ATTLIST %SMIL.body.qname; %SMIL.body.attrib;
        %Core.attrib;
        %I18n.attrib;
>
<!-- end of SMIL-struct.mod -->
