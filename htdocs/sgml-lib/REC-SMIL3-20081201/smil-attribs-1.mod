<!-- ...................................................................... -->
<!-- SMIL 3.0 Common Attributes Module  ................................... -->
<!-- file: smil-attribs-1.mod

      This is SMIL 3.0.

        Copyright: 1998-2008 W3C (MIT, ERCIM, Keio), All Rights
        Reserved.  See http://www.w3.org/Consortium/Legal/.

        Editor for SMIL 3.0: Sjoerd Mullender, CWI
        Editor for previous versions of SMIL: Warner ten Kate,
        Jacco van Ossenbruggen, Sjoerd Mullender.
        $Revision: 1.16 $
        $Date: 2008/09/07 20:36:49 $

     This DTD module is identified by the PUBLIC and SYSTEM identifiers:

     PUBLIC "-//W3C//ENTITIES SMIL 3.0 Common Attributes 1.0//EN"
     SYSTEM "http://www.w3.org/2008/SMIL30/smil-attribs-1.mod"

     ...................................................................... -->

<!-- Common Attributes

     This module declares the common attributes for the SMIL DTD Modules.
-->

<!ENTITY % SMIL.pfx "">

<!ENTITY % SMIL.Structure.module "IGNORE">
<![%SMIL.Structure.module;[
  <!ENTITY % SMIL.id.attrib
   "xml:id                 ID                       #IMPLIED"
  >

  <!ENTITY % SMIL.class.attrib
   "%SMIL.pfx;class        CDATA                    #IMPLIED"
  >
]]>
<!ENTITY % SMIL.TextExternal.module "IGNORE">
<![%SMIL.TextExternal.module;[
  <!ENTITY % SMIL.id.attrib
   "xml:id                 ID                       #IMPLIED"
  >
]]>
<!ENTITY % SMIL.id.attrib "">
<!ENTITY % SMIL.class.attrib "">

<!-- the title and xml:lang attributes are defined both in the
     Structure module and the MediaDescription module, but they are
     defined identically
-->
<!ENTITY % SMIL.Structure.module "IGNORE">
<![%SMIL.Structure.module;[
  <!ENTITY % SMIL.title.attrib
   "%SMIL.pfx;title        %Text.datatype;                   #IMPLIED"
  >
  <!ENTITY % SMIL.xml.lang.attrib
   "xml:lang %LanguageCode.datatype; #IMPLIED"
  >
]]>
<!ENTITY % SMIL.MediaDescription.module "IGNORE">
<![%SMIL.MediaDescription.module;[
  <!ENTITY % SMIL.title.attrib
   "%SMIL.pfx;title        %Text.datatype;                   #IMPLIED"
  >
  <!ENTITY % SMIL.xml.lang.attrib
   "xml:lang %LanguageCode.datatype; #IMPLIED"
  >
]]>
<![%SMIL.TextExternal.module;[
  <!ENTITY % SMIL.xml.lang.attrib
   "xml:lang %LanguageCode.datatype; #IMPLIED"
  >
]]>
<!ENTITY % SMIL.title.attrib "">
<!ENTITY % SMIL.xml.lang.attrib "">

<!ENTITY % SMIL.Identity.module "IGNORE">
<![%SMIL.Identity.module;[
  <!-- the baseProfile declaration may be overridden by the profile -->
  <!ENTITY % SMIL.baseProfile.default "#IMPLIED">
  <!ENTITY % SMIL.Identity.attrib "
    %SMIL.pfx;version      (3.0)                    #FIXED '3.0'
    %SMIL.pfx;baseProfile  NMTOKEN                  %SMIL.baseProfile.default;
  ">
]]>
<!ENTITY % SMIL.Identity.attrib "">

<!ENTITY % SMIL.Metainformation.module "IGNORE">
<![%SMIL.Metainformation.module;[
  <!ENTITY % SMIL.label.attrib "
    %SMIL.pfx;label        %URI.datatype;           #IMPLIED
  ">
]]>
<!ENTITY % SMIL.label.attrib "">

<!ENTITY % SMIL.MediaAccessibility.module "IGNORE">
<![%SMIL.MediaAccessibility.module;[
  <!ENTITY % SMIL.Accessibility.attrib "
    %SMIL.pfx;alt          %Text.datatype;                   #IMPLIED
    %SMIL.pfx;longdesc     %URI.datatype;                    #IMPLIED
    %SMIL.pfx;readIndex    CDATA                             '0'
  ">
]]>
<!ENTITY % SMIL.Accessibility.attrib "">


<!ENTITY % SMIL.Core.extra.attrib "" >
<!ENTITY % SMIL.Core.attrib "
  xml:base %URI.datatype; #IMPLIED
  %SMIL.id.attrib;
  %SMIL.class.attrib;
  %SMIL.title.attrib;
  %SMIL.Accessibility.attrib;
  %SMIL.label.attrib;
  %SMIL.Identity.attrib;
  %SMIL.xmlns.extra.attrib;
  %SMIL.Core.extra.attrib;
