////////////////////////////////////////////////////////////////////////////////
//  File: picoMIPS4test_stim.sv
//
//  Description: testbench for the picoMIPS4test.sv
////////////////////////////////////////////////////////////////////////////////

module picoMIPS4test_stim;

// Outputs
logic [6:0] LED;

// Inputs
logic [9:0] SW;
logic fastclk;

picoMIPS4test dut (.*);

initial begin
  fastclk = 1'b1;
  forever
    #10 fastclk = ~fastclk;
end

initial begin
  SW[9] = 1'b1;
  #15 SW[9] = 1'b0;
  #20 SW[9] = 1'b1;
end

initial begin
  SW[7:0] = 8'h0;
  SW[8]   = 1'b0;

  #45;
end

endmodule
