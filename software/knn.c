#include "system.h"
#include "periphs.h"
#include <iob-uart.h>
#include "iob_timer.h"
#include "iob_knn.h"
#include "random.h" //random generator for bare metal
#include "stdlib.h"
#include "stdint.h"

//uncomment to use rand from C lib 
//#define cmwc_rand rand

#ifdef DEBUG //type make DEBUG=1 to print debug info
#define S 12  //random seed
#define N 10  //data set size
#define K 4   //number of neighbours (K)
#define C 4   //number data classes
#define M 4   //number samples to be classified
#else
#define S 12   
#define N 100000
#define K 10  
#define C 4  
#define M 100 
#endif

#define INFINITE ~0

//
//Data structures
//


int main() {

 	uart_init(UART_BASE,FREQ/BAUD);  
	srand(S);

	knn_init(KNN_BASE);
	knn_start();
	knn_reset();

	signed long int x, y, dist = 0;

	//32 bit coordinates
	//

	x = (10 << 16) | (15 & 0xFFFF);

	y = (15 << 16) | (10 & 0xFFFF);

//	uart_printf("(main-sw) x: %d y: %d\n", x, y);


	knn_set_x(x);
	knn_set_y(y);
		

	uart_printf("\n dist_hardware = %ld \n", knn_get_dist());

	knn_stop();
	return 0;
  
}
