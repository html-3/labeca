#include "__cf_Pi_test_3.h"
#include "Pi_test_3.h"
#include "Pi_test_3_private.h"
jxbih4cc4o jxbih4cc4o4 ; h4tr05fetl h4tr05fetlx ; jm0e5wk21v jm0e5wk21vo ;
static gk4bgt4ywz gzurmpwdkb_ ; gk4bgt4ywz * const gzurmpwdkb = & gzurmpwdkb_
; static void rt_ertODEUpdateContinuousStates ( RTWSolverInfo * si ) { time_T
t = rtsiGetT ( si ) ; time_T tnew = rtsiGetSolverStopTime ( si ) ; time_T h =
rtsiGetStepSize ( si ) ; real_T * x = rtsiGetContStates ( si ) ;
ODE4_IntgData * id = ( ODE4_IntgData * ) rtsiGetSolverData ( si ) ; real_T *
y = id -> y ; real_T * f0 = id -> f [ _PIqWtbzrbQqv_KS_31HnE2 ] ; real_T * f1
= id -> f [ _QHNSjd8JBrVVYZAcs7Zm32 ] ; real_T * f2 = id -> f [
_gN74BbsU5wqNjkJbC9b672 ] ; real_T * f3 = id -> f [ _nfvdmbxYkVXzXnpHyWwmg2 ]
; real_T temp ; int_T i ; int_T nXc = _QHNSjd8JBrVVYZAcs7Zm32 ;
rtsiSetSimTimeStep ( si , MINOR_TIME_STEP ) ; ( void ) memcpy ( y , x , (
uint_T ) nXc * sizeof ( real_T ) ) ; rtsiSetdX ( si , f0 ) ;
Pi_test_3_derivatives ( ) ; temp = _IE_h0ySUMKhEY_mtQbaOn_ * h ; for ( i =
_PIqWtbzrbQqv_KS_31HnE2 ; i < nXc ; i ++ ) { x [ i ] = y [ i ] + ( temp * f0
[ i ] ) ; } rtsiSetT ( si , t + temp ) ; rtsiSetdX ( si , f1 ) ;
Pi_test_3_step ( ) ; Pi_test_3_derivatives ( ) ; for ( i =
_PIqWtbzrbQqv_KS_31HnE2 ; i < nXc ; i ++ ) { x [ i ] = y [ i ] + ( temp * f1
[ i ] ) ; } rtsiSetdX ( si , f2 ) ; Pi_test_3_step ( ) ;
Pi_test_3_derivatives ( ) ; for ( i = _PIqWtbzrbQqv_KS_31HnE2 ; i < nXc ; i
++ ) { x [ i ] = y [ i ] + ( h * f2 [ i ] ) ; } rtsiSetT ( si , tnew ) ;
rtsiSetdX ( si , f3 ) ; Pi_test_3_step ( ) ; Pi_test_3_derivatives ( ) ; temp
= h / _j70tR3aLfEVetsFUXmWMd2 ; for ( i = _PIqWtbzrbQqv_KS_31HnE2 ; i < nXc ;
i ++ ) { x [ i ] = y [ i ] + temp * ( f0 [ i ] + _IfqgJOo_0kGGrK4yerXJx_ * f1
[ i ] + _IfqgJOo_0kGGrK4yerXJx_ * f2 [ i ] + f3 [ i ] ) ; }
rtsiSetSimTimeStep ( si , MAJOR_TIME_STEP ) ; } void Pi_test_3_step ( void )
{ p00yb3zgla * obj ; real_T oqbnqsoi1t ; uint16_T ffpwtnqj0x_p ; if (
rtmIsMajorTimeStep ( gzurmpwdkb ) ) { if ( ! ( gzurmpwdkb -> Timing .
clockTick0 + _QHNSjd8JBrVVYZAcs7Zm32 ) ) { rtsiSetSolverStopTime ( &
gzurmpwdkb -> solverInfo , ( ( gzurmpwdkb -> Timing . clockTickH0 +
_QHNSjd8JBrVVYZAcs7Zm32 ) * gzurmpwdkb -> Timing . stepSize0 *
_Nn3DUUbvuyRrgaA48_gSO0 ) ) ; } else { rtsiSetSolverStopTime ( & gzurmpwdkb
-> solverInfo , ( ( gzurmpwdkb -> Timing . clockTick0 +
_QHNSjd8JBrVVYZAcs7Zm32 ) * gzurmpwdkb -> Timing . stepSize0 + gzurmpwdkb ->
Timing . clockTickH0 * gzurmpwdkb -> Timing . stepSize0 *
_Nn3DUUbvuyRrgaA48_gSO0 ) ) ; } } if ( rtmIsMinorTimeStep ( gzurmpwdkb ) ) {
gzurmpwdkb -> Timing . t [ _PIqWtbzrbQqv_KS_31HnE2 ] = rtsiGetT ( &
gzurmpwdkb -> solverInfo ) ; } if ( rtmIsMajorTimeStep ( gzurmpwdkb ) ) {
oqbnqsoi1t = ( jm0e5wk21vo . jejetohfol < eil1ubehyx . PulseGenerator2_Duty )
&& ( jm0e5wk21vo . jejetohfol >= _PIqWtbzrbQqv_KS_31HnE2 ) ? eil1ubehyx .
PulseGenerator2_Amp : _Z77Ee2RGrs6HvPP38e_Kk_ ; if ( jm0e5wk21vo . jejetohfol
>= eil1ubehyx . PulseGenerator2_Period - _p01KwLUrlxQyp_iCq4iLA2 ) {
jm0e5wk21vo . jejetohfol = _PIqWtbzrbQqv_KS_31HnE2 ; } else { jm0e5wk21vo .
jejetohfol ++ ; } jxbih4cc4o4 . m34wvvitzi = oqbnqsoi1t + eil1ubehyx .
Constant1_Value ; } if ( jm0e5wk21vo . amysdhmstu . SampleTime != eil1ubehyx
. AnalogInput1_SampleTime ) { jm0e5wk21vo . amysdhmstu . SampleTime =
eil1ubehyx . AnalogInput1_SampleTime ; } obj = & jm0e5wk21vo . amysdhmstu ;
obj -> AnalogInDriverObj . MW_ANALOGIN_HANDLE = MW_AnalogIn_GetHandle (
_sXmQ95XPMFlewD5otpB7G_ ) ; MW_AnalogInSingle_ReadResult ( jm0e5wk21vo .
amysdhmstu . AnalogInDriverObj . MW_ANALOGIN_HANDLE , & ffpwtnqj0x_p ,
_nfvdmbxYkVXzXnpHyWwmg2 ) ; jxbih4cc4o4 . haet5p5sww = ( ( real_T )
ffpwtnqj0x_p - eil1ubehyx . Constant_Value ) * eil1ubehyx . Gain5_Gain ;
jxbih4cc4o4 . dkhxfw5sbj = jxbih4cc4o4 . m34wvvitzi - jxbih4cc4o4 .
haet5p5sww ; if ( rtmIsMajorTimeStep ( gzurmpwdkb ) ) { } jxbih4cc4o4 .
jtybkotaic = eil1ubehyx . Kp * jxbih4cc4o4 . dkhxfw5sbj + h4tr05fetlx .
cg0b5cr2xy ; oqbnqsoi1t = floor ( jxbih4cc4o4 . jtybkotaic ) ; if ( rtIsNaN (
oqbnqsoi1t ) || rtIsInf ( oqbnqsoi1t ) ) { oqbnqsoi1t =
_Z77Ee2RGrs6HvPP38e_Kk_ ; } else { oqbnqsoi1t = fmod ( oqbnqsoi1t ,
_1OvB6M17ZelgpATxMeVF51 ) ; } MW_DACWrite ( _PIqWtbzrbQqv_KS_31HnE2 , (
uint32_T ) ( oqbnqsoi1t < _Z77Ee2RGrs6HvPP38e_Kk_ ? ( int32_T ) ( uint16_T )
- ( int16_T ) ( uint16_T ) - oqbnqsoi1t : ( int32_T ) ( uint16_T ) oqbnqsoi1t
) ) ; if ( rtmIsMajorTimeStep ( gzurmpwdkb ) ) { } jxbih4cc4o4 . pefwuvr1pz =
_p01KwLUrlxQyp_iCq4iLA2 / eil1ubehyx . Ti * jxbih4cc4o4 . dkhxfw5sbj ; if (
rtmIsMajorTimeStep ( gzurmpwdkb ) ) { } if ( rtmIsMajorTimeStep ( gzurmpwdkb
) ) { rtExtModeUploadCheckTrigger ( _gN74BbsU5wqNjkJbC9b672 ) ; {
rtExtModeUpload ( _PIqWtbzrbQqv_KS_31HnE2 , ( real_T ) gzurmpwdkb -> Timing .
t [ _PIqWtbzrbQqv_KS_31HnE2 ] ) ; } if ( rtmIsMajorTimeStep ( gzurmpwdkb ) )
{ rtExtModeUpload ( _QHNSjd8JBrVVYZAcs7Zm32 , ( real_T ) ( ( ( gzurmpwdkb ->
Timing . clockTick1 + gzurmpwdkb -> Timing . clockTickH1 *
_Nn3DUUbvuyRrgaA48_gSO0 ) ) * _ejJFkqxLkFf8z5s0UH9rX0 ) ) ; } } if (
rtmIsMajorTimeStep ( gzurmpwdkb ) ) { { if ( ( rtmGetTFinal ( gzurmpwdkb ) !=
- _QHNSjd8JBrVVYZAcs7Zm32 ) && ! ( ( rtmGetTFinal ( gzurmpwdkb ) - ( ( (
gzurmpwdkb -> Timing . clockTick1 + gzurmpwdkb -> Timing . clockTickH1 *
_Nn3DUUbvuyRrgaA48_gSO0 ) ) * _ejJFkqxLkFf8z5s0UH9rX0 ) ) > ( ( ( gzurmpwdkb
-> Timing . clockTick1 + gzurmpwdkb -> Timing . clockTickH1 *
_Nn3DUUbvuyRrgaA48_gSO0 ) ) * _ejJFkqxLkFf8z5s0UH9rX0 ) * ( DBL_EPSILON ) ) )
{ rtmSetErrorStatus ( gzurmpwdkb ,
"\123\x69\155\x75l\141\x74\151\x6f\156 \x66\151\x6e\151\x73he\144" ) ; } if (
rtmGetStopRequested ( gzurmpwdkb ) ) { rtmSetErrorStatus ( gzurmpwdkb ,
"\123\x69\155\x75l\141\x74\151\x6f\156 \x66\151\x6e\151\x73he\144" ) ; } }
rt_ertODEUpdateContinuousStates ( & gzurmpwdkb -> solverInfo ) ; if ( ! ( ++
gzurmpwdkb -> Timing . clockTick0 ) ) { ++ gzurmpwdkb -> Timing . clockTickH0
; } gzurmpwdkb -> Timing . t [ _PIqWtbzrbQqv_KS_31HnE2 ] =
rtsiGetSolverStopTime ( & gzurmpwdkb -> solverInfo ) ; { gzurmpwdkb -> Timing
. clockTick1 ++ ; if ( ! gzurmpwdkb -> Timing . clockTick1 ) { gzurmpwdkb ->
Timing . clockTickH1 ++ ; } } } } void Pi_test_3_derivatives ( void ) {
fbw4zhdtkp * _rtXdot ; _rtXdot = ( ( fbw4zhdtkp * ) gzurmpwdkb -> derivs ) ;
_rtXdot -> cg0b5cr2xy = jxbih4cc4o4 . pefwuvr1pz ; } void
Pi_test_3_initialize ( void ) { rt_InitInfAndNaN ( sizeof ( real_T ) ) ; (
void ) memset ( ( void * ) gzurmpwdkb , _PIqWtbzrbQqv_KS_31HnE2 , sizeof (
gk4bgt4ywz ) ) ; { rtsiSetSimTimeStepPtr ( & gzurmpwdkb -> solverInfo , &
gzurmpwdkb -> Timing . simTimeStep ) ; rtsiSetTPtr ( & gzurmpwdkb ->
solverInfo , & rtmGetTPtr ( gzurmpwdkb ) ) ; rtsiSetStepSizePtr ( &
gzurmpwdkb -> solverInfo , & gzurmpwdkb -> Timing . stepSize0 ) ;
rtsiSetdXPtr ( & gzurmpwdkb -> solverInfo , & gzurmpwdkb -> derivs ) ;
rtsiSetContStatesPtr ( & gzurmpwdkb -> solverInfo , ( real_T * * ) &
gzurmpwdkb -> contStates ) ; rtsiSetNumContStatesPtr ( & gzurmpwdkb ->
solverInfo , & gzurmpwdkb -> Sizes . numContStates ) ;
rtsiSetNumPeriodicContStatesPtr ( & gzurmpwdkb -> solverInfo , & gzurmpwdkb
-> Sizes . numPeriodicContStates ) ; rtsiSetPeriodicContStateIndicesPtr ( &
gzurmpwdkb -> solverInfo , & gzurmpwdkb -> periodicContStateIndices ) ;
rtsiSetPeriodicContStateRangesPtr ( & gzurmpwdkb -> solverInfo , & gzurmpwdkb
-> periodicContStateRanges ) ; rtsiSetErrorStatusPtr ( & gzurmpwdkb ->
solverInfo , ( & rtmGetErrorStatus ( gzurmpwdkb ) ) ) ; rtsiSetRTModelPtr ( &
gzurmpwdkb -> solverInfo , gzurmpwdkb ) ; } rtsiSetSimTimeStep ( & gzurmpwdkb
-> solverInfo , MAJOR_TIME_STEP ) ; gzurmpwdkb -> intgData . y = gzurmpwdkb
-> odeY ; gzurmpwdkb -> intgData . f [ _PIqWtbzrbQqv_KS_31HnE2 ] = gzurmpwdkb
-> odeF [ _PIqWtbzrbQqv_KS_31HnE2 ] ; gzurmpwdkb -> intgData . f [
_QHNSjd8JBrVVYZAcs7Zm32 ] = gzurmpwdkb -> odeF [ _QHNSjd8JBrVVYZAcs7Zm32 ] ;
gzurmpwdkb -> intgData . f [ _gN74BbsU5wqNjkJbC9b672 ] = gzurmpwdkb -> odeF [
_gN74BbsU5wqNjkJbC9b672 ] ; gzurmpwdkb -> intgData . f [
_nfvdmbxYkVXzXnpHyWwmg2 ] = gzurmpwdkb -> odeF [ _nfvdmbxYkVXzXnpHyWwmg2 ] ;
gzurmpwdkb -> contStates = ( ( h4tr05fetl * ) & h4tr05fetlx ) ;
rtsiSetSolverData ( & gzurmpwdkb -> solverInfo , ( void * ) & gzurmpwdkb ->
intgData ) ; rtsiSetSolverName ( & gzurmpwdkb -> solverInfo , "ode4" ) ;
rtmSetTPtr ( gzurmpwdkb , & gzurmpwdkb -> Timing . tArray [
_PIqWtbzrbQqv_KS_31HnE2 ] ) ; rtmSetTFinal ( gzurmpwdkb , -
_QHNSjd8JBrVVYZAcs7Zm32 ) ; gzurmpwdkb -> Timing . stepSize0 =
_ejJFkqxLkFf8z5s0UH9rX0 ; gzurmpwdkb -> Sizes . checksums [
_PIqWtbzrbQqv_KS_31HnE2 ] = ( _tN7ti0A4z4QmiuxkRp72t_ ) ; gzurmpwdkb -> Sizes
. checksums [ _QHNSjd8JBrVVYZAcs7Zm32 ] = ( _HYT3T0kcp6MAkDrpLvXRK0 ) ;
gzurmpwdkb -> Sizes . checksums [ _gN74BbsU5wqNjkJbC9b672 ] = (
_FtM8ZVeTA3dF9cgCBDKuP2 ) ; gzurmpwdkb -> Sizes . checksums [
_nfvdmbxYkVXzXnpHyWwmg2 ] = ( _TW80q6AzN6QP_I7saKAEO_ ) ; { static const
sysRanDType rtAlwaysEnabled = SUBSYS_RAN_BC_ENABLE ; static RTWExtModeInfo
rt_ExtModeInfo ; static const sysRanDType * systemRan [
_nfvdmbxYkVXzXnpHyWwmg2 ] ; gzurmpwdkb -> extModeInfo = ( & rt_ExtModeInfo )
; rteiSetSubSystemActiveVectorAddresses ( & rt_ExtModeInfo , systemRan ) ;
systemRan [ _PIqWtbzrbQqv_KS_31HnE2 ] = & rtAlwaysEnabled ; systemRan [
_QHNSjd8JBrVVYZAcs7Zm32 ] = & rtAlwaysEnabled ; systemRan [
_gN74BbsU5wqNjkJbC9b672 ] = & rtAlwaysEnabled ; rteiSetModelMappingInfoPtr (
gzurmpwdkb -> extModeInfo , & gzurmpwdkb -> SpecialInfo . mappingInfo ) ;
rteiSetChecksumsPtr ( gzurmpwdkb -> extModeInfo , gzurmpwdkb -> Sizes .
checksums ) ; rteiSetTPtr ( gzurmpwdkb -> extModeInfo , rtmGetTPtr (
gzurmpwdkb ) ) ; } ( void ) memset ( ( ( void * ) & jxbih4cc4o4 ) ,
_PIqWtbzrbQqv_KS_31HnE2 , sizeof ( jxbih4cc4o ) ) ; { ( void ) memset ( (
void * ) & h4tr05fetlx , _PIqWtbzrbQqv_KS_31HnE2 , sizeof ( h4tr05fetl ) ) ;
} ( void ) memset ( ( void * ) & jm0e5wk21vo , _PIqWtbzrbQqv_KS_31HnE2 ,
sizeof ( jm0e5wk21v ) ) ; { p00yb3zgla * obj ; jm0e5wk21vo . jejetohfol =
_PIqWtbzrbQqv_KS_31HnE2 ; jm0e5wk21vo . amysdhmstu . matlabCodegenIsDeleted =
true ; jm0e5wk21vo . amysdhmstu . isInitialized = _PIqWtbzrbQqv_KS_31HnE2 ;
jm0e5wk21vo . amysdhmstu . SampleTime = - _p01KwLUrlxQyp_iCq4iLA2 ;
jm0e5wk21vo . amysdhmstu . matlabCodegenIsDeleted = false ; jm0e5wk21vo .
jo4srod3a3 = true ; jm0e5wk21vo . amysdhmstu . SampleTime = eil1ubehyx .
AnalogInput1_SampleTime ; obj = & jm0e5wk21vo . amysdhmstu ; jm0e5wk21vo .
amysdhmstu . isSetupComplete = false ; jm0e5wk21vo . amysdhmstu .
isInitialized = _QHNSjd8JBrVVYZAcs7Zm32 ; obj -> AnalogInDriverObj .
MW_ANALOGIN_HANDLE = MW_AnalogInSingle_Open ( _sXmQ95XPMFlewD5otpB7G_ ) ;
jm0e5wk21vo . amysdhmstu . isSetupComplete = true ; jm0e5wk21vo . mciyhzklww
= true ; jm0e5wk21vo . hxot4gjmvk . isInitialized = _QHNSjd8JBrVVYZAcs7Zm32 ;
} h4tr05fetlx . cg0b5cr2xy = eil1ubehyx . DiscretePIDController1_InitialC ; }
void Pi_test_3_terminate ( void ) { p00yb3zgla * obj ; obj = & jm0e5wk21vo .
amysdhmstu ; if ( ! jm0e5wk21vo . amysdhmstu . matlabCodegenIsDeleted ) {
jm0e5wk21vo . amysdhmstu . matlabCodegenIsDeleted = true ; if ( ( jm0e5wk21vo
. amysdhmstu . isInitialized == _QHNSjd8JBrVVYZAcs7Zm32 ) && jm0e5wk21vo .
amysdhmstu . isSetupComplete ) { obj -> AnalogInDriverObj .
MW_ANALOGIN_HANDLE = MW_AnalogIn_GetHandle ( _sXmQ95XPMFlewD5otpB7G_ ) ;
MW_AnalogIn_Close ( jm0e5wk21vo . amysdhmstu . AnalogInDriverObj .
MW_ANALOGIN_HANDLE ) ; } } }
