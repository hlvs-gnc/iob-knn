`timescale 1ns/1ps
`include "iob_lib.vh"

module knn_core
   #(
     parameter DATA_W = 32,
     parameter NBR_LABELS = 4,
     parameter NBR_KNN = 4,
     parameter NBR_TESTP = 4,
     parameter NBR_DATAP = 4
   )
   (   
    `INPUT(clk, 1),
    `INPUT(rst, 1),
    `INPUT(rst_dist, 1),
    `INPUT(en, 1),
    `INPUT(en_dist, 1),
    `INPUT(A, DATA_W),
    `INPUT(B, DATA_W),
    `OUTPUT(distance, DATA_W)
    );
 
   `SIGNAL_SIGNED(dist_out_h, 16)
   `SIGNAL_SIGNED(dist_out_l, 16)
   `SIGNAL_SIGNED(dist_res, 32)

   `SIGNAL(knn_dist, DATA_W)
   `SIGNAL(knn_dist_in, DATA_W)

   integer n = 0;

   `COMB if(n < 4*10 & en_dist) begin

	dist_out_h = A[31:16]-B[31:16];
	dist_out_l = A[15:0]-B[15:0];		

	dist_res = dist_out_h**2 + dist_out_l**2;

//	$display("distance: %d\n", dist_res);

	n = n + 1;

    end

   `SIGNAL2OUT(distance, dist_res) //distance must go to the list block in order to collect the cluster of the K-neirest neighbours relative to the test point
     
   //`SIGNAL(knn_info, DATA_W)    
/*
     knn_list list
      (
        .clk(clk),
        .rst(rst),
        .en_list(1),
        .dist_entry(knn_dist_in),
        .label_entry(label),
        .nn_out(knn_info)
        );
*/
endmodule
