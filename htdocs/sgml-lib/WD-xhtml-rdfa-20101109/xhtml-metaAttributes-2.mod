<!-- ...................................................................... -->
<!-- XHTML MetaAttributes Module  ......................................... -->
<!-- file: xhtml-metaAttributes-1.mod

     This is XHTML-RDFa, modules to annotate XHTML family documents.
     Copyright 2007-2008 W3C (MIT, ERCIM, Keio), All Rights Reserved.
     Revision: $Id: xhtml-metaAttributes-2.mod,v 1.1 2010/11/09 13:52:46 bertails Exp $

     This DTD module is identified by the PUBLIC and SYSTEM identifiers:

       PUBLIC "-//W3C//ENTITIES XHTML MetaAttributes 1.0//EN"
       SYSTEM "http://www.w3.org/MarkUp/DTD/xhtml-metaAttributes-1.mod"

     Revisions:
     (none)
     ....................................................................... -->

<!ENTITY % XHTML.global.attrs.prefixed "IGNORE" >

<!-- Placeholder Compact URI-related types -->
<!ENTITY % CURIE.datatype "CDATA" >
<!ENTITY % CURIEs.datatype "CDATA" >
<!ENTITY % CURIEorURI.datatype "CDATA" >
<!ENTITY % CURIEorURIs.datatype "CDATA" >
<!ENTITY % PREFIX.datatype "CDATA" >
<!ENTITY % SafeCURIEorCURIEorURI.datatype "CDATA" >
<!ENTITY % SafeCURIEorCURIEorURIs.datatype "CDATA" >
<!ENTITY % TERMorCURIEorAbsURI.datatype "CDATA" >
<!ENTITY % TERMorCURIEorAbsURIs.datatype "CDATA" >


<!-- Common Attributes

     This module declares a collection of meta-information related 
     attributes.

     %NS.decl.attrib; is declared in the XHTML Qname module.

	 This file also includes declarations of "global" versions of the 
     attributes.  The global versions of the attributes are for use on 
     elements in other namespaces.  
-->

<!ENTITY % about.attrib
     "about        %SafeCURIEorCURIEorURI.datatype;             #IMPLIED"
>

<![%XHTML.global.attrs.prefixed;[
<!ENTITY % XHTML.global.about.attrib
     "%XHTML.prefix;:about   %SafeCURIEorCURIEorURI.datatype;    #IMPLIED"
>
]]>

<!ENTITY % typeof.attrib
     "typeof        %TERMorCURIEorAbsURIs.datatype;             #IMPLIED"
>

<![%XHTML.global.attrs.prefixed;[
<!ENTITY % XHTML.global.typeof.attrib
     "%XHTML.prefix;:typeof           %TERMorCURIEorAbsURIs.datatype;        #IMPLIED"
>
]]>

<!ENTITY % property.attrib
     "property        %TERMorCURIEorAbsURIs.datatype;             #IMPLIED"
>

<![%XHTML.global.attrs.prefixed;[
<!ENTITY % XHTML.global.property.attrib
     "%XHTML.prefix;:property           %TERMorCURIEorAbsURIs.datatype;        #IMPLIED"
>
]]>

<!ENTITY % resource.attrib
     "resource        %SafeCURIEorCURIEorURI.datatype;             #IMPLIED"
>

<![%XHTML.global.attrs.prefixed;[
<!ENTITY % XHTML.global.resource.attrib
     "%XHTML.prefix;:resource           %SafeCURIEorCURIEorURI.datatype;        #IMPLIED"
>
]]>

<!ENTITY % content.attrib
     "content        CDATA             #IMPLIED"
>

<![%XHTML.global.attrs.prefixed;[
<!ENTITY % XHTML.global.content.attrib
     "%XHTML.prefix;:content           CDATA        #IMPLIED"
>
]]>

<!ENTITY % datatype.attrib
     "datatype        %TERMorCURIEorAbsURI.datatype;             #IMPLIED"
>

<![%XHTML.global.attrs.prefixed;[
<!ENTITY % XHTML.global.datatype.attrib
     "%XHTML.prefix;:datatype           %TERMorCURIEorAbsURI.datatype;        #IMPLIED"
>
]]>

<!ENTITY % rel.attrib
     "rel        %TERMorCURIEorAbsURIs.datatype;             #IMPLIED"
>

<![%XHTML.global.attrs.prefixed;[
<!ENTITY % XHTML.global.rel.attrib
     "%XHTML.prefix;:rel           %TERMorCURIEorAbsURIs.datatype;        #IMPLIED"
>
]]>

<!ENTITY % rev.attrib
     "rev        %TERMorCURIEorAbsURIs.datatype;             #IMPLIED"
>

<![%XHTML.global.attrs.prefixed;[
<!ENTITY % XHTML.global.rev.attrib
     "%XHTML.prefix;:rev           %TERMorCURIEorAbsURIs.datatype;        #IMPLIED"
>
]]>

<!ENTITY % prefix.attrib
     "prefix        %PREFIX.datatype;             #IMPLIED"
>

<![%XHTML.global.attrs.prefixed;[
<!ENTITY % XHTML.global.prefix.attrib
     "%XHTML.prefix;:prefix           %PREFIX.datatype;        #IMPLIED"
>
]]>

<!ENTITY % vocab.attrib
     "vocab        %URI.datatype;             #IMPLIED"
>

<![%XHTML.global.attrs.prefixed;[
<!ENTITY % XHTML.global.vocab.attrib
     "%XHTML.prefix;:vocab           %URI.datatype;        #IMPLIED"
>
]]>

<!ENTITY % Metainformation.extra.attrib "" >

<!ENTITY % Metainformation.attrib
     "%about.attrib;
      %content.attrib;
      %datatype.attrib;
      %typeof.attrib;
      %prefix.attrib;
      %property.attrib;
      %rel.attrib;
      %resource.attrib;
      %rev.attrib;
      %vocab.attrib;
      %Metainformation.extra.attrib;"
>

<!ENTITY % XHTML.global.metainformation.extra.attrib "" >

<![%XHTML.global.attrs.prefixed;[

<!ENTITY % XHTML.global.metainformation.attrib
     "%XHTML.global.about.attrib;
      %XHTML.global.content.attrib;
      %XHTML.global.datatype.attrib;
      %XHTML.global.typeof.attrib;
      %XHTML.global.prefix.attrib;
      %XHTML.global.property.attrib;
      %XHTML.global.rel.attrib;
      %XHTML.global.resource.attrib;
      %XHTML.global.rev.attrib;
      %XHTML.global.vocab.attrib;
      %XHTML.global.metainformation.extra.attrib;"
>
]]>

<!ENTITY % XHTML.global.metainformation.attrib "" >


<!-- end of xhtml-metaAttributes-1.mod -->
