<!-- ====================================================================== -->
<!-- SMIL 3.0 Metainformation Module ====================================== -->
<!-- file: SMIL-metainformation.mod

     This is SMIL 3.0.

        Copyright: 1998-2008 W3C (MIT, ERCIM, Keio), All Rights
        Reserved.  See http://www.w3.org/Consortium/Legal/.

        Editor for SMIL 3.0: Sjoerd Mullender, CWI
        Editor for previous versions of SMIL: Thierry Michel,
        Jacco van Ossenbruggen, Sjoerd Mullender.
        $Revision: 1.7 $
        $Date: 2008/09/07 20:36:50 $

     This module declares the meta and metadata elements types and 
     its attributes, used to provide declarative document metainformation.
   
     This DTD module is identified by the PUBLIC and SYSTEM identifiers:

     PUBLIC "-//W3C//ELEMENTS SMIL 3.0 Document Metainformation//EN"
     SYSTEM "http://www.w3.org/2008/SMIL30/SMIL-metainformation.mod"

     ====================================================================== -->


<!-- ================== Profiling Entities ================================ -->

<!ENTITY % SMIL.Metainformation.module "IGNORE">
<![%SMIL.Metainformation.module;[
  <!ENTITY % SMIL.meta.content     "EMPTY">
  <!ENTITY % SMIL.meta.attrib      "">
  <!ENTITY % SMIL.meta.qname       "meta">

  <!ENTITY % SMIL.metadata.content "EMPTY">
  <!ENTITY % SMIL.metadata.attrib  "">
  <!ENTITY % SMIL.metadata.qname   "metadata">

  <!-- ================== meta element ==================================== -->

  <!ELEMENT %SMIL.meta.qname; %SMIL.meta.content;>
  <!ATTLIST %SMIL.meta.qname; %SMIL.meta.attrib;
    %SMIL.Core.attrib;
    %SMIL.I18n.attrib;
    content CDATA #REQUIRED
    name CDATA #REQUIRED        
    >

  <!-- ================== metadata element ================================ -->

  <!ELEMENT %SMIL.metadata.qname; %SMIL.metadata.content;>
  <!ATTLIST %SMIL.metadata.qname; %SMIL.metadata.attrib;
    %SMIL.Core.attrib;
    %SMIL.I18n.attrib;
  >
]]>

<!-- end of SMIL-metainformation.mod -->
