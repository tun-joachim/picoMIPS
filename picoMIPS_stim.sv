////////////////////////////////////////////////////////////////////////////////
//  File: picoMIPS_stim.sv
//
//  Description: testbench for the picoMIPS.sv
////////////////////////////////////////////////////////////////////////////////

timeunit 1ns; timeprecision 10ps;

module picoMIPS_stim;

import picoMIPS_package::*;

// Outputs
logic [6:0] LED;
logic [DATA_WIDTH-1:0] led_num;

// Inputs
logic [9:0] SW;
logic clk;

picoMIPS dut (.*);

initial begin
  clk = 1'b1;
  forever
    #10 clk = ~clk;
end

initial begin
  SW[9] = 1'b1;
  #15 SW[9] = 1'b0;
  #20 SW[9] = 1'b1;
end

initial begin
  SW[7:0] = 8'h0;
  SW[8]   = 1'b0;

  #205 SW[7:0]=8'h4; SW[8]=1'b1;
  #100 SW[8]=1'b0;
  #100 SW[7:0]=8'h2; SW[8]=1'b1;
  #100 SW[8]=1'b0;
  #800 SW[8]=1'b1;
  #100 SW[8]=1'b0;
end

always_comb
case(LED)
  ~7'b011_1111: led_num = 0;
  ~7'b000_0110: led_num = 1;
  ~7'b101_1011: led_num = 2;
  ~7'b100_1111: led_num = 3;
  ~7'b110_0110: led_num = 4;
  ~7'b110_1101: led_num = 5;
  ~7'b111_1101: led_num = 6;
  ~7'b000_0111: led_num = 7;
  ~7'b111_1111: led_num = 8;
  ~7'b110_1111: led_num = 9;
  ~7'b111_0111: led_num = 10;
  ~7'b111_1100: led_num = 11;
  ~7'b011_1001: led_num = 12;
  ~7'b101_1110: led_num = 13;
  ~7'b111_1001: led_num = 14;
  ~7'b111_0001: led_num = 15;
  default: led_num = 0;
endcase

endmodule
