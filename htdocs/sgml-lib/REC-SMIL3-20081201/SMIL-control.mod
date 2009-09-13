<!-- ====================================================================== -->
<!-- SMIL 3.0 Content Control Module ====================================== -->
<!-- file: SMIL-control.mod

      This is SMIL 3.0.

        Copyright: 1998-2008 W3C (MIT, ERCIM, Keio), All Rights
        Reserved.  See http://www.w3.org/Consortium/Legal/.

        Editor for SMIL 3.0: Sjoerd Mullender, CWI
        Editor for previous versions of SMIL: Jacco van Ossenbruggen,
        Aaron Cohen, Sjoerd Mullender.
        $Revision: 1.7 $
        $Date: 2008/09/07 20:36:49 $

     This DTD module is identified by the PUBLIC and SYSTEM identifiers:

     PUBLIC "-//W3C//ELEMENTS SMIL 3.0 Content Control//EN"
     SYSTEM "http://www.w3.org/2008/SMIL30/SMIL-control.mod"

     ====================================================================== -->

<!ENTITY % SMIL.BasicContentControl.module "IGNORE">
<![%SMIL.BasicContentControl.module;[
  <!ENTITY % SMIL.switch.attrib "">
  <!ENTITY % SMIL.switch.content "EMPTY">
  <!ENTITY % SMIL.switch.qname "switch">
  
  <!ELEMENT %SMIL.switch.qname; %SMIL.switch.content;>
  <!ATTLIST %SMIL.switch.qname; %SMIL.switch.attrib;
        %SMIL.Core.attrib;
        %SMIL.I18n.attrib;
        allowReorder         (yes|no)           'no'
  >
]]>

<!-- ========================= CustomTest Elements ======================== -->
<!ENTITY % SMIL.CustomTestAttributes.module "IGNORE">
<![%SMIL.CustomTestAttributes.module;[

  <!ENTITY % SMIL.customTest.attrib "">
  <!ENTITY % SMIL.customTest.qname "customTest">
  <!ENTITY % SMIL.customTest.content "EMPTY">
  <!ELEMENT %SMIL.customTest.qname; %SMIL.customTest.content;>
  <!ATTLIST %SMIL.customTest.qname; %SMIL.customTest.attrib;
        %SMIL.Core.attrib;
        %SMIL.I18n.attrib;
        defaultState (true|false)                   'false'
        override     (visible|hidden)               'hidden'
        uid          %URI.datatype;                 #IMPLIED
  >
  <!ENTITY % SMIL.customAttributes.attrib "">
  <!ENTITY % SMIL.customAttributes.qname "customAttributes">
  <!ENTITY % SMIL.customAttributes.content "(customTest+)">
  <!ELEMENT %SMIL.customAttributes.qname; %SMIL.customAttributes.content;>
  <!ATTLIST %SMIL.customAttributes.qname; %SMIL.customAttributes.attrib;
        %SMIL.Core.attrib;
        %SMIL.I18n.attrib;
  >

]]> <!-- end of CustomTestAttributes -->

<!-- ========================= PrefetchControl Elements =================== -->
<!ENTITY % SMIL.PrefetchControl.module "IGNORE">
<![%SMIL.PrefetchControl.module;[
  <!ENTITY % SMIL.prefetch.attrib "">
  <!ENTITY % SMIL.prefetch.qname "prefetch">
  <!ENTITY % SMIL.prefetch.content "EMPTY">
  <!ELEMENT %SMIL.prefetch.qname; %SMIL.prefetch.content;>
  <!ATTLIST %SMIL.prefetch.qname; %SMIL.prefetch.attrib;
        %SMIL.Core.attrib;
        %SMIL.I18n.attrib;
        bandwidth     CDATA             '100&#37;'
        mediaSize     CDATA             #IMPLIED
        mediaTime     CDATA             #IMPLIED
        src           %URI.datatype;    #IMPLIED
  >
]]>

<!-- end of SMIL-control.mod -->
