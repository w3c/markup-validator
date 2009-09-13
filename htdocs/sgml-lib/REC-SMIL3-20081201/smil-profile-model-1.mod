<!-- ====================================================================== -->
<!-- SMIL 3.0 Document Model Module ======================================= -->
<!-- file: smil-profile-model-1.mod

     This is SMIL 3.0.

        Copyright: 1998-2008 W3C (MIT, ERCIM, Keio), All Rights
        Reserved.  See http://www.w3.org/Consortium/Legal/.

        Editor for SMIL 3.0: Sjoerd Mullender, CWI
        Editor for previous versions of SMIL: Warner ten Kate,
        Jacco van Ossenbruggen, Aaron Cohen, Sjoerd Mullender.
        $Id: smil-profile-model-1.mod,v 1.22 2008/09/07 20:36:50 smullend Exp $
        $Date: 2008/09/07 20:36:50 $

     This DTD module is identified by the PUBLIC and SYSTEM identifiers:

     PUBLIC "-//W3C//ENTITIES SMIL 3.0 Document Model 1.0//EN"
     SYSTEM "http://www.w3.org/2008/SMIL30/smil-profile-model-1.mod"

     ====================================================================== -->

<!--
        This file defines the SMIL 3.0 Document Model.
        All attributes and content models are defined in the second
        half of this file.  We first start with some utility definitions.
        These are mainly used to simplify the use of Modules in the
        second part of the file.

        Note that in this model, the Metainformation module is required.
-->

<!-- ================== Util: Body - Content Control ====================== -->
<!ENTITY % SMIL.BasicContentControl.module "IGNORE">
<![%SMIL.BasicContentControl.module;[
  <!ENTITY % SMIL.switch-control "| %SMIL.switch.qname;">
]]>
<!ENTITY % SMIL.switch-control "">
<!ENTITY % SMIL.PrefetchControl.module "IGNORE">
<![%SMIL.PrefetchControl.module;[
  <!ENTITY % SMIL.prefetch-control "| %SMIL.prefetch.qname;">
]]>
<!ENTITY % SMIL.prefetch-control "">
<!ENTITY % SMIL.content-control "%SMIL.switch-control;%SMIL.prefetch-control;">

<!ENTITY % SMIL.content-control-attrs "%SMIL.Test.attrib; 
                                       %SMIL.customTestAttr.attrib; 
                                       %SMIL.skip-content.attrib;">

<!-- ================== Util: Head ======================================== -->
<!ENTITY % SMIL.head-meta.content       "%SMIL.metadata.qname;">
<!ENTITY % SMIL.TextStyling.module "IGNORE">
<![%SMIL.TextStyling.module;[
  <!ENTITY % SMIL.head-textStyling.content ",((%SMIL.textStyling.qname;), %SMIL.meta.qname;*)?">
]]>
<!ENTITY % SMIL.head-textStyling.content "">
<!ENTITY % SMIL.StructureLayout.module "IGNORE">
<![%SMIL.StructureLayout.module;[
  <!ENTITY % SMIL.head-layout.content ",((%SMIL.layout.qname; %SMIL.switch-control;), %SMIL.meta.qname;*)?">
]]>
<!ENTITY % SMIL.head-layout.content "">
<!ENTITY % SMIL.CustomTestAttributes.module "IGNORE">
<![%SMIL.CustomTestAttributes.module;[
  <!ENTITY % SMIL.head-control.content ",((%SMIL.customAttributes.qname;), %SMIL.meta.qname;*)?">
]]>
<!ENTITY % SMIL.head-control.content "">
<!ENTITY % SMIL.BasicTransitions.module "IGNORE">
<![%SMIL.BasicTransitions.module;[
  <!ENTITY % SMIL.head-transition.content ",((%SMIL.transition.qname;+),%SMIL.meta.qname;*)?">
]]>
<!ENTITY % SMIL.head-transition.content "">
<!ENTITY % SMIL.MediaParam.module "IGNORE">
<![%SMIL.MediaParam.module;[
  <!ENTITY % SMIL.head-media.content      ",((%SMIL.paramGroup.qname;+), %SMIL.meta.qname;*)?">
]]>
<!ENTITY % SMIL.head-media.content "">
<!ENTITY % SMIL.UserState.module "IGNORE">
<![%SMIL.UserState.module;[
  <!ENTITY % SMIL.head-state.content ",((%SMIL.state.qname;), %SMIL.meta.qname;*)?">
]]>
<!ENTITY % SMIL.head-state.content "">
<!ENTITY % SMIL.StateSubmission.module "IGNORE">
<![%SMIL.StateSubmission.module;[
  <!ENTITY % SMIL.head-submission.content ",((%SMIL.submission.qname;),%SMIL.meta.qname;*)*">
]]>
<!ENTITY % SMIL.head-submission.content "">

