#include "__cf_Pi_test_3.h"
#include "rt_nonfinite.h"
#include "rtGetNaN.h"
#include "rtGetInf.h"
#define NumBitsPerChar                 _p1ZMcYujXmC1ks3HAHIPa0
real_T rtInf ; real_T rtMinusInf ; real_T rtNaN ; real32_T rtInfF ; real32_T
rtMinusInfF ; real32_T rtNaNF ; void rt_InitInfAndNaN ( size_t realSize ) { (
void ) ( realSize ) ; rtNaN = rtGetNaN ( ) ; rtNaNF = rtGetNaNF ( ) ; rtInf =
rtGetInf ( ) ; rtInfF = rtGetInfF ( ) ; rtMinusInf = rtGetMinusInf ( ) ;
rtMinusInfF = rtGetMinusInfF ( ) ; } boolean_T rtIsInf ( real_T value ) {
return ( boolean_T ) ( ( value == rtInf || value == rtMinusInf ) ?
_TlYaTpHyOy3h9kx50A0_s2 : _TPQ_vWWUSL7ze3htINC_W2 ) ; } boolean_T rtIsInfF (
real32_T value ) { return ( boolean_T ) ( ( ( value ) == rtInfF || ( value )
== rtMinusInfF ) ? _TlYaTpHyOy3h9kx50A0_s2 : _TPQ_vWWUSL7ze3htINC_W2 ) ; }
boolean_T rtIsNaN ( real_T value ) { boolean_T result = ( boolean_T )
_PIqWtbzrbQqv_KS_31HnE2 ; size_t bitsPerReal = sizeof ( real_T ) * (
NumBitsPerChar ) ; if ( bitsPerReal == __khn2qNy4zfE3Rcj6lRsn0 ) { result =
rtIsNaNF ( ( real32_T ) value ) ; } else { union { LittleEndianIEEEDouble
bitVal ; real_T fltVal ; } tmpVal ; tmpVal . fltVal = value ; result = (
boolean_T ) ( ( tmpVal . bitVal . words . wordH & _C69we9z7iNW9YfIyLPLPC_ )
== _C69we9z7iNW9YfIyLPLPC_ && ( ( tmpVal . bitVal . words . wordH &
_CWvptZDNi2y10nMHh800M_ ) != _PIqWtbzrbQqv_KS_31HnE2 || ( tmpVal . bitVal .
words . wordL != _PIqWtbzrbQqv_KS_31HnE2 ) ) ) ; } return result ; }
boolean_T rtIsNaNF ( real32_T value ) { IEEESingle tmp ; tmp . wordL .
wordLreal = value ; return ( boolean_T ) ( ( tmp . wordL . wordLuint &
_Lx0QXbAfgItqmPZnmu_Pj0 ) == _Lx0QXbAfgItqmPZnmu_Pj0 && ( tmp . wordL .
wordLuint & _i__a2Y_VTA2QJVHiStPPV_ ) != _PIqWtbzrbQqv_KS_31HnE2 ) ; }
