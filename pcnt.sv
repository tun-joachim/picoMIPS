////////////////////////////////////////////////////////////////////////////////
//  File: pcnt.sv
//
//  Description: The program counter of the picoMIPS
////////////////////////////////////////////////////////////////////////////////

module pcnt # (
  parameter PMEM_WIDTH = 5
)(
  // Outputs
  addr,

  // Inputs
  inc,
  clk,
  nRst
);

output logic [PMEM_WIDTH-1:0] addr;

input logic inc, clk, nRst;

reg [PMEM_WIDTH-1:0] pc;

always_ff @ (posedge clk or negedge nRst)
if (!nRst)
  pc <= {PMEM_WIDTH{1'b0}};
else
  if (inc)
    pc <= pc + {{PMEM_WIDTH-1{1'b0}}, 1'b1};
  else
    pc <= pc;

assign addr = pc;

endmodule
