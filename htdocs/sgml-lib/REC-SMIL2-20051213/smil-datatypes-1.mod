<!-- ...................................................................... -->
<!-- SMIL 2.1 Datatypes Module  ........................................... -->
<!-- file: smil-datatypes-1.mod

     This is SMIL 2.1.

        Copyright: 1998-2005 W3C (MIT, ERCIM, Keio), All Rights
        Reserved.  See http://www.w3.org/Consortium/Legal/.

        Author:     Jacco van Ossenbruggen
        Editor for SMIL 2.1: Sjoerd Mullender, CWI
        $Revision: 1.1 $
        $Date: 2007-04-02 05:08:40 $

     This DTD module is identified by the PUBLIC and SYSTEM identifiers:

     PUBLIC "-//W3C//ENTITIES SMIL 2.1 Datatypes 1.0//EN"
     SYSTEM "http://www.w3.org/2005/SMIL21/smil-datatypes-1.mod"

     ....................................................................... -->

<!-- Datatypes

     defines containers for the following datatypes, many of
     these imported from other specifications and standards.
-->

<!ENTITY % Character.datatype "CDATA">
    <!-- a single character from [ISO10646] -->
<!ENTITY % ContentType.datatype "CDATA">
    <!-- media type, as per [RFC2045] -->
<!ENTITY % LanguageCode.datatype "CDATA">
    <!-- a language code, as per [RFC3066] -->
<!ENTITY % LanguageCodes.datatype "CDATA">
    <!-- comma-separated list of language codes, as per [RFC3066] -->
<!ENTITY % Number.datatype "CDATA">
    <!-- one or more digits -->
<!ENTITY % Script.datatype "CDATA">
    <!-- script expression -->
<!ENTITY % Text.datatype "CDATA">
    <!-- used for titles etc. -->
<!ENTITY % TimeValue.datatype "CDATA">
    <!-- a Number, possibly with its dimension, or a reserved 
         word like 'indefinite' -->
<!ENTITY % URI.datatype "CDATA" >
    <!-- used for URI references -->

<!-- end of smil-datatypes-1.mod -->
