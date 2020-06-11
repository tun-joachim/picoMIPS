////////////////////////////////////////////////////////////////////////////////
//  File: alu.sv
//
//  Description: This module handles the addition and multiplication.
////////////////////////////////////////////////////////////////////////////////

module alu # (
  parameter DATA_WIDTH = 8
)(
  // Outputs
  result,

  // Inputs
  A,
  B,
  ctrl
);

output logic signed [DATA_WIDTH-1:0] result;

input logic signed [DATA_WIDTH-1:0] A, B;
input logic [2:0] ctrl;

logic signed [(2*DATA_WIDTH)-1:0] mult;

always_comb begin
  result = B;
  case (ctrl)
    3'b001: result = B;
    3'b010: result = A + B;
    3'b100: result = mult[(2*DATA_WIDTH)-2:DATA_WIDTH-1];
    default: result = B;
  endcase
end

assign mult = A * B;

endmodule
