////////////////////////////////////////////////////////////////////////////////
//  File: picoMIPS_package.sv
//
//  Description: This file contains commonly used type definition or global
//               parameter declaration. All changes such as data width should
//               be made here.
////////////////////////////////////////////////////////////////////////////////

package picoMIPS_package;

  // Global parameters.
parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 5;
parameter PMEM_WIDTH = 5;
parameter INST_WIDTH = 6;

typedef enum logic [INST_WIDTH-1:0] {
  ADD,      //  0000 00ss sssd dddd xxxt tttt
            //  Add values of register 's' and register 't' and store to
            //  register 'd'
  ADI,      //  0000 01ss sssd dddd iiii iiii
            //  Add value of 'i' and register 's' and store at register 'd'
  MUL,      //  0000 10ss sssd dddd xxxt tttt
            //  Multiply values of register 's' and register 't' and store
            //  to register 'd'
  MLI,      //  0000 11ss sssd dddd iiii iiii
            //  Multiply value of 'i' and register 's' and store to register 'd'
  NXX,      //  0001 00ta xxxx xxxx xxxx xxxx
            //    NOP     0001 0000 xxxx xxxx xxxx xxxx
            //            No Operation.
            //    NSW     0001 0001 axxx xxxx xxxx xxxx
            //            No Operation until SW8 is 'a'.
  LXX       //  0001 01ss ssst txxx iiii iiii
            //    LDI     0001 01dd ddd0 0xxx iiii iiii
            //            Load the value 'i' to register 'd'
            //    LDS     0001 01dd ddd0 1xxx xxxx xxxx
            //            Load the switch value to register 'd'
            //    LED     0001 01ss sss1 txxx xxxx xxxx
            //            Display value of register 's' on LED and wait for SW8
            //            to be 't'.
} inst_t;

endpackage