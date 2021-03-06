////////////////////////////////////////////////////////////////////////////////
//  File: decoder.sv
//
//  Description: This file contains the opcodes for the program and the decoder
//               module to decode the instructions and flag the required
//               signals to carry out the operation.
////////////////////////////////////////////////////////////////////////////////

module decoder # (
  parameter DATA_WIDTH = 8,
  parameter ADDR_WIDTH = 5,
  parameter INST_WIDTH = 6
)(
  // Outputs
  ctrl_flags,
  Rd,
  Rs,
  Rt,

  // Inputs
  SW8,
  bus
);

//`define SIMULATION

import picoMIPS_package::*;

output logic [7:0] ctrl_flags;
output logic [ADDR_WIDTH-1:0] Rd, Rs, Rt;

input logic [INST_WIDTH+(2*ADDR_WIDTH)+DATA_WIDTH-1:0] bus;

input logic SW8;

inst_t inst;

logic inc, imm, treg, write, SW0_7, LED, adding, multi;

/// Instruction
always_comb begin
  // Default values here
  Rd = 5'd0;
  Rs = 5'd0;
  Rt = 5'd0;
  inc = 1'b0;
  imm = 1'b0;
  treg = 1'b0;
  write = 1'b0;
  SW0_7 = 1'b0;
  LED   = 1'b0;
  adding = 1'b0;
  multi = 1'b0;
`ifdef SIMULATION
  $cast(inst, bus[INST_WIDTH+(2*ADDR_WIDTH)+DATA_WIDTH-1:(2*ADDR_WIDTH)+DATA_WIDTH]);
`else
  inst = inst_t'(bus[INST_WIDTH+(2*ADDR_WIDTH)+DATA_WIDTH-1:(2*ADDR_WIDTH)+DATA_WIDTH]);
`endif
  case (inst)
    ADD: begin // 000000
      Rd = bus[ADDR_WIDTH+DATA_WIDTH-1:DATA_WIDTH];
      Rs = bus[(2*ADDR_WIDTH)+DATA_WIDTH-1:ADDR_WIDTH+DATA_WIDTH];
      Rt = bus[ADDR_WIDTH-1:0];
      inc = 1'b1;
      treg = 1'b1;
      write = 1'b1;
      adding = 1'b1;
    end
    ADI: begin // 000001
      Rd = bus[ADDR_WIDTH+DATA_WIDTH-1:DATA_WIDTH];
      Rs = bus[(2*ADDR_WIDTH)+DATA_WIDTH-1:ADDR_WIDTH+DATA_WIDTH];
      inc = 1'b1;
      imm = 1'b1;
      write = 1'b1;
      adding = 1'b1;
    end
    MUL: begin // 000010
      Rd = bus[ADDR_WIDTH+DATA_WIDTH-1:DATA_WIDTH];
      Rs = bus[(2*ADDR_WIDTH)+DATA_WIDTH-1:ADDR_WIDTH+DATA_WIDTH];
      Rt = bus[ADDR_WIDTH-1:0];
      inc = 1'b1;
      treg = 1'b1;
      write = 1'b1;
      multi = 1'b1;
    end
    MLI: begin // 000011
      Rd = bus[ADDR_WIDTH+DATA_WIDTH-1:DATA_WIDTH];
      Rs = bus[(2*ADDR_WIDTH)+DATA_WIDTH-1:ADDR_WIDTH+DATA_WIDTH];
      inc = 1'b1;
      imm = 1'b1;
      write = 1'b1;
      multi = 1'b1;
    end
    NXX:      // 000100
      unique case(bus[(2*ADDR_WIDTH)+DATA_WIDTH-2:(2*ADDR_WIDTH)+DATA_WIDTH-3])
        2'b00, 2'b01: begin
          inc = 1'b1;
        end
        2'b10, 2'b11: begin
          if(SW8 == bus[(2*ADDR_WIDTH)+DATA_WIDTH-3])
            inc = 1'b1;
          else
            inc = 1'b0;
        end
      endcase
    LXX:      // 000101
      unique case(bus[DATA_WIDTH+4:DATA_WIDTH+3])
        2'b00: begin
          Rd = bus[(2*ADDR_WIDTH)+DATA_WIDTH-1:ADDR_WIDTH+DATA_WIDTH];
          inc = 1'b1;
          imm = 1'b1;
          write = 1'b1;
        end
        2'b01: begin
          Rd = bus[(2*ADDR_WIDTH)+DATA_WIDTH-1:ADDR_WIDTH+DATA_WIDTH];
          inc = 1'b1;
          write = 1'b1;
          SW0_7 = 1'b1;
        end
        2'b10, 2'b11: begin
          Rs = bus[(2*ADDR_WIDTH)+DATA_WIDTH-1:ADDR_WIDTH+DATA_WIDTH];
          LED = 1'b1;
          if(SW8 == bus[DATA_WIDTH+3])
            inc = 1'b1;
          else
            inc = 1'b0;
        end
      endcase
    default: begin
      Rd = 5'd0;
      Rs = 5'd0;
      Rt = 5'd0;
      inc = 1'b0;
      imm = 1'b0;
      treg = 1'b0;
      write = 1'b0;
      SW0_7 = 1'b0;
      LED   = 1'b0;
      adding = 1'b0;
      multi = 1'b0;
    end
  endcase
end

assign ctrl_flags = {multi, adding, LED, SW0_7, inc, imm, treg, write};

endmodule
