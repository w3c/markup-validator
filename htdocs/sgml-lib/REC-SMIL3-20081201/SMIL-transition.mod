<!-- ====================================================================== -->
<!-- SMIL 3.0 Transition Module =========================================== -->
<!-- file: SMIL-transition.mod

     This is SMIL 3.0.

        Copyright: 1998-2008 W3C (MIT, ERCIM, Keio), All Rights
        Reserved.  See http://www.w3.org/Consortium/Legal/.

        Editor for SMIL 3.0: Sjoerd Mullender, CWI
        Editor for previous versions of SMIL: Jacco van Ossenbruggen,
        Sjoerd Mullender.
        $Revision: 1.7 $
        $Date: 2008/09/07 20:36:50 $

     This DTD module is identified by the PUBLIC and SYSTEM identifiers:

     PUBLIC "-//W3C//ELEMENTS SMIL 3.0 Transition//EN"
     SYSTEM "http://www.w3.org/2008/SMIL30/SMIL-transition.mod"

     ====================================================================== -->

<!ENTITY % SMIL.TransitionModifiers.module "IGNORE">
<![%SMIL.TransitionModifiers.module;[
  <!ENTITY % SMIL.transition-modifiers-attrs "
    horzRepeat   CDATA                  '1'
    vertRepeat   CDATA                  '1'
    borderWidth  CDATA                  '0'
    borderColor  CDATA                  'black'
  ">
]]> <!-- End of TransitionModifiers.module -->
<!ENTITY % SMIL.transition-modifiers-attrs "">

<!ENTITY % SMIL.transition-types "(barWipe|boxWipe|fourBoxWipe|barnDoorWipe|
 diagonalWipe|bowTieWipe|miscDiagonalWipe|veeWipe|barnVeeWipe|zigZagWipe|
 barnZigZagWipe|irisWipe|triangleWipe|arrowHeadWipe|pentagonWipe|
 hexagonWipe|ellipseWipe|eyeWipe|roundRectWipe|starWipe|miscShapeWipe|
 clockWipe|pinWheelWipe|singleSweepWipe|fanWipe|doubleFanWipe|doubleSweepWipe|
 saloonDoorWipe|windshieldWipe|snakeWipe|spiralWipe|parallelSnakesWipe|
 boxSnakesWipe|waterfallWipe|pushWipe|slideWipe|fade|audioFade|
 audioVisualFade)"
>

<!ENTITY % SMIL.transition-subtypes "(bottom|bottomCenter|bottomLeft|
 bottomLeftClockwise|bottomLeftCounterClockwise|
 bottomLeftDiagonal|bottomRight|bottomRightClockwise|
 bottomRightCounterClockwise|bottomRightDiagonal|centerRight|centerTop|
 circle|clockwiseBottom|clockwiseBottomRight|clockwiseLeft|clockwiseNine|
 clockwiseRight|clockwiseSix|clockwiseThree|clockwiseTop|clockwiseTopLeft|
 clockwiseTwelve|cornersIn|cornersOut|counterClockwiseBottomLeft|
 counterClockwiseTopRight|crossfade|diagonalBottomLeft|
 diagonalBottomLeftOpposite|diagonalTopLeft|diagonalTopLeftOpposite|
 diamond|doubleBarnDoor|doubleDiamond|down|fadeFromColor|fadeToColor|
 fanInHorizontal|fanInVertical|fanOutHorizontal|fanOutVertical|fivePoint|
 fourBlade|fourBoxHorizontal|fourBoxVertical|fourPoint|fromBottom|fromLeft|
 fromRight|fromTop|heart|horizontal|horizontalLeft|horizontalLeftSame|
 horizontalRight|horizontalRightSame|horizontalTopLeftOpposite|
 horizontalTopRightOpposite|keyhole|left|leftCenter|leftToRight|
 oppositeHorizontal|oppositeVertical|parallelDiagonal|
 parallelDiagonalBottomLeft|parallelDiagonalTopLeft|
 parallelVertical|rectangle|right|rightCenter|sixPoint|top|topCenter|
 topLeft|topLeftClockwise|topLeftCounterClockwise|topLeftDiagonal|
 topLeftHorizontal|topLeftVertical|topRight|topRightClockwise|
 topRightCounterClockwise|topRightDiagonal|topToBottom|twoBladeHorizontal|
 twoBladeVertical|twoBoxBottom|twoBoxLeft|twoBoxRight|twoBoxTop|up|
 vertical|verticalBottomLeftOpposite|verticalBottomSame|verticalLeft|
 verticalRight|verticalTopLeftOpposite|verticalTopSame)"