">

<!ENTITY % SMIL.RoleAttributes.module "IGNORE">
<![%SMIL.RoleAttributes.module;[
  <!ENTITY % XHTMLNS "
    xmlns:xhtml CDATA 'http://www.w3.org/1999/xhtml'
  ">

  <!ENTITY % XHTMLPR "xhtml:">

  <!ENTITY % XHTML-Role-attrib "
    %XHTMLPR;role CDATA #IMPLIED
  ">
]]>
<!ENTITY % XHTMLNS "">
<!ENTITY % XHTML-Role-attrib "">

<!ENTITY % SMIL.ITS-Attributes.module "IGNORE">
<![%SMIL.ITS-Attributes.module;[
  <!-- Entity for the definition of the ITS namespace, necessary for
       DTD processing
  -->
  <!ENTITY % ITSNS "
    xmlns:its CDATA 'http://www.w3.org/2005/11/its'
  ">

  <!-- Prefix commonly used for ITS markup -->
  <!ENTITY % ITSPR "its:">

  <!-- Entity which contains local ITS markup for internationalization
       and localization purposes. Explanatations:
       - its:translate : Attribute to express translation
         information. See
         http://www.w3.org/TR/2007/REC-its-20070403/#trans-datacat .
       - its:locNote : Attribute for localization notes. See
         http://www.w3.org/TR/2007/REC-its-20070403/#locNote-datacat .
       - its:locNoteType: Attribute for the localization note type
         (description or alert). See
         http://www.w3.org/TR/2007/REC-its-20070403/#locNote-datacat .
       - its:term : Attribute to specify terms. See
         http://www.w3.org/TR/2007/REC-its-20070403/#terminology .
       - its:termInfoRef : Attribute to provide references to
         additional information about a term. See
         http://www.w3.org/TR/2007/REC-its-20070403/#terminology .
       - its:dir : Attribute to supply information about text
         directionality. See
         http://www.w3.org/TR/2007/REC-its-20070403/#directionality .
  -->
  <!ENTITY % ITS-LOCAL-ATTR "
    %ITSPR;translate   (yes | no)              #IMPLIED
    %ITSPR;locNote     CDATA                   #IMPLIED
    %ITSPR;locNoteType (alert | description)   #IMPLIED
    %ITSPR;locNoteRef  CDATA                   #IMPLIED
    %ITSPR;termInfoRef CDATA                   #IMPLIED
    %ITSPR;term        (yes | no)              #IMPLIED
    %ITSPR;dir         (ltr | rtl | lro | rlo) #IMPLIED
  ">
]]>
<!ENTITY % ITSNS "">
<!ENTITY % ITS-LOCAL-ATTR "">

<!ENTITY % SMIL.I18n.extra.attrib "" >
<!ENTITY % SMIL.I18n.attrib "
  %SMIL.xml.lang.attrib;
  %SMIL.I18n.extra.attrib;
  %ITS-LOCAL-ATTR;
">
<!-- ITS-LOCAL-ATTR contains attribute declarations for
     internationalization and localization related markup. See
     http://www.w3.org/TR/2007/REC-its-20070403/ for more information.
-->

<![%SMIL.MediaDescription.module;[
  <!ENTITY % SMIL.Description.attrib "
    %SMIL.pfx;abstract        %Text.datatype;   #IMPLIED
    %SMIL.pfx;author          %Text.datatype;   #IMPLIED
    %SMIL.pfx;copyright       %Text.datatype;   #IMPLIED
  ">
]]>
<!ENTITY % SMIL.Description.attrib "">

<!ENTITY % SMIL.LinkingAttributes.module "IGNORE">
<![%SMIL.LinkingAttributes.module;[
  <!ENTITY % SMIL.tabindex.attrib "
    %SMIL.pfx;tabindex        %Number.datatype;   #IMPLIED
  ">
]]>
<!ENTITY % SMIL.tabindex.attrib "">

