////////////////////////////////////////////////////////////////////////////////
//  File:led_7seg_stim.sv
//
//  Description: testbench for the led_7seg.sv
////////////////////////////////////////////////////////////////////////////////

timeunit 1ns; timeprecision 10ps;

module led_7seg_stim;

import picoMIPS_package::*;

// Outputs
logic [6:0] LED;

// Inputs
logic [DATA_WIDTH-1:0] val;
logic en;

led_7seg dut (.*);

initial begin
  en = 1'b0;
  val = {DATA_WIDTH{1'b0}};
  for(int i=1;i<(1<<DATA_WIDTH);i++)
    #20 val = i;

  en = 1'b1;
  for(int i=0;i<(1<<DATA_WIDTH);i++)
    #20 val = i;
end

endmodule
