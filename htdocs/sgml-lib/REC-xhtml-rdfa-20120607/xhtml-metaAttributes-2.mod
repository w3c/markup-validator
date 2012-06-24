<!-- ...................................................................... -->
<!-- XHTML MetaAttributes Module  ......................................... -->
<!-- file: xhtml-metaAttributes-1.mod

     This is XHTML-RDFa, modules to annotate XHTML family documents.
     Copyright 2007-2008 W3C (MIT, ERCIM, Keio), All Rights Reserved.
     Revision: $Id: xhtml-metaAttributes-2.mod,v 1.1 2012/06/04 17:24:40 denis Exp $

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
<!ENTITY % CURIEorIRI.datatype "CDATA" >
<!ENTITY % CURIEorIRIs.datatype "CDATA" >
<!ENTITY % IRI.datatype "CDATA" >
<!ENTITY % IRIs.datatype "CDATA" >
<!ENTITY % PREFIX.datatype "CDATA" >
<!ENTITY % SafeCURIEorCURIEorIRI.datatype "CDATA" >
<!ENTITY % SafeCURIEorCURIEorIRIs.datatype "CDATA" >
<!ENTITY % TERMorCURIEorAbsIRI.datatype "CDATA" >
<!ENTITY % TERMorCURIEorAbsIRIs.datatype "CDATA" >


<!-- Common Attributes

     This module declares a collection of meta-information related 
     attributes.

     %NS.decl.attrib; is declared in the XHTML Qname module.

	 This file also includes declarations of "global" versions of the 
     attributes.  The global versions of the attributes are for use on 
     elements in other namespaces.  
-->

<!ENTITY % about.attrib
     "about        %SafeCURIEorCURIEorIRI.datatype;             #IMPLIED"
>

<![%XHTML.global.attrs.prefixed;[
<!ENTITY % XHTML.global.about.attrib
     "%XHTML.prefix;:about   %SafeCURIEorCURIEorIRI.datatype;    #IMPLIED"
>
]]>

<!ENTITY % typeof.attrib
     "typeof        %TERMorCURIEorAbsIRIs.datatype;             #IMPLIED"
>

<![%XHTML.global.attrs.prefixed;[
<!ENTITY % XHTML.global.typeof.attrib
     "%XHTML.prefix;:typeof           %TERMorCURIEorAbsIRIs.datatype;        #IMPLIED"
>
]]>

<!ENTITY % property.attrib
     "property        %TERMorCURIEorAbsIRIs.datatype;             #IMPLIED"
>

<![%XHTML.global.attrs.prefixed;[
<!ENTITY % XHTML.global.property.attrib
     "%XHTML.prefix;:property           %TERMorCURIEorAbsIRIs.datatype;        #IMPLIED"
>
]]>

<!ENTITY % resource.attrib
     "resource        %SafeCURIEorCURIEorIRI.datatype;             #IMPLIED"
>

<![%XHTML.global.attrs.prefixed;[
<!ENTITY % XHTML.global.resource.attrib
     "%XHTML.prefix;:resource           %SafeCURIEorCURIEorIRI.datatype;        #IMPLIED"
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
     "datatype        %TERMorCURIEorAbsIRI.datatype;             #IMPLIED"
>

<![%XHTML.global.attrs.prefixed;[
<!ENTITY % XHTML.global.datatype.attrib
     "%XHTML.prefix;:datatype           %TERMorCURIEorAbsIRI.datatype;        #IMPLIED"
>
]]>

<!ENTITY % inlist.attrib
     "inlist        CDATA             #IMPLIED"
>

<![%XHTML.global.attrs.prefixed;[
<!ENTITY % XHTML.global.inlist.attrib
     "%XHTML.prefix;:inlist           CDATA        #IMPLIED"
>
]]>

<!ENTITY % rel.attrib
     "rel        %TERMorCURIEorAbsIRIs.datatype;             #IMPLIED"
>

<![%XHTML.global.attrs.prefixed;[
<!ENTITY % XHTML.global.rel.attrib
     "%XHTML.prefix;:rel           %TERMorCURIEorAbsIRIs.datatype;        #IMPLIED"
>
]]>

<!ENTITY % rev.attrib
     "rev        %TERMorCURIEorAbsIRIs.datatype;             #IMPLIED"
>

<![%XHTML.global.attrs.prefixed;[
<!ENTITY % XHTML.global.rev.attrib
     "%XHTML.prefix;:rev           %TERMorCURIEorAbsIRIs.datatype;        #IMPLIED"
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
     "vocab        %IRI.datatype;             #IMPLIED"
>

<![%XHTML.global.attrs.prefixed;[
<!ENTITY % XHTML.global.vocab.attrib
     "%XHTML.prefix;:vocab           %IRI.datatype;        #IMPLIED"
>
]]>

<!ENTITY % Metainformation.extra.attrib "" >

<!ENTITY % Metainformation.attrib
     "%about.attrib;
      %content.attrib;
      %datatype.attrib;
	  %inlist.attrib;
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
      %XHTML.global.inlist.attrib;
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
