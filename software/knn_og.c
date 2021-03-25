#include "system.h"
#include "periphs.h"
#include <iob-uart.h>
#include "iob_timer.h"
#include "iob_knn.h"
#include "random.h" //random generator for bare metal
#include "printf.h"

//uncomment to use rand from C lib 
//#define cmwc_rand rand

datum data[N], x[M];

neighbor knn_list[K]; 

//
//Functions
//

//square distance between 2 points a and b
unsigned int sq_dist(datum a, datum b) {
  short X = a.x-b.x;
  unsigned int X2=X*X;
  short Y = a.y-b.y;
  unsigned int Y2=Y*Y;
  return (X2 + Y2);
}

//insert element in ordered array of neighbours
void insert (neighbor element, unsigned int position) {
  for (int j=K-1; j>position; j--)
    knn_list[j] = knn_list[j-1];

  knn_list[position] = element;

}

///////////////////////////////////////////////////////////////////
int main() {

  unsigned long long elapsed;
  unsigned int elapsedu;

  //init uart and timer
  uart_init(UART_BASE, FREQ/BAUD);
  //printf("\nInit timer\n");
  //uart_txwait();

  timer_init(TIMER_BASE);
  
  //read current timer count, compute elapsed time
  //elapsed  = timer_get_count();
  //elapsedu = timer_time_us();


  //int vote accumulator
  int votes_acc[C] = {0};

  //generate random seed 
  random_init(S);

  //init dataset
  for (int i=0; i<N; i++) {
       
    //init coordinates
    data[i].x = (short) cmwc_rand();
    data[i].y = (short) cmwc_rand();

    //init label
    data[i].label = (unsigned char) (cmwc_rand()%C);
  }
  
  //printf("Init dataset");

#ifdef DEBUG
  printf("\n\n\nDATASET\n");
  printf("Idx \tX \tY \tLabel\n");
  for (int i=0; i<N; i++)
    printf("%d \t%d \t%d \t%d\n", i, data[i].x,  data[i].y, data[i].label);
#endif
  
  //init test points
  for (int k=0; k<M; k++) {
    x[k].x  = (short) cmwc_rand();
    x[k].y  = (short) cmwc_rand();
    //x[k].label will be calculated by the algorithm
  }

  //printf("Init test points\n");

#ifdef DEBUG
  printf("\n\nTEST POINTS\n");
  printf("Idx \tX \tY\n");
  for (int k=0; k<M; k++)
    printf("%d \t%d \t%d\n", k, x[k].x, x[k].y);
#endif
  
  //
  // PROCESS DATA
  //

  //start knn here
  knn_init(KNN_BASE);
//  printf("Init KNN\n"); 

  for (int k=0; k<M; k++) { //for all test points
  //compute distances to dataset points

#ifdef DEBUG
    printf("\n\nProcessing x[%d]:\n", k);
#endif
     
    knn_set_testp((x[k].x << 16) | (x[k].y & 0xFFFF));

    //init all k neighbors infinite distance
    //for (int j=0; j<K; j++)
    // knn_list[j].dist = INFINITE;

    //printf("Init k-neighbours distance\n");

#ifdef DEBUG
    printf("Datum \tX \tY \tLabel \tDistance\n");
#endif
    for (int i=0; i<N; i++) { //for all dataset points
      //compute distance to x[k]
      
      //unsigned int d = sq_dist(x[k], data[i]);
      //printf("%d\n", d); 
      knn_set_datap((data[i].x << 16) | (data[i].y & 0xFFFF));
      
      /*      
      //insert in ordered list
      for (int j=0; j<K; j++)
        if ( d < knn_list[j].dist ) {
          insert((neighbor){i,d}, j);
          break;
        }
      

#ifdef DEBUG
      //dataset
      printf("%d \t%d \t%d \t%d \t%d\n", i, data[i].x, data[i].y, data[i].label, d);
#endif
*/
    }
    
    knn_stop();
     
//    knn_get_list(knn_list);

    //printf("Distances check\n");
    
    //classify test point

    //clear all votes
    int votes[C] = {0};
    int best_votation = 0;
    int best_voted = 0;

    //make neighbours vote
    for (int j=0; j<K; j++) { //for all neighbors
      if ( (++votes[data[knn_list[j].idx].label]) > best_votation ) {
        best_voted = data[knn_list[j].idx].label;
        best_votation = votes[best_voted];
      }
    }

   // printf("Voting check\n");

    x[k].label = best_voted;

    votes_acc[best_voted]++;
    
#ifdef DEBUG
    printf("\n\nNEIGHBORS of x[%d]=(%d, %d):\n", k, x[k].x, x[k].y);
    printf("K \tIdx \tX \tY \tDist \t\tLabel\n");
    for (int j=0; j<K; j++)
      printf("%d \t%d \t%d \t%d \t%d \t%d\n", j+1, knn_list[j].idx, data[knn_list[j].idx].x, data[knn_list[j].idx].y, knn_list[j].dist,  data[knn_list[j].idx].label);
    
    printf("\n\nCLASSIFICATION of x[%d]:\n", k);
    printf("X \tY \tLabel\n");
    printf("%d \t%d \t%d\n\n\n", x[k].x, x[k].y, x[k].label);

#endif
    
  } //all test points classified

  
  //stop knn here
  //read current timer count, compute elapsed time
  elapsedu = timer_time_us(TIMER_BASE);
  printf("\nExecution time: %dus @%dMHz\n\n", elapsedu, FREQ/1000000);

  
  //print classification distribution to check for statistical bias
  for (int l=0; l<C; l++)
    printf("%d ", votes_acc[l]);
  printf("\n");
  
}
