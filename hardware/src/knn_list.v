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
    `INPUT(prior_nn_dist, 32),
    `INPUT(prior_nn_label, 8),
    `INPUT(dist_entry, DATA_W),
    `INPUT(label_entry, LABEL_BITS),
    `OUTPUT(nn_dist, DATA_W),
    `OUTPUT(nn_label, LABEL_BITS)
   );

    `SIGNAL(new_reg_val, 1)
    `SIGNAL(dist_in, DATA_W)
    `SIGNAL(label_in, LABEL_BITS)
    `SIGNAL(dist_out, DATA_W)
    `SIGNAL(label_out, LABEL_BITS)

    `COMB begin
  
	        if (dist_entry < dist_out) //compare distance value with the k-neighbours register
        	
			new_reg_val = 1'b1;
		else
			new_reg_val = 1'b0;
	
		if (new_reg_val == 1)

			dist_in = dist_entry;
			label_in = label_entry;

		$display("dist_in = %d, label_in = %d", dist_in, label_in);
    end

    `REG_ARE(clk, rst, 1, en_list & new_reg_val, label_out, label_entry)
    `REG_ARE(clk, rst, 1, en_list & new_reg_val, dist_out, dist_entry)
	
    `SIGNAL2OUT(nn_dist, dist_out)
    `SIGNAL2OUT(nn_label, label_out)
 
endmodule

//TODO: control block to implement signaling for the finite state machine


