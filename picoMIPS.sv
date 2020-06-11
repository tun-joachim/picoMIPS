////////////////////////////////////////////////////////////////////////////////
//  File: picoMIPS.sv
//
//  Description: This is the top-level module for the picoMIPS.
////////////////////////////////////////////////////////////////////////////////

module picoMIPS # (
  parameter DATA_WIDTH = picoMIPS_package::DATA_WIDTH,
  parameter ADDR_WIDTH = picoMIPS_package::ADDR_WIDTH,
  parameter PMEM_WIDTH = picoMIPS_package::PMEM_WIDTH,
  parameter INST_WIDTH = picoMIPS_package::INST_WIDTH
)(
  // Outputs
  LED,

  // Inputs
  SW,
  clk
);

output logic [6:0] LED;

input logic [9:0] SW;

input logic clk;

logic [INST_WIDTH+(2*ADDR_WIDTH)+DATA_WIDTH-1:0] system_bus;

logic [7:0] ctrl_flags;
logic [ADDR_WIDTH-1:0] Rd, Rs, Rt;
logic [DATA_WIDTH-1:0] Rd_data, Rs_data, result;
logic [PMEM_WIDTH-1:0] addr;

// Control Path
decoder #(DATA_WIDTH, ADDR_WIDTH, INST_WIDTH) decoder_inst(
  // Outputs
  .ctrl_flags(ctrl_flags),
  .Rd(Rd),
  .Rs(Rs),
  .Rt(Rt),

  // Inputs
  .SW8       (SW[8]),
  .bus       (system_bus)
);

pcnt # (PMEM_WIDTH) pcnt_inst(
  // Outputs
  .addr (addr),

  // Inputs
  .inc  (ctrl_flags[3]),
  .clk  (clk),
  .nRst (SW[9])
);

pmem # (DATA_WIDTH, ADDR_WIDTH, PMEM_WIDTH) pmem_inst(
  // Outputs
  .dout (system_bus),

  // Inputs
  .addr (addr)
);

// Data Path
preg #(DATA_WIDTH, ADDR_WIDTH) preg_inst(
  // Outputs
  .Rd_data (Rd_data),
  .Rs_data (Rs_data),

  // Inputs
  .Rd      (Rd),
  .Rs      (Rs),
  .Rt      (Rt),
  .Wdata   (ctrl_flags[4] ? SW[7:0] : result),
  .ctrl    (ctrl_flags[1:0]),
  .clk     (clk)
);

alu #(DATA_WIDTH) alu_inst(
  // Outputs
  .result (result),

  // Inputs
  .A      (Rd_data),
  .B      (ctrl_flags[2] ? system_bus[DATA_WIDTH-1:0] : Rs_data),
  .ctrl   (ctrl_flags[7:5])
);

// Led
led_7seg # (DATA_WIDTH) led_inst (
  // Outputs
  .LED (LED),

  // Inputs
  .val (result),
  .en  (ctrl_flags[5])
);

endmodule
