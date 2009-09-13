<!-- ====================================================================== -->
<!-- SMIL 3.0 Layout Modules ============================================== -->
<!-- file: SMIL-layout.mod

        This is SMIL 3.0.

        Copyright: 1998-2008 W3C (MIT, ERCIM, Keio), All Rights
        Reserved.  See http://www.w3.org/Consortium/Legal/.

        Editor for SMIL 3.0: Sjoerd Mullender, CWI
        Editor for previous versions of SMIL: Jacco van Ossenbruggen,
        Aaron Cohen, Sjoerd Mullender.
        $Revision: 1.12 $
        $Date: 2008/09/18 10:33:45 $

        This DTD module is identified by the PUBLIC and SYSTEM identifiers:

        PUBLIC "-//W3C//ELEMENTS SMIL 3.0 Layout//EN"
        SYSTEM "http://www.w3.org/2008/SMIL30/SMIL-layout.mod"

        =================================================================== -->

<!-- ================== StructureLayout =================================== -->
<!ENTITY % SMIL.StructureLayout.module "IGNORE">
<![%SMIL.StructureLayout.module;[
  <!-- ================== StructureLayout Profiling Entities ============== -->
  <!ENTITY % SMIL.layout.attrib       "">
  <!ENTITY % SMIL.layout.content     "EMPTY">

  <!-- ================== StructureLayout Elements ======================== -->
  <!--
     Layout contains the region and root-layout elements defined by
     smil-basic-layout or other elements defined by an external layout
     mechanism.
  -->

  <!ENTITY % SMIL.layout.qname "layout">
  <!ELEMENT %SMIL.layout.qname; %SMIL.layout.content;>
  <!ATTLIST %SMIL.layout.qname; %SMIL.layout.attrib;
        %SMIL.Core.attrib;
        %SMIL.I18n.attrib;
        type CDATA 'text/smil-basic-layout'
  >
]]> <!-- end StructureLayout.module -->

<!-- ================== BasicLayout ======================================= -->
<!ENTITY % SMIL.BasicLayout.module "IGNORE">
<![%SMIL.BasicLayout.module;[
  <!-- ================== BasicLayout Profiling Entities ================== -->
  <!ENTITY % SMIL.region.attrib       "">
  <!ENTITY % SMIL.rootlayout.attrib   "">
  <!ENTITY % SMIL.region.content     "EMPTY">
  <!ENTITY % SMIL.rootlayout.content "EMPTY">

  <!-- ================== BasicLayout Entities ============================ -->
  <!-- Serious hacking: we need an extra level of indirection to get
       the correct default value of the backgroundOpacity attribute
  -->
  <!ENTITY % SMIL.backgroundOpacity.attrib-indirect "%SMIL.backgroundOpacity.attrib;">
  <!ENTITY % SMIL.backgroundOpacity.attrib-indirect2 "%SMIL.backgroundOpacity.attrib-indirect;">
  <!ENTITY % SMIL.common-layout-attrs "
        %SMIL.region-size.attrib;
        %SMIL.backgroundColor.attrib;
        %SMIL.backgroundOpacity.attrib-indirect2;
  ">

  <!ENTITY % SMIL.region-attrs "
        %SMIL.region-positioning.attrib;
        %SMIL.z-index.attrib;
        %SMIL.fit.attrib;
        showBackground      (always|whenActive) 'always'
  ">

  <!-- ================== Region Element ================================== -->
  <!ENTITY % SMIL.region.qname "region">
  <!ELEMENT %SMIL.region.qname; %SMIL.region.content;>
  <!ATTLIST %SMIL.region.qname; %SMIL.region.attrib;
        %SMIL.Core.attrib;
        %SMIL.I18n.attrib;
        %SMIL.backgroundColor.deprecated.attrib;
        %SMIL.common-layout-attrs;
        %SMIL.region-attrs;
        regionName NMTOKEN #IMPLIED
  >

  <!-- ================== Root-layout Element ============================= -->
  <!ENTITY % SMIL.root-layout.qname "root-layout">
  <!ELEMENT %SMIL.root-layout.qname; %SMIL.rootlayout.content; >
  <!ATTLIST %SMIL.root-layout.qname; %SMIL.rootlayout.attrib;
        %SMIL.Core.attrib;
        %SMIL.I18n.attrib;
        %SMIL.backgroundColor.deprecated.attrib;
        %SMIL.common-layout-attrs;
  >
]]> <!-- end BasicLayout.module -->

