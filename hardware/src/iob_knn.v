`timescale 1ns/1ps
`include "iob_lib.vh"
`include "interconnect.vh"
`include "iob_knn.vh"

module iob_knn 
  #(
    parameter ADDR_W = `KNN_ADDR_W, //NODOC Address width
    parameter DATA_W = `DATA_W, //NODOC Data word width
    parameter WDATA_W = `KNN_WDATA_W //NODOC Data word width on writes
    )
   (
`include "cpu_nat_s_if.v"
`include "gen_if.v"
    );

//BLOCK Register File & Configuration, control and status registers accessible by the sofware
`include "KNNsw_reg.v"
`include "KNNsw_reg_gen.v"

    //combined hard/soft reset 
   `SIGNAL(rst_int, 1)
   `COMB rst_int = rst | KNN_RESET;

   //write signal
   `SIGNAL(write, 1) 
   `COMB write = | wstrb;
  
   `SIGNAL_OUT(en_acc, 1)
   `SIGNAL_OUT(rst_acc, 1)
   //
   //BLOCK 64-bit time counter & Free-running 64-bit counter with enable and soft reset capabilities
   //
   //`SIGNAL_OUT(distance, DATA_W)
   knn_core knn0
     (
      .clk(clk),
      .rst(rst_int),
      .rst_acc(rst_acc),
      .en(KNN_ENABLE & write & valid),
      .en_acc(en_acc),
      .A(KNN_X),
      .B(KNN_Y),
      .distance(KNN_DIST)
      );
   
   
   //ready signal   
   `SIGNAL(ready_knn, 1)
   `REG_AR(clk, rst, 0, ready_knn, valid)

   `SIGNAL2OUT(ready, ready_knn)
   
   //rdata signal
   //`COMB begin
   //end
      
endmodule
