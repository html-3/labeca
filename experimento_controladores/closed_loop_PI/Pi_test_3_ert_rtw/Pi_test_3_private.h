#include "__cf_Pi_test_3.h"
#ifndef RTW_HEADER_Pi_test_3_private_h_
#define RTW_HEADER_Pi_test_3_private_h_
#include "rtwtypes.h"
#include "multiword_types.h"
#ifndef rtmIsMajorTimeStep
#define rtmIsMajorTimeStep(rtm) (((rtm)->Timing.simTimeStep) == MAJOR_TIME_STEP)
#endif
#ifndef rtmIsMinorTimeStep
#define rtmIsMinorTimeStep(rtm) (((rtm)->Timing.simTimeStep) == MINOR_TIME_STEP)
#endif
#ifndef rtmSetTFinal
#define rtmSetTFinal(rtm, val) ((rtm)->Timing.tFinal = (val))
#endif
#ifndef rtmSetTPtr
#define rtmSetTPtr(rtm, val) ((rtm)->Timing.t = (val))
#endif
extern void Pi_test_3_derivatives ( void ) ;
#endif
