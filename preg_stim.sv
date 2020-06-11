////////////////////////////////////////////////////////////////////////////////
//  File:preg_stim.sv
//
//  Description: testbench for the preg.sv
////////////////////////////////////////////////////////////////////////////////

timeunit 1ns; timeprecision 10ps;

module preg_stim;

import picoMIPS_package::*;

// Outputs
logic [DATA_WIDTH-1:0] Rd_data, Rs_data;

// Inputs
logic [ADDR_WIDTH-1:0] Rd, Rs, Rt;
logic [DATA_WIDTH-1:0] Wdata;
logic [1:0]            ctrl; //{treg,write}

logic clk;

preg dut (.*);

initial begin
  clk = 1'b1;
  forever
    #10 clk = ~clk;
end

initial begin
  Rd = {ADDR_WIDTH{1'b0}};
  Rs = {ADDR_WIDTH{1'b0}};
  Rt = {ADDR_WIDTH{1'b0}};
  Wdata = {DATA_WIDTH{1'b0}};
  ctrl = 2'b00;

  #25;
  for(int i=1;i<(1<<ADDR_WIDTH);i++)
    for(int j=0;j<(1<<DATA_WIDTH);j++) begin
       #20 Rd = i; Rs = i; Wdata = j;
    end

  ctrl = 2'b01;
  for(int i=0;i<(1<<ADDR_WIDTH);i++)
    for(int j=0;j<(1<<DATA_WIDTH);j++) begin
       #20 Rd = i; Rs = i; Wdata = j;
    end

  ctrl = 2'b10; Rd = {ADDR_WIDTH{1'b0}};
  for(int i=0;i<(1<<ADDR_WIDTH);i++)
    for(int j=0;j<(1<<DATA_WIDTH);j++) begin
       #20 Rt = i; Rs = i; Wdata = j;
    end

end

endmodule
