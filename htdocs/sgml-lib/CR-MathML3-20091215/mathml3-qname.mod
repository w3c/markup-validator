
<!-- ....................................................................... -->
<!-- MathML Qualified Names Module  ........................................ -->
<!-- file: mathml3-qname-1.mod

     This is the Mathematical Markup Language (MathML) 2.0, an XML 
     application for describing mathematical notation and capturing 
     both its structure and content.

     Copyright 1998-2009 W3C (MIT, INRIA, Keio), All Rights Reserved.

     This DTD module is identified by the PUBLIC and SYSTEM identifiers:

       PUBLIC "-//W3C//ENTITIES MathML 3.0 Qualified Names 1.0//EN"
       SYSTEM "mathml3-qname.mod"

     Revisions:
     (none)
     ....................................................................... -->

<!-- MathML Qualified Names

     This module is contained in two parts, labeled Section 'A' and 'B':

       Section A declares parameter entities to support namespace-
       qualified names, namespace declarations, and name prefixing 
       for MathML.
    
       Section B declares parameter entities used to provide
       namespace-qualified names for all MathML element types.

     This module is derived from the XHTML Qualified Names Template module.
-->

<!-- Section A: XHTML XML Namespace Framework :::::::::::::::::::: -->

<!ENTITY % NS.prefixed     "IGNORE" >
<!ENTITY % MATHML.prefixed "%NS.prefixed;" >

<!-- XLink ............... -->

<!ENTITY % XLINK.prefix         "xlink" >		
<!ENTITY % XLINK.xmlns "http://www.w3.org/1999/xlink" >
<!ENTITY % XLINK.xmlns.attrib
     "xmlns:%XLINK.prefix;  CDATA           #FIXED '%XLINK.xmlns;'"
>

<!-- W3C XML Schema ............... -->

<!ENTITY % Schema.prefix         "xsi" >		
<!ENTITY % Schema.xmlns "http://www.w3.org/2001/XMLSchema-instance" >
<!ENTITY % Schema.xmlns.attrib
     "xmlns:%Schema.prefix;  CDATA           #IMPLIED"
>

<!-- MathML .............. -->

<!ENTITY % MATHML.xmlns    "http://www.w3.org/1998/Math/MathML" >
<!ENTITY % MATHML.prefix   "m" >
<![%MATHML.prefixed;[
<!ENTITY % MATHML.xmlns.extra.attrib  "" >
]]>
<!ENTITY % MATHML.xmlns.extra.attrib 
     "%XLINK.xmlns.attrib; 
      %Schema.xmlns.attrib;" >

<![%MATHML.prefixed;[
<!ENTITY % MATHML.pfx  "%MATHML.prefix;:" >
<!ENTITY % MATHML.xmlns.attrib
     "xmlns:%MATHML.prefix;  CDATA   #FIXED '%MATHML.xmlns;'
      %MATHML.xmlns.extra.attrib;"
>
]]>
<!ENTITY % MATHML.pfx  "" >
<!ENTITY % MATHML.xmlns.attrib
     "xmlns        CDATA           #FIXED '%MATHML.xmlns;'
      %MATHML.xmlns.extra.attrib;"
>

<![%NS.prefixed;[
<!ENTITY % XHTML.xmlns.extra.attrib 
     "%MATHML.xmlns.attrib;" >
]]>
<!ENTITY % XHTML.xmlns.extra.attrib
     "%XLINK.xmlns.attrib;
      %Schema.xmlns.attrib;"
>


<!-- ignores subsequent instantiation of this module when
     used as external subset rather than module fragment.
     NOTE: Do not modify this parameter entity, otherwise
     a recursive parsing situation may result.
-->
<!ENTITY % mathml-qname.module "IGNORE" >

<!-- Section B: MathML Qualified Names ::::::::::::::::::::::::::::: -->

<!-- 9. This section declares parameter entities used to provide
        namespace-qualified names for all MathML element types.
-->