<!-- ================== BasicLayout ======================================= -->
<!ENTITY % SMIL.BasicLayout.module "IGNORE">
<![%SMIL.BasicLayout.module;[
  <!ENTITY % SMIL.regionAttr.attrib "
   %SMIL.pfx;region                CDATA    #IMPLIED
  ">

  <!-- add one &#38; for each level of indirection -->
  <!ENTITY % SMIL.backgroundOpacity.attrib "
   %SMIL.pfx;backgroundOpacity     CDATA    '100&#38;#38;#38;#37;'
  ">

  <!ENTITY % SMIL.backgroundColor.attrib "
   %SMIL.pfx;backgroundColor       %Color.datatype;    #IMPLIED
  ">
  <!ENTITY % SMIL.backgroundColor.deprecated.attrib "
   %SMIL.pfx;background-color      %Color.datatype;    #IMPLIED
  ">

  <!ENTITY % SMIL.region-positioning.attrib "
   %SMIL.pfx;top                   CDATA    'auto'
   %SMIL.pfx;bottom                CDATA    'auto'
   %SMIL.pfx;left                  CDATA    'auto'
   %SMIL.pfx;right                 CDATA    'auto'
  ">

  <!ENTITY % SMIL.region-size.attrib "
   %SMIL.pfx;height                CDATA    'auto'
   %SMIL.pfx;width                 CDATA    'auto'
  ">

  <!ENTITY % SMIL.z-index.attrib "
   %SMIL.pfx;z-index               CDATA    #IMPLIED
  ">

  <!ENTITY % SMIL.fit.attrib "
   %SMIL.pfx;fit           (hidden|fill|meet|meetBest|scroll|slice)   #IMPLIED 
  ">
]]>
<!ENTITY % SMIL.regionAttr.attrib "">
<!ENTITY % SMIL.backgroundOpacity.attrib "">
<!ENTITY % SMIL.backgroundColor.attrib "">
<!ENTITY % SMIL.backgroundColor.deprecated.attrib "">
<!ENTITY % SMIL.region-positioning.attrib "">
<!ENTITY % SMIL.region-size.attrib "">
<!ENTITY % SMIL.z-index.attrib "">
<!ENTITY % SMIL.fit.attrib "">

<!-- ================== SubRegionLayout =================================== -->
<!ENTITY % SMIL.SubRegionLayout.module "IGNORE">
<![%SMIL.SubRegionLayout.module;[
  <!-- requires BasicLayout -->
  <!ENTITY % SMIL.SubRegionLayout.attrib "
    %SMIL.region-positioning.attrib;
    %SMIL.region-size.attrib;
  ">
]]>
<!ENTITY % SMIL.SubRegionLayout.attrib "">

<!-- ================== OverrideLayout ==================================== -->
<!ENTITY % SMIL.OverrideLayout.module "IGNORE">
<![%SMIL.OverrideLayout.module;[
  <!-- requires BasicLayout -->
  <!ENTITY % SMIL.OverrideLayout.attrib "
    %SMIL.backgroundColor.attrib;
    %SMIL.backgroundOpacity.attrib;
    %SMIL.fit.attrib;
    %SMIL.z-index.attrib;
  ">
]]>
<!ENTITY % SMIL.OverrideLayout.attrib "">

<!-- ================ Registration Point attribute for media elements ===== -->
<!-- integrating language using AlignmentLayout must include regPoint       -->
<!-- attribute on media elements for regPoint elements to be useful         -->

<!ENTITY % SMIL.AlignmentLayout.module "IGNORE">
<![%SMIL.AlignmentLayout.module;[
  <!ENTITY % SMIL.regPointAttr.attrib "
    %SMIL.pfx;regPoint  CDATA    #IMPLIED
  ">

  <!ENTITY % SMIL.regAlign.attrib "
    %SMIL.pfx;regAlign  (topLeft|topMid|topRight|midLeft|center|
                     midRight|bottomLeft|bottomMid|bottomRight) #IMPLIED
  ">

  <!ENTITY % SMIL.mediaAlign.attrib "
    %SMIL.pfx;mediaAlign (topLeft|topMid|topRight|midLeft|center|
                     midRight|bottomLeft|bottomMid|bottomRight) #IMPLIED
  ">

  <!ENTITY % SMIL.soundAlign.attrib "
    %SMIL.pfx;soundAlign (left|both|right) #IMPLIED
  ">
]]>
<!ENTITY % SMIL.regPointAttr.attrib "">
<!ENTITY % SMIL.regAlign.attrib "">
<!ENTITY % SMIL.mediaAlign.attrib "">
<!ENTITY % SMIL.soundAlign.attrib "">

<!ENTITY % SMIL.RegistrationPoint.attrib "
  %SMIL.regPointAttr.attrib;
  %SMIL.regAlign.attrib;
  %SMIL.mediaAlign.attrib;
">

<!--=================== Content Control =======================-->
<!-- customTest Attribute, do not confuse with customTest element! -->
<!ENTITY % SMIL.CustomTestAttributes.module "IGNORE">
<![%SMIL.CustomTestAttributes.module;[
  <!ENTITY % SMIL.customTestAttr.attrib "
    %SMIL.pfx;customTest              CDATA          #IMPLIED
  ">
]]>
<!ENTITY % SMIL.customTestAttr.attrib "">

<!-- ========================= SkipContentControl Module ================== -->
<!ENTITY % SMIL.SkipContentControl.module "IGNORE">
<![%SMIL.SkipContentControl.module;[
  <!ENTITY % SMIL.skip-content.attrib "
    %SMIL.pfx;skip-content          (true|false)    'true'
  ">
]]>
<!ENTITY % SMIL.skip-content.attrib "">

