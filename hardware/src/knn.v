`timescale 1ns/1ps
`include "iob_lib.vh"

module knn_core
   #(
     parameter DATA_W = 32
   )
   (
//    `INPUT(KNN_ENABLE, 1),    
    `INPUT(clk, 1),
    `INPUT(rst, 1),
    `INPUT(en, 1),
    `INPUT(A, DATA_W),
    `INPUT(B, DATA_W),
    `OUTPUT(distance, DATA_W)
    );
    

   `SIGNAL(dist_out, 32)
   `SIGNAL(dist_out_h, 16)
   `SIGNAL(dist_out_l, 16)
   `SIGNAL(reg_A, 32)
   `SIGNAL(reg_B, 32)
   `SIGNAL(reg_dist_x, 32)
   `SIGNAL(reg_dist_y, 32) 


   `REG_RE(clk, rst, 0, en, reg_A, A)
   `REG_RE(clk, rst, 0, en, reg_B, B)

   `COMB begin
			
		dist_out_h = reg_A[31:16]-reg_B[31:16];
		dist_out_l = reg_A[15:0]-reg_B[15:0];

		reg_dist_x = dist_out_h**2;
		reg_dist_y = dist_out_l**2;
		
		$display("\n distance - x: %d, y: %d\n", reg_dist_x, reg_dist_y);

		//dist_out = (dist_out_h <<< 16) | (dist_out_l & 65535);
		//dist_out = (reg_dist[63:32] <<< 32) + (reg_dist[31:0] & 32'hFFFFFFFF);	

		dist_out = reg_dist_x + reg_dist_y;

		//$display("(knn_core) distance: %d\n", dist_out);
	end

   	`SIGNAL2OUT(distance, dist_out)

endmodule
