////////////////////////////////////////////////////////////////////////////////
//  File: pmem.sv
//
//  Description: This module stores the program for the picoMIPS
////////////////////////////////////////////////////////////////////////////////

module pmem #(
  parameter DATA_WIDTH = 8,
  parameter ADDR_WIDTH = 5,
  parameter PMEM_WIDTH = 5,
  parameter INST_WIDTH = 6
)(
  // Outputs
  dout,

  // Inputs
  addr
);

output logic [INST_WIDTH+(2*ADDR_WIDTH)+DATA_WIDTH-1:0] dout;

input logic [PMEM_WIDTH-1:0] addr;

// Program
reg [INST_WIDTH+(2*ADDR_WIDTH)+DATA_WIDTH-1:0] mem [(1<<PMEM_WIDTH)-1:0];

initial // Preload the memory with the hex file
  $readmemh("pmem.mem", mem);

assign dout = mem[addr];

endmodule