<!-- Content Control Test Attributes --> 

<!ENTITY % SMIL.BasicContentControl.module "IGNORE">
<!ENTITY % SMIL.ContentControl.deprecated.module "IGNORE">
<![%SMIL.BasicContentControl.module;[
  <!ENTITY % SMIL.BasicContentControl.attrib "
    %SMIL.pfx;systemAudioDesc               (on|off)        #IMPLIED
    %SMIL.pfx;systemBaseProfile             NMTOKEN         #IMPLIED
    %SMIL.pfx;systemBitrate                 CDATA           #IMPLIED
    %SMIL.pfx;systemCaptions                (on|off)        #IMPLIED
    %SMIL.pfx;systemComponent               CDATA           #IMPLIED
    %SMIL.pfx;systemCPU                     NMTOKEN         #IMPLIED
    %SMIL.pfx;systemLanguage                CDATA           #IMPLIED
    %SMIL.pfx;systemOperatingSystem         NMTOKEN         #IMPLIED
    %SMIL.pfx;systemOverdubOrSubtitle       (overdub|subtitle) #IMPLIED
    %SMIL.pfx;systemScreenDepth             CDATA           #IMPLIED
    %SMIL.pfx;systemScreenSize              CDATA           #IMPLIED
    %SMIL.pfx;systemVersion                 (3.0)           #IMPLIED
  ">
  <![%SMIL.ContentControl.deprecated.module;[
    <!ENTITY % SMIL.BasicContentControl.deprecated.attrib "
      %SMIL.pfx;system-bitrate                CDATA           #IMPLIED
      %SMIL.pfx;system-captions               (on|off)        #IMPLIED
      %SMIL.pfx;system-language               CDATA           #IMPLIED
      %SMIL.pfx;system-overdub-or-caption     (overdub|caption) #IMPLIED
      %SMIL.pfx;system-screen-depth           CDATA           #IMPLIED
      %SMIL.pfx;system-screen-size            CDATA           #IMPLIED
    ">
  ]]>
]]>
<!ENTITY % SMIL.BasicContentControl.attrib "">
<!ENTITY % SMIL.BasicContentControl.deprecated.attrib "">

<!ENTITY % SMIL.RequiredContentControl.module "IGNORE">
<![%SMIL.RequiredContentControl.module;[
  <!ENTITY % SMIL.RequiredContentControl.attrib "
    %SMIL.pfx;systemRequired                CDATA           #IMPLIED
  ">
  <![%SMIL.ContentControl.deprecated.module;[
    <!ENTITY % SMIL.RequiredContentControl.deprecated.attrib "
      %SMIL.pfx;system-required               CDATA           #IMPLIED
    ">
  ]]>
]]>
<!ENTITY % SMIL.RequiredContentControl.attrib "">
<!ENTITY % SMIL.RequiredContentControl.deprecated.attrib "">

<!ENTITY % SMIL.Test.attrib "
  %SMIL.BasicContentControl.attrib;
  %SMIL.BasicContentControl.deprecated.attrib;
  %SMIL.RequiredContentControl.attrib;
  %SMIL.RequiredContentControl.deprecated.attrib;
">

<!-- SMIL Animation Module  =============================================== -->
<!ENTITY % SMIL.BasicAnimation.module "IGNORE">
<![%SMIL.BasicAnimation.module;[
  <!ENTITY % SMIL.BasicAnimation.attrib "
    %SMIL.pfx;values     CDATA #IMPLIED
    %SMIL.pfx;from       CDATA #IMPLIED
    %SMIL.pfx;to         CDATA #IMPLIED
    %SMIL.pfx;by         CDATA #IMPLIED
  ">
]]>
<!ENTITY % SMIL.BasicAnimation.attrib "">

<!-- SMIL SMILtext Module  ================================================ -->
<!ENTITY % SMIL.BasicText.module "IGNORE">
<![%SMIL.BasicText.module;[
  <!ENTITY % SMIL.BasicText.attrib "
    %SMIL.pfx;textWrapOption (wrap|noWrap|inherit) 'wrap'
    xml:space                (default|preserve)    'default'
  ">
]]>
<!ENTITY % SMIL.BasicText.attrib "">

<!ENTITY % SMIL.TextMotion.module "IGNORE">
<![%SMIL.TextMotion.module;[
  <!ENTITY % SMIL.textMode-motion-values "|crawl|scroll|jump">
  <!ENTITY % SMIL.TextMotion.attrib "
    %SMIL.pfx;textConceal (none|initial|final|both|inherit) 'inherit'
    %SMIL.pfx;textRate    CDATA                             'auto'
  ">
]]>
<!ENTITY % SMIL.textMode-motion-values "">
<!ENTITY % SMIL.TextMotion.attrib "">

