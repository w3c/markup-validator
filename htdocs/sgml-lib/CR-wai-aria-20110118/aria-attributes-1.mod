<!-- ...................................................................... -->
<!-- ARIA Attributes Module ............................................... -->
<!-- file: aria-attributes-1.mod

     This is ARIA Attributes - the Accessible Rich Internet Applications
     attributes module for XHTML.

     Copyright 2008-2009 W3C (MIT, ERCIM, Keio), All Rights Reserved.

     This DTD module is identified by the PUBLIC and SYSTEM identifiers:

       PUBLIC "-//W3C//ENTITIES XHTML ARIA Attributes 1.0//EN"
       SYSTEM "http://www.w3.org/MarkUp/DTD/aria-attributes-1.mod"

     Revisions:
     (none)
     ....................................................................... -->

<!-- states -->
<!ENTITY % ARIA.states.attrib "
    aria-busy ( true | false ) 'false'
    aria-checked ( true | false | mixed | undefined ) 'undefined'
    aria-disabled ( true | false ) 'false'
    aria-dropeffect NMTOKENS 'none'
    aria-expanded ( true | false | undefined ) 'undefined'
    aria-grabbed ( true | false | undefined ) 'undefined'
    aria-hidden ( true | false ) 'false'
    aria-invalid ( grammar | false | spelling | true ) 'false'
    aria-pressed ( true | false | mixed | undefined ) 'undefined'
    aria-selected ( true | false | undefined ) 'undefined'
">

<!-- properties -->
<!ENTITY % ARIA.props.attrib "
    aria-activedescendant IDREF #IMPLIED
    aria-atomic ( true | false ) 'false'
    aria-autocomplete ( inline | list | both | none ) 'none'
    aria-controls IDREFS #IMPLIED
    aria-describedby IDREFS #IMPLIED
    aria-flowto IDREFS #IMPLIED
    aria-haspopup ( true | false ) 'false'
    aria-label CDATA #IMPLIED
    aria-labelledby IDREFS #IMPLIED
    aria-level CDATA #IMPLIED
    aria-live ( off | polite | assertive ) 'off'
    aria-multiline ( true | false ) 'false'
    aria-multiselectable ( true | false ) 'false'
    aria-owns IDREFS #IMPLIED
    aria-posinset CDATA #IMPLIED
    aria-readonly ( true | false ) 'false'
    aria-relevant NMTOKENS 'additions text'
    aria-required ( true | false ) 'false'
    aria-setsize CDATA #IMPLIED
    aria-sort ( ascending | descending | none | other ) 'none'
    aria-valuemax CDATA #IMPLIED
    aria-valuemin CDATA #IMPLIED
    aria-valuenow CDATA #IMPLIED
    aria-valuetext CDATA #IMPLIED
">

<!ENTITY % ARIA.extra.attrib "" >

<!ENTITY % ARIA.attrib "
    %ARIA.states.attrib;
    %ARIA.props.attrib;
    %ARIA.extra.attrib;
">

<!-- End aria-attributes Module ................................................... -->
