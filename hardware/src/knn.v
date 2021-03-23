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
    `OUTPUT(knn_info, 2)
    );

    `SIGNAL(knn_dist, DATA_W)
    `SIGNAL(rst_dist, 1)
    `SIGNAL(en_dist, 1)
    `SIGNAL(knn_id_out, DATA_W/4)

    knn_dist dist0
            (
              .clk(clk),
              .rst(rst),
              .rst_dist(rst_dist),
              .en(en),
	      .en_dist(en_dist),
	      .valid(valid),
	      .A(A),
	      .B(B),
	      .distance(knn_dist)
            );
         
    knn_list list
            (
              .clk(clk),
              .rst(rst),
  	      .valid(valid),
	      .ID(knn_info),
              .dist_entry(knn_dist),
	      .knn_info(knn_info)
            );	

endmodule