<!ENTITY % SMIL.TextStyling.module "IGNORE">
<![%SMIL.TextStyling.module;[
  <!ENTITY % SMIL.textAlign.attrib "
    %SMIL.pfx;textAlign (start|end|left|right|center|inherit) 'inherit'
  ">
  <!ENTITY % SMIL.textDirection.attrib "
    %SMIL.pfx;textDirection (ltr|rtl|ltro|rtlo|inherit) 'inherit'
  ">
  <!ENTITY % SMIL.textMode.attrib "
    %SMIL.pfx;textMode (append|replace%SMIL.textMode-motion-values;|inherit) 'inherit'
  ">
  <!ENTITY % SMIL.textPlace.attrib "
    %SMIL.pfx;textPlace (start|center|end|inherit) 'inherit'
  ">
  <!ENTITY % SMIL.textWritingMode.attrib "
    %SMIL.pfx;textWritingMode (lr-tb|rl-tb|tb-lr|tb-rl|lr|rl|inherit) 'inherit'
  ">
  <!ENTITY % SMIL.TextStyling.attrib "
    %SMIL.pfx;textBackgroundColor %Color.datatype;      'transparent'
    %SMIL.pfx;textColor           %Color.datatype;      #IMPLIED
    %SMIL.pfx;textFontFamily      CDATA                 'inherit'
    %SMIL.pfx;textFontSize        CDATA                 'inherit'
    %SMIL.pfx;textFontStyle       (normal|italic|oblique|reverseOblique|inherit) 'inherit'
    %SMIL.pfx;textFontWeight      (normal|bold|inherit) 'inherit'
    %SMIL.pfx;textStyle           IDREF                 #IMPLIED
  ">
]]>
<!ENTITY % SMIL.textAlign.attrib "">
<!ENTITY % SMIL.textDirection.attrib "">
<!ENTITY % SMIL.textMode.attrib "">
<!ENTITY % SMIL.textPlace.attrib "">
<!ENTITY % SMIL.textWritingMode.attrib "">
<!ENTITY % SMIL.TextStyling.attrib "">

<!-- SMIL State Module  =================================================== -->
<!ENTITY % SMIL.StateTest.module "IGNORE">
<![%SMIL.StateTest.module;[
  <!ENTITY % SMIL.StateTest.attrib "
    %SMIL.pfx;expr CDATA #IMPLIED
  ">
]]>
<!ENTITY % SMIL.StateTest.attrib "">

<!-- SMIL Timing Module  ================================================== -->
<!ENTITY % SMIL.begin.attrib "%SMIL.pfx;begin %TimeValue.datatype; #IMPLIED">
<!ENTITY % SMIL.end.attrib "%SMIL.pfx;end %TimeValue.datatype; #IMPLIED">

<!ENTITY % SMIL.BasicInlineTiming.module "IGNORE">
<![%SMIL.BasicInlineTiming.module;[
  <!ENTITY % SMIL.BasicInlineTiming.attrib "
    %SMIL.begin.attrib;
    %SMIL.pfx;dur                       %TimeValue.datatype; #IMPLIED
    %SMIL.end.attrib;
  ">
]]>

<!ENTITY % SMIL.AccessKeyTiming.module "IGNORE">
<![%SMIL.AccessKeyTiming.module;[
  <!ENTITY % SMIL.BasicInlineTiming.attrib "
    %SMIL.begin.attrib;
    %SMIL.end.attrib;
  ">
]]>

<!ENTITY % SMIL.EventTiming.module "IGNORE">
<![%SMIL.EventTiming.module;[
  <!ENTITY % SMIL.BasicInlineTiming.attrib "
    %SMIL.begin.attrib;
    %SMIL.end.attrib;
  ">
]]>

<!ENTITY % SMIL.MediaMarkerTiming.module "IGNORE">
<![%SMIL.MediaMarkerTiming.module;[
  <!ENTITY % SMIL.BasicInlineTiming.attrib "
    %SMIL.begin.attrib;
    %SMIL.end.attrib;
  ">
]]>

<!ENTITY % SMIL.RepeatValueTiming.module "IGNORE">
<![%SMIL.RepeatValueTiming.module;[
  <!ENTITY % SMIL.BasicInlineTiming.attrib "
    %SMIL.begin.attrib;
    %SMIL.end.attrib;
  ">
]]>

<!ENTITY % SMIL.SyncbaseTiming.module "IGNORE">
<![%SMIL.SyncbaseTiming.module;[
  <!ENTITY % SMIL.BasicInlineTiming.attrib "
    %SMIL.begin.attrib;
    %SMIL.end.attrib;
  ">
]]>

<!ENTITY % SMIL.WallclockTiming.module "IGNORE">
<![%SMIL.WallclockTiming.module;[
  <!ENTITY % SMIL.BasicInlineTiming.attrib "
    %SMIL.begin.attrib;
    %SMIL.end.attrib;
  ">
]]>
<!ENTITY % SMIL.BasicInlineTiming.attrib "">

