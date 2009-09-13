<!-- ====================================================================== -->
<!-- SMIL 3.0 Media Objects Modules ======================================= -->
<!-- file: SMIL-media.mod

     This is SMIL 3.0.

        Copyright: 1998-2008 W3C (MIT, ERCIM, Keio), All Rights
        Reserved.  See http://www.w3.org/Consortium/Legal/.

        Editor for SMIL 3.0: Sjoerd Mullender, CWI
        Editor for previous versions of SMIL: Rob Lanphier,
        Jacco van Ossenbruggen,, Sjoerd Mullender Sjoerd Mullender.
        $Revision: 1.9 $
        $Date: 2008/09/07 20:36:50 $

     This DTD module is identified by the PUBLIC and SYSTEM identifiers:

     PUBLIC "-//W3C//ELEMENTS SMIL 3.0 Media Objects//EN"
     SYSTEM "http://www.w3.org/2008/SMIL30/SMIL-media.mod"

     ====================================================================== -->

<!-- ================== Profiling Entities ================================ -->

<!ENTITY % SMIL.MediaParam.module "IGNORE">
<![%SMIL.MediaParam.module;[
  <!ENTITY % SMIL.param.attrib "">
  <!ENTITY % SMIL.param.qname "param">
  <!ENTITY % SMIL.param.content "EMPTY">
  <!ELEMENT %SMIL.param.qname; %SMIL.param.content;>

  <!ATTLIST %SMIL.param.qname; %SMIL.param.attrib;
    %SMIL.Core.attrib;
    %SMIL.I18n.attrib;
    name        CDATA                   #IMPLIED
    value       CDATA                   #IMPLIED
    valuetype   (data | ref | object)   'data'
    type        %ContentType.datatype;  #IMPLIED
  >

  <!ENTITY % SMIL.paramGroup.content "(%SMIL.param.qname;*)">
  <!ENTITY % SMIL.paramGroup.attrib "">
  <!ENTITY % SMIL.paramGroup.qname "paramGroup">

  <!ELEMENT %SMIL.paramGroup.qname; %SMIL.paramGroup.content;>
  <!-- normally we get xml:id from the Structure module, but in case
       that is not included, we define it ourselves -->
  <![%SMIL.Structure.module;[
    <!ENTITY % SMIL.paramGroup.id.attrib "">
  ]]>
  <!ENTITY % SMIL.paramGroup.id.attrib "xml:id ID #IMPLIED">
  <!ATTLIST %SMIL.paramGroup.qname; %SMIL.paramGroup.attrib;
    %SMIL.Core.attrib;
    %SMIL.I18n.attrib;
    %SMIL.paramGroup.id.attrib;
  >
  
]]>

<!ENTITY % SMIL.mo-attributes "
      %SMIL.media-object.attrib;
      %SMIL.Core.attrib;
      %SMIL.I18n.attrib;
      %SMIL.Description.attrib;
      %SMIL.MediaRenderAttributes.attrib;
">

