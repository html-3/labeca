#include "__cf_Pi_test_3.h"
#include "Pi_test_3.h"
#include "rtwtypes.h"
#include "xcp.h"
#include "ext_work.h"
volatile int IsrOverrun = _PIqWtbzrbQqv_KS_31HnE2 ; static boolean_T
OverrunFlag = _PIqWtbzrbQqv_KS_31HnE2 ; void rt_OneStep ( void ) { if (
OverrunFlag ++ ) { IsrOverrun = _QHNSjd8JBrVVYZAcs7Zm32 ; OverrunFlag -- ;
return ; }
#ifndef _MW_ARDUINO_LOOP_ 
interrupts ( ) ;
#endif
; Pi_test_3_step ( ) ;
#ifndef _MW_ARDUINO_LOOP_ 
noInterrupts ( ) ;
#endif
; OverrunFlag -- ; rtExtModeCheckEndTrigger ( ) ; } extern void
rtIOStreamResync ( ) ; volatile boolean_T stopRequested ; volatile boolean_T
runModel ; int main ( void ) { float modelBaseRate = _ejJFkqxLkFf8z5s0UH9rX0
; float systemClock = _PIqWtbzrbQqv_KS_31HnE2 ; stopRequested = false ;
runModel = false ;
#if defined(MW_MULTI_TASKING_MODE) && (MW_MULTI_TASKING_MODE == _QHNSjd8JBrVVYZAcs7Zm32)
MW_ASM ( " \123V\x43 #1" ) ;
#endif
; init ( ) ; MW_Arduino_Init ( ) ; rtmSetErrorStatus ( gzurmpwdkb ,
_PIqWtbzrbQqv_KS_31HnE2 ) ; rtParseArgsForExtMode ( _PIqWtbzrbQqv_KS_31HnE2 ,
NULL ) ; Pi_test_3_initialize ( ) ; noInterrupts ( ) ; interrupts ( ) ;
rtSetTFinalForExtMode ( & rtmGetTFinal ( gzurmpwdkb ) ) ; rtExtModeCheckInit
( _gN74BbsU5wqNjkJbC9b672 ) ; { boolean_T rtmStopReq = false ;
rtExtModeWaitForStartPkt ( gzurmpwdkb -> extModeInfo ,
_gN74BbsU5wqNjkJbC9b672 , & rtmStopReq ) ; if ( rtmStopReq ) {
rtmSetStopRequested ( gzurmpwdkb , true ) ; } } rtERTExtModeStartMsg ( ) ;
noInterrupts ( ) ; configureArduinoARMTimer ( ) ; runModel = (
rtmGetErrorStatus ( gzurmpwdkb ) == ( NULL ) ) && ! rtmGetStopRequested (
gzurmpwdkb ) ;
#ifndef _MW_ARDUINO_LOOP_ 
interrupts ( ) ;
#endif
; XcpStatus lastXcpState = xcpStatusGet ( ) ; interrupts ( ) ; while (
runModel ) { { boolean_T rtmStopReq = false ; rtExtModeOneStep ( gzurmpwdkb
-> extModeInfo , _gN74BbsU5wqNjkJbC9b672 , & rtmStopReq ) ; if ( rtmStopReq )
{ rtmSetStopRequested ( gzurmpwdkb , true ) ; } } stopRequested = ! ( (
rtmGetErrorStatus ( gzurmpwdkb ) == ( NULL ) ) && ! rtmGetStopRequested (
gzurmpwdkb ) ) ; runModel = ! ( stopRequested ) ; if ( stopRequested )
disable_rt_OneStep ( ) ; if ( lastXcpState == XCP_CONNECTED && xcpStatusGet (
) == XCP_DISCONNECTED ) rtIOStreamResync ( ) ; lastXcpState = xcpStatusGet (
) ; MW_Arduino_Loop ( ) ; } Pi_test_3_terminate ( ) ; rtExtModeShutdown (
_gN74BbsU5wqNjkJbC9b672 ) ; MW_Arduino_Terminate ( ) ; noInterrupts ( ) ;
return _PIqWtbzrbQqv_KS_31HnE2 ; }