<!ENTITY % SMIL.RepeatTiming.module "IGNORE">
<!ENTITY % SMIL.RepeatTiming.deprecated.module "IGNORE">
<![%SMIL.RepeatTiming.module;[
  <!ENTITY % SMIL.RepeatTiming.attrib "
    %SMIL.pfx;repeatCount               %Number.datatype;    #IMPLIED
    %SMIL.pfx;repeatDur                 %TimeValue.datatype; #IMPLIED
  ">
  <![%SMIL.RepeatTiming.deprecated.module;[
    <!ENTITY % SMIL.RepeatTiming.deprecated.attrib "
      %SMIL.pfx;repeat                  %TimeValue.datatype; #IMPLIED
    ">
  ]]>
]]>
<!ENTITY % SMIL.RepeatTiming.attrib "">
<!ENTITY % SMIL.RepeatTiming.deprecated.attrib "">

<!ENTITY % SMIL.MinMaxTiming.module "IGNORE">
<![%SMIL.MinMaxTiming.module;[
  <!ENTITY % SMIL.MinMaxTiming.attrib "
    %SMIL.pfx;min                       %TimeValue.datatype; '0'
    %SMIL.pfx;max                       %TimeValue.datatype; 'indefinite'
  ">
]]>
<!ENTITY % SMIL.MinMaxTiming.attrib "">

<!ENTITY % SMIL.BasicTimeContainers.module "IGNORE">
<![%SMIL.BasicTimeContainers.module;[
  <!ENTITY % SMIL.IncludeFillEndsync "INCLUDE">
]]>
<!ENTITY % SMIL.BasicExclTimeContainers.module "IGNORE">
<![%SMIL.BasicExclTimeContainers.module;[
  <!ENTITY % SMIL.IncludeFillEndsync "INCLUDE">
]]>
<!ENTITY % SMIL.TimeContainerAttributes.module "IGNORE">
<![%SMIL.TimeContainerAttributes.module;[
  <!ENTITY % SMIL.IncludeFillEndsync "INCLUDE">
]]>
<!ENTITY % SMIL.IncludeFillEndsync "IGNORE">

<![%SMIL.IncludeFillEndsync;[
  <!ENTITY % SMIL.fill.attrib "
    %SMIL.pfx;fill (remove|freeze|hold|transition|auto|default) 'default'
  ">

  <!ENTITY % SMIL.endsync.attrib "
    %SMIL.pfx;endsync               CDATA 'last'
  ">

  <!-- endsync has a different default when applied to media elements -->
  <!ENTITY % SMIL.endsync.media.attrib "
    %SMIL.pfx;endsync               CDATA 'media'
  ">
]]>
<!ENTITY % SMIL.fill.attrib "">
<!ENTITY % SMIL.endsync.attrib "">
<!ENTITY % SMIL.endsync.media.attrib "">

<!ENTITY % SMIL.FillDefault.module "IGNORE">
<![%SMIL.FillDefault.module;[
  <!ENTITY % SMIL.fillDefault.attrib "
    %SMIL.pfx;fillDefault (remove|freeze|hold|transition|auto|inherit) 'inherit'
  ">
]]>
<!ENTITY % SMIL.fillDefault.attrib "">

<![%SMIL.TimeContainerAttributes.module;[
  <!ENTITY % SMIL.TimeContainerAttributes.attrib "
    %SMIL.pfx;timeAction            CDATA #IMPLIED
    %SMIL.pfx;timeContainer         CDATA #IMPLIED
  ">
]]>
<!ENTITY % SMIL.TimeContainerAttributes.attrib "">

<!ENTITY % SMIL.RestartTiming.module "IGNORE">
<![%SMIL.RestartTiming.module;[
  <!ENTITY % SMIL.RestartTiming.attrib "
    %SMIL.pfx;restart (always|whenNotActive|never|default) 'default'
  ">
]]>
<!ENTITY % SMIL.RestartTiming.attrib "">

<!ENTITY % SMIL.RestartDefault.module "IGNORE">
<![%SMIL.RestartDefault.module;[
  <!ENTITY % SMIL.RestartDefaultTiming.attrib "
    %SMIL.pfx;restartDefault (inherit|always|never|whenNotActive) 'inherit'
  ">
]]>
<!ENTITY % SMIL.RestartDefaultTiming.attrib "">

<!ENTITY % SMIL.SyncBehavior.module "IGNORE">
<![%SMIL.SyncBehavior.module;[
  <!ENTITY % SMIL.SyncBehavior.attrib "
    %SMIL.pfx;syncBehavior (canSlip|locked|independent|default) 'default'
    %SMIL.pfx;syncTolerance %TimeValue.datatype;                'default'
  ">
]]>
<!ENTITY % SMIL.SyncBehavior.attrib "">

