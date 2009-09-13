<!-- ====================================================================== -->
<!-- SMIL 3.0 Structure Module ============================================ -->
<!-- file: SMIL-struct.mod

     This is SMIL 3.0.

        Copyright: 1998-2008 W3C (MIT, ERCIM, Keio), All Rights
        Reserved.  See http://www.w3.org/Consortium/Legal/.

        Editor for SMIL 3.0: Sjoerd Mullender, CWI
        Editor for previous versions of SMIL: Warner ten Kate,
        Jacco van Ossenbruggen, Sjoerd Mullender.
        $Revision: 1.6 $
        $Date: 2008/09/07 20:36:50 $

     This DTD module is identified by the PUBLIC and SYSTEM identifiers:

     PUBLIC "-//W3C//ELEMENTS SMIL 3.0 Document Structure//EN"
     SYSTEM "http://www.w3.org/2008/SMIL30/SMIL-struct.mod"

     ====================================================================== -->

<![%SMIL.Structure.module;[
  <!-- ================== SMIL Document Root ============================== -->
  <!ENTITY % SMIL.smil.attrib  "" >
  <!ENTITY % SMIL.smil.content "EMPTY" >
  <!ENTITY % SMIL.smil.qname   "smil" >

  <!-- If smil: prefixes are used, we supply a default xmlns:smil attribute.
       If no prefix is used, we require an xmlns attribute instead.
       Note that the xmlns:smil attribute declaration is part of
       %SMIL.Core.attrib;.
  -->
  <![%SMIL.prefixed;[
    <!ENTITY % SMIL.smil.xmlns.attrib "">
  ]]>
  <!ENTITY % SMIL.smil.xmlns.attrib "xmlns %URI.datatype; #REQUIRED">
  <!ELEMENT %SMIL.smil.qname; %SMIL.smil.content;>
  <!ATTLIST %SMIL.smil.qname; %SMIL.smil.attrib;
    %SMIL.Core.attrib;
    %SMIL.I18n.attrib;
    %SMIL.smil.xmlns.attrib;
  >

  <!-- ================== The Document Head =============================== -->
  <!ENTITY % SMIL.head.content "EMPTY" >
  <!ENTITY % SMIL.head.attrib  "" >
  <!ENTITY % SMIL.head.qname   "head" >

  <!ELEMENT %SMIL.head.qname; %SMIL.head.content;>
  <!ATTLIST %SMIL.head.qname; %SMIL.head.attrib;
    %SMIL.Core.attrib;
    %SMIL.I18n.attrib;
  >

  <!--=================== The Document Body - Timing Root ================= -->
  <!ENTITY % SMIL.body.content "EMPTY" >
  <!ENTITY % SMIL.body.attrib  "" >
  <!ENTITY % SMIL.body.qname   "body" >

  <!ELEMENT %SMIL.body.qname; %SMIL.body.content;>
  <!ATTLIST %SMIL.body.qname; %SMIL.body.attrib;
    %SMIL.Core.attrib;
    %SMIL.I18n.attrib;
  >
]]>
<!-- end of SMIL-struct.mod -->
