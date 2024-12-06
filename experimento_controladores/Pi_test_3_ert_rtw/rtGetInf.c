#include "__cf_Pi_test_3.h"
#include "rtGetInf.h"
#define NumBitsPerChar                 _p1ZMcYujXmC1ks3HAHIPa0
real_T rtGetInf ( void ) { size_t bitsPerReal = sizeof ( real_T ) * (
NumBitsPerChar ) ; real_T inf = _Z77Ee2RGrs6HvPP38e_Kk_ ; if ( bitsPerReal ==
__khn2qNy4zfE3Rcj6lRsn0 ) { inf = rtGetInfF ( ) ; } else { uint16_T one =
_TlYaTpHyOy3h9kx50A0_s2 ; enum { LittleEndian , BigEndian } machByteOrder = (
* ( ( uint8_T * ) & one ) == _TlYaTpHyOy3h9kx50A0_s2 ) ? LittleEndian :
BigEndian ; switch ( machByteOrder ) { case LittleEndian : { union {
LittleEndianIEEEDouble bitVal ; real_T fltVal ; } tmpVal ; tmpVal . bitVal .
words . wordH = _eRPEafvKyL4WAirvhKXYK_ ; tmpVal . bitVal . words . wordL =
_4uNfhCjtiZICTr_I_2dNn_ ; inf = tmpVal . fltVal ; break ; } case BigEndian :
{ union { BigEndianIEEEDouble bitVal ; real_T fltVal ; } tmpVal ; tmpVal .
bitVal . words . wordH = _eRPEafvKyL4WAirvhKXYK_ ; tmpVal . bitVal . words .
wordL = _4uNfhCjtiZICTr_I_2dNn_ ; inf = tmpVal . fltVal ; break ; } } }
return inf ; } real32_T rtGetInfF ( void ) { IEEESingle infF ; infF . wordL .
wordLuint = _hIrqezDQ2P81pyClduDuH2 ; return infF . wordL . wordLreal ; }
real_T rtGetMinusInf ( void ) { size_t bitsPerReal = sizeof ( real_T ) * (
NumBitsPerChar ) ; real_T minf = _Z77Ee2RGrs6HvPP38e_Kk_ ; if ( bitsPerReal
== __khn2qNy4zfE3Rcj6lRsn0 ) { minf = rtGetMinusInfF ( ) ; } else { uint16_T
one = _TlYaTpHyOy3h9kx50A0_s2 ; enum { LittleEndian , BigEndian }
machByteOrder = ( * ( ( uint8_T * ) & one ) == _TlYaTpHyOy3h9kx50A0_s2 ) ?
LittleEndian : BigEndian ; switch ( machByteOrder ) { case LittleEndian : {
union { LittleEndianIEEEDouble bitVal ; real_T fltVal ; } tmpVal ; tmpVal .
bitVal . words . wordH = _PxkvxoLP11XHz_7ymjcx0_ ; tmpVal . bitVal . words .
wordL = _4uNfhCjtiZICTr_I_2dNn_ ; minf = tmpVal . fltVal ; break ; } case
BigEndian : { union { BigEndianIEEEDouble bitVal ; real_T fltVal ; } tmpVal ;
tmpVal . bitVal . words . wordH = _PxkvxoLP11XHz_7ymjcx0_ ; tmpVal . bitVal .
words . wordL = _4uNfhCjtiZICTr_I_2dNn_ ; minf = tmpVal . fltVal ; break ; }
} } return minf ; } real32_T rtGetMinusInfF ( void ) { IEEESingle minfF ;
minfF . wordL . wordLuint = _eTyz2v5u0kC8gQ_w7T4vi1 ; return minfF . wordL .
wordLreal ; }
