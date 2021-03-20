`timescale 1ns/1ps
`include "iob_lib.vh"


module knn_list
   #(
    parameter DATA_W = 32,
    parameter NBR_KNN = 4
    )
   (
    `INPUT(clk, 1),
    `INPUT(rst, 1),
    `INPUT(en_list, 1),
    `INPUT(prior_nn_dist, 32),
    `INPUT(dist_entry, DATA_W),
    `OUTPUT(nn_dist, DATA_W)
   );

    `SIGNAL(new_reg_val, 1)
    `SIGNAL(dist_in, DATA_W)
    `SIGNAL(dist_out, DATA_W)

    `COMB begin
  
	        if (dist_entry < dist_out) //compare distance value with the k-neighbours register
        	
			new_reg_val = 1'b1;
		else
			new_reg_val = 1'b0;
	
		if (new_reg_val == 1)

			dist_in = dist_entry;

		$display("dist_in = %d", dist_in);
    end

    `REG_ARE(clk, rst, 1, en_list & new_reg_val, dist_out, dist_entry)
	
    `SIGNAL2OUT(nn_dist, dist_out)
 
endmodule

//TODO: control block to implement signaling for the finite state machine
