/*
 * File: Projeto_Controlador_PI_21_a.c
 *
 * Code generated for Simulink model 'Projeto_Controlador_PI_21_a'.
 *
 * Model version                  : 1.0
 * Simulink Coder version         : 24.1 (R2024a) 19-Nov-2023
 * C/C++ source code generated on : Tue Dec  3 14:29:03 2024
 *
 * Target selection: ert.tlc
 * Embedded hardware selection: ARM Compatible->ARM Cortex
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "Projeto_Controlador_PI_21_a.h"
#include <math.h>
#include "rt_nonfinite.h"
#include "rtwtypes.h"
#include "Projeto_Controlador_PI_21_a_private.h"

/* Block signals (default storage) */
B_Projeto_Controlador_PI_21_a_T Projeto_Controlador_PI_21_a_B;

/* Block states (default storage) */
DW_Projeto_Controlador_PI_21__T Projeto_Controlador_PI_21_a_DW;

/* Real-time model */
static RT_MODEL_Projeto_Controlador__T Projeto_Controlador_PI_21_a_M_;
RT_MODEL_Projeto_Controlador__T *const Projeto_Controlador_PI_21_a_M =
  &Projeto_Controlador_PI_21_a_M_;

/* Model step function */
void Projeto_Controlador_PI_21_a_step(void)
{
  real_T rtb_PulseGenerator;

  /* DiscretePulseGenerator: '<Root>/Pulse Generator' */
  rtb_PulseGenerator = (Projeto_Controlador_PI_21_a_DW.clockTickCounter <
                        Projeto_Controlador_PI_21_a_P.PulseGenerator_Duty) &&
    (Projeto_Controlador_PI_21_a_DW.clockTickCounter >= 0) ?
    Projeto_Controlador_PI_21_a_P.PulseGenerator_Amp : 0.0;
  if (Projeto_Controlador_PI_21_a_DW.clockTickCounter >=
      Projeto_Controlador_PI_21_a_P.PulseGenerator_Period - 1.0) {
    Projeto_Controlador_PI_21_a_DW.clockTickCounter = 0;
  } else {
    Projeto_Controlador_PI_21_a_DW.clockTickCounter++;
  }

  /* End of DiscretePulseGenerator: '<Root>/Pulse Generator' */

  /* DataTypeConversion: '<Root>/Data Type Conversion1' */
  rtb_PulseGenerator = floor(rtb_PulseGenerator);
  if (rtIsNaN(rtb_PulseGenerator) || rtIsInf(rtb_PulseGenerator)) {
    rtb_PulseGenerator = 0.0;
  } else {
    rtb_PulseGenerator = fmod(rtb_PulseGenerator, 65536.0);
  }

  /* DataTypeConversion: '<Root>/Data Type Conversion1' */
  Projeto_Controlador_PI_21_a_B.DataTypeConversion1 = (uint16_T)
    (rtb_PulseGenerator < 0.0 ? (int32_T)(uint16_T)-(int16_T)(uint16_T)
     -rtb_PulseGenerator : (int32_T)(uint16_T)rtb_PulseGenerator);

  /* MATLABSystem: '<Root>/Analog Output1' */
  if (Projeto_Controlador_PI_21_a_DW.obj.Protocol !=
      Projeto_Controlador_PI_21_a_P.AnalogOutput1_Protocol) {
    Projeto_Controlador_PI_21_a_DW.obj.Protocol =
      Projeto_Controlador_PI_21_a_P.AnalogOutput1_Protocol;
  }

  MW_DACWrite(0, (uint32_T)Projeto_Controlador_PI_21_a_B.DataTypeConversion1);

  /* End of MATLABSystem: '<Root>/Analog Output1' */

  /* Update absolute time for base rate */
  /* The "clockTick0" counts the number of times the code of this task has
   * been executed. The absolute time is the multiplication of "clockTick0"
   * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
   * overflow during the application lifespan selected.
   */
  Projeto_Controlador_PI_21_a_M->Timing.taskTime0 =
    ((time_T)(++Projeto_Controlador_PI_21_a_M->Timing.clockTick0)) *
    Projeto_Controlador_PI_21_a_M->Timing.stepSize0;
}

/* Model initialize function */
void Projeto_Controlador_PI_21_a_initialize(void)
{
  /* Registration code */

  /* initialize non-finites */
  rt_InitInfAndNaN(sizeof(real_T));
  rtmSetTFinal(Projeto_Controlador_PI_21_a_M, -1);
  Projeto_Controlador_PI_21_a_M->Timing.stepSize0 = 0.1;

  /* External mode info */
  Projeto_Controlador_PI_21_a_M->Sizes.checksums[0] = (2037729966U);
  Projeto_Controlador_PI_21_a_M->Sizes.checksums[1] = (3719003392U);
  Projeto_Controlador_PI_21_a_M->Sizes.checksums[2] = (415235756U);
  Projeto_Controlador_PI_21_a_M->Sizes.checksums[3] = (3336838118U);

  {
    static const sysRanDType rtAlwaysEnabled = SUBSYS_RAN_BC_ENABLE;
    static RTWExtModeInfo rt_ExtModeInfo;
    static const sysRanDType *systemRan[2];
    Projeto_Controlador_PI_21_a_M->extModeInfo = (&rt_ExtModeInfo);
    rteiSetSubSystemActiveVectorAddresses(&rt_ExtModeInfo, systemRan);
    systemRan[0] = &rtAlwaysEnabled;
    systemRan[1] = &rtAlwaysEnabled;
    rteiSetModelMappingInfoPtr(Projeto_Controlador_PI_21_a_M->extModeInfo,
      &Projeto_Controlador_PI_21_a_M->SpecialInfo.mappingInfo);
    rteiSetChecksumsPtr(Projeto_Controlador_PI_21_a_M->extModeInfo,
                        Projeto_Controlador_PI_21_a_M->Sizes.checksums);
    rteiSetTPtr(Projeto_Controlador_PI_21_a_M->extModeInfo, rtmGetTPtr
                (Projeto_Controlador_PI_21_a_M));
  }

  /* Start for MATLABSystem: '<Root>/Analog Output1' */
  Projeto_Controlador_PI_21_a_DW.obj.Protocol =
    Projeto_Controlador_PI_21_a_P.AnalogOutput1_Protocol;
  Projeto_Controlador_PI_21_a_DW.obj.isInitialized = 1;
  MW_DACInit();
}

/* Model terminate function */
void Projeto_Controlador_PI_21_a_terminate(void)
{
  /* (no terminate code required) */
}

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
