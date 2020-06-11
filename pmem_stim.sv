////////////////////////////////////////////////////////////////////////////////
//  File:pmem_stim.sv
//
//  Description: testbench for the pmem.sv
////////////////////////////////////////////////////////////////////////////////

timeunit 1ns; timeprecision 10ps;

module pmem_stim;

import picoMIPS_package::*;

// Outputs
logic [INST_WIDTH+(2*ADDR_WIDTH)+DATA_WIDTH-1:0] dout;

// Inputs
logic [(1<<PMEM_WIDTH)-1:0] addr;

pmem dut (.*);

initial begin
  addr = {PMEM_WIDTH{1'b0}};
  for(int i=1;i<(1<<PMEM_WIDTH);i++)
    #20 addr = i;
end

endmodule