<!--=================== Util: Body - Animation ============================ -->
<!ENTITY % SMIL.BasicAnimation.module "IGNORE">
<![%SMIL.BasicAnimation.module;[
  <!ENTITY % SMIL.animation.elements "| %SMIL.animate.qname; 
                                      | %SMIL.set.qname; 
                                      | %SMIL.animateMotion.qname; 
                                      | %SMIL.animateColor.qname;">
  <!ENTITY % SMIL.simple-animation.elements "| %SMIL.animate.qname; 
                                             | %SMIL.set.qname;">
]]>
<!ENTITY % SMIL.animation.elements "">
<!ENTITY % SMIL.simple-animation.elements "">

<!--=================== Util: Body - Media ================================ -->

<!ENTITY % SMIL.BasicText.module "IGNORE">
<![%SMIL.BasicText.module;[
  <!ENTITY % SMIL.BasicText.content "| %SMIL.smilText.qname;">
]]>
<!ENTITY % SMIL.BasicText.content "">
<!ENTITY % SMIL.BrushMedia.module "IGNORE">
<![%SMIL.BrushMedia.module;[
  <!ENTITY % SMIL.BrushMedia.content "| %SMIL.brush.qname;">
]]>
<!ENTITY % SMIL.BrushMedia.content "">
<!ENTITY % SMIL.Timesheet.module "IGNORE">
<![%SMIL.Timesheet.module;[
  <!ENTITY % SMIL.Timesheet.content "| %SMIL.item.qname;">
]]>
<!ENTITY % SMIL.Timesheet.content "">
<!ENTITY % SMIL.BasicMedia.module "IGNORE">
<![%SMIL.BasicMedia.module;[
  <!ENTITY % SMIL.media-object "| %SMIL.audio.qname; 
                                | %SMIL.video.qname; 
                                | %SMIL.animation.qname;
                                | %SMIL.text.qname;
                                | %SMIL.img.qname;
                                | %SMIL.textstream.qname;
                                | %SMIL.ref.qname;
                                %SMIL.BrushMedia.content;
                                %SMIL.BasicText.content;
                                %SMIL.Timesheet.content;">
]]>
<!ENTITY % SMIL.media-object "%SMIL.BrushMedia.content;
                              %SMIL.BasicText.content;
                              %SMIL.Timesheet.content;">

<!--=================== Util: Body - State ================================ -->
<![%SMIL.StateSubmission.module;[
  <!ENTITY % SMIL.send.element "| %SMIL.send.qname;">
  <!ENTITY % SMIL.submission.content "(%SMIL.metadata.qname;)*">
  <!ENTITY % SMIL.submission-post "IGNORE">
  <![%SMIL.submission-post;[
    <!ENTITY % SMIL.method-types "| post">
  ]]>
]]>
<!ENTITY % SMIL.send.element "">
<!ENTITY % SMIL.UserState.module "IGNORE">
<![%SMIL.UserState.module;[
  <!ENTITY % SMIL.state.elements "
    | %SMIL.newvalue.qname;
    | %SMIL.delvalue.qname;
    | %SMIL.setvalue.qname;
    %SMIL.send.element;
  ">
  <!ENTITY % SMIL.state.attrib "%SMIL.skip-content.attrib;">
]]>
<!ENTITY % SMIL.state.elements "%SMIL.send.element;">

