`timescale 1ns/1ps
`include "iob_lib.vh"
`include "interconnect.vh"

module knn_tb;

   localparam PER=10;
   
   `CLOCK(clk, PER)
   `RESET(rst, 7, 10)

   `SIGNAL(KNN_ENABLE, 1)
   `SIGNAL(KNN_SAMPLE, 1)
   `SIGNAL_OUT(KNN_VALUE, 2*`DATA_W)
   
   initial begin
`ifdef VCD
      $dumpfile("knn.vcd");
      $dumpvars();
`endif
      KNN_ENABLE = 0;
      KNN_SAMPLE = 0;

      @(posedge rst);
      @(negedge rst);
      @(posedge clk) #1 KNN_ENABLE = 1;
      @(posedge clk) #1 KNN_SAMPLE = 1;
      @(posedge clk) #1 KNN_SAMPLE = 0;

      //uncomment to fail the test 
      //@(posedge clk) #1;
            
      $finish;
   end
   
   //instantiate knn core
   knn_core knn0
     (
      .KNN_ENABLE(KNN_ENABLE),
      .KNN_SAMPLE(KNN_SAMPLE),
      .KNN_VALUE(KNN_VALUE),
      .clk(clk),
      .rst(rst)
      );   

endmodule
