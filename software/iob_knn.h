#pragma once

//Functions
void knn_reset();
void knn_start();	
void knn_stop();
void knn_init( int base_address);	
unsigned int knn_get_dist(int coordinates_x, int coordinates_y);
