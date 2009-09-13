<!-- ====================================================================== -->
<!-- SMIL 3.0 smilText Modules ============================================ -->
<!-- file: SMIL-smiltext.mod

        This is SMIL 3.0.

        Copyright: 1998-2008 W3C (MIT, ERCIM, Keio), All Rights
        Reserved.  See http://www.w3.org/Consortium/Legal/.

        Editor for SMIL 3.0: Sjoerd Mullender, CWI
        $Revision: 1.10 $
        $Date: 2008/09/07 20:36:50 $

        This DTD module is identified by the PUBLIC and SYSTEM identifiers:

        PUBLIC "-//W3C//ELEMENTS SMIL 3.0 SMILtext//EN"
        SYSTEM "http://www.w3.org/2008/SMIL30/SMIL-smiltext.mod"

        =================================================================== -->

<!-- ================== TextExternal ====================================== -->
<!ENTITY % SMIL.TextExternal.module "IGNORE">
<![%SMIL.TextExternal.module;[
  <!ENTITY % SMIL.TextExternal.attrib "
    dur              %TimeValue.datatype; #IMPLIED
    height           CDATA                'auto'
    width            CDATA                'auto'
    backgroundColor  %Color.datatype;     'transparent'
    xmlns            %URI.datatype;       #REQUIRED
  ">
]]>
<!ENTITY % SMIL.TextExternal.attrib "">

<!-- ================== BasicText ========================================= -->
<!ENTITY % SMIL.BasicText.module "IGNORE">
<![%SMIL.BasicText.module;[
  <!ENTITY % SMIL.smilText.attrib "">
  <!ENTITY % SMIL.smilText.content "EMPTY">
  <!ENTITY % SMIL.smilText.qname "smilText">
  <!ELEMENT %SMIL.smilText.qname; %SMIL.smilText.content;>
  <!ATTLIST %SMIL.smilText.qname; %SMIL.smilText.attrib;
    %SMIL.Core.attrib;
    %SMIL.I18n.attrib;
    %SMIL.Description.attrib;
    %SMIL.BasicText.attrib;
    %SMIL.textAlign.attrib;
    %SMIL.TextStyling.attrib;
    %SMIL.textMode.attrib;
    %SMIL.textPlace.attrib;
    %SMIL.textWritingMode.attrib;
    %SMIL.TextMotion.attrib;
    %SMIL.MediaOpacity.attrib;
    %SMIL.MediaRenderAttributes.attrib;
    %SMIL.TextExternal.attrib;
  >

  <!ENTITY % SMIL.tev.attrib "">
  <!ENTITY % SMIL.tev.content "EMPTY">
  <!ENTITY % SMIL.tev.qname "tev">
  <!ELEMENT %SMIL.tev.qname; %SMIL.tev.content;>
  <!ATTLIST %SMIL.tev.qname; %SMIL.tev.attrib;
    %SMIL.Core.attrib;
    %SMIL.I18n.attrib;
    begin CDATA #IMPLIED
    next  CDATA #IMPLIED
  >

  <!ENTITY % SMIL.clear.attrib "">
  <!ENTITY % SMIL.clear.content "EMPTY">
  <!ENTITY % SMIL.clear.qname "clear">
  <!ELEMENT %SMIL.clear.qname; %SMIL.clear.content;>
  <!ATTLIST %SMIL.clear.qname; %SMIL.clear.attrib;
    %SMIL.Core.attrib;
    %SMIL.I18n.attrib;
    begin CDATA #IMPLIED
    next  CDATA #IMPLIED
  >

  <!ENTITY % SMIL.br.attrib "">
  <!ENTITY % SMIL.br.content "EMPTY">
  <!ENTITY % SMIL.br.qname "br">
  <!ELEMENT %SMIL.br.qname; %SMIL.br.content;>
  <!ATTLIST %SMIL.br.qname; %SMIL.br.attrib;
    %SMIL.Core.attrib;
    %SMIL.I18n.attrib;
  >
]]>

<!-- ================== TextStyling ======================================= -->
<!ENTITY % SMIL.TextStyling.module "IGNORE">
<![%SMIL.TextStyling.module;[
  <!ENTITY % SMIL.div.attrib "">
  <!ENTITY % SMIL.div.content "EMPTY">
  <!ENTITY % SMIL.div.qname "div">
  <!ELEMENT %SMIL.div.qname; %SMIL.div.content;>
  <!ATTLIST %SMIL.div.qname; %SMIL.div.attrib;
    %SMIL.Core.attrib;
    %SMIL.I18n.attrib;
    %SMIL.Description.attrib;
    %SMIL.BasicText.attrib;
    %SMIL.textAlign.attrib;
    %SMIL.TextStyling.attrib;
    %SMIL.textWritingMode.attrib;
  >

  <!ENTITY % SMIL.p.attrib "">
  <!ENTITY % SMIL.p.content "EMPTY">
  <!ENTITY % SMIL.p.qname "p">
  <!ELEMENT %SMIL.p.qname; %SMIL.p.content;>
  <!ATTLIST %SMIL.p.qname; %SMIL.p.attrib;
    %SMIL.Core.attrib;
    %SMIL.I18n.attrib;
    %SMIL.Description.attrib;
    %SMIL.BasicText.attrib;
    %SMIL.TextStyling.attrib;
    %SMIL.textWritingMode.attrib;
  >

  <!ENTITY % SMIL.span.attrib "">
  <!ENTITY % SMIL.span.content "EMPTY">
  <!ENTITY % SMIL.span.qname "span">
  <!ELEMENT %SMIL.span.qname; %SMIL.span.content;>
  <!ATTLIST %SMIL.span.qname; %SMIL.span.attrib;
    %SMIL.Core.attrib;
    %SMIL.I18n.attrib;
    %SMIL.Description.attrib;
    %SMIL.BasicText.attrib;
    %SMIL.TextStyling.attrib;
    %SMIL.textDirection.attrib;
  >

  <!ENTITY % SMIL.textStyle.attrib "">
  <!ENTITY % SMIL.textStyle.content "EMPTY">
  <!ENTITY % SMIL.textStyle.qname "textStyle">
  <!ELEMENT %SMIL.textStyle.qname; %SMIL.textStyle.content;>
  <!ATTLIST %SMIL.textStyle.qname; %SMIL.textStyle.attrib;
    %SMIL.Core.attrib;
    %SMIL.I18n.attrib;
    %SMIL.BasicText.attrib;
    %SMIL.TextStyling.attrib;
    %SMIL.textAlign.attrib;
    %SMIL.textDirection.attrib;
    %SMIL.textMode.attrib;
    %SMIL.textPlace.attrib;
    %SMIL.textWritingMode.attrib;
    %SMIL.TextMotion.attrib;
  >

  <!ENTITY % SMIL.textStyling.attrib "">
  <!ENTITY % SMIL.textStyling.content "(%SMIL.textStyle.qname;)*">
  <!ENTITY % SMIL.textStyling.qname "textStyling">
  <!ELEMENT %SMIL.textStyling.qname; %SMIL.textStyling.content;>
  <!ATTLIST %SMIL.textStyling.qname; %SMIL.textStyling.attrib;
    %SMIL.Core.attrib;
    %SMIL.I18n.attrib;
  >
]]>

<!-- ================== TextMotion ======================================== -->
<!ENTITY % SMIL.TextMotion.module "IGNORE">
<![%SMIL.TextMotion.module;[
]]>

<!-- end of SMIL-smiltext.mod -->
