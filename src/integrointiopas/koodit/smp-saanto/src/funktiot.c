#include <math.h>
#include "inc/funktiot.h"

double yksi_per_x(double x, int *virhe) {
  if (round(x, 3) == 0) {
    *virhe = 1;
    return 0;
  } else {
    *virhe = 0;
    return 1 / x;
  }
}