<!ENTITY % SMIL.SyncBehaviorDefault.module "IGNORE">
<![%SMIL.SyncBehaviorDefault.module;[
  <!ENTITY % SMIL.SyncBehaviorDefault.attrib "
    %SMIL.pfx;syncBehaviorDefault (canSlip|locked|independent|inherit) 'inherit'
    %SMIL.pfx;syncToleranceDefault  %TimeValue.datatype;               'inherit'
  ">
]]>
<!ENTITY % SMIL.SyncBehaviorDefault.attrib "">

<!ENTITY % SMIL.SyncMaster.module "IGNORE">
<![%SMIL.SyncMaster.module;[
  <!ENTITY % SMIL.SyncMaster.attrib "
    %SMIL.pfx;syncMaster    (true|false)                 'false'
  ">
]]>
<!ENTITY % SMIL.SyncMaster.attrib "">

<!-- ================== Time Manipulations ================================ -->
<!ENTITY % SMIL.TimeManipulations.module "IGNORE">
<![%SMIL.TimeManipulations.module;[
  <!ENTITY % SMIL.TimeManipulations.attrib "
    %SMIL.pfx;accelerate          %Number.datatype; '0'
    %SMIL.pfx;decelerate          %Number.datatype; '0'
    %SMIL.pfx;speed               %Number.datatype; '1.0'
    %SMIL.pfx;autoReverse         (true|false)      'false'
  ">
]]>
<!ENTITY % SMIL.TimeManipulations.attrib "">

<!-- ================== Media Objects ===================================== -->
<!ENTITY % SMIL.MediaClipping.module "IGNORE">
<![%SMIL.MediaClipping.module;[
  <!ENTITY % SMIL.MediaClip.attrib "
    %SMIL.pfx;clipBegin      CDATA   #IMPLIED
    %SMIL.pfx;clipEnd        CDATA   #IMPLIED
  ">
  <!ENTITY % SMIL.MediaClipping.deprecated.module "IGNORE">
  <![%SMIL.MediaClipping.deprecated.module;[
    <!ENTITY % SMIL.MediaClip.attrib.deprecated "
      %SMIL.pfx;clip-begin     CDATA   #IMPLIED
      %SMIL.pfx;clip-end       CDATA   #IMPLIED
    ">
  ]]>
]]>
<!ENTITY % SMIL.MediaClip.attrib "">
<!ENTITY % SMIL.MediaClip.attrib.deprecated "">

<!ENTITY % SMIL.MediaParam.module "IGNORE">
<![%SMIL.MediaParam.module;[
  <!ENTITY % SMIL.MediaObject.attrib "
    %SMIL.pfx;paramGroup     NMTOKEN #IMPLIED
  ">
]]>
<!ENTITY % SMIL.MediaObject.attrib "">

<!ENTITY % SMIL.MediaRenderAttributes.module "IGNORE">
<![%SMIL.MediaRenderAttributes.module;[
  <!ENTITY % SMIL.MediaRenderAttributes.attrib "
    %SMIL.pfx;erase        (whenDone|never)   'whenDone'
    %SMIL.pfx;sensitivity   CDATA             'opaque'
  ">
]]>
<!ENTITY % SMIL.MediaRenderAttributes.attrib "">

<!ENTITY % SMIL.MediaOpacity.module "IGNORE">
<![%SMIL.MediaOpacity.module;[
  <!ENTITY % SMIL.MediaOpacity.attrib "
    %SMIL.pfx;chromaKey              CDATA    #IMPLIED
    %SMIL.pfx;chromaKeyOpacity       CDATA    #IMPLIED
    %SMIL.pfx;chromaKeyTolerance     CDATA    #IMPLIED
    %SMIL.pfx;mediaOpacity           CDATA    #IMPLIED
    %SMIL.pfx;mediaBackgroundOpacity CDATA    #IMPLIED
  ">
]]>
<!ENTITY % SMIL.MediaOpacity.attrib "">

<!ENTITY % SMIL.MediaPanZoom.module "IGNORE">
<![%SMIL.MediaPanZoom.module;[
  <!ENTITY % SMIL.MediaPanZoom.attrib "
    %SMIL.pfx;panZoom                CDATA    #IMPLIED
  ">
]]>
<!ENTITY % SMIL.MediaPanZoom.attrib "">

<!-- ================== Transitions Media ================================= -->
<!ENTITY % SMIL.BasicTransitions.module "IGNORE">
<![%SMIL.BasicTransitions.module;[
  <!ENTITY % SMIL.Transition.attrib "
   %SMIL.pfx;transIn                CDATA        #IMPLIED
   %SMIL.pfx;transOut               CDATA        #IMPLIED
  ">
]]>
<!ENTITY % SMIL.Transition.attrib "">

