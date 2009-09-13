<!-- ...................................................................... -->
<!-- SMIL Qualified Names Module  ......................................... -->
<!-- file: smil-qname-1.mod

     This is SMIL 3.0.

        Copyright: 1998-2008 W3C (MIT, ERCIM, Keio), All Rights
        Reserved.  See http://www.w3.org/Consortium/Legal/.
        
        Editor for SMIL 3.0: Sjoerd Mullender, CWI
        Editor for previous versions of SMIL: Jacco van Ossenbruggen,
        Sjoerd Mullender.
        $Revision: 1.9 $
        $Date: 2008/09/07 20:36:50 $

     This DTD module is identified by the PUBLIC and SYSTEM identifiers:

       PUBLIC "-//W3C//ENTITIES SMIL 3.0 Qualified Names 1.0//EN"
       SYSTEM "http://www.w3.org/2008/SMIL30/smil-qname-1.mod"

     ...................................................................... -->

<!-- SMIL Qualified Names

     This module is contained in two parts, labeled Section 'A' and 'B':

       Section A declares parameter entities to support namespace-
       qualified names, namespace declarations, and name prefixing 
       for SMIL and extensions.
    
       Section B declares parameter entities used to provide
       namespace-qualified names for all SMIL element types:

         %SMIL.animation.qname; the xmlns-qualified name for <animation>
         %SMIL.video.qname;     the xmlns-qualified name for <video>
         ...

     SMIL extensions would create a module similar to this one, 
     using the '%smil-qname-extra.mod;' parameter entity to insert 
     it within Section A.  A template module suitable for this purpose 
     ('template-qname-1.mod') is included in the XHTML distribution.
-->

<!-- Section A: SMIL XML Namespace Framework :::::::::::::::::::::::::::::: -->

<!-- 1. Declare a %SMIL.prefixed; conditional section keyword, used
        to activate namespace prefixing. The default value should 
        inherit '%NS.prefixed;' from the DTD driver, so that unless 
        overridden, the default behavior follows the overall DTD 
        prefixing scheme.
-->
<!ENTITY % NS.prefixed "IGNORE" >
<!ENTITY % SMIL.prefixed "%NS.prefixed;" >

<!-- 2. Declare parameter entities (e.g., %SMIL.xmlns;) containing 
        the URI reference used to identify the SMIL namespace:
-->

<!ENTITY % SMIL.xmlns  "http://www.w3.org/ns/SMIL" >

<!-- 3. Declare parameter entities (e.g., %SMIL.prefix;) containing
        the default namespace prefix string(s) to use when prefixing 
        is enabled. This may be overridden in the DTD driver or the
        internal subset of a document instance. If no default prefix
        is desired, this may be declared as an empty string.

     NOTE: As specified in [XMLNAMES], the namespace prefix serves 
     as a proxy for the URI reference, and is not in itself significant.
-->
<!ENTITY % SMIL.prefix  "smil" >

<!-- 4. Declare parameter entities (e.g., %SMIL.pfx;) containing the 
        colonized prefix(es) (e.g., '%SMIL.prefix;:') used when 
        prefixing is active, an empty string when it is not.
-->
<![%SMIL.prefixed;[
  <!ENTITY % SMIL.pfx  "%SMIL.prefix;:" >
]]>
<!ENTITY % SMIL.pfx  "" >

<!-- 5. The parameter entity %SMIL.xmlns.extra.attrib; may be
        redeclared to contain any non-SMIL namespace declaration
        attributes for namespaces embedded in SMIL. When prefixing
        is active it contains the prefixed xmlns attribute and any
        namespace declarations embedded in SMIL, otherwise an empty
        string.
-->
<![%SMIL.prefixed;[
  <!ENTITY % SMIL.xmlns.extra.attrib
        "xmlns:%SMIL.prefix;    %URI.datatype;  #FIXED  '%SMIL.xmlns;'" >
]]>
<!ENTITY % SMIL.xmlns.extra.attrib "" >

<!ENTITY % XHTML.xmlns.extra.attrib
      "%SMIL.xmlns.extra.attrib;"
>


<!--  Declare the two parameter entities used to support XLink,
      first the parameter entity container for the URI used to
      identify the XLink namespace:
-->
<!ENTITY % XLINK.xmlns "http://www.w3.org/1999/xlink" >
<!-- This contains the XLink namespace declaration attribute. -->
<!ENTITY % XLINK.xmlns.attrib
     "xmlns:xlink  %URI.datatype;           #FIXED '%XLINK.xmlns;'"
>


<!-- declare qualified name extensions here -->
<!ENTITY % smil-qname-extra.mod "" >
%smil-qname-extra.mod;


<!-- Section B: SMIL Qualified Names :::::::::::::::::::::::::::::::::::::: -->

<!-- This section declares parameter entities used to provide
     namespace-qualified names for all SMIL element types.
-->

<!-- Structure Module -->
<!ENTITY % SMIL.smil.qname             "%SMIL.pfx;smil" >
<!ENTITY % SMIL.head.qname             "%SMIL.pfx;head" >
<!ENTITY % SMIL.body.qname             "%SMIL.pfx;body" >

