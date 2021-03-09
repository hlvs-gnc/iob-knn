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
}

void knn_set_test(int coordinates){
	IO_SET(base, KNN_X, coordinates);
}

void knn_set_train(int coordinates, char label){
	IO_SET(base, KNN_LABEL, label);
	IO_SET(base, KNN_Y, coordinates);
}

