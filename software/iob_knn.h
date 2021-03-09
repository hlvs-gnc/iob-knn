#pragma once

//Functions
void knn_reset();
void knn_start();	
void knn_stop();
void knn_init( int base_address);	
void knn_set_test(int coordinates);
void knn_set_train(int coordinates, char label);
