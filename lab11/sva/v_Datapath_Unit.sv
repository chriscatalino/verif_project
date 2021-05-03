
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
//// Load_DR eventually followed by Load_shftreg eventually followed by start
//eventually followed by by 8 consecutive shift pulses
property Load_DR_until_clear;
	@(posedge Clock) disable iff (~rst_b) 
		(Load_XMT_DR |=> (!Load_XMT_DR throughout clear[->1]));
endproperty
Load_DR_until_clear_A : assume property(Load_DR_until_clear);

property shift_pulse;
	@(posedge Clock) disable iff (~rst_b) 
		($rose(shift) |=> shift[*7]);
endproperty
shift_pulse_A : assume property(shift_pulse);



// Assertions
// Start Sequence
sequence START_SEQUENCE;
	(Load_XMT_DR ##[1:$] Load_XMT_shftreg ##[1:$] start ##[1:$] shift);
endsequence
//// Assert BC_lt_BCmax when bit_count < word_size+1 (bits are actively being transmitted)
// Aux code first
reg [3:0] bit_count;
always @(posedge Clock)
	if(rst_b==1'b0)
	begin
		bit_count <= 0;
	end
	else
	begin
		case({shift,clear})
			2'b00: begin bit_count <= bit_count; end
			2'b01: begin bit_count <= 0; end
			2'b10: begin bit_count <= bit_count+1;end
			2'b11: begin bit_count <= 0; end
		endcase 		
	end
begin
end
property BC_lt_BCmax_check;
	@(posedge Clock) disable iff (~rst_b) (bit_count <= 4'd8) |-> BC_lt_BCmax;
endproperty
BC_lt_BCmax_check_A : assert property(BC_lt_BCmax_check);


//property ;
//	@(posedge Clock) disable iff (~rst_b)
//endproperty
//_A : assert property();

// Coverage

endmodule

// Bind Wrapper
module Datapath_Unit_Wrapper;

bind Datapath_Unit Datapath_Unit_Props Datapath_Unit_Props_Inst(
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