<!-- ================== Util: Body - Linking ============================== -->
<!ENTITY % SMIL.BasicLinking.module "IGNORE">
<!ENTITY % SMIL.BasicLinking.deprecated.module "IGNORE">
<![%SMIL.BasicLinking.module;[
  <![%SMIL.BasicLinking.deprecated.module;[
    <!ENTITY % SMIL.anchor-control "| %SMIL.anchor.qname; | %SMIL.area.qname;">
  ]]>
  <!ENTITY % SMIL.anchor-control "| %SMIL.area.qname;">
  <!ENTITY % SMIL.a-control "| %SMIL.a.qname;">
]]>
<!ENTITY % SMIL.anchor-control "">
<!ENTITY % SMIL.a-control "">

<!--=================== Util: Body - Timing =============================== -->
<!ENTITY % SMIL.BasicTimeContainers.class "%SMIL.par.qname; 
                                         | %SMIL.seq.qname;">

<!ENTITY % SMIL.BasicExclTimeContainers.module "IGNORE">
<![%SMIL.BasicExclTimeContainers.module;[
  <!ENTITY % SMIL.ExclTimeContainers.class "|%SMIL.excl.qname;">
]]>
<!ENTITY % SMIL.ExclTimeContainers.class "">

<!ENTITY % SMIL.timecontainer.class   "%SMIL.BasicTimeContainers.class;
                                       %SMIL.ExclTimeContainers.class;">

<!ENTITY % SMIL.timecontainer.content "%SMIL.timecontainer.class; 
                                       %SMIL.media-object;
                                       %SMIL.animation.elements;
                                       %SMIL.content-control;
                                       %SMIL.a-control;
                                       %SMIL.state.elements;">

<!ENTITY % SMIL.smil-basictime.attrib "
 %SMIL.BasicInlineTiming.attrib;
 %SMIL.RepeatTiming.attrib;
 %SMIL.RepeatTiming.deprecated.attrib;
 %SMIL.MinMaxTiming.attrib;
">

<!ENTITY % SMIL.timecontainer.attrib "
 %SMIL.smil-basictime.attrib;
 %SMIL.TimeManipulations.attrib;
 %SMIL.RestartTiming.attrib;
 %SMIL.RestartDefaultTiming.attrib;
 %SMIL.SyncBehavior.attrib;
 %SMIL.SyncBehaviorDefault.attrib;
 %SMIL.SyncMaster.attrib;
 %SMIL.fillDefault.attrib;
">

<!-- ====================================================================== -->
<!-- ====================================================================== -->
<!-- ====================================================================== -->

<!-- 
     The actual content model and attribute definitions for each module 
     sections follow below.
-->

<!-- ================== Linking =========================================== -->
<!ENTITY % SMIL.BasicLinking.module "IGNORE">
<![%SMIL.BasicLinking.module;[
  <!ENTITY % SMIL.a.content      "(%SMIL.timecontainer.class;
                                   %SMIL.media-object;
                                   %SMIL.animation.elements;
                                   %SMIL.state.elements;
                                   %SMIL.content-control;
                                  |%SMIL.metadata.qname;)*">
  <!ENTITY % SMIL.area.content   "(%SMIL.metadata.qname;
                                   %SMIL.simple-animation.elements;)*">
  <!ENTITY % SMIL.anchor.content "(%SMIL.metadata.qname;
                                   %SMIL.simple-animation.elements;)*">

  <!ENTITY % SMIL.a.attrib "
    %SMIL.smil-basictime.attrib;
    %SMIL.Test.attrib;
    %SMIL.customTestAttr.attrib;
    %XHTML-Role-attrib;
  ">
  <!ENTITY % SMIL.area.attrib "
    %SMIL.smil-basictime.attrib;
    %SMIL.content-control-attrs;
    %SMIL.StateTest.attrib;
    %XHTML-Role-attrib;
  ">
  <!ENTITY % SMIL.anchor.attrib "
    %SMIL.smil-basictime.attrib;
    %SMIL.content-control-attrs;
    %SMIL.StateTest.attrib;
    %XHTML-Role-attrib;
  ">
]]>

<!-- ================== Content Control =================================== -->
<![%SMIL.BasicAnimation.module;[
  <!ENTITY % SMIL.animation-switch "((%SMIL.animate.qname; | %SMIL.set.qname; | %SMIL.animateMotion.qname; | %SMIL.animateColor.qname;), (%SMIL.metadata.qname; %SMIL.switch-control;)*)*,">
]]>
<!ENTITY % SMIL.animation-switch "">