<!ENTITY % SMIL.BasicMedia.module "IGNORE">
<![%SMIL.BasicMedia.module;[
  <!ENTITY % SMIL.media-object.content "EMPTY">
  <!ENTITY % SMIL.media-object.attrib "">
  <!ENTITY % SMIL.soundAlign.attrib "">

  <!-- ================ Media Objects Entities ============================ -->

  <!--
     Most info is in the attributes, media objects are empty or
     have children defined at the language integration level:
  -->

  <!ENTITY % SMIL.mo-content "%SMIL.media-object.content;">

  <!-- ================ Media Objects Elements ============================ -->
  <!ENTITY % SMIL.ref.qname           "ref">
  <!ENTITY % SMIL.animation.qname     "animation">
  <!ENTITY % SMIL.audio.qname         "audio">
  <!ENTITY % SMIL.img.qname           "img">
  <!ENTITY % SMIL.text.qname          "text">
  <!ENTITY % SMIL.textstream.qname    "textstream">
  <!ENTITY % SMIL.video.qname         "video">

  <!ENTITY % SMIL.ref.content         "%SMIL.mo-content;">
  <!ENTITY % SMIL.animation.content   "%SMIL.mo-content;">
  <!ENTITY % SMIL.audio.content       "%SMIL.mo-content;">
  <!ENTITY % SMIL.img.content         "%SMIL.mo-content;">
  <!ENTITY % SMIL.text.content        "%SMIL.mo-content;">
  <!ENTITY % SMIL.textstream.content  "%SMIL.mo-content;">
  <!ENTITY % SMIL.video.content       "%SMIL.mo-content;">

  <!ELEMENT %SMIL.ref.qname;          %SMIL.ref.content;>
  <!ELEMENT %SMIL.animation.qname;    %SMIL.animation.content;>
  <!ELEMENT %SMIL.audio.qname;        %SMIL.audio.content;>
  <!ELEMENT %SMIL.img.qname;          %SMIL.img.content;>
  <!ELEMENT %SMIL.text.qname;         %SMIL.text.content;>
  <!ELEMENT %SMIL.textstream.qname;   %SMIL.textstream.content;>
  <!ELEMENT %SMIL.video.qname;        %SMIL.video.content;>

  <!ATTLIST %SMIL.ref.qname;           
          %SMIL.MediaClip.attrib;
          %SMIL.MediaClip.attrib.deprecated;
          %SMIL.mo-attributes;
          %SMIL.MediaOpacity.attrib;
          %SMIL.MediaPanZoom.attrib;
          %SMIL.soundAlign.attrib;
          src         %URI.datatype;          #IMPLIED
          type        %ContentType.datatype;  #IMPLIED
          mediaRepeat (preserve|strip)        'preserve'
  >
  <!ATTLIST %SMIL.animation.qname;     
          %SMIL.MediaClip.attrib;
          %SMIL.MediaClip.attrib.deprecated;
          %SMIL.mo-attributes;
          %SMIL.MediaOpacity.attrib;
          %SMIL.MediaPanZoom.attrib;
          %SMIL.soundAlign.attrib;
          src         %URI.datatype;          #IMPLIED
          type        %ContentType.datatype;  #IMPLIED
          mediaRepeat (preserve|strip)        'preserve'
  >
  <!ATTLIST %SMIL.audio.qname;         
          %SMIL.MediaClip.attrib;
          %SMIL.MediaClip.attrib.deprecated;
          %SMIL.mo-attributes;
          %SMIL.MediaOpacity.attrib;
          %SMIL.MediaPanZoom.attrib;
          %SMIL.soundAlign.attrib;
          src         %URI.datatype;          #IMPLIED
          type        %ContentType.datatype;  #IMPLIED
          mediaRepeat (preserve|strip)        'preserve'
  >
  <!ATTLIST %SMIL.img.qname;           
          %SMIL.MediaClip.attrib;
          %SMIL.MediaClip.attrib.deprecated;
          %SMIL.mo-attributes;
          %SMIL.MediaOpacity.attrib;
          %SMIL.MediaPanZoom.attrib;
          %SMIL.soundAlign.attrib;
          src         %URI.datatype;          #IMPLIED
          type        %ContentType.datatype;  #IMPLIED
          mediaRepeat (preserve|strip)        'preserve'
  >
  <!ATTLIST %SMIL.text.qname;          
          %SMIL.MediaClip.attrib;
          %SMIL.MediaClip.attrib.deprecated;
          %SMIL.mo-attributes;
          %SMIL.MediaOpacity.attrib;
          %SMIL.MediaPanZoom.attrib;
          %SMIL.soundAlign.attrib;
          src         %URI.datatype;          #IMPLIED
          type        %ContentType.datatype;  #IMPLIED
          mediaRepeat (preserve|strip)        'preserve'
  >
  <!ATTLIST %SMIL.textstream.qname;    
          %SMIL.MediaClip.attrib;
          %SMIL.MediaClip.attrib.deprecated;
          %SMIL.mo-attributes;
          %SMIL.MediaOpacity.attrib;
          %SMIL.MediaPanZoom.attrib;
          %SMIL.soundAlign.attrib;
          src         %URI.datatype;          #IMPLIED
          type        %ContentType.datatype;  #IMPLIED
          mediaRepeat (preserve|strip)        'preserve'
  >
  <!ATTLIST %SMIL.video.qname;         
          %SMIL.MediaClip.attrib;
          %SMIL.MediaClip.attrib.deprecated;
          %SMIL.mo-attributes;
          %SMIL.MediaOpacity.attrib;
          %SMIL.MediaPanZoom.attrib;
          %SMIL.soundAlign.attrib;
          src         %URI.datatype;          #IMPLIED
          type        %ContentType.datatype;  #IMPLIED
          mediaRepeat (preserve|strip)        'preserve'
  >
]]>

<!-- BrushMedia -->
<!ENTITY % SMIL.BrushMedia.module "IGNORE">
<![%SMIL.BrushMedia.module;[
  <!ENTITY % SMIL.brush.attrib "">
  <!ENTITY % SMIL.brush.content "%SMIL.mo-content;">
  <!ENTITY % SMIL.brush.qname "brush">
  <!ELEMENT %SMIL.brush.qname; %SMIL.brush.content;>
  <!ATTLIST %SMIL.brush.qname; %SMIL.brush.attrib; 
        %SMIL.mo-attributes;
        color        %Color.datatype;            #IMPLIED
  >
]]>

<!-- end of SMIL-media.mod -->
