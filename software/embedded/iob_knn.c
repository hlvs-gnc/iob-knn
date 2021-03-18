#include "interconnect.h"
#include "iob_knn.h"
#include "KNNsw_reg.h"

//base address
static int base;

void knn_reset() {
  IO_SET(base, KNN_RESET, 1);
  IO_SET(base, KNN_RESET, 0);
}

void knn_start() {
  IO_SET(base, KNN_ENABLE, 1);
}

void knn_stop() {
  IO_SET(base, KNN_ENABLE, 0);
}

void knn_init( int base_address){

  base = base_address;
  knn_reset();
}


unsigned int knn_get_dist(int coordinates_x, int coordinates_y){

	IO_SET(base, KNN_X, coordinates_x);
	IO_SET(base, KNN_Y, coordinates_y);
	return IO_GET(base, KNN_DIST);
}