<!-- ================== Timesheets ======================================== -->
<!ENTITY % SMIL.Timesheet.module "IGNORE">
<![%SMIL.Timesheet.module;[
  <!ENTITY % SMIL.Timesheet.attrib "
    %SMIL.pfx;first     CDATA     #IMPLIED
    %SMIL.pfx;last      CDATA     #IMPLIED
    %SMIL.pfx;next      CDATA     #IMPLIED
    %SMIL.pfx;prev      CDATA     #IMPLIED
  ">
]]>
<!ENTITY % SMIL.Timesheet.attrib "">

<!-- ================== Module Namespace Prefixes ========================= -->
<!ENTITY % SMIL.IncludeModuleNamespaces "IGNORE">
<![%SMIL.IncludeModuleNamespaces;[
  <!ENTITY % SMIL.ModuleNamespaces "
    xmlns:Structure %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/Structure'
    xmlns:Identity %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/Identity'
    xmlns:BasicMedia %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/BasicMedia'
    xmlns:BrushMedia %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/BrushMedia'
    xmlns:MediaAccessibility %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/MediaAccessibility'
    xmlns:MediaClipMarkers %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/MediaClipMarkers'
    xmlns:MediaClipping %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/MediaClipping'
    xmlns:MediaDescription %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/MediaDescription'
    xmlns:MediaOpacity %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/MediaOpacity'
    xmlns:MediaPanZoom %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/MediaPanZoom'
    xmlns:MediaParam %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/MediaParam'
    xmlns:MediaRenderAttributes %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/MediaRenderAttributes'
    xmlns:AccessKeyTiming %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/AccessKeyTiming'
    xmlns:BasicExclTimeContainers %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/BasicExclTimeContainers'
    xmlns:BasicInlineTiming %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/BasicInlineTiming'
    xmlns:BasicPriorityClassContainers %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/BasicPriorityClassContainers'
    xmlns:BasicTimeContainers %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/BasicTimeContainers'
    xmlns:DOMTimingMethods %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/DOMTimingMethods'
    xmlns:EventTiming %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/EventTiming'
    xmlns:FillDefault %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/FillDefault'
    xmlns:MediaMarkerTiming %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/MediaMarkerTiming'
    xmlns:MinMaxTiming %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/MinMaxTiming'
    xmlns:MultiArcTiming %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/MultiArcTiming'
    xmlns:RepeatTiming %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/RepeatTiming'
    xmlns:RepeatValueTiming %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/RepeatValueTiming'
    xmlns:RestartDefault %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/RestartDefault'
    xmlns:RestartTiming %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/RestartTiming'
    xmlns:SyncbaseTiming %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/SyncbaseTiming'
    xmlns:SyncBehaviorDefault %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/SyncBehaviorDefault'
    xmlns:SyncBehavior %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/SyncBehavior'
    xmlns:SyncMaster %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/SyncMaster'
    xmlns:TimeContainerAttributes %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/TimeContainerAttributes'
    xmlns:WallclockTiming %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/WallclockTiming'
    xmlns:BasicContentControl %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/BasicContentControl'
    xmlns:CustomTestAttributes %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/CustomTestAttributes'
    xmlns:PrefetchControl %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/PrefetchControl'
    xmlns:RequiredContentControl %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/RequiredContentControl'
    xmlns:SkipContentControl %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/SkipContentControl'
    xmlns:AlignmentLayout %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/AlignmentLayout'
    xmlns:AudioLayout %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/AudioLayout'
    xmlns:BackgroundTilingLayout %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/BackgroundTilingLayout'
    xmlns:BasicLayout %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/BasicLayout'
    xmlns:MultiWindowLayout %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/MultiWindowLayout'
    xmlns:OverrideLayout %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/OverrideLayout'
    xmlns:StructureLayout %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/StructureLayout'
    xmlns:SubRegionLayout %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/SubRegionLayout'
    xmlns:BasicText %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/BasicText'
    xmlns:TextMotion %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/TextMotion'
    xmlns:TextStyling %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/TextStyling'
    xmlns:BasicLinking %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/BasicLinking'
    xmlns:LinkingAttributes %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/LinkingAttributes'
    xmlns:ObjectLinking %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/ObjectLinking'
    xmlns:Metainformation %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/Metainformation'
    xmlns:BasicTransitions %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/BasicTransitions'
    xmlns:FullScreenTransitionEffects %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/FullScreenTransitionEffects'
    xmlns:InlineTransitions %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/InlineTransitions'
    xmlns:TransitionModifiers %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/TransitionModifiers'
    xmlns:BasicAnimation %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/BasicAnimation'
    xmlns:SplineAnimation %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/SplineAnimation'
    xmlns:StateInterpolation %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/StateInterpolation'
    xmlns:StateSubmission %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/StateSubmission'
    xmlns:StateTest %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/StateTest'
    xmlns:UserState %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/UserState'
    xmlns:TimeManipulations %URI.datatype; #FIXED 'http://www.w3.org/2008/SMIL30/TimeManipulations'
  ">
]]>
<!ENTITY % SMIL.ModuleNamespaces "">

<!-- end of smil-attribs-1.mod -->
