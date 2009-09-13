<!-- ====================================================================== -->
<!-- SMIL 3.0 State Modules =============================================== -->
<!-- file: SMIL-state.mod

        This is SMIL 3.0.

        Copyright: 1998-2008 W3C (MIT, ERCIM, Keio), All Rights
        Reserved.  See http://www.w3.org/Consortium/Legal/.

        Editor for SMIL 3.0: Sjoerd Mullender, CWI
        $Revision: 1.8 $
        $Date: 2008/09/07 20:36:50 $

        This DTD module is identified by the PUBLIC and SYSTEM identifiers:

        PUBLIC "-//W3C//ELEMENTS SMIL 3.0 State//EN"
        SYSTEM "http://www.w3.org/2008/SMIL30/SMIL-state.mod"

        =================================================================== -->

<!-- ================== StateTest ========================================= -->
<!ENTITY % SMIL.StateTest.module "IGNORE">
<![%SMIL.StateTest.module;[
  <!-- this module only defines the expr attribute, for which
       see smil-attribs-1.mod
  -->
]]>

<!-- ================== UserState ========================================= -->
<!ENTITY % SMIL.UserState.module "IGNORE">
<![%SMIL.UserState.module;[
  <!-- can be overridden by the profile -->
  <!ENTITY % SMIL.language-attrib-default "#IMPLIED">
  <!ENTITY % SMIL.newvalue-ref-attrib-default "#IMPLIED">
  <!ENTITY % SMIL.newvalue-name-attrib-default "#IMPLIED">

  <!ENTITY % SMIL.state.attrib "">
  <!ENTITY % SMIL.state.content "EMPTY">
  <!ENTITY % SMIL.state.qname "state">
  <!ELEMENT %SMIL.state.qname; %SMIL.state.content;>
  <!ATTLIST %SMIL.state.qname; %SMIL.state.attrib;
    %SMIL.Core.attrib;
    %SMIL.I18n.attrib;
    language %URI.datatype; %SMIL.language-attrib-default;
    src      %URI.datatype; #IMPLIED
  >

  <!ENTITY % SMIL.setvalue.attrib "">
  <!ENTITY % SMIL.setvalue.content "EMPTY">
  <!ENTITY % SMIL.setvalue.qname "setvalue">
  <!ELEMENT %SMIL.setvalue.qname; %SMIL.setvalue.content;>
  <!ATTLIST %SMIL.setvalue.qname; %SMIL.setvalue.attrib;
    %SMIL.Core.attrib;
    %SMIL.I18n.attrib;
    ref   CDATA #REQUIRED
    value CDATA #REQUIRED
  >

  <!ENTITY % SMIL.newvalue.attrib "">
  <!ENTITY % SMIL.newvalue.content "EMPTY">
  <!ENTITY % SMIL.newvalue.qname "newvalue">
  <!ELEMENT %SMIL.newvalue.qname; %SMIL.newvalue.content;>
  <!ATTLIST %SMIL.newvalue.qname; %SMIL.newvalue.attrib;
    %SMIL.Core.attrib;
    %SMIL.I18n.attrib;
    ref   CDATA                    %SMIL.newvalue-ref-attrib-default;
    where (before | after | child) 'child'
    name  CDATA                    %SMIL.newvalue-name-attrib-default;
    value CDATA                    #IMPLIED
  >

  <!ENTITY % SMIL.delvalue.attrib "">
  <!ENTITY % SMIL.delvalue.content "EMPTY">
  <!ENTITY % SMIL.delvalue.qname "delvalue">
  <!ELEMENT %SMIL.delvalue.qname; %SMIL.delvalue.content;>
  <!ATTLIST %SMIL.delvalue.qname; %SMIL.delvalue.attrib;
    %SMIL.Core.attrib;
    %SMIL.I18n.attrib;
    ref CDATA #REQUIRED
  >
]]>

<!-- ================== StateSubmission =================================== -->
<!ENTITY % SMIL.StateSubmission.module "IGNORE">
<![%SMIL.StateSubmission.module;[
  <!ENTITY % SMIL.method-types "">

  <!ENTITY % SMIL.submission.attrib "">
  <!ENTITY % SMIL.submission.content "EMPTY">
  <!ENTITY % SMIL.submission.qname "submission">
  <!ELEMENT %SMIL.submission.qname; %SMIL.submission.content;>
  <!ATTLIST %SMIL.submission.qname; %SMIL.submission.attrib;
    %SMIL.Core.attrib;
    %SMIL.I18n.attrib;
    ref     CDATA                            #IMPLIED
    action  %URI.datatype;                   #REQUIRED
    method  (put | get %SMIL.method-types;)  #REQUIRED
    replace (all | instance | none)          #IMPLIED
    target  CDATA                            #IMPLIED
  >

  <!ENTITY % SMIL.send.attrib "">
  <!ENTITY % SMIL.send.content "EMPTY">
  <!ENTITY % SMIL.send.qname "send">
  <!ELEMENT %SMIL.send.qname; %SMIL.send.content;>
  <!ATTLIST %SMIL.send.qname; %SMIL.send.attrib;
    %SMIL.Core.attrib;
    %SMIL.I18n.attrib;
    submission IDREF #IMPLIED
  >
]]>

<!-- ================== StateInterpolation ================================ -->
<!ENTITY % SMIL.StateInterpolation.module "IGNORE">
<![%SMIL.StateInterpolation.module;[
  <!-- no new elements or attributes -->
]]>

<!-- end of SMIL-state.mod -->
