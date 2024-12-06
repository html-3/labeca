/* Include files */

#include "Pi_test_3_cgxe.h"
#include "m_GBiICrRCBVBLRAQibqTYqF.h"

unsigned int cgxe_Pi_test_3_method_dispatcher(SimStruct* S, int_T method, void
  * data)
{
  if (ssGetChecksum0(S) == 3068681063 &&
      ssGetChecksum1(S) == 3865645102 &&
      ssGetChecksum2(S) == 288931199 &&
      ssGetChecksum3(S) == 4044380094) {
    method_dispatcher_GBiICrRCBVBLRAQibqTYqF(S, method, data);
    return 1;
  }

  return 0;
}