<!-- The content model of the switch element is very complex:
     - if switch occurs inside the head element, the only allowed
       content is layout (and Metainformation and nested switch);
     - if switch occurs inside a media element, the only allowed
       content is param, area (anchor), and animation elements (and
       Metainformation and nested switch);
     - if switch occurs inside a par, seq or excl element, the only
       allowed content is time containers (par, seq, excl), media
       elements (ref and friends, smilText, etc.), animation elements,
       and the a and prefetch elements (and Metainformation and nested
       switch).
     Note that there is overlap in the allowed content for the various
     cases.
-->
<![%SMIL.MediaParam.module;[
  <![%SMIL.BasicLinking.module;[
    <!ENTITY % SMIL.param-anchor "(%SMIL.param.qname; %SMIL.anchor-control;),">
  ]]>
  <!ENTITY % SMIL.param-anchor "%SMIL.param.qname;,">
]]>
<![%SMIL.BasicLinking.module;[
  <!ENTITY % SMIL.param-anchor "(%SMIL.anchor.qname; | %SMIL.area.qname;),">
]]>
<!ENTITY % SMIL.param-anchor "">
<!ENTITY % SMIL.switch.content "((%SMIL.metadata.qname;
                                  %SMIL.switch-control;)*,
                                 ((%SMIL.animation-switch;
                                   (((%SMIL.timecontainer.class;
                                      %SMIL.media-object;
                                      %SMIL.state.elements;
                                      %SMIL.prefetch-control;
                                      %SMIL.a-control;)+,
                                     (%SMIL.metadata.qname;
                                      %SMIL.animation.elements;
                                      %SMIL.switch-control;)*)+ |
                                    (%SMIL.param-anchor;
                                     (%SMIL.metadata.qname;
                                      %SMIL.animation.elements;
                                      %SMIL.switch-control;)*)+)) |
                                  (%SMIL.layout.qname;,
                                   (%SMIL.metadata.qname;
                                    %SMIL.switch-control;)*)*))">

<!ENTITY % SMIL.switch.attrib "
 %SMIL.Test.attrib;
 %SMIL.customTestAttr.attrib;
 %XHTML-Role-attrib;
">
<!ENTITY % SMIL.prefetch.content "(%SMIL.metadata.qname;)*">
<!ENTITY % SMIL.prefetch.attrib "
 %SMIL.timecontainer.attrib; 
 %SMIL.MediaClip.attrib; 
 %SMIL.MediaClip.attrib.deprecated; 
 %SMIL.Test.attrib; 
 %SMIL.customTestAttr.attrib; 
 %SMIL.skip-content.attrib;
 %SMIL.StateTest.attrib;
">

<!ENTITY % SMIL.customAttributes.content "
        ((%SMIL.metadata.qname;)*,
         (%SMIL.customTest.qname;,
          (%SMIL.metadata.qname;)*)+)">
<!ENTITY % SMIL.customAttributes.attrib  "
 %SMIL.skip-content.attrib;
">
<!ENTITY % SMIL.customTest.content "(%SMIL.metadata.qname;)*">
<!ENTITY % SMIL.customTest.attrib "
 %SMIL.skip-content.attrib;
">

<!-- ================== Animation ========================================= -->

