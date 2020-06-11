////////////////////////////////////////////////////////////////////////////////
//  File:alu_stim.sv
//
//  Description: testbench for the alu.sv
////////////////////////////////////////////////////////////////////////////////

timeunit 1ns; timeprecision 10ps;

module alu_stim;

import picoMIPS_package::*;

// Outputs
logic signed [DATA_WIDTH-1:0] result;

// Inputs
logic signed [DATA_WIDTH-1:0] A, B;
logic [2:0] ctrl;

alu dut (.*);

initial begin
  A = {DATA_WIDTH{1'b0}};
  B = {DATA_WIDTH{1'b0}};
  ctrl = 3'b000;

  #20 A=8'hF0; B=8'h4; ctrl=3'b100;

  #20 A=8'h0; B=8'h0; ctrl=3'b000;

  #20;
  for(int i=1;i<(1<<DATA_WIDTH);i++)
    for(int j=1;j<(1<<DATA_WIDTH);j++) begin
      #20 A=i; B=j;
    end

  ctrl = 3'b001;
  for(int i=0;i<(1<<DATA_WIDTH);i++)
    for(int j=0;j<(1<<DATA_WIDTH);j++) begin
      #20 A=i; B=j;
    end

  ctrl = 3'b010;
  for(int i=0;i<(1<<DATA_WIDTH);i++)
    for(int j=0;j<(1<<DATA_WIDTH);j++) begin
      #20 A=i; B=j;
    end

  ctrl = 3'b100;
  for(int i=0;i<(1<<DATA_WIDTH);i++)
    for(int j=0;j<(1<<DATA_WIDTH);j++) begin
      #20 A=i; B=j;
    end
end

endmodule
