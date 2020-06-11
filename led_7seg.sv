////////////////////////////////////////////////////////////////////////////////
//  File: led_7seg.sv
//
//  Description: Decodes the values to their representations on the 7 seg LED.
////////////////////////////////////////////////////////////////////////////////

module led_7seg # (
  parameter DATA_WIDTH = 8
)(
  // Outputs
  LED,

  // Inputs
  val,
  en
);

output logic [6:0] LED;

input logic [DATA_WIDTH-1:0] val;
input logic en;

always_comb begin
  LED = ~7'd0;
  if(~en)
    LED = ~7'd0;
  else
    case(val)
      0:  LED = ~7'b011_1111;
      1:  LED = ~7'b000_0110;
      2:  LED = ~7'b101_1011;
      3:  LED = ~7'b100_1111;
      4:  LED = ~7'b110_0110;
      5:  LED = ~7'b110_1101;
      6:  LED = ~7'b111_1101;
      7:  LED = ~7'b000_0111;
      8:  LED = ~7'b111_1111;
      9:  LED = ~7'b110_1111;
      10: LED = ~7'b111_0111;
      11: LED = ~7'b111_1100;
      12: LED = ~7'b011_1001;
      13: LED = ~7'b101_1110;
      14: LED = ~7'b111_1001;
      15: LED = ~7'b111_0001;
      default: LED = ~7'd0;
    endcase
end

endmodule
