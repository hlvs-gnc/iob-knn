`timescale 1ns/1ps
`include "iob_lib.vh"

module knn_core
   #(
     parameter DATA_W = 32
   )
   (
    `INPUT(KNN_ENABLE, 1),    
    `INPUT(clk, 1),
    `INPUT(rst, 1),
    `INPUT(en, 1),
    `INPUT(A, DATA_W),
    `INPUT(B, DATA_W),
    `OUTPUT(distance, 32)
    );
    

   `SIGNAL(DIST, 32)
   `SIGNAL(DIST_HIGH, 16)
   `SIGNAL(DIST_LOW, 16)
   `SIGNAL(reg_1, 32)
   `SIGNAL(reg_2, 32)

   `REG_RE(clk, rst, 0, en, reg_1, A)
   `REG_RE(clk, rst, 0, en, reg_2, B)

   `COMB begin
		
		//$display("(knn_core)\n");	   
  		//$display(" reg_1: %d\n", reg_1);
		//$display(" reg_2: %d\n", reg_2);
		
		//DIST = (reg_1-reg_2)**2;
   		
		DIST_HIGH = reg_1[31:16]-reg_2[31:16];
		DIST_LOW = reg_1[15:0]-reg_2[15:0];
		
		DIST = (DIST_HIGH <<< 16) | (DIST_LOW & 65535);

		$display("(knn_core) distance: %b\n", DIST);
	end

   	`SIGNAL2OUT(distance, DIST)

endmodule

