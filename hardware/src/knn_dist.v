`timescale 1ns/1ps
`include "iob_lib.vh"

module knn_dist
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
    `INPUT(en_dist, 1),
    `INPUT(valid, 1),
    `INPUT(A, DATA_W),
    `INPUT(B, DATA_W),
    `OUTPUT(en_list, 1),
    `OUTPUT(distance, DATA_W),
    `OUTPUT(id, DATA_W/4)
    );

   `SIGNAL_SIGNED(dist_h, 16)
   `SIGNAL_SIGNED(dist_l, 16)
   `SIGNAL(dist_h_pwr, 32)
   `SIGNAL(dist_l_pwr, 32)
   `SIGNAL(dist_res, 32)
   
   `SIGNAL(ok_signal, 1)

   integer i = 0;
   `SIGNAL2OUT(distance, dist_res) //distance must go to the list block in order to collect the cluster of the K-neirest neighbours relative to the test point
   
   `SIGNAL2OUT(en_list, ok_signal)
   `SIGNAL2OUT(id, i)


   `COMB if(en_dist) begin
	
	ok_signal=1'b0;
        
	dist_h = A[31:16]-B[31:16];
        dist_l = A[15:0]-B[15:0];
	
	dist_h_pwr = dist_h * dist_h;
	dist_l_pwr = dist_l * dist_l;

        dist_res = dist_h_pwr + dist_l_pwr;
  	
	ok_signal=1'b1;

	i = i + 1;
		
	if(i == NBR_DATAP) i = 0;
	
    end

endmodule
