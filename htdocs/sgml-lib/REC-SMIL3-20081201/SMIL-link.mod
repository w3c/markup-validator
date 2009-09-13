<!-- ====================================================================== -->
<!-- SMIL 3.0 Linking Module ============================================== -->
<!-- file: SMIL-link.mod

     This is SMIL 3.0.

        Copyright: 1998-2008 W3C (MIT, ERCIM, Keio), All Rights
        Reserved.  See http://www.w3.org/Consortium/Legal/.

        Editor for SMIL 3.0: Sjoerd Mullender, CWI
        Editor for previous versions of SMIL: Jacco van Ossenbruggen,
        Lloyd Rutledge, Aaron Cohen, Sjoerd Mullender.
        $Revision: 1.10 $
        $Date: 2008/09/07 20:36:50 $

     This DTD module is identified by the PUBLIC and SYSTEM identifiers:

     PUBLIC "-//W3C//ELEMENTS SMIL 3.0 Linking//EN"
     SYSTEM "http://www.w3.org/2008/SMIL30/SMIL-link.mod"

     ====================================================================== -->

<!-- ======================== LinkingAttributes Entities ================== -->
<!ENTITY % SMIL.LinkingAttributes.module "IGNORE">
<![%SMIL.LinkingAttributes.module;[
  <!ENTITY % SMIL.linking-attrs "
        sourceLevel             CDATA               '+0.0dB'
        destinationLevel        CDATA               '+0.0dB'
        sourcePlaystate         (play|pause|stop)   #IMPLIED
        destinationPlaystate    (play|pause)        'play'
        show                    (new|pause|replace) 'replace'
        accesskey               %Character.datatype; #IMPLIED
        target                  CDATA                #IMPLIED
        external                (true|false)        'false'
        actuate                 (onRequest|onLoad)  'onRequest'
        %SMIL.tabindex.attrib;
  ">
]]>
<!ENTITY % SMIL.linking-attrs "">


<!-- ======================== ObjectLinking =============================== -->
<!ENTITY % SMIL.ObjectLinking.module "IGNORE">
<![%SMIL.ObjectLinking.module;[

  <!ENTITY % SMIL.Fragment "
    fragment                  CDATA               #IMPLIED
  ">
]]>
<!ENTITY % SMIL.Fragment "">

<!-- ========================= BasicLinking Elements ====================== -->
<!ENTITY % SMIL.BasicLinking.module "IGNORE">
<!ENTITY % SMIL.BasicLinking.deprecated.module "IGNORE">
<![%SMIL.BasicLinking.module;[

  <!-- ======================= BasicLinking Entities ====================== -->
  <!ENTITY % SMIL.Shape "(rect|circle|poly|default)">
  <!ENTITY % SMIL.Coords "CDATA">
    <!-- comma separated list of lengths -->

  <!ENTITY % SMIL.a.attrib  "">
  <!ENTITY % SMIL.a.content "EMPTY">
  <!ENTITY % SMIL.a.qname   "a">
  <!ELEMENT %SMIL.a.qname; %SMIL.a.content;>
  <!ATTLIST %SMIL.a.qname; %SMIL.a.attrib;
    %SMIL.Core.attrib;
    %SMIL.I18n.attrib;
    %SMIL.linking-attrs;
    href                      %URI.datatype;      #REQUIRED
  >

  <!ENTITY % SMIL.area.attrib  "">
  <!ENTITY % SMIL.area.content "EMPTY">
  <!ENTITY % SMIL.area.qname   "area">
  <!ELEMENT %SMIL.area.qname; %SMIL.area.content;>
  <!ATTLIST %SMIL.area.qname; %SMIL.area.attrib;
    %SMIL.Core.attrib;
    %SMIL.I18n.attrib;
    %SMIL.linking-attrs;
    %SMIL.Fragment;
    shape                     %SMIL.Shape;        'rect'
    coords                    %SMIL.Coords;       #IMPLIED
    href                      %URI.datatype;      #IMPLIED
    nohref                    (nohref)            #IMPLIED
  >

  <![%SMIL.BasicLinking.deprecated.module;[
    <!ENTITY % SMIL.anchor.attrib  "">
    <!ENTITY % SMIL.anchor.content "EMPTY">
    <!ENTITY % SMIL.anchor.qname  "anchor">
    <!ELEMENT %SMIL.anchor.qname; %SMIL.anchor.content;>
    <!ATTLIST %SMIL.anchor.qname; %SMIL.anchor.attrib;
      %SMIL.Core.attrib;
      %SMIL.I18n.attrib;
      %SMIL.linking-attrs;
      %SMIL.Fragment;
      shape                     %SMIL.Shape;        'rect'
      coords                    %SMIL.Coords;       #IMPLIED
      href                      %URI.datatype;      #IMPLIED
      nohref                    (nohref)            #IMPLIED
    >
  ]]>
]]> <!-- end of BasicLinking -->

<!-- end of SMIL-link.mod -->
