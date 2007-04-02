<!-- ================================================================= -->
<!-- SMIL Timing and Synchronization Modules ========================= -->
<!-- file: SMIL-timing.mod

     This is SMIL 2.1.

        Copyright: 1998-2005 W3C (MIT, ERCIM, Keio), All Rights
        Reserved.  See http://www.w3.org/Consortium/Legal/.

        Author:     Jacco van Ossenbruggen.
        Editor for SMIL 2.1: Sjoerd Mullender, CWI
        $Revision: 1.1 $
        $Date: 2007-04-02 05:08:39 $

     This DTD module is identified by the PUBLIC and SYSTEM identifiers:

     PUBLIC "-//W3C//ELEMENTS SMIL 2.1 Timing//EN"
     SYSTEM "http://www.w3.org/2005/SMIL21/SMIL-timing.mod"

     ================================================================= -->


<!-- ================== Timing Elements ============================== -->

<!ENTITY % SMIL.BasicTimeContainers.module "IGNORE">
<![%SMIL.BasicTimeContainers.module;[
  <!ENTITY % SMIL.par.content "EMPTY">
  <!ENTITY % SMIL.seq.content "EMPTY">
  <!ENTITY % SMIL.par.attrib  "">
  <!ENTITY % SMIL.seq.attrib  "">
  <!ENTITY % SMIL.seq.qname   "seq">
  <!ENTITY % SMIL.par.qname   "par">

  <!ELEMENT %SMIL.seq.qname; %SMIL.seq.content;>
  <!ATTLIST %SMIL.seq.qname; %SMIL.seq.attrib;
   %Core.attrib;
   %I18n.attrib;
   %SMIL.Description.attrib;
  >

  <!ELEMENT %SMIL.par.qname; %SMIL.par.content;>
  <!ATTLIST %SMIL.par.qname; %SMIL.par.attrib;
   %Core.attrib;
   %I18n.attrib;
   %SMIL.Description.attrib;
  >
]]>  <!-- End of BasicTimeContainers.module -->


<!ENTITY % SMIL.BasicExclTimeContainers.module "IGNORE">
<![%SMIL.BasicExclTimeContainers.module;[
  <!ENTITY % SMIL.excl.content          "EMPTY">
  <!ENTITY % SMIL.excl.attrib           "">
  <!ENTITY % SMIL.excl.qname            "excl">

  <!ELEMENT %SMIL.excl.qname; %SMIL.excl.content;>
  <!ATTLIST %SMIL.excl.qname; %SMIL.excl.attrib;
   %Core.attrib;
   %I18n.attrib;
   %SMIL.Description.attrib;
  >
]]>  <!-- End of BasicExclTimeContainers.module -->

<!ENTITY % SMIL.BasicPriorityClassContainers.module "IGNORE">
<![%SMIL.BasicPriorityClassContainers.module;[
  <!ENTITY % SMIL.priorityClass.content "EMPTY">
  <!ENTITY % SMIL.priorityClass.attrib  "">
  <!ENTITY % SMIL.priorityClass.qname   "priorityClass">

  <!ELEMENT %SMIL.priorityClass.qname; %SMIL.priorityClass.content;>
  <!ATTLIST %SMIL.priorityClass.qname; %SMIL.priorityClass.attrib;
    peers       (stop|pause|defer|never) "stop"
    higher      (stop|pause)             "pause" 
    lower       (defer|never)            "defer"
    pauseDisplay (disable|hide|show )    "show"
    %SMIL.Description.attrib;
    %Core.attrib;
    %I18n.attrib;
  >
]]>  <!-- End of BasicPriorityClassContainers.module -->

<!-- end of SMIL-timing.mod -->
