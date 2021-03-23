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
    `INPUT(valid, 1),
    `INPUT(ID, 2),
    `INPUT(dist_entry, DATA_W),
    `OUTPUT(knn_info, 2)
   );

    `SIGNAL(id_out, 8)
    `SIGNAL(id_counter, 2)
    `SIGNAL(set_value, 1)

    reg new_reg_val [0:NBR_KNN-1];

    reg [DATA_W:0] dist_vec [0:NBR_KNN-1];
    
    integer i;

    `SIGNAL2OUT(knn_info, id_out)
   

    `REG_E(clk, valid, dist_vec[id_counter], 32'Hffffffff)


    `COUNTER_RE(clk, rst, valid, id_counter)

    `COMB begin	
	
	$display("counter: %d\n", id_counter);	
   	
	for(i = 0; i < NBR_KNN; i = i + 1) begin 

	    if (dist_entry < dist_vec[i]) begin //compare distance value with the knn register	
	
			dist_vec[i] = dist_entry;

			$display("dist_vec[0]: %d\n", dist_vec[0]);
			$display("dist_vec[1]: %d\n", dist_vec[1]);
			$display("dist_vec[2]: %d\n", dist_vec[2]);
			$display("dist_vec[3]: %d\n", dist_vec[3]);

	    end
		
	end
    
    end

endmodule //knn_list
