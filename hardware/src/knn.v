`timescale 1ns/1ps
`include "iob_lib.vh"

module knn_core
   #(
     parameter DATA_W = 32,
     parameter NBR_KNN = 4,
     parameter NBR_TESTP = 4,
     parameter NBR_DATAP = 10
   )
   (   
    `INPUT(clk, 1),
    `INPUT(rst, 1),
    `INPUT(en, 1),
    `INPUT(valid, 1),
    `INPUT(ready, 1),
    `INPUT(A, DATA_W),
    `INPUT(B, DATA_W),
    `INPUT(knn_id, 4),
    `OUTPUT(knn_info, 8)
    );

    `SIGNAL(knn_dist, DATA_W)
    `SIGNAL(datap_id, DATA_W/4)
    `SIGNAL(ready_list, 1)

    knn_dist dist0
            (
              .clk(clk),
              .rst(rst), 
              .en(en),
	      .en_dist(ready),
	      .valid(valid),
	      .A(A),
	      .B(B),
	      .en_list(ready_list),
	      .distance(knn_dist),
	      .id(datap_id)
            );

    knn_list list
            (
              .clk(clk),
              .rst(rst),
  	      .valid(ready_list),
	      .datap_id(datap_id),
              .knn_id(knn_id),
	      .dist_entry(knn_dist),
	      .knn_info(knn_info)
            );

endmodule