<![%SMIL.BasicAnimation.module;[
  <!-- choose targetElement or XLink: -->
  <!ENTITY % SMIL.animation-targetElement "IGNORE">
  <!ENTITY % SMIL.animation-XLinkTarget   "IGNORE">

  <!ENTITY % SMIL.animate.content "(%SMIL.metadata.qname;)*">
  <!ENTITY % SMIL.animateColor.content "(%SMIL.metadata.qname;)*">
  <!ENTITY % SMIL.animateMotion.content "(%SMIL.metadata.qname;)*">
  <!ENTITY % SMIL.set.content "(%SMIL.metadata.qname;)*">

  <!ENTITY % SMIL.animate.attrib "
    %SMIL.smil-basictime.attrib;
    %SMIL.TimeManipulations.attrib;
    %SMIL.RestartTiming.attrib;
    %SMIL.RestartDefaultTiming.attrib;
    %SMIL.fill.attrib;
    %SMIL.fillDefault.attrib;
    %SMIL.Test.attrib;
    %SMIL.customTestAttr.attrib;
    %SMIL.skip-content.attrib;
    %SMIL.StateTest.attrib;
  ">
  <!ENTITY % SMIL.animateColor.attrib "
    %SMIL.smil-basictime.attrib;
    %SMIL.TimeManipulations.attrib;
    %SMIL.RestartTiming.attrib;
    %SMIL.RestartDefaultTiming.attrib;
    %SMIL.fill.attrib;
    %SMIL.fillDefault.attrib;
    %SMIL.Test.attrib;
    %SMIL.customTestAttr.attrib;
    %SMIL.skip-content.attrib;
    %SMIL.StateTest.attrib;
  ">
  <!ENTITY % SMIL.animateMotion.attrib "
    %SMIL.smil-basictime.attrib;
    %SMIL.TimeManipulations.attrib;
    %SMIL.RestartTiming.attrib;
    %SMIL.RestartDefaultTiming.attrib;
    %SMIL.fill.attrib;
    %SMIL.fillDefault.attrib;
    %SMIL.Test.attrib;
    %SMIL.customTestAttr.attrib;
    %SMIL.skip-content.attrib;
    %SMIL.StateTest.attrib;
  ">
  <!ENTITY % SMIL.set.attrib "
    %SMIL.smil-basictime.attrib;
    %SMIL.TimeManipulations.attrib;
    %SMIL.RestartTiming.attrib;
    %SMIL.RestartDefaultTiming.attrib;
    %SMIL.fill.attrib;
    %SMIL.fillDefault.attrib;
    %SMIL.Test.attrib;
    %SMIL.customTestAttr.attrib;
    %SMIL.skip-content.attrib;
    %SMIL.StateTest.attrib;
  ">
]]>

<!-- ================== Layout ============================================ -->
<!ENTITY % SMIL.BasicLayout.module "IGNORE">
<![%SMIL.BasicLayout.module;[
  <!ENTITY % SMIL.BasicLayout-content "|%SMIL.region.qname;|%SMIL.root-layout.qname;">
]]>
<!ENTITY % SMIL.BasicLayout-content "">
<!ENTITY % SMIL.MultiWindowLayout.module "IGNORE">
<![%SMIL.MultiWindowLayout.module;[
  <!ENTITY % SMIL.MultiWindowLayout-content "|%SMIL.topLayout.qname;">
]]>
<!ENTITY % SMIL.MultiWindowLayout-content "">
<!ENTITY % SMIL.AlignmentLayout.module "IGNORE">
<![%SMIL.AlignmentLayout.module;[
  <!ENTITY % SMIL.AlignmentLayout-content "|%SMIL.regPoint.qname;">
]]>
<!ENTITY % SMIL.AlignmentLayout-content "">
<!ENTITY % SMIL.SubRegionLayout.module "IGNORE">
<![%SMIL.SubRegionLayout.module;[
  <!ENTITY % SMIL.SubRegionLayout-content "|%SMIL.region.qname;">
]]>
<!ENTITY % SMIL.SubRegionLayout-content "">

<!ENTITY % SMIL.layout.content "(%SMIL.metadata.qname;
                                 %SMIL.BasicLayout-content;
                                 %SMIL.MultiWindowLayout-content;
                                 %SMIL.AlignmentLayout-content;)*">
<!ENTITY % SMIL.region.content "(%SMIL.metadata.qname;
                                 %SMIL.SubRegionLayout-content;)*">
<![%SMIL.MultiWindowLayout.module;[
  <!ENTITY % SMIL.topLayout.content "(%SMIL.region.qname;
                                     |%SMIL.metadata.qname;)*">
]]>
<![%SMIL.BasicLayout.module;[
  <!ENTITY % SMIL.rootlayout.content "(%SMIL.metadata.qname;)*">
  <!ENTITY % SMIL.rootlayout.attrib "
    %SMIL.content-control-attrs;
  ">
  <!ENTITY % SMIL.region.attrib "
    %SMIL.content-control-attrs;
    %SMIL.BasicText.attrib;
    %SMIL.MediaOpacity.attrib;
    %SMIL.MediaPanZoom.attrib;
    %SMIL.MediaRenderAttributes.attrib;
    %SMIL.textAlign.attrib;
    %SMIL.textDirection.attrib;
    %SMIL.textMode.attrib;
    %SMIL.textPlace.attrib;
    %SMIL.TextStyling.attrib;
    %SMIL.textWritingMode.attrib;
    %XHTML-Role-attrib;
  ">
]]>
<![%SMIL.AlignmentLayout.module;[
  <!ENTITY % SMIL.regPoint.content "(%SMIL.metadata.qname;)*">
  <!ENTITY % SMIL.regPoint.attrib "
    %SMIL.content-control-attrs;
  ">
]]>
<![%SMIL.SubRegionLayout.module;[
  <!ENTITY % SMIL.topLayout.attrib "
    %SMIL.content-control-attrs;
  ">
]]>
<!ENTITY % SMIL.layout.attrib "
 %SMIL.Test.attrib;
 %SMIL.customTestAttr.attrib;
