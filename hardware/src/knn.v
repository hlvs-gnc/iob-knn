`timescale 1ns/1ps
`include "iob_lib.vh"


module knn_list
   #(
    parameter DATA_W = 32,
    parameter NBR_KNN = 10,
    parameter LABEL_BITS = 8
    )
   (
    `INPUT(clk, 1),
    `INPUT(rst, 1),
    `INPUT(nn_entry, DATA_W),
    `INPUT(label_entry, LABEL_BITS),
    `OUTPUT(nn_out, NBR_KNN*LABEL_BITS)
   );

endmodule

//TODO: control block to implement signaling for the finite state machine

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
    `INPUT(label, 8),
    `OUTPUT(distance, DATA_W)
    );
 
   `SIGNAL_SIGNED(dist_out_h, 16)
   `SIGNAL_SIGNED(dist_out_l, 16)
   `SIGNAL_SIGNED(dist_res, 32)

   reg [31:0] knn_dist[NBR_TESTP*NBR_DATAP];
   reg [7:0] knn_labels[NBR_DATAP*NBR_KNN];
   int i = 0; 

   `COMB if(i < NBR_TESTP*NBR_DATAP & en_dist) begin
	   
	dist_out_h = A[31:16]-B[31:16];
	dist_out_l = A[15:0]-B[15:0];		

	dist_res = dist_out_h**2 + dist_out_l**2;

	i = i + 1;

    end

   `SIGNAL2OUT(distance, dist_res) //distance must go to the list block in order to collect the cluster of the K-neirest neighbours relative to the test point

endmodule
