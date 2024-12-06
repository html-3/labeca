#include "__cf_Pi_test_3.h"
#include "rtGetNaN.h"
#define NumBitsPerChar                 _p1ZMcYujXmC1ks3HAHIPa0
real_T rtGetNaN ( void ) { size_t bitsPerReal = sizeof ( real_T ) * (
NumBitsPerChar ) ; real_T nan = _Z77Ee2RGrs6HvPP38e_Kk_ ; if ( bitsPerReal ==
__khn2qNy4zfE3Rcj6lRsn0 ) { nan = rtGetNaNF ( ) ; } else { uint16_T one =
_TlYaTpHyOy3h9kx50A0_s2 ; enum { LittleEndian , BigEndian } machByteOrder = (
* ( ( uint8_T * ) & one ) == _TlYaTpHyOy3h9kx50A0_s2 ) ? LittleEndian :
BigEndian ; switch ( machByteOrder ) { case LittleEndian : { union {
LittleEndianIEEEDouble bitVal ; real_T fltVal ; } tmpVal ; tmpVal . bitVal .
words . wordH = _u0Jv1KzpVzaiATs9m_XkA0 ; tmpVal . bitVal . words . wordL =
_4uNfhCjtiZICTr_I_2dNn_ ; nan = tmpVal . fltVal ; break ; } case BigEndian :
{ union { BigEndianIEEEDouble bitVal ; real_T fltVal ; } tmpVal ; tmpVal .
bitVal . words . wordH = _1upaaZGyJRIPK_I_ChRY10 ; tmpVal . bitVal . words .
wordL = _s_WvixMJrKe3kEjc_igDY2 ; nan = tmpVal . fltVal ; break ; } } }
return nan ; } real32_T rtGetNaNF ( void ) { IEEESingle nanF = { {
_M3BP4AS2LfT3eQSyoMbkh0 } } ; uint16_T one = _TlYaTpHyOy3h9kx50A0_s2 ; enum {
LittleEndian , BigEndian } machByteOrder = ( * ( ( uint8_T * ) & one ) ==
_TlYaTpHyOy3h9kx50A0_s2 ) ? LittleEndian : BigEndian ; switch ( machByteOrder
) { case LittleEndian : { nanF . wordL . wordLuint = _ko6ArOnxQVl22oHhrMlSz2
; break ; } case BigEndian : { nanF . wordL . wordLuint =
_1upaaZGyJRIPK_I_ChRY10 ; break ; } } return nanF . wordL . wordLreal ; }