">

<!-- ================== Media  ============================================ -->
<![%SMIL.MediaParam.module;[
  <!ENTITY % SMIL.param.content       "(%SMIL.metadata.qname;)*">
  <!ENTITY % SMIL.param.attrib        "%SMIL.content-control-attrs;">
  <!ENTITY % SMIL.paramGroup.content  "(%SMIL.param.qname;|%SMIL.metadata.qname;)*">
  <!ENTITY % SMIL.paramGroup.attrib   "
    %SMIL.skip-content.attrib;
  ">

  <!ENTITY % SMIL.param-control "| %SMIL.param.qname;">
  <!ENTITY % SMIL.paramGroup-control "| %SMIL.paramGroup.qname;">
]]>
<!ENTITY % SMIL.param-control "">
<!ENTITY % SMIL.paramGroup-control "">

<!ENTITY % SMIL.media-object.content "(%SMIL.metadata.qname;
                                       %SMIL.param-control;
                                       %SMIL.anchor-control;
                                       %SMIL.switch-control;
                                       %SMIL.animation.elements;)*">
<!ENTITY % SMIL.media-object.attrib "
  %SMIL.timecontainer.attrib;
  %SMIL.endsync.media.attrib;
  %SMIL.fill.attrib;
  %SMIL.Test.attrib;
  %SMIL.customTestAttr.attrib;
  %SMIL.regionAttr.attrib;
  %SMIL.Transition.attrib;
  %SMIL.SubRegionLayout.attrib;
  %SMIL.OverrideLayout.attrib;
  %SMIL.RegistrationPoint.attrib;
  %SMIL.tabindex.attrib;
  %SMIL.MediaObject.attrib;
  %SMIL.StateTest.attrib;
  %XHTML-Role-attrib;
">

<!ENTITY % SMIL.brush.attrib        "%SMIL.skip-content.attrib;">

<!-- ================== Metadata ========================================== -->
<!ENTITY % SMIL.meta.content     "EMPTY">
<!ENTITY % SMIL.meta.attrib      "%SMIL.skip-content.attrib;">

<!ENTITY % SMIL.metadata.content "EMPTY">
<!ENTITY % SMIL.metadata.attrib  "%SMIL.skip-content.attrib;">

<!-- ================== smilText ========================================== -->
<!ENTITY % SMIL.smilText.content "(
         #PCDATA
        |%SMIL.metadata.qname;
        |%SMIL.tev.qname;
        |%SMIL.clear.qname;
        |%SMIL.br.qname;
        |%SMIL.span.qname;
        |%SMIL.p.qname;
        |%SMIL.div.qname;
         %SMIL.param-control;
)*">
<!ENTITY % SMIL.smilText.attrib "
  %SMIL.skip-content.attrib;
  %SMIL.media-object.attrib;
