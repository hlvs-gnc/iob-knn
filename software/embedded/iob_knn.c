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

  //capture base address for good
  base = base_address;
  knn_reset();
  knn_start();
}

void knn_set_x(int x){
	IO_SET(base, KNN_X, x);
}

void knn_set_y(int y){
	IO_SET(base, KNN_Y, y);
}

signed long int knn_get_dist(){

	return (signed long int) IO_GET(base, KNN_DIST);
}
