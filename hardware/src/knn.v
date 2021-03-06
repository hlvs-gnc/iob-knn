`timescale 1ns/1ps
`include "iob_lib.vh"

module knn_core
   #(
     parameter DATA_W = 32
   )
   (   
    `INPUT(clk, 1),
    `INPUT(rst, 1),
    `INPUT(rst_acc, 1),
    `INPUT(en, 1),
    `INPUT(en_acc, 1),
    `INPUT(A, DATA_W),
    `INPUT(B, DATA_W),
    `OUTPUT(distance, DATA_W)
    );
    
   `SIGNAL_SIGNED(dist_out_h, 16)
   `SIGNAL_SIGNED(dist_out_l, 16)
   `SIGNAL_SIGNED(dist_res, 32)

   `COMB begin
		
	dist_out_h = A[31:16]-B[31:16];
	dist_out_l = A[15:0]-B[15:0];

	dist_res = dist_out_h**2 + dist_out_l**2;

	//$display("\t### (knn_core) distance: %d ###\n", dist_res);
    end

   `SIGNAL2OUT(distance, dist_res)

endmodule