">
<!ENTITY % SMIL.tev.content "(%SMIL.metadata.qname;)*">
<!ENTITY % SMIL.clear.content "(%SMIL.metadata.qname;)*">
<!ENTITY % SMIL.br.content "(%SMIL.metadata.qname;)*">
<!ENTITY % SMIL.div.content "(
         #PCDATA
        |%SMIL.metadata.qname;
        |%SMIL.tev.qname;
        |%SMIL.clear.qname;
        |%SMIL.br.qname;
        |%SMIL.div.qname;
        |%SMIL.p.qname;
        |%SMIL.span.qname;
)*">
<!ENTITY % SMIL.p.content "(
         #PCDATA
        |%SMIL.metadata.qname;
        |%SMIL.tev.qname;
        |%SMIL.clear.qname;
        |%SMIL.br.qname;
        |%SMIL.span.qname;
)*">
<!ENTITY % SMIL.span.content "(
         #PCDATA
        |%SMIL.metadata.qname;
        |%SMIL.tev.qname;
        |%SMIL.clear.qname;
        |%SMIL.br.qname;
        |%SMIL.span.qname;
)*">
<!ENTITY % SMIL.textStyle.content "(%SMIL.metadata.qname;)*">
<!ENTITY % SMIL.textStyling.content "((%SMIL.metadata.qname;)*,(%SMIL.textStyle.qname;,(%SMIL.metadata.qname;)*)+)">
<!ENTITY % SMIL.textStyle.attrib "
  %SMIL.Test.attrib;
">

<!-- ================== UserState ========================================= -->
<!ENTITY % SMIL.language-attrib-default
  "'http://www.w3.org/TR/1999/REC-xpath-19991116'">
<!ENTITY % SMIL.newvalue-ref-attrib-default "'/*'">
<!ENTITY % SMIL.newvalue-name-attrib-default "#REQUIRED">

<!ENTITY % SMIL.newvalue.attrib "
  %SMIL.smil-basictime.attrib;
  %SMIL.TimeManipulations.attrib;
  %SMIL.RestartTiming.attrib;
  %SMIL.RestartDefaultTiming.attrib;
  %SMIL.fillDefault.attrib;
  %SMIL.Test.attrib;
  %SMIL.customTestAttr.attrib;
  %SMIL.skip-content.attrib;
  %SMIL.StateTest.attrib;
">
<!ENTITY % SMIL.setvalue.attrib "
  %SMIL.smil-basictime.attrib;
  %SMIL.TimeManipulations.attrib;
  %SMIL.RestartTiming.attrib;
  %SMIL.RestartDefaultTiming.attrib;
  %SMIL.fillDefault.attrib;
  %SMIL.Test.attrib;
  %SMIL.customTestAttr.attrib;
  %SMIL.skip-content.attrib;
  %SMIL.StateTest.attrib;
">
<!ENTITY % SMIL.delvalue.attrib "
  %SMIL.smil-basictime.attrib;
  %SMIL.TimeManipulations.attrib;
  %SMIL.RestartTiming.attrib;
  %SMIL.RestartDefaultTiming.attrib;
  %SMIL.fillDefault.attrib;
  %SMIL.Test.attrib;
  %SMIL.customTestAttr.attrib;
  %SMIL.skip-content.attrib;
  %SMIL.StateTest.attrib;
">
<!ENTITY % SMIL.newvalue.content "(%SMIL.metadata.qname;)*">
<!ENTITY % SMIL.setvalue.content "(%SMIL.metadata.qname;)*">
<!ENTITY % SMIL.delvalue.content "(%SMIL.metadata.qname;)*">

<!ENTITY % SMIL.send.attrib "
  %SMIL.smil-basictime.attrib;
  %SMIL.TimeManipulations.attrib;
  %SMIL.RestartTiming.attrib;
  %SMIL.RestartDefaultTiming.attrib;
  %SMIL.fillDefault.attrib;
  %SMIL.Test.attrib;
  %SMIL.customTestAttr.attrib;
  %SMIL.skip-content.attrib;
  %SMIL.StateTest.attrib;
">
<!ENTITY % SMIL.send.content "(%SMIL.metadata.qname;)*">

<!-- ================== Structure ========================================= -->
<!ENTITY % SMIL.smil.content "((%SMIL.metadata.qname;)*,
                               (%SMIL.head.qname;,
                                (%SMIL.metadata.qname;)*)?,
                               (%SMIL.body.qname;,
                                (%SMIL.metadata.qname;)*)?)">
<!ENTITY % SMIL.head.content "(
         %SMIL.meta.qname;*
         %SMIL.head-control.content;
         ,((%SMIL.head-meta.content;),      %SMIL.meta.qname;*)?
         %SMIL.head-textStyling.content;
         %SMIL.head-layout.content;
         %SMIL.head-state.content;
         %SMIL.head-submission.content;
         %SMIL.head-transition.content;
         %SMIL.head-media.content;
)">
<!ENTITY % SMIL.body.content "(%SMIL.timecontainer.class;
                               %SMIL.media-object;
                               %SMIL.animation.elements;
                               %SMIL.state.elements;
                               %SMIL.content-control;
                               %SMIL.a-control;
                              |%SMIL.metadata.qname;)*">

