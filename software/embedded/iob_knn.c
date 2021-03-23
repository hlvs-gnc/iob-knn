#include "interconnect.h"
#include "iob_knn.h"
#include "KNNsw_reg.h"
#include "printf.h"

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

void knn_set_testp(int coordinates_x){
	
	IO_SET(base, KNN_X, coordinates_x);
	IO_SET(base, KNN_READY, 0);
}

void knn_set_datap(int coordinates_y){

	IO_SET(base, KNN_Y, coordinates_y);

}

void knn_get_list(neighbor *knn_vector){
	
	IO_SET(base, KNN_READY, 1);	
	for(int i = 0; i < K; i++){
//		IO_SET(base, KNN_ID, i);
		knn_vector[i].idx=IO_GET(base, KNN_INFO);

	}
	
	knn_reset();
}
