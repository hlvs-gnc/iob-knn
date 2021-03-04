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

	signed long int x1, y1, x2, y2;
	signed long int dist=0;
	signed long int a, b;

	//32 bit coordinates

	//for(int i = 0; i < 5; i++){
		x1 = rand() % 15;
		y1 = rand() % 15;
		x2 = rand() % 15;
		y2 = rand() % 15;
		
		uart_printf("A coordinates - x: %d, y: %d\n", x1, y1);
		uart_printf("B coordinates - x: %d, y: %d\n", x2, y2);

		a = (x1 << 16) | (y1 & 0xFFFF);

		b = (x2 << 16) | (y2 & 0xFFFF);
	
		//uart_printf("(main-sw) a: %d b: %d\n", x, y);

		knn_set_x(a);
		knn_set_y(b);
		
		dist = knn_get_dist();

		uart_printf("\n dist_hardware = %d \n\n", dist);
	//}

	knn_stop();
	return 0;
  
}