<!-- BasicMedia Module -->
<!ENTITY % SMIL.ref.qname              "%SMIL.pfx;ref" >
<!ENTITY % SMIL.animation.qname        "%SMIL.pfx;animation" >
<!ENTITY % SMIL.audio.qname            "%SMIL.pfx;audio" >
<!ENTITY % SMIL.img.qname              "%SMIL.pfx;img" >
<!ENTITY % SMIL.text.qname             "%SMIL.pfx;text" >
<!ENTITY % SMIL.textstream.qname       "%SMIL.pfx;textstream" >
<!ENTITY % SMIL.video.qname            "%SMIL.pfx;video" >
<!-- MediaParam Module -->
<!ENTITY % SMIL.param.qname            "%SMIL.pfx;param" >
<!ENTITY % SMIL.paramGroup.qname       "%SMIL.pfx;paramGroup" >
<!-- BrushMedia Module -->
<!ENTITY % SMIL.brush.qname            "%SMIL.pfx;brush" >

<!-- BasicTimeContainers Module -->
<!ENTITY % SMIL.par.qname              "%SMIL.pfx;par" >
<!ENTITY % SMIL.seq.qname              "%SMIL.pfx;seq" >
<!-- BasicExclTimeContainers Module -->
<!ENTITY % SMIL.excl.qname             "%SMIL.pfx;excl" >
<!-- BasicPriorityClassContainers Module -->
<!ENTITY % SMIL.priorityClass.qname    "%SMIL.pfx;priorityClass">

<!-- BasicContentControl Module -->
<!ENTITY % SMIL.switch.qname           "%SMIL.pfx;switch" >
<!-- CustomTestAttributes Module -->
<!ENTITY % SMIL.customAttributes.qname "%SMIL.pfx;customAttributes" >
<!ENTITY % SMIL.customTest.qname       "%SMIL.pfx;customTest" >
<!-- PrefetchControl Module -->
<!ENTITY % SMIL.prefetch.qname         "%SMIL.pfx;prefetch" >

<!-- StructureLayout Module -->
<!ENTITY % SMIL.layout.qname           "%SMIL.pfx;layout" >
<!-- BasicLayout Module -->
<!ENTITY % SMIL.region.qname           "%SMIL.pfx;region" >
<!ENTITY % SMIL.root-layout.qname      "%SMIL.pfx;root-layout" >
<!-- MultiWindowLayout Module -->
<!ENTITY % SMIL.topLayout.qname        "%SMIL.pfx;topLayout" >
<!-- AlignmentLayout Module -->
<!ENTITY % SMIL.regPoint.qname         "%SMIL.pfx;regPoint" >

<!-- BasicText Module -->
<!ENTITY % SMIL.br.qname               "%SMIL.pfx;br" >
<!ENTITY % SMIL.clear.qname            "%SMIL.pfx;clear" >
<!ENTITY % SMIL.smilText.qname         "%SMIL.pfx;smilText" >
<!ENTITY % SMIL.tev.qname              "%SMIL.pfx;tev" >
<!-- TextStyling Module -->
<!ENTITY % SMIL.div.qname              "%SMIL.pfx;div" >
<!ENTITY % SMIL.p.qname                "%SMIL.pfx;p" >
<!ENTITY % SMIL.span.qname             "%SMIL.pfx;span" >
<!ENTITY % SMIL.textStyle.qname        "%SMIL.pfx;textStyle" >
<!ENTITY % SMIL.textStyling.qname      "%SMIL.pfx;textStyling" >

<!-- BasicLinking -->
<!ENTITY % SMIL.a.qname                "%SMIL.pfx;a" >
<!ENTITY % SMIL.anchor.qname           "%SMIL.pfx;anchor" >
<!ENTITY % SMIL.area.qname             "%SMIL.pfx;area" >

<!-- Metainformation Module -->
<!ENTITY % SMIL.meta.qname             "%SMIL.pfx;meta" >
<!ENTITY % SMIL.metadata.qname         "%SMIL.pfx;metadata" >

<!-- BasicTransitions Module -->
<!ENTITY % SMIL.transition.qname       "%SMIL.pfx;transition" >
<!-- InlineTransitions Module -->
<!ENTITY % SMIL.transitionFilter.qname "%SMIL.pfx;transitionFilter" >

<!-- BasicAnimation Module -->
<!ENTITY % SMIL.animate.qname          "%SMIL.pfx;animate" >
<!ENTITY % SMIL.animateColor.qname     "%SMIL.pfx;animateColor" >
<!ENTITY % SMIL.animateMotion.qname    "%SMIL.pfx;animateMotion" >
<!ENTITY % SMIL.set.qname              "%SMIL.pfx;set" >

<!-- UserState Module -->
<!ENTITY % SMIL.delvalue.qname         "%SMIL.pfx;delvalue" >
<!ENTITY % SMIL.newvalue.qname         "%SMIL.pfx;newvalue" >
<!ENTITY % SMIL.setvalue.qname         "%SMIL.pfx;setvalue" >
<!ENTITY % SMIL.state.qname            "%SMIL.pfx;state" >
<!-- StateSubmission Module -->
<!ENTITY % SMIL.send.qname             "%SMIL.pfx;send" >
<!ENTITY % SMIL.submission.qname       "%SMIL.pfx;submission" >

<!-- External Timing (Timesheets) -->
<!ENTITY % SMIL.item.qname             "%SMIL.pfx;item" >
<!ENTITY % SMIL.timesheet.qname        "%SMIL.pfx;timesheet" >

<!-- end of smil-qname-1.mod -->
