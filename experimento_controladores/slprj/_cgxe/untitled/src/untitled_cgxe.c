/* Include files */

#include "untitled_cgxe.h"
#include "m_WBFuoMLHwH7vmtP2e3deNE.h"
#include "m_DGhxag2R9sJ3wuBsm9iYt.h"

unsigned int cgxe_untitled_method_dispatcher(SimStruct* S, int_T method, void
  * data)
{
  if (ssGetChecksum0(S) == 165793420 &&
      ssGetChecksum1(S) == 356088486 &&
      ssGetChecksum2(S) == 1807742613 &&
      ssGetChecksum3(S) == 1624885115) {
    method_dispatcher_WBFuoMLHwH7vmtP2e3deNE(S, method, data);
    return 1;
  }

  if (ssGetChecksum0(S) == 2631079288 &&
      ssGetChecksum1(S) == 289515331 &&
      ssGetChecksum2(S) == 3390273714 &&
      ssGetChecksum3(S) == 2363253151) {
    method_dispatcher_DGhxag2R9sJ3wuBsm9iYt(S, method, data);
    return 1;
  }

  return 0;
}