<!ENTITY % SMIL.smil.attrib "
        %SMIL.Test.attrib;
        %SMIL.ModuleNamespaces;
        %ITSNS;
        %XHTMLNS;
">
<!ENTITY % SMIL.head.attrib "">
<!ENTITY % SMIL.body.attrib "
        %SMIL.timecontainer.attrib; 
        %SMIL.Description.attrib;
        %SMIL.fill.attrib;
">

<!-- ================== Transitions ======================================= -->
<!ENTITY % SMIL.transition.content "(%SMIL.metadata.qname;)*">
<!ENTITY % SMIL.transition.attrib "%SMIL.content-control-attrs;
">

<!-- ================== Timing ============================================ -->
<!ENTITY % SMIL.par.attrib "
        %SMIL.endsync.attrib; 
        %SMIL.fill.attrib;
        %SMIL.timecontainer.attrib; 
        %SMIL.Test.attrib; 
        %SMIL.customTestAttr.attrib; 
        %SMIL.regionAttr.attrib;
        %SMIL.StateTest.attrib;
        %XHTML-Role-attrib;
">
<!ENTITY % SMIL.seq.attrib "
        %SMIL.fill.attrib;
        %SMIL.timecontainer.attrib; 
        %SMIL.Test.attrib; 
        %SMIL.customTestAttr.attrib; 
        %SMIL.regionAttr.attrib;
        %SMIL.StateTest.attrib;
        %SMIL.Timesheet.attrib;
        %XHTML-Role-attrib;
">
<!ENTITY % SMIL.excl.attrib "
        %SMIL.endsync.attrib; 
        %SMIL.fill.attrib;
        %SMIL.timecontainer.attrib; 
        %SMIL.Test.attrib; 
        %SMIL.customTestAttr.attrib; 
        %SMIL.regionAttr.attrib; 
        %SMIL.skip-content.attrib;
        %SMIL.StateTest.attrib;
        %XHTML-Role-attrib;
">
<!ENTITY % SMIL.par.content "(%SMIL.timecontainer.content;|%SMIL.metadata.qname;)*">
<!ENTITY % SMIL.seq.content "(%SMIL.timecontainer.content;|%SMIL.metadata.qname;)*">
<!ENTITY % SMIL.BasicPriorityClassContainers.module "IGNORE">
<![%SMIL.BasicPriorityClassContainers.module;[
  <!-- An excl element contains either only priorityClass children or
       no priorityClass children.  It is made more complex by the fact
       that in either case there may be switch, meta, and metadata
       children interspersed.
  -->
  <!ENTITY % SMIL.excl.content "
        ((%SMIL.metadata.qname;)*,
         (((%SMIL.timecontainer.content;),
           (%SMIL.metadata.qname;)*)* |
          (%SMIL.priorityClass.qname;,
           (%SMIL.metadata.qname;)*)+))">

  <!ENTITY % SMIL.priorityClass.attrib  "
    %SMIL.content-control-attrs;
  ">
  <!ENTITY % SMIL.priorityClass.content "(%SMIL.timecontainer.content; |
                                          %SMIL.metadata.qname;)*">
]]>
<!ENTITY % SMIL.excl.content "(%SMIL.timecontainer.content; |
                               %SMIL.metadata.qname;)*">

<!-- External Timing -->
<!ENTITY % SMIL.Timesheet.module "IGNORE">
<![%SMIL.Timesheet.module;[
  <!ENTITY % SMIL.timesheet.content "(%SMIL.timecontainer.class;
                                      %SMIL.media-object;
                                      %SMIL.animation.elements;
                                      %SMIL.state.elements;
                                      %SMIL.content-control;
                                      %SMIL.a-control;
                                     |%SMIL.metadata.qname;)*">
  <!ENTITY % SMIL.timesheet.attrib "
    %SMIL.media-object.attrib;
  ">
]]>

<!-- end of smil-profile-model-1.mod -->
