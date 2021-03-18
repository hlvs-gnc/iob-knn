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


