#pragma once

//#ifdef DEBUG //type make DEBUG=1 to print debug info
#define S 12  //random seed
#define N 10  //data set size
#define K 4   //number of neighbours (K)
#define C 4   //number data classes
#define M 4   //number samples to be classified
/*#else
#define S 12   
#define N 100000
#define K 10  
#define C 4  
#define M 100
#endif*/

#define INFINITE ~0

//
//Data structures
//

//labeled dataset
typedef struct datum {
  short x;
  short y;
  unsigned char label;
} datum;

//neighbor info
typedef struct neighbor {
  unsigned int idx; //index in dataset array
  unsigned int dist; //distance to test point
} neighbor;


//IO and control functions
void knn_reset();
void knn_start();	
void knn_stop();
void knn_init(int base_address);
void knn_set_testp(int coordinates_x);
void knn_set_datap(int coordinates_y);
void knn_get_list(neighbor *knn_vector);
