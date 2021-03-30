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
    `INPUT(get_id, 1),
    `INPUT(datap_id, 8),
    `INPUT(knn_id, 4),
    `INPUT(dist_entry, DATA_W),
    `OUTPUT(knn_info, 8)
   );

    `SIGNAL(id_out, 8)
    `SIGNAL(knn_counter, 2)
    `SIGNAL(set_value, 1)

    reg new_reg_val [0:NBR_KNN-1];

    reg [DATA_W-1:0] dist_vec [0:NBR_KNN-1];
    reg [(DATA_W/4)-1:0] id_vec [0:NBR_KNN-1];

    integer i = 0;
    integer j;
    integer k;
    integer n = 0;

    `SIGNAL2OUT(knn_info, id_out)
 
    reg [31:0] min_dist = 32'Hffffffff; 

    integer id_min_dist=0;
    integer id_max=0;


    always @(posedge clk) begin
  	for(j=0; j<NBR_KNN ; j=j+1) begin
  		if (rst) dist_vec[j] <= 32'Hffffffff; // set maximum distance 
  	end
    end

    always @(posedge clk) begin
        for(k=0; k<NBR_KNN ; k=k+1) begin
                if (rst) id_vec[k] <= 8'H00;
        end
    end


    always @(valid) begin	
	        
	//for(i = 0; i < NBR_KNN; i = i + 1) begin 
	
/*	$display("dist_entry: %d", dist_entry);
	$display("min_dist: %d", dist_vec[id_min_dist]);
	$display("id_min_dist: %d", id_min_dist);
*/
	    if (dist_entry < dist_vec[id_min_dist]) begin // compare distance value with the knn register			
			dist_vec[id_min_dist+1] = dist_vec[id_min_dist];
			dist_vec[id_min_dist] = dist_entry;
		
			id_vec[id_min_dist+1] = id_vec[id_min_dist];	
			id_vec[id_min_dist] = datap_id;
	
		//	id_min_dist = id_min_dist + 1;
    		
			//TODO: need to break from the verified condition
            end else begin
	        
  // 			$display("ELSE! id_max_dist: %d", id_min_dist); 

			id_min_dist = id_min_dist + 1;
	    end
             /*           $display("#################################");
                        $display("dist_vec[0]: %d\n", dist_vec[0]);
                        $display("dist_vec[1]: %d\n", dist_vec[1]);
                        $display("dist_vec[2]: %d\n", dist_vec[2]);
                        $display("dist_vec[3]: %d\n", dist_vec[3]);

                        $display("#################################");
                        $display("id_vec[0]: %d\n", id_vec[0]);
                        $display("id_vec[1]: %d\n", id_vec[1]);
                        $display("id_vec[2]: %d\n", id_vec[2]);
                        $display("id_vec[3]: %d\n", id_vec[3]);
*/
	//end

    end

    always @(*) begin

 	id_out = id_vec[knn_id];

    end
	//TODO: output
endmodule //knn_list
