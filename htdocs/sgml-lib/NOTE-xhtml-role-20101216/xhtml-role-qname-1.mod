<!-- ....................................................................... -->
<!-- XHTML Role Qname Module  ............................................ -->
<!-- file: xhtml-role-qname-1.mod

     This is XHTML Role - the Role Attribute Module for XHTML.

     Copyright 2006 W3C (MIT, ERCIM, Keio), All Rights Reserved.

     This DTD module is identified by the PUBLIC and SYSTEM identifiers:

       PUBLIC "-//W3C//ENTITIES XHTML Role Attribute Qnames 1.0//EN"
       SYSTEM "http://www.w3.org/MarkUp/DTD/xhtml-role-qname-1.mod"

     Revisions:
     (none)
     ....................................................................... -->

<!-- XHTML Role Attribute Qname (Qualified Name) Module

     This module is contained in two parts, labeled Section 'A' and 'B':

       Section A declares parameter entities to support namespace-
       qualified names, namespace declarations, and name prefixing
       for XHTML Role and extensions.

       Section B declares parameter entities used to provide
       namespace-qualified names for the XHTML role attribute:

         %role.qname;   the xmlns-qualified name for @role
         ...

     XHTML Role extensions would create a module similar to this one.
-->

<!-- Section A: XHTML Role Attribute XML Namespace Framework ::::::::::::::: -->

<!-- 1. Declare a %XHTML-ROLE.prefixed; conditional section keyword, used
        to activate namespace prefixing. The default value should
        inherit '%NS.prefixed;' from the DTD driver, so that unless
        overridden, the default behavior follows the overall DTD
        prefixing scheme.
-->
<!ENTITY % NS.prefixed "IGNORE" >
<!ENTITY % XHTML-ROLE.prefixed "%NS.prefixed;" >

<!-- 2. Declare a parameter entity (eg., %XHTML-ROLE.xmlns;) containing
        the URI reference used to identify the XHTML Role Attribute namespace
-->
<!ENTITY % XHTML-ROLE.xmlns  "http://www.w3.org/1999/xhtml" >

<!-- 3. Declare parameter entities (eg., %XML.prefix;) containing
        the default namespace prefix string(s) to use when prefixing
        is enabled. This may be overridden in the DTD driver or the
        internal subset of an document instance. If no default prefix
        is desired, this may be declared as an empty string.

     NOTE: As specified in [XMLNAMES], the namespace prefix serves
     as a proxy for the URI reference, and is not in itself significant.
-->
<!ENTITY % XHTML-ROLE.prefix  "" >

<!-- 4. Declare parameter entities (eg., %XHTML-ROLE.pfx;) containing the
        colonized prefix(es) (eg., '%XHTML-ROLE.prefix;:') used when
        prefixing is active, an empty string when it is not.
-->
<![%XHTML-ROLE.prefixed;[
<!ENTITY % XHTML-ROLE.pfx  "%XHTML-ROLE.prefix;:" >
]]>
<!ENTITY % XHTML-ROLE.pfx  "" >

<!-- declare qualified name extensions here ............ -->
<!ENTITY % xhtml-role-qname-extra.mod "" >
%xhtml-role-qname-extra.mod;

<!-- 5. The parameter entity %XHTML-ROLE.xmlns.extra.attrib; may be
        redeclared to contain any non-XHTML Role Attribute namespace 
        declaration attributes for namespaces embedded in XML. The default
        is an empty string.  XLink should be included here if used
        in the DTD.
-->
<!ENTITY % XHTML-ROLE.xmlns.extra.attrib "" >


<!-- Section B: XML Qualified Names ::::::::::::::::::::::::::::: -->

<!-- 6. This section declares parameter entities used to provide
        namespace-qualified names for the XHTML role attribute.
-->

<!ENTITY % xhtml-role.role.qname  "%XHTML-ROLE.pfx;role" >


<!-- The following defines a PE for use in the attribute sets of elements in
     other namespaces that want to incorporate the XHTML role attribute. Note
     that in this case the XHTML-ROLE.pfx should be defined. -->

<!ENTITY % xhtml-role.attrs.qname
   "%XHTML-ROLE.pfx;role             CDATA        #IMPLIED"
    >

<!-- end of xhtml-role-qname-1.mod -->
