module UART_XMTR_Props(
	input [7:0] Data_Bus,
	input       Load_XMT_datareg,
	input       T_byte,
	input       Byte_ready,
	input       Clock,
	input       rst_b
);

wire BC_lt_BCmax;
wire Load_XMT_DR;
wire Load_XMT_shftreg;
wire start;
wire shift;
wire clear;
wire Serial_out;

// Instantiatew Sub-Modules to Generate Intermediate Signals for Test
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


// Aux Code for Control Unit FSM
parameter       idle = 3'b001;
parameter       waiting = 3'b010;
parameter       sending = 3'b100;
reg [2:0] state;
reg [2:0] next_state;

always @ (Load_XMT_datareg or Byte_ready or T_byte or BC_lt_BCmax or rst_b or state)
begin
   case (state)
      idle:
         begin
            if(Byte_ready == 1'b1)
               next_state <= waiting;
            else
               next_state <= idle;
         end
      waiting:
         begin
            if(T_byte == 1'b1)
               next_state <= sending;
            else
               next_state <= waiting;
         end
      sending:
         begin
            if(BC_lt_BCmax == 1'b0)
               next_state <= idle;
            else
               next_state <= sending;
         end
   endcase
end
always @ (posedge Clock or negedge rst_b) 
begin
	if(rst_b == 1'b0)
		state <= idle;
	else
		state <= next_state;
end

// Aux Code to Mimic bit_count
reg [3:0] bit_count;
always @ (posedge Clock or negedge rst_b)
begin
	if(rst_b == 1'b0)
		bit_count <= 4'd0;
	else
      if (shift == 1'b1 && clear == 1'b0)
		   bit_count <= bit_count + 1'd1;
      else if (clear == 1'b1)
         bit_count <= 4'd0;
      else
         bit_count <= bit_count;
end

// Aux Code to Latch Databus for later checking
reg [7:0] databus_save;
always @ (posedge Clock or negedge rst_b)
begin
	if(rst_b == 1'b0)
		databus_save <= 8'd0;
	else
      if (Load_XMT_datareg == 1'b1 && state == idle)
         databus_save <= Data_Bus;
      else
         databus_save <= databus_save;
end

// Assumptions
// Make sure proper sequence of input load/ready signals
LOAD_XMT_SEQUENCE_A : assume property(@(posedge Clock)
                        Load_XMT_datareg |-> state==idle;
);
BYTE_READY_SEQUENCE_A : assume property(@(posedge Clock)
                        Byte_ready |-> state==idle;
);
T_BYTE_SEQUENCE_A : assume property(@(posedge Clock)
                        T_byte |-> state==waiting;
);


// Assertions
LOAD_DATAREG_CHECK_0 : assert property(@(Load_XMT_datareg or state or posedge Clock) 
                           (state==idle && Load_XMT_datareg) |->  Load_XMT_DR);
LOAD_DATAREG_CHECK_1 : assert property(@(Load_XMT_datareg or state or posedge Clock) 
                            state!=idle  |->  ~Load_XMT_DR);
 // Check if is asserted according to bitcount correctly (low when bitcount == 9)
BCMAX_CHECK_0 : assert property(@(posedge Clock)
                            bit_count <= 4'd8 |-> BC_lt_BCmax;
);
// BCmax is cleared when clear is asserted
BCMAX_CHECK_1 : assert property(@(posedge Clock)
                  clear |-> ~BC_lt_BCmax;
);
//XMT_SHFTREG_CHECK : // TODO - check that Byte_Ready forces assertion of Load_XMT_sfhtreg (at same time)
//START_CEHCK_0 : // TODO -  start should go same time T_byte goes high
//START_CEHCK_1 : // TODO -  only goes high while in waiting state
//START_CEHCK_2 : // TODO -  after start, stays low until after a shift and after a clear
//SHIFT_CHECK_0 : // TODO - shift should follow until clear
//SHIFT_CHECK_1 : // TODO - only goes high in sending state
//CLEAR_CHECK_0 : // TODO - when BCMAX is asserted and after shift is asserted
//CLEAR_CHECK_1 : // TODO - only goes high in sending state
//SERIAL_OUT_CHECK : // TODO - check if matches what was latched from databus
//RESET_CHECK : // TODO -  need to review documentation


// Coverage


endmodule

