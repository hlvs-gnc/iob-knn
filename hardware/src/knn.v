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
    `INPUT(rst_dist, 1),
    `INPUT(en, 1),
    `INPUT(en_dist, 1),
    `INPUT(valid, 1),
    `INPUT(A, DATA_W),
    `INPUT(B, DATA_W),
    `INPUT(label_qualifier, LABEL_BITS),
    `OUTPUT(distance, DATA_W)
    );
 
   `SIGNAL_SIGNED(dist_out_h, 16)
   `SIGNAL_SIGNED(dist_out_l, 16)
   `SIGNAL_SIGNED(dist_res, 32)

   `SIGNAL(knn_dist_out, DATA_W*NBR_KNN)
   `SIGNAL(knn_label_out, LABEL_BITS*NBR_KNN)

   integer n = 0;

   `COMB if(n < NBR_TESTP*NBR_DATAP & en_dist) begin

	dist_out_h = A[31:16]-B[31:16];
	dist_out_l = A[15:0]-B[15:0];		

	dist_res = dist_out_h**2 + dist_out_l**2;
	
	n = n + 1;

    end

    `SIGNAL2OUT(distance, dist_res) //distance must go to the list block in order to collect the cluster of the K-neirest neighbours relative to the test point
    

    genvar i;
    
    generate
        for(i = 1; i < NBR_KNN; i = i + 1) begin
    
	    knn_list list
            (
              .clk(clk),
              .rst(rst),
              .en_list(valid),
	      .prior_nn_dist(knn_dist_out[i*DATA_W-1:(i-1)*DATA_W]),
	      .prior_nn_label(knn_label_out[i*LABEL_BITS-1:(i-1)*LABEL_BITS]),
              .dist_entry(dist_res),
              .label_entry(label_qualifier),
	      .nn_dist(knn_dist_out[(i+1)*DATA_W-1:i*DATA_W]),
              .nn_label(knn_label_out[(i+1)*LABEL_BITS-1:i*LABEL_BITS])
            );
	
	end
    endgenerate


endmodule
