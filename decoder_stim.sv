////////////////////////////////////////////////////////////////////////////////
//  File:decoder_stim.sv
//
//  Description: testbench for the decoder.sv
////////////////////////////////////////////////////////////////////////////////

timeunit 1ns; timeprecision 10ps;

module decoder_stim;

import picoMIPS_package::*;

// Outputs
logic [7:0] ctrl_flags;
logic [ADDR_WIDTH-1:0] Rd, Rs, Rt;

// Inputs
logic [INST_WIDTH+(2*ADDR_WIDTH)+DATA_WIDTH-1:0] bus;

logic SW8;

decoder dut (.*);

initial begin
  bus = {INST_WIDTH+(2*ADDR_WIDTH)+DATA_WIDTH{1'b0}};
  SW8 = 1'b0;

  #20 bus = 24'h144040;
  #20 bus = 24'h1460F0;
  #20 bus = 24'h148060;
  #20 bus = 24'h118000;
  #20 SW8 = 1'b1;
  #20 bus = 24'h140800;
  #20 bus = 24'h110000;
  #20 SW8 = 1'b0;
  #20 bus = 24'h118000;
  #20 SW8 = 1'b1;
  #20 bus = 24'h142800;
  #20 bus = 24'h110000;
  #20 SW8 = 1'b0;
  #20 bus = 24'h080202;
  #20 bus = 24'h080503;
  #20 bus = 24'h002205;
  #20 bus = 24'h044205;
  #20 bus = 24'h080503;
  #20 bus = 24'h082404;
  #20 bus = 24'h008405;
  #20 bus = 24'h04840C;
  #20 bus = 24'h145100;
  #20 SW8 = 1'b1;
  #20 bus = 24'h149000;
  #20 SW8 = 1'b0;
  #20 bus = 24'h100000;
  #20 bus = 24'h100000;
  #20 bus = 24'h100000;
end

endmodule
