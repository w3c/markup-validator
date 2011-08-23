<!-- ....................................................................... -->
<!-- SVG 1.1 Basic Clip Module ............................................. -->
<!-- file: svg-basic-clip.mod

     This is SVG, a language for describing two-dimensional graphics in XML.
     Copyright 2001, 2002, 2011 W3C (MIT, INRIA, Keio), All Rights Reserved.
     Revision: $Id: svg-basic-clip.mod,v 1.15 2011/07/08 03:20:21 cmccorma Exp $

     This DTD module is identified by the PUBLIC and SYSTEM identifiers:

        PUBLIC "-//W3C//ELEMENTS SVG 1.1 Basic Clip//EN"
        SYSTEM "http://www.w3.org/Graphics/SVG/1.1/DTD/svg-basic-clip.mod"

     ....................................................................... -->

<!-- Basic Clip

        clipPath

     This module declares markup to provide support for clipping.
-->

<!-- 'clip-path' property/attribute value (e.g., 'none', <uri>) -->
<!ENTITY % ClipPathValue.datatype "CDATA" >

<!-- Qualified Names (Default) ......................... -->

<!ENTITY % SVG.clipPath.qname "clipPath" >

<!-- Attribute Collections (Default) ................... -->

<!ENTITY % SVG.Core.attrib "" >
<!ENTITY % SVG.Conditional.attrib "" >
<!ENTITY % SVG.Style.attrib "" >
<!ENTITY % SVG.Text.attrib "" >
<!ENTITY % SVG.TextContent.attrib "" >
<!ENTITY % SVG.Font.attrib "" >
<!ENTITY % SVG.Paint.attrib "" >
<!ENTITY % SVG.Color.attrib "" >
<!ENTITY % SVG.Opacity.attrib "" >
<!ENTITY % SVG.Graphics.attrib "" >
<!ENTITY % SVG.Mask.attrib "" >
<!ENTITY % SVG.Filter.attrib "" >
<!ENTITY % SVG.Cursor.attrib "" >
<!ENTITY % SVG.External.attrib "" >

<!-- SVG.Clip.class .................................... -->

<!ENTITY % SVG.Clip.extra.class "" >

<!ENTITY % SVG.Clip.class
    "| %SVG.clipPath.qname; %SVG.Clip.extra.class;"
>

<!-- SVG.Clip.attrib ................................... -->

<!ENTITY % SVG.Clip.extra.attrib "" >

<!ENTITY % SVG.Clip.attrib
    "clip-path %ClipPathValue.datatype; #IMPLIED
     clip-rule %ClipFillRule.datatype; #IMPLIED
     %SVG.Clip.extra.attrib;"
>

<!-- clipPath: Clip Path Element ....................... -->

<!ENTITY % SVG.clipPath.extra.content "" >

<!ENTITY % SVG.clipPath.element "INCLUDE" >
<![%SVG.clipPath.element;[
<!ENTITY % SVG.clipPath.content
    "( %SVG.Description.class; | %SVG.Animation.class; %SVG.Use.class;
       %SVG.Shape.class; | %SVG.text.qname; %SVG.clipPath.extra.content; )*"
>
<!ELEMENT %SVG.clipPath.qname; %SVG.clipPath.content; >
<!-- end of SVG.clipPath.element -->]]>

<!ENTITY % SVG.clipPath.attlist "INCLUDE" >
<![%SVG.clipPath.attlist;[
<!ATTLIST %SVG.clipPath.qname;
    %SVG.Core.attrib;
    %SVG.Conditional.attrib;
    %SVG.Style.attrib;
    %SVG.Presentation.attrib;
    %SVG.External.attrib;
    transform %TransformList.datatype; #IMPLIED
    clipPathUnits ( userSpaceOnUse | objectBoundingBox ) #IMPLIED
>
<!-- end of SVG.clipPath.attlist -->]]>

<!-- end of svg-basic-clip.mod -->
