<!-- ====================================================================== -->
<!-- SMIL 3.0 Timesheet Module ============================================ -->
<!-- file: SMIL-timesheet.mod

        This is SMIL 3.0.

        Copyright: 1998-2008 W3C (MIT, ERCIM, Keio), All Rights
        Reserved.  See http://www.w3.org/Consortium/Legal/.

        Editor for SMIL 3.0: Sjoerd Mullender, CWI
        $Revision: 1.3 $
        $Date: 2008/09/07 20:36:50 $

        This DTD module is identified by the PUBLIC and SYSTEM identifiers:

        PUBLIC "-//W3C//ELEMENTS SMIL 3.0 Timesheet//EN"
        SYSTEM "http://www.w3.org/2008/SMIL30/SMIL-timesheet.mod"

        =================================================================== -->

<!-- ================== Timesheet ========================================= -->
<!ENTITY % SMIL.Timesheet.module "IGNORE">
<![%SMIL.Timesheet.module;[
  <!ENTITY % SMIL.timesheet.attrib "">
  <!ENTITY % SMIL.timesheet.qname "timesheet">
  <!ENTITY % SMIL.timesheet.content "EMPTY">
  <!ELEMENT %SMIL.timesheet.qname; %SMIL.timesheet.content;>
  <!ATTLIST %SMIL.timesheet.qname; %SMIL.timesheet.attrib;
    %SMIL.Core.attrib;
    %SMIL.I18n.attrib;
    src          %URI.datatype;      #IMPLIED
    media        CDATA               #IMPLIED
  >

  <!ENTITY % SMIL.item.attrib "">
  <!ENTITY % SMIL.item.qname "item">
  <!ENTITY % SMIL.item.content "EMPTY">
  <!ELEMENT %SMIL.item.qname; %SMIL.item.content;>
  <!ATTLIST %SMIL.item.qname; %SMIL.item.attrib;
    %SMIL.Core.attrib;
    %SMIL.I18n.attrib;
    select       CDATA               #IMPLIED
    beginInc     CDATA               #IMPLIED
    indexStart   %Number.datatype;   #IMPLIED
  >
]]>

<!-- end of SMIL-timesheet.mod -->
