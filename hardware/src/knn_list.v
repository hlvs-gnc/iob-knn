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
    `INPUT(ID, 8),
    `INPUT(dist_entry, DATA_W),
    `OUTPUT(knn_info, 2)
   );

    `SIGNAL(id_out, 8)
    `SIGNAL(knn_counter, 2)
    `SIGNAL(set_value, 1)

    reg new_reg_val [0:NBR_KNN-1];

    reg [DATA_W:0] dist_vec [0:NBR_KNN-1];
    reg [DATA_W/4:0] id_vec [0:NBR_KNN-1];

    integer i;
    integer j;
    integer k;

    `SIGNAL2OUT(knn_info, id_out)
  

    always @(posedge clk) begin
  	for(j=0; j<NBR_KNN ; j=j+1) begin
  		if (rst) dist_vec[j] <= 32'Hffffffff; 
  	end
    end

    always @(posedge clk) begin
        for(k=0; k<NBR_KNN ; k=k+1) begin
                if (rst) id_vec[k] <= 8'H00;
        end
    end


    `COUNTER_RE(clk, rst, valid, knn_counter)

    `COMB if(valid) begin	
	
//	$display("counter: %d\n", knn_counter);	
//      $display("ID: %d\n", ID); 
//	$display("dist_entry: %d\n", dist_entry); 

	for(i = 0; i < NBR_KNN; i = i + 1) begin 

	    if (dist_entry < dist_vec[knn_counter]) begin //compare distance value with the knn register	
	
		    	new_reg_val[knn_counter]=1;
			dist_vec[knn_counter] = dist_entry;
			id_vec[knn_counter] = ID;

			$display("#################################");
			$display("dist_vec[0]: %d\n", dist_vec[0]);
               		$display("dist_vec[1]: %d\n", dist_vec[1]);
        	        $display("dist_vec[2]: %d\n", dist_vec[2]);
	                $display("dist_vec[3]: %d\n", dist_vec[3]);

			$display("#################################");
                        $display("id_vec[0]: %d\n", id_vec[0]);
                        $display("id_vec[1]: %d\n", id_vec[1]);
                        $display("id_vec[2]: %d\n", id_vec[2]);
                        $display("id_vec[3]: %d\n", id_vec[3]);

    		//TODO: need to break from the verified condition
            end
	    else begin
	        	new_reg_val[knn_counter]=0;

	    end

	end
    
    end

endmodule //knn_list
