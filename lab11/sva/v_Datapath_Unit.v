
module Datapath_Unit_Props(
   input       Serial_out,
   input       BC_lt_BCmax,
   input [7:0] Data_Bus,
   input       Load_XMT_DR,
   input       Load_XMT_shftreg,
   input       start,
   input       shift,
   input       clear,
   input       Clock,
   input       rst_b
);

// Assumptions

// Assertions
//// Assert BC_lt_BCmax when bit_count < word_size+1 (bits are actively being transmitted)
property 
endproperty
//// Load_XMT_DR implies databus is passed onto XMT_Data_reg
//// Load_XMT_shfreg iplies XMT_datareg is passed into XMT_shfreg
//       - Load_XMT_sftreg |-> XMT_shftreg == {XMT_datareg,1}
//// Start implies the start of tranmission by dropping XMT_shfreg[0] to zero
//// Shift impliies XMT_shfreg to shift by one bit towards LSB and backfill with a stop bit (1)
//       - shift |-> bit_count = bit_count +1
//       - shift |-> XMT_shftreg == {1, XMT_shftreg[8:1]}
//       - probably need aux code to track bit count
//// Clear clears the bit_count
//       - clear |-> bit_cout == 4'd0
//       - clear |-> shift is low
//// Timing Simulation Assertions


// Coverage

endmodule

// Bind Wrapper
module Datapath_Unit_Wrapper;

bind Datapath_Unit_Props(
.Serial_out(Serial_out),
.BC_lt_BCmax(BC_lt_BCmax),
.Data_Bus(Data_Bus),
.Load_XMT_DR(Load_XMT_DR),
.Load_XMT_shftreg(Load_XMT_shftreg),
.start(start),
.shift(shift),
.clear(clear),
.Clock(Clock),
.rst_b(rst_b)
);

endmodule
