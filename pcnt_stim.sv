////////////////////////////////////////////////////////////////////////////////
//  File:cnt_stim.sv
//
//  Description: testbench for the pmem.sv
////////////////////////////////////////////////////////////////////////////////

timeunit 1ns; timeprecision 10ps;

module pcnt_stim;

import picoMIPS_package::*;

// Outputs
logic [PMEM_WIDTH-1:0] addr;

// Inputs
logic inc, clk, nRst;

pcnt dut (.*);

initial begin
  clk = 1'b1;
  forever
    #10 clk = ~clk;
end

initial begin
  nRst = 1'b1;
  #15 nRst = 1'b0;
  #20 nRst = 1'b1;
end

initial begin
  inc = 0;

  #85 inc = 1'b1;
end

endmodule
