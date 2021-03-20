`timescale 1ns/1ps
`include "iob_lib.vh"

module knn_core
   #(
     parameter DATA_W = 32,
     parameter NBR_LABELS = 4,
     parameter NBR_KNN = 4,
     parameter NBR_TESTP = 4,
     parameter NBR_DATAP = 10,
     parameter LABEL_BITS = 8
   )
   (   
    `INPUT(clk, 1),
    `INPUT(rst, 1),
    `INPUT(en, 1),
    `INPUT(valid, 1),
    `INPUT(A, DATA_W),
    `INPUT(B, DATA_W),
    `OUTPUT(knn_info, DATA_W)
    );

    `SIGNAL(knn_dist, DATA_W)
    `SIGNAL(rst_dist, 1)
    `SIGNAL(en_dist, 1)

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

    genvar i;
    
    generate
        for(i = 1; i < NBR_KNN; i = i + 1) begin
    
	    knn_list list
            (
              .clk(clk),
              .rst(rst),
              .en_list(valid),
	      .prior_nn_dist(knn_dist_out[i*DATA_W-1:(i-1)*DATA_W]),
              .dist_entry(knn_dist),
	      .nn_dist(knn_dist_out[(i+1)*DATA_W-1:i*DATA_W])
            );
	
	end
    endgenerate


endmodule
