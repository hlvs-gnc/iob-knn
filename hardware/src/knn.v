`timescale 1ns/1ps
`include "iob_lib.vh"


module knn_list
   #(
    parameter DATA_W = 32,
    parameter NBR_KNN = 4,
    parameter LABEL_BITS = 8
    )
   (
    `INPUT(clk, 1),
    `INPUT(rst, 1),
    `INPUT(en_list, 1),
    `INPUT(dist_entry, DATA_W),
    `INPUT(label_entry, LABEL_BITS),
    `OUTPUT(nn_out, NBR_KNN*LABEL_BITS)
   );

    reg [DATA_W:0] dist_out [NBR_KNN:0];

    integer i = 0;
/*
    `COMB begin

	for (i = 0; i < NBR_KNN; i=i+1) begin
	    
    		if (i < 8 & en_list) begin //compare distance value with the k-neighbours array
	        
		dist_out[i] = dist_entry;
	        i = i + 1; 
 	   	$display("dist_out[%d]: %d", i-1, dist_out[i-1]);
 	    end
	end
 
     end

//    `SIGNAL2OUT(nn_out, dist_out)

  */ 
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