>

<!ENTITY  % SMIL.transition-attrs "
   type         %SMIL.transition-types;     #IMPLIED
   subtype      %SMIL.transition-subtypes;  #IMPLIED
   fadeColor    CDATA                  'black'
   %SMIL.transition-modifiers-attrs;
">

<!ENTITY % SMIL.BasicTransitions.module "IGNORE">
<![%SMIL.BasicTransitions.module;[
 <!ENTITY % SMIL.transition.attrib  "">
 <!ENTITY % SMIL.transition.content "EMPTY">
 <!ENTITY % SMIL.transition.qname   "transition">
 <!ELEMENT %SMIL.transition.qname; %SMIL.transition.content;>
 <!ATTLIST %SMIL.transition.qname; %SMIL.transition.attrib;
    %SMIL.Core.attrib;
    %SMIL.I18n.attrib;
    %SMIL.transition-attrs;
    dur           %TimeValue.datatype; #IMPLIED
    startProgress CDATA              '0.0'
    endProgress   CDATA              '1.0'
    direction     (forward|reverse)  'forward'
 >
]]> <!-- End of BasicTransitions.module -->

<!ENTITY % SMIL.InlineTransitions.module "IGNORE">
<![%SMIL.InlineTransitions.module;[

  <!ENTITY % SMIL.transitionFilter.attrib  "">
  <!ENTITY % SMIL.transitionFilter.content "EMPTY">
  <!ENTITY % SMIL.transitionFilter.qname   "transitionFilter">
  <!ELEMENT %SMIL.transitionFilter.qname; %SMIL.transitionFilter.content;>
  <!ATTLIST %SMIL.transitionFilter.qname; %SMIL.transitionFilter.attrib;
    %SMIL.Core.attrib;
    %SMIL.I18n.attrib;
    %SMIL.transition-attrs;
    mode        (in|out)                'in'
    begin       %TimeValue.datatype;    #IMPLIED
    dur         %TimeValue.datatype;    #IMPLIED
    end         %TimeValue.datatype;    #IMPLIED
    %SMIL.RepeatTiming.attrib;
    from        CDATA                   '0.0'
    to          CDATA                   '1.0'
    by          CDATA                   #IMPLIED
    values      CDATA                   #IMPLIED
    calcMode    (discrete|linear|paced) 'linear'
  >

  <!-- Language Designer chooses to integrate targetElement or XLink
       attributes.  To integrate the targetElement attribute, define
       the entity SMIL.transition-targetElement as "INCLUDE"; to
       integrate the XLink attributes, define
       SMIL.transition-XLinkTarget as "INCLUDE".

       If InlineTransitions are included, one or the other MUST be
       defined.  It is strongly recommended that only one of the two be
       defined.
  -->
  <!ENTITY % SMIL.transition-XLinkTarget "IGNORE">
  <![%SMIL.transition-XLinkTarget;[
    <!ATTLIST %SMIL.transitionFilter.qname;
      href    %URI.datatype;                #IMPLIED
      type    (simple|extended|locator|arc) #FIXED 'simple'
      actuate (onLoad|onRequest)            #FIXED 'onLoad'
      show    (embed|new|replace)           #FIXED 'embed'
    >
  ]]>
  <!ENTITY % SMIL.transition-targetElement "IGNORE">
  <![%SMIL.transition-targetElement;[
    <!ATTLIST %SMIL.transitionFilter.qname;
      targetElement IDREF #IMPLIED
    >
  ]]>
]]> <!-- End of InlineTransitions.module -->

<!-- ================== FullScreenTransitionEffects ======================= -->
<!ENTITY % SMIL.FullScreenTransitionEffects.module "IGNORE">
<![%SMIL.FullScreenTransitionEffects.module;[
  <!-- ================== FullScreenTransitionEffects Entities ============ -->
  <!ENTITY % SMIL.scope-attrs "
    scope (region|screen) 'region'
  ">

  <!-- ================ Add attributes to region element ================== -->
  <!ATTLIST %SMIL.transition.qname; %SMIL.scope-attrs;>
]]> <!-- end FullScreenTransitionEffects.module -->

<!-- end of SMIL-transition.mod -->