<!ENTITY % ns1:abs.qname "%MATHML.pfx;ns1:abs" >
<!ENTITY % ns1:and.qname "%MATHML.pfx;ns1:and" >
<!ENTITY % ns1:annotation-xml.qname "%MATHML.pfx;ns1:annotation-xml" >
<!ENTITY % ns1:annotation.qname "%MATHML.pfx;ns1:annotation" >
<!ENTITY % ns1:apply.qname "%MATHML.pfx;ns1:apply" >
<!ENTITY % ns1:approx.qname "%MATHML.pfx;ns1:approx" >
<!ENTITY % ns1:arccos.qname "%MATHML.pfx;ns1:arccos" >
<!ENTITY % ns1:arccosh.qname "%MATHML.pfx;ns1:arccosh" >
<!ENTITY % ns1:arccot.qname "%MATHML.pfx;ns1:arccot" >
<!ENTITY % ns1:arccoth.qname "%MATHML.pfx;ns1:arccoth" >
<!ENTITY % ns1:arccsc.qname "%MATHML.pfx;ns1:arccsc" >
<!ENTITY % ns1:arccsch.qname "%MATHML.pfx;ns1:arccsch" >
<!ENTITY % ns1:arcsec.qname "%MATHML.pfx;ns1:arcsec" >
<!ENTITY % ns1:arcsech.qname "%MATHML.pfx;ns1:arcsech" >
<!ENTITY % ns1:arcsin.qname "%MATHML.pfx;ns1:arcsin" >
<!ENTITY % ns1:arcsinh.qname "%MATHML.pfx;ns1:arcsinh" >
<!ENTITY % ns1:arctan.qname "%MATHML.pfx;ns1:arctan" >
<!ENTITY % ns1:arctanh.qname "%MATHML.pfx;ns1:arctanh" >
<!ENTITY % ns1:arg.qname "%MATHML.pfx;ns1:arg" >
<!ENTITY % ns1:bind.qname "%MATHML.pfx;ns1:bind" >
<!ENTITY % ns1:bvar.qname "%MATHML.pfx;ns1:bvar" >
<!ENTITY % ns1:card.qname "%MATHML.pfx;ns1:card" >
<!ENTITY % ns1:cartesianproduct.qname "%MATHML.pfx;ns1:cartesianproduct" >
<!ENTITY % ns1:cbytes.qname "%MATHML.pfx;ns1:cbytes" >
<!ENTITY % ns1:ceiling.qname "%MATHML.pfx;ns1:ceiling" >
<!ENTITY % ns1:cerror.qname "%MATHML.pfx;ns1:cerror" >
<!ENTITY % ns1:ci.qname "%MATHML.pfx;ns1:ci" >
<!ENTITY % ns1:cn.qname "%MATHML.pfx;ns1:cn" >
<!ENTITY % ns1:codomain.qname "%MATHML.pfx;ns1:codomain" >
<!ENTITY % ns1:complexes.qname "%MATHML.pfx;ns1:complexes" >
<!ENTITY % ns1:compose.qname "%MATHML.pfx;ns1:compose" >
<!ENTITY % ns1:condition.qname "%MATHML.pfx;ns1:condition" >
<!ENTITY % ns1:conjugate.qname "%MATHML.pfx;ns1:conjugate" >
<!ENTITY % ns1:cos.qname "%MATHML.pfx;ns1:cos" >
<!ENTITY % ns1:cosh.qname "%MATHML.pfx;ns1:cosh" >
<!ENTITY % ns1:cot.qname "%MATHML.pfx;ns1:cot" >
<!ENTITY % ns1:coth.qname "%MATHML.pfx;ns1:coth" >
<!ENTITY % ns1:cs.qname "%MATHML.pfx;ns1:cs" >
<!ENTITY % ns1:csc.qname "%MATHML.pfx;ns1:csc" >
<!ENTITY % ns1:csch.qname "%MATHML.pfx;ns1:csch" >
<!ENTITY % ns1:csymbol.qname "%MATHML.pfx;ns1:csymbol" >
<!ENTITY % ns1:curl.qname "%MATHML.pfx;ns1:curl" >
<!ENTITY % ns1:declare.qname "%MATHML.pfx;ns1:declare" >
<!ENTITY % ns1:degree.qname "%MATHML.pfx;ns1:degree" >
<!ENTITY % ns1:determinant.qname "%MATHML.pfx;ns1:determinant" >
<!ENTITY % ns1:diff.qname "%MATHML.pfx;ns1:diff" >
<!ENTITY % ns1:divergence.qname "%MATHML.pfx;ns1:divergence" >
<!ENTITY % ns1:divide.qname "%MATHML.pfx;ns1:divide" >
<!ENTITY % ns1:domain.qname "%MATHML.pfx;ns1:domain" >
<!ENTITY % ns1:domainofapplication.qname "%MATHML.pfx;ns1:domainofapplication" >
<!ENTITY % ns1:emptyset.qname "%MATHML.pfx;ns1:emptyset" >
<!ENTITY % ns1:eq.qname "%MATHML.pfx;ns1:eq" >
<!ENTITY % ns1:equivalent.qname "%MATHML.pfx;ns1:equivalent" >
<!ENTITY % ns1:eulergamma.qname "%MATHML.pfx;ns1:eulergamma" >
<!ENTITY % ns1:exists.qname "%MATHML.pfx;ns1:exists" >
<!ENTITY % ns1:exp.qname "%MATHML.pfx;ns1:exp" >
<!ENTITY % ns1:exponentiale.qname "%MATHML.pfx;ns1:exponentiale" >
<!ENTITY % ns1:factorial.qname "%MATHML.pfx;ns1:factorial" >
<!ENTITY % ns1:factorof.qname "%MATHML.pfx;ns1:factorof" >
<!ENTITY % ns1:false.qname "%MATHML.pfx;ns1:false" >
<!ENTITY % ns1:floor.qname "%MATHML.pfx;ns1:floor" >
<!ENTITY % ns1:fn.qname "%MATHML.pfx;ns1:fn" >
<!ENTITY % ns1:forall.qname "%MATHML.pfx;ns1:forall" >
<!ENTITY % ns1:gcd.qname "%MATHML.pfx;ns1:gcd" >
<!ENTITY % ns1:geq.qname "%MATHML.pfx;ns1:geq" >
<!ENTITY % ns1:grad.qname "%MATHML.pfx;ns1:grad" >
<!ENTITY % ns1:gt.qname "%MATHML.pfx;ns1:gt" >
<!ENTITY % ns1:ident.qname "%MATHML.pfx;ns1:ident" >
<!ENTITY % ns1:image.qname "%MATHML.pfx;ns1:image" >
<!ENTITY % ns1:imaginary.qname "%MATHML.pfx;ns1:imaginary" >
<!ENTITY % ns1:imaginaryi.qname "%MATHML.pfx;ns1:imaginaryi" >
<!ENTITY % ns1:implies.qname "%MATHML.pfx;ns1:implies" >
<!ENTITY % ns1:in.qname "%MATHML.pfx;ns1:in" >
<!ENTITY % ns1:infinity.qname "%MATHML.pfx;ns1:infinity" >
<!ENTITY % ns1:int.qname "%MATHML.pfx;ns1:int" >
<!ENTITY % ns1:integers.qname "%MATHML.pfx;ns1:integers" >
<!ENTITY % ns1:intersect.qname "%MATHML.pfx;ns1:intersect" >
<!ENTITY % ns1:interval.qname "%MATHML.pfx;ns1:interval" >
<!ENTITY % ns1:inverse.qname "%MATHML.pfx;ns1:inverse" >
<!ENTITY % ns1:lambda.qname "%MATHML.pfx;ns1:lambda" >
<!ENTITY % ns1:laplacian.qname "%MATHML.pfx;ns1:laplacian" >
<!ENTITY % ns1:lcm.qname "%MATHML.pfx;ns1:lcm" >
<!ENTITY % ns1:leq.qname "%MATHML.pfx;ns1:leq" >
<!ENTITY % ns1:limit.qname "%MATHML.pfx;ns1:limit" >
<!ENTITY % ns1:list.qname "%MATHML.pfx;ns1:list" >
<!ENTITY % ns1:ln.qname "%MATHML.pfx;ns1:ln" >
<!ENTITY % ns1:log.qname "%MATHML.pfx;ns1:log" >
<!ENTITY % ns1:logbase.qname "%MATHML.pfx;ns1:logbase" >
<!ENTITY % ns1:lowlimit.qname "%MATHML.pfx;ns1:lowlimit" >
<!ENTITY % ns1:lt.qname "%MATHML.pfx;ns1:lt" >
<!ENTITY % ns1:maction.qname "%MATHML.pfx;ns1:maction" >
<!ENTITY % ns1:maligngroup.qname "%MATHML.pfx;ns1:maligngroup" >
<!ENTITY % ns1:malignmark.qname "%MATHML.pfx;ns1:malignmark" >
<!ENTITY % ns1:math.qname "%MATHML.pfx;ns1:math" >
<!ENTITY % ns1:matrix.qname "%MATHML.pfx;ns1:matrix" >
<!ENTITY % ns1:matrixrow.qname "%MATHML.pfx;ns1:matrixrow" >
<!ENTITY % ns1:max.qname "%MATHML.pfx;ns1:max" >
<!ENTITY % ns1:mean.qname "%MATHML.pfx;ns1:mean" >
<!ENTITY % ns1:median.qname "%MATHML.pfx;ns1:median" >
<!ENTITY % ns1:menclose.qname "%MATHML.pfx;ns1:menclose" >
<!ENTITY % ns1:merror.qname "%MATHML.pfx;ns1:merror" >
<!ENTITY % ns1:mfenced.qname "%MATHML.pfx;ns1:mfenced" >
<!ENTITY % ns1:mfrac.qname "%MATHML.pfx;ns1:mfrac" >
<!ENTITY % ns1:mglyph.qname "%MATHML.pfx;ns1:mglyph" >
<!ENTITY % ns1:mi.qname "%MATHML.pfx;ns1:mi" >
<!ENTITY % ns1:min.qname "%MATHML.pfx;ns1:min" >
<!ENTITY % ns1:minus.qname "%MATHML.pfx;ns1:minus" >
<!ENTITY % ns1:mlabeledtr.qname "%MATHML.pfx;ns1:mlabeledtr" >
<!ENTITY % ns1:mlongdiv.qname "%MATHML.pfx;ns1:mlongdiv" >
<!ENTITY % ns1:mmultiscripts.qname "%MATHML.pfx;ns1:mmultiscripts" >
<!ENTITY % ns1:mn.qname "%MATHML.pfx;ns1:mn" >
<!ENTITY % ns1:mo.qname "%MATHML.pfx;ns1:mo" >
<!ENTITY % ns1:mode.qname "%MATHML.pfx;ns1:mode" >
<!ENTITY % ns1:moment.qname "%MATHML.pfx;ns1:moment" >
<!ENTITY % ns1:momentabout.qname "%MATHML.pfx;ns1:momentabout" >
<!ENTITY % ns1:mover.qname "%MATHML.pfx;ns1:mover" >
<!ENTITY % ns1:mpadded.qname "%MATHML.pfx;ns1:mpadded" >
<!ENTITY % ns1:mphantom.qname "%MATHML.pfx;ns1:mphantom" >
<!ENTITY % ns1:mprescripts.qname "%MATHML.pfx;ns1:mprescripts" >
<!ENTITY % ns1:mroot.qname "%MATHML.pfx;ns1:mroot" >
<!ENTITY % ns1:mrow.qname "%MATHML.pfx;ns1:mrow" >
<!ENTITY % ns1:ms.qname "%MATHML.pfx;ns1:ms" >
<!ENTITY % ns1:mscarries.qname "%MATHML.pfx;ns1:mscarries" >
<!ENTITY % ns1:mscarry.qname "%MATHML.pfx;ns1:mscarry" >
<!ENTITY % ns1:msgroup.qname "%MATHML.pfx;ns1:msgroup" >
<!ENTITY % ns1:msline.qname "%MATHML.pfx;ns1:msline" >
<!ENTITY % ns1:mspace.qname "%MATHML.pfx;ns1:mspace" >
<!ENTITY % ns1:msqrt.qname "%MATHML.pfx;ns1:msqrt" >
<!ENTITY % ns1:msrow.qname "%MATHML.pfx;ns1:msrow" >
<!ENTITY % ns1:mstack.qname "%MATHML.pfx;ns1:mstack" >
<!ENTITY % ns1:mstyle.qname "%MATHML.pfx;ns1:mstyle" >
<!ENTITY % ns1:msub.qname "%MATHML.pfx;ns1:msub" >
<!ENTITY % ns1:msubsup.qname "%MATHML.pfx;ns1:msubsup" >
<!ENTITY % ns1:msup.qname "%MATHML.pfx;ns1:msup" >
<!ENTITY % ns1:mtable.qname "%MATHML.pfx;ns1:mtable" >
<!ENTITY % ns1:mtd.qname "%MATHML.pfx;ns1:mtd" >
<!ENTITY % ns1:mtext.qname "%MATHML.pfx;ns1:mtext" >
<!ENTITY % ns1:mtr.qname "%MATHML.pfx;ns1:mtr" >
<!ENTITY % ns1:munder.qname "%MATHML.pfx;ns1:munder" >
<!ENTITY % ns1:munderover.qname "%MATHML.pfx;ns1:munderover" >
<!ENTITY % ns1:naturalnumbers.qname "%MATHML.pfx;ns1:naturalnumbers" >
<!ENTITY % ns1:neq.qname "%MATHML.pfx;ns1:neq" >
<!ENTITY % ns1:none.qname "%MATHML.pfx;ns1:none" >
<!ENTITY % ns1:not.qname "%MATHML.pfx;ns1:not" >
<!ENTITY % ns1:notanumber.qname "%MATHML.pfx;ns1:notanumber" >
<!ENTITY % ns1:notin.qname "%MATHML.pfx;ns1:notin" >
<!ENTITY % ns1:notprsubset.qname "%MATHML.pfx;ns1:notprsubset" >
<!ENTITY % ns1:notsubset.qname "%MATHML.pfx;ns1:notsubset" >
<!ENTITY % ns1:or.qname "%MATHML.pfx;ns1:or" >
<!ENTITY % ns1:otherwise.qname "%MATHML.pfx;ns1:otherwise" >
<!ENTITY % ns1:outerproduct.qname "%MATHML.pfx;ns1:outerproduct" >
<!ENTITY % ns1:partialdiff.qname "%MATHML.pfx;ns1:partialdiff" >
<!ENTITY % ns1:pi.qname "%MATHML.pfx;ns1:pi" >
<!ENTITY % ns1:piece.qname "%MATHML.pfx;ns1:piece" >
<!ENTITY % ns1:piecewise.qname "%MATHML.pfx;ns1:piecewise" >
<!ENTITY % ns1:plus.qname "%MATHML.pfx;ns1:plus" >
<!ENTITY % ns1:power.qname "%MATHML.pfx;ns1:power" >
<!ENTITY % ns1:primes.qname "%MATHML.pfx;ns1:primes" >
<!ENTITY % ns1:product.qname "%MATHML.pfx;ns1:product" >
<!ENTITY % ns1:prsubset.qname "%MATHML.pfx;ns1:prsubset" >
<!ENTITY % ns1:quotient.qname "%MATHML.pfx;ns1:quotient" >
<!ENTITY % ns1:rationals.qname "%MATHML.pfx;ns1:rationals" >
<!ENTITY % ns1:real.qname "%MATHML.pfx;ns1:real" >
<!ENTITY % ns1:reals.qname "%MATHML.pfx;ns1:reals" >
<!ENTITY % ns1:reln.qname "%MATHML.pfx;ns1:reln" >
<!ENTITY % ns1:rem.qname "%MATHML.pfx;ns1:rem" >
<!ENTITY % ns1:root.qname "%MATHML.pfx;ns1:root" >
<!ENTITY % ns1:scalarproduct.qname "%MATHML.pfx;ns1:scalarproduct" >
<!ENTITY % ns1:sdev.qname "%MATHML.pfx;ns1:sdev" >
<!ENTITY % ns1:sec.qname "%MATHML.pfx;ns1:sec" >
<!ENTITY % ns1:sech.qname "%MATHML.pfx;ns1:sech" >
<!ENTITY % ns1:selector.qname "%MATHML.pfx;ns1:selector" >
<!ENTITY % ns1:semantics.qname "%MATHML.pfx;ns1:semantics" >
<!ENTITY % ns1:sep.qname "%MATHML.pfx;ns1:sep" >
<!ENTITY % ns1:set.qname "%MATHML.pfx;ns1:set" >
<!ENTITY % ns1:setdiff.qname "%MATHML.pfx;ns1:setdiff" >
<!ENTITY % ns1:share.qname "%MATHML.pfx;ns1:share" >
<!ENTITY % ns1:sin.qname "%MATHML.pfx;ns1:sin" >
<!ENTITY % ns1:sinh.qname "%MATHML.pfx;ns1:sinh" >
<!ENTITY % ns1:subset.qname "%MATHML.pfx;ns1:subset" >
<!ENTITY % ns1:sum.qname "%MATHML.pfx;ns1:sum" >
<!ENTITY % ns1:tan.qname "%MATHML.pfx;ns1:tan" >
<!ENTITY % ns1:tanh.qname "%MATHML.pfx;ns1:tanh" >
<!ENTITY % ns1:tendsto.qname "%MATHML.pfx;ns1:tendsto" >
<!ENTITY % ns1:times.qname "%MATHML.pfx;ns1:times" >
<!ENTITY % ns1:transpose.qname "%MATHML.pfx;ns1:transpose" >
<!ENTITY % ns1:true.qname "%MATHML.pfx;ns1:true" >
<!ENTITY % ns1:union.qname "%MATHML.pfx;ns1:union" >
<!ENTITY % ns1:uplimit.qname "%MATHML.pfx;ns1:uplimit" >
<!ENTITY % ns1:variance.qname "%MATHML.pfx;ns1:variance" >
<!ENTITY % ns1:vector.qname "%MATHML.pfx;ns1:vector" >
<!ENTITY % ns1:vectorproduct.qname "%MATHML.pfx;ns1:vectorproduct" >
<!ENTITY % ns1:xor.qname "%MATHML.pfx;ns1:xor" >