<!-- ================== AudioLayout ======================================= -->
<!ENTITY % SMIL.AudioLayout.module "IGNORE">
<![%SMIL.AudioLayout.module;[
  <!-- ================== AudioLayout Entities ============================ -->
  <!ENTITY % SMIL.soundLevel.attrib "
        soundLevel                        CDATA    '+0.0dB'
  ">

  <!-- ================ AudioLayout Elements ============================== -->
  <!-- ================ Add soundLevel to region element ================== -->
  <!ATTLIST %SMIL.region.qname; %SMIL.soundLevel.attrib;>
  <!-- ================ Add soundLevel to media elements ================== -->
  <!ENTITY % SMIL.OverrideLayout.module "IGNORE">
  <![%SMIL.OverrideLayout.module;[
    <!ATTLIST %SMIL.ref.qname; %SMIL.soundLevel.attrib;>
    <!ATTLIST %SMIL.animation.qname; %SMIL.soundLevel.attrib;>
    <!ATTLIST %SMIL.audio.qname; %SMIL.soundLevel.attrib;>
    <!ATTLIST %SMIL.img.qname; %SMIL.soundLevel.attrib;>
    <!ATTLIST %SMIL.text.qname; %SMIL.soundLevel.attrib;>
    <!ATTLIST %SMIL.textstream.qname; %SMIL.soundLevel.attrib;>
    <!ATTLIST %SMIL.video.qname; %SMIL.soundLevel.attrib;>
  ]]>
]]> <!-- end AudioLayout.module -->


<!-- ================ MultiWindowLayout =================================== -->
<!ENTITY % SMIL.MultiWindowLayout.module "IGNORE">
<![%SMIL.MultiWindowLayout.module;[
  <!-- ============== MultiWindowLayout Profiling Entities ================ -->
  <!ENTITY % SMIL.topLayout.attrib    "">
  <!ENTITY % SMIL.topLayout.content   "EMPTY">
  
  <!-- ============== MultiWindowLayout Elements ========================== -->
  <!--================= topLayout element ================================= -->
  <!ENTITY % SMIL.topLayout.qname "topLayout">
  <!ELEMENT %SMIL.topLayout.qname; %SMIL.topLayout.content;>
  <!ATTLIST %SMIL.topLayout.qname; %SMIL.topLayout.attrib;
        %SMIL.Core.attrib;
        %SMIL.I18n.attrib;
        %SMIL.common-layout-attrs;
        close               (onRequest|whenNotActive) 'onRequest'
        open                (onStart|whenActive)      'onStart'
  >
]]> <!-- end MultiWindowLayout.module -->


<!-- ====================== AlignmentLayout =============================== -->
<!ENTITY % SMIL.AlignmentLayout.module "IGNORE">
<![%SMIL.AlignmentLayout.module;[
  <!-- ========== AlignmentLayout Profiling Entities ====================== -->
  <!ENTITY % SMIL.regPoint.attrib     "">
  <!ENTITY % SMIL.regPoint.content   "EMPTY">

  <!-- ============ AlignmentLayout Elements ============================== -->
  <!ENTITY % SMIL.regPoint.qname "regPoint">
  <!ELEMENT %SMIL.regPoint.qname; %SMIL.regPoint.content;>
  <!ATTLIST %SMIL.regPoint.qname; %SMIL.regPoint.attrib;
        %SMIL.Core.attrib;
        %SMIL.I18n.attrib;
        %SMIL.regAlign.attrib;
        %SMIL.region-positioning.attrib;
  >
  <!ATTLIST %SMIL.region.qname;
       %SMIL.RegistrationPoint.attrib;
       %SMIL.soundAlign.attrib;
  >
]]> <!-- end AlignmentLayout.module -->

<!-- ================== BackgroundTilingLayout ============================ -->
<!ENTITY % SMIL.BackgroundTilingLayout.module "IGNORE">
<![%SMIL.BackgroundTilingLayout.module;[
  <!-- ================== BackgroundTilingLayout Entities ================= -->
  <!ENTITY % SMIL.BackgroundTiling-attrs "
    backgroundImage  %URI.datatype;                            'none'
    backgroundRepeat (repeat|repeatX|repeatY|noRepeat|inherit) 'repeat'
">

  <!-- ================ BackgroundTilingLayout Elements =================== -->
  <!-- ================ Add attributes to region element ================== -->
  <!ATTLIST %SMIL.region.qname; %SMIL.BackgroundTiling-attrs;>
  <!ATTLIST %SMIL.root-layout.qname; %SMIL.BackgroundTiling-attrs;>
  <![%SMIL.MultiWindowLayout.module;[
    <!ATTLIST %SMIL.topLayout.qname; %SMIL.BackgroundTiling-attrs;>
  ]]>
]]> <!-- end BackgroundTilingLayout.module -->




<!-- end of SMIL-layout.mod -->
