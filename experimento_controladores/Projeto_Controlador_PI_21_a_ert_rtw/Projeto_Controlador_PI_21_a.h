/*
 * File: Projeto_Controlador_PI_21_a.h
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

#ifndef Projeto_Controlador_PI_21_a_h_
#define Projeto_Controlador_PI_21_a_h_
#ifndef Projeto_Controlador_PI_21_a_COMMON_INCLUDES_
#define Projeto_Controlador_PI_21_a_COMMON_INCLUDES_
#include "rtwtypes.h"
#include "rtw_extmode.h"
#include "sysran_types.h"
#include "rtw_continuous.h"
#include "rtw_solver.h"
#include "MW_analogWriteDAC.h"
#endif                        /* Projeto_Controlador_PI_21_a_COMMON_INCLUDES_ */

#include "Projeto_Controlador_PI_21_a_types.h"
#include "rt_nonfinite.h"
#include "MW_target_hardware_resources.h"

/* Macros for accessing real-time model data structure */
#ifndef rtmGetFinalTime
#define rtmGetFinalTime(rtm)           ((rtm)->Timing.tFinal)
#endif

#ifndef rtmGetRTWExtModeInfo
#define rtmGetRTWExtModeInfo(rtm)      ((rtm)->extModeInfo)
#endif

#ifndef rtmGetErrorStatus
#define rtmGetErrorStatus(rtm)         ((rtm)->errorStatus)
#endif

#ifndef rtmSetErrorStatus
#define rtmSetErrorStatus(rtm, val)    ((rtm)->errorStatus = (val))
#endif

#ifndef rtmGetStopRequested
#define rtmGetStopRequested(rtm)       ((rtm)->Timing.stopRequestedFlag)
#endif

#ifndef rtmSetStopRequested
#define rtmSetStopRequested(rtm, val)  ((rtm)->Timing.stopRequestedFlag = (val))
#endif

#ifndef rtmGetStopRequestedPtr
#define rtmGetStopRequestedPtr(rtm)    (&((rtm)->Timing.stopRequestedFlag))
#endif

#ifndef rtmGetT
#define rtmGetT(rtm)                   ((rtm)->Timing.taskTime0)
#endif

#ifndef rtmGetTFinal
#define rtmGetTFinal(rtm)              ((rtm)->Timing.tFinal)
#endif

#ifndef rtmGetTPtr
#define rtmGetTPtr(rtm)                (&(rtm)->Timing.taskTime0)
#endif

/* Block signals (default storage) */
typedef struct {
  uint16_T DataTypeConversion1;        /* '<Root>/Data Type Conversion1' */
} B_Projeto_Controlador_PI_21_a_T;

/* Block states (default storage) for system '<Root>' */
typedef struct {
  codertarget_arduinobase_inter_T obj; /* '<Root>/Analog Output1' */
  struct {
    void *LoggedData;
  } Scope1_PWORK;                      /* '<Root>/Scope1' */

  int32_T clockTickCounter;            /* '<Root>/Pulse Generator' */
} DW_Projeto_Controlador_PI_21__T;

/* Parameters (default storage) */
struct P_Projeto_Controlador_PI_21_a_T_ {
  real_T AnalogOutput1_Protocol;       /* Expression: 0
                                        * Referenced by: '<Root>/Analog Output1'
                                        */
  real_T PulseGenerator_Amp;           /* Expression: 4000
                                        * Referenced by: '<Root>/Pulse Generator'
                                        */
  real_T PulseGenerator_Period;     /* Computed Parameter: PulseGenerator_Period
                                     * Referenced by: '<Root>/Pulse Generator'
                                     */
  real_T PulseGenerator_Duty;         /* Computed Parameter: PulseGenerator_Duty
                                       * Referenced by: '<Root>/Pulse Generator'
                                       */
  real_T PulseGenerator_PhaseDelay;    /* Expression: 0
                                        * Referenced by: '<Root>/Pulse Generator'
                                        */
};

/* Real-time Model Data Structure */
struct tag_RTM_Projeto_Controlador_P_T {
  const char_T *errorStatus;
  RTWExtModeInfo *extModeInfo;

  /*
   * Sizes:
   * The following substructure contains sizes information
   * for many of the model attributes such as inputs, outputs,
   * dwork, sample times, etc.
   */
  struct {
    uint32_T checksums[4];
  } Sizes;

  /*
   * SpecialInfo:
   * The following substructure contains special information
   * related to other components that are dependent on RTW.
   */
  struct {
    const void *mappingInfo;
  } SpecialInfo;

  /*
   * Timing:
   * The following substructure contains information regarding
   * the timing information for the model.
   */
  struct {
    time_T taskTime0;
    uint32_T clockTick0;
    time_T stepSize0;
    time_T tFinal;
    boolean_T stopRequestedFlag;
  } Timing;
};

/* Block parameters (default storage) */
extern P_Projeto_Controlador_PI_21_a_T Projeto_Controlador_PI_21_a_P;

/* Block signals (default storage) */
extern B_Projeto_Controlador_PI_21_a_T Projeto_Controlador_PI_21_a_B;

/* Block states (default storage) */
extern DW_Projeto_Controlador_PI_21__T Projeto_Controlador_PI_21_a_DW;

/* Model entry point functions */
extern void Projeto_Controlador_PI_21_a_initialize(void);
extern void Projeto_Controlador_PI_21_a_step(void);
extern void Projeto_Controlador_PI_21_a_terminate(void);

/* Real-time Model object */
extern RT_MODEL_Projeto_Controlador__T *const Projeto_Controlador_PI_21_a_M;
extern volatile boolean_T stopRequested;
extern volatile boolean_T runModel;

/*-
 * The generated code includes comments that allow you to trace directly
 * back to the appropriate location in the model.  The basic format
 * is <system>/block_name, where system is the system number (uniquely
 * assigned by Simulink) and block_name is the name of the block.
 *
 * Use the MATLAB hilite_system command to trace the generated code back
 * to the model.  For example,
 *
 * hilite_system('<S3>')    - opens system 3
 * hilite_system('<S3>/Kp') - opens and selects block Kp which resides in S3
 *
 * Here is the system hierarchy for this model
 *
 * '<Root>' : 'Projeto_Controlador_PI_21_a'
 */
#endif                                 /* Projeto_Controlador_PI_21_a_h_ */

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
