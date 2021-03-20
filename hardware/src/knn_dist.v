`timescale 1ns/1ps
`include "iob_lib.vh"

module knn_dist
   #(
     parameter DATA_W = 32,
     parameter NBR_LABELS = 4,
     parameter NBR_KNN = 4,
     parameter NBR_TESTP = 4,
     parameter NBR_DATAP = 10,
     parameter LABEL_BITS = 8
   )
   (
    `INPUT(clk, 1),
    `INPUT(rst, 1),
    `INPUT(rst_dist, 1),
    `INPUT(en, 1),
    `INPUT(en_dist, 1),
    `INPUT(valid, 1),
    `INPUT(A, DATA_W),
    `INPUT(B, DATA_W),
    `OUTPUT(distance, DATA_W)
    );

   `SIGNAL_SIGNED(dist_out_h, 16)
   `SIGNAL_SIGNED(dist_out_l, 16)
   `SIGNAL_SIGNED(dist_res, 32)

   `SIGNAL(knn_dist_out, DATA_W*NBR_KNN)
   `SIGNAL(knn_label_out, LABEL_BITS*NBR_KNN)

   integer n = 0;

   `COMB if(n < NBR_TESTP*NBR_DATAP & en_dist) begin

        dist_out_h = A[31:16]-B[31:16];
        dist_out_l = A[15:0]-B[15:0];

        dist_res = dist_out_h**2 + dist_out_l**2;

        n = n + 1;

    end

    `SIGNAL2OUT(distance, dist_res) //distance must go to the list block in order to collect the cluster of the K-neirest neighbours relative to the test point

