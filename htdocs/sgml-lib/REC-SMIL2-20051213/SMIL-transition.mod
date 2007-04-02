<!-- ====================================================================== -->
<!-- SMIL Transition Module  ============================================== -->
<!-- file: SMIL-transition.mod

     This is SMIL 2.1.

        Copyright: 1998-2005 W3C (MIT, ERCIM, Keio), All Rights
        Reserved.  See http://www.w3.org/Consortium/Legal/.

        Author:     Jacco van Ossenbruggen.
        Editor for SMIL 2.1: Sjoerd Mullender, CWI
        $Revision: 1.1 $
        $Date: 2007-04-02 05:08:39 $

     This DTD module is identified by the PUBLIC and SYSTEM identifiers:

     PUBLIC "-//W3C//ELEMENTS SMIL 2.1 Transition//EN"
     SYSTEM "http://www.w3.org/2005/SMIL21/SMIL-transition.mod"

     ====================================================================== -->

<!ENTITY % SMIL.TransitionModifiers.module "IGNORE">
<![%SMIL.TransitionModifiers.module;[
 <!ENTITY % SMIL.transition-modifiers-attrs '
    horzRepeat   CDATA                  "1"
    vertRepeat   CDATA                  "1"
    borderWidth  CDATA                  "0"
    borderColor  CDATA                  "black"
 '>
]]> <!-- End of TransitionModifiers.module -->
<!ENTITY % SMIL.transition-modifiers-attrs "">

<!ENTITY % SMIL.BasicTransitions.module "INCLUDE">
<![%SMIL.BasicTransitions.module;[

 <!ENTITY % SMIL.transition-types "(barWipe|boxWipe|fourBoxWipe|barnDoorWipe|
  diagonalWipe|bowTieWipe|miscDiagonalWipe|veeWipe|barnVeeWipe|zigZagWipe|
  barnZigZagWipe|irisWipe|triangleWipe|arrowHeadWipe|pentagonWipe|
  hexagonWipe|ellipseWipe|eyeWipe|roundRectWipe|starWipe|miscShapeWipe|clockWipe|
  pinWheelWipe|singleSweepWipe|fanWipe|doubleFanWipe|doubleSweepWipe|
  saloonDoorWipe|windshieldWipe|snakeWipe|spiralWipe|parallelSnakesWipe|
  boxSnakesWipe|waterfallWipe|pushWipe|slideWipe|fade|audioFade|audioVisualFade)"
 >

 <!ENTITY % SMIL.transition-subtypes "(bottom
  |bottomCenter|bottomLeft|bottomLeftClockwise|bottomLeftCounterClockwise|
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

 <!ENTITY  % SMIL.transition-attrs '
    type         %SMIL.transition-types;     #IMPLIED
    subtype      %SMIL.transition-subtypes;  #IMPLIED
    fadeColor    CDATA                  "black"
    %SMIL.transition-modifiers-attrs;
 '>

 <!ENTITY % SMIL.transition.attrib  "">
 <!ENTITY % SMIL.transition.content "EMPTY">
 <!ENTITY % SMIL.transition.qname   "transition">
 <!ELEMENT %SMIL.transition.qname; %SMIL.transition.content;>
 <!ATTLIST %SMIL.transition.qname; %SMIL.transition.attrib;
    %Core.attrib;
    %I18n.attrib;
    %SMIL.transition-attrs;
    dur           %TimeValue.datatype; #IMPLIED
    startProgress CDATA              "0.0"
    endProgress   CDATA              "1.0"
    direction     (forward|reverse)  "forward"
 >
]]> <!-- End of BasicTransitions.module -->

<!ENTITY % SMIL.InlineTransitions.module "IGNORE">
<![%SMIL.InlineTransitions.module;[

 <!ENTITY % SMIL.transitionFilter.attrib  "">
 <!ENTITY % SMIL.transitionFilter.content "EMPTY">
 <!ENTITY % SMIL.transitionFilter.qname   "transitionFilter">
 <!ELEMENT %SMIL.transitionFilter.qname; %SMIL.transitionFilter.content;>
 <!ATTLIST %SMIL.transitionFilter.qname; %SMIL.transitionFilter.attrib;
    %Core.attrib;
    %I18n.attrib;
    %SMIL.transition-attrs;
    %SMIL.BasicInlineTiming.attrib;
    %SMIL.BasicAnimation.attrib;
    calcMode   (discrete|linear|paced) 'linear'
 >
]]> <!-- End of InlineTransitions.module -->

<!-- ================== FullScreenTransitionEffects ====================== -->
<!ENTITY % SMIL.FullScreenTransitionEffects.module "IGNORE">
<![%SMIL.FullScreenTransitionEffects.module;[
  <!-- ================== FullScreenTransitionEffects Entities =========== -->
  <!ENTITY % SMIL.scope-attrs "
    scope (region|screen) 'region'
">

  <!-- ================ Add attributes to region element ================= -->
  <!ATTLIST %SMIL.transition.qname; %SMIL.scope-attrs;>
]]> <!-- end FullScreenTransitionEffects.module -->

<!-- end of SMIL-transition.mod -->
