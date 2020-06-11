////////////////////////////////////////////////////////////////////////////////
//  File: preg.sv
//
//  Description: This file contains the program registers used by the ALU.
////////////////////////////////////////////////////////////////////////////////

module preg #(
  parameter DATA_WIDTH = 8,
  parameter ADDR_WIDTH = 5
)(
  // Outputs
  Rd_data,
  Rs_data,

  // Inputs
  Rd,
  Rs,
  Rt,
  Wdata,
  ctrl,
  clk
);

output logic [DATA_WIDTH-1:0] Rd_data, Rs_data;

input logic [ADDR_WIDTH-1:0] Rd, Rs, Rt;
input logic [DATA_WIDTH-1:0] Wdata;
input logic [1:0]            ctrl;

input logic clk;

reg [DATA_WIDTH-1:0] register [(1<<ADDR_WIDTH)-1:0];

// register
always_ff @ (posedge clk)
  if (ctrl[0]) // write
    register[Rd] <= Wdata;
  else
    register<= register;

assign Rd_data = ctrl[1] ? register[Rt] : register[Rd];
assign Rs_data = register[Rs];

endmodule
