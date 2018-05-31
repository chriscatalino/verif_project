// Including files
`include "Control_Unit.v"
`include "Datapath_Unit.v"

// Module Definition
module UART_XMTR(Serial_out, Data_Bus, Load_XMT_datareg, Byte_ready, T_byte, Clock, rst_b);

	// Internal parameter
	parameter word_size = 8;			// size of data, e.g., 8 bits

	// Declare input/output ports
	// ...
	// ...
	output Serial_out;
	input [word_size-1:0] Data_Bus;
	input Load_XMT_datareg;
	input T_byte;
	input Byte_ready;
	input Clock;
	input rst_b;
	// Declare internal wires
	// ...
	// ...
	wire BC_lt_BCmax;
	wire Load_XMT_DR;
	wire Load_XMT_shftreg;
	wire start;
	wire shift;
	wire clear;
	// Connect Sub modules
	// a. Connect Control_Unit
	// ...
	// ...
	Control_Unit CONTROL_UNIT_INST
	(
		.Load_XMT_DR(Load_XMT_DR),
		.Load_XMT_shftreg(Load_XMT_shftreg),
		.start(start),
		.shift(shift),
		.clear(clear),
		.Load_XMT_datareg(Load_XMT_datareg),
		.Byte_ready(Byte_ready),
		.T_byte(T_byte),
		.BC_lt_BCmax(BC_lt_BCmax),
		.Clock(Clock),
		.rst_b(rst_b)
	);
	// b. Connect Datapath_Unit
	// ...
	// ...
	Datapath_Unit DATAPATH_UNIT_INST
	(
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

