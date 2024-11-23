/* Include files */

#include "arduino_write_cgxe.h"
#include "m_Q3NQfhmrWJEmXkmVukg3ZC.h"

unsigned int cgxe_arduino_write_method_dispatcher(SimStruct* S, int_T method,
  void* data)
{
  if (ssGetChecksum0(S) == 3993668478 &&
      ssGetChecksum1(S) == 2604283472 &&
      ssGetChecksum2(S) == 1502000795 &&
      ssGetChecksum3(S) == 1604512853) {
    method_dispatcher_Q3NQfhmrWJEmXkmVukg3ZC(S, method, data);
    return 1;
  }

  return 0;
}
