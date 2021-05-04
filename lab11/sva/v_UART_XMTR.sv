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
                        Load_XMT_datareg |-> state==idle
);
BYTE_READY_SEQUENCE_A : assume property(@(posedge Clock)
                        Byte_ready |-> state==idle
);
T_BYTE_SEQUENCE_A : assume property(@(posedge Clock)
                        T_byte |-> state==waiting
);
LOAD_BEFORE_READY : assume property(@(posedge Clock)
                  $rose(state == idle) |=> (~Byte_ready throughout Load_XMT_datareg[->1]);
);


// Assertions
LOAD_DATAREG_CHECK_0 : assert property(@(posedge Clock) 
                           (state==idle && Load_XMT_datareg) |->  Load_XMT_DR);
LOAD_DATAREG_CHECK_1 : assert property(@(posedge Clock) 
                            state!=idle  |->  ~Load_XMT_DR);
 // Check if is asserted according to bitcount correctly (low when bitcount == 9)
BCMAX_CHECK_0 : assert property(@(posedge Clock)
               bit_count <= 4'd8 |-> BC_lt_BCmax
);
// BCmax is cleared when clear is asserted
BCMAX_CHECK_1 : assert property(@(posedge Clock)
               clear |-> ~BC_lt_BCmax
);
// Byte_Ready forces assertion of Load_XMT_sfhtreg (at same time)
XMT_SHFTREG_CHECK : assert property(@(posedge Clock)
               (state==idle && Byte_ready) |->  Load_XMT_shftreg
);
// Start should go same time T_byte goes high
START_CHECK_0 : assert property(@(posedge Clock)
               $rose(T_byte) |-> (start throughout shift[->1]) 
);
// Only goes high while in waiting state
START_CEHCK_1 : assert property(@(posedge Clock)
               $rose(start) |-> state==waiting
);
// After start, stays low until after a shift and after a clear
START_CHECK_2 : assert property(@(posedge Clock)
               $fell(start) |-> (~start throughout clear[->1])
);
// Shift should follow until clear
SHIFT_CHECK_0 : assert property(@(posedge Clock)
               $rose(shift) |-> (shift throughout clear[->1])
);
// Only goes high in sending state
SHIFT_CHECK_1 : assert property(@(posedge Clock)
               shift |-> state==sending
);
// Only goes high when BCMax High
SHIFT_CHECK_2 :  assert property(@(posedge Clock)
               shift |-> BC_lt_BCmax
);
// When BCMAX is asserted and after shift is asserted
CLEAR_CHECK_0 : assert property(@(posedge Clock)
               $fell(BC_lt_BCmax) |-> (clear && ~shift)
);
// Only goes high in sending state
CLEAR_CHECK_1 : assert property(@(posedge Clock)
               clear |-> state==sending
);
// Check if matches what was latched from databus
SERIAL_OUT_CHECK : assert property(@(posedge Clock)
               $rose(shift) |-> (~Serial_out) ##1 (Serial_out==databus_save[0]) ##1 (Serial_out==databus_save[1])
                                              ##1 (Serial_out==databus_save[2]) ##1 (Serial_out==databus_save[3])
                                              ##1 (Serial_out==databus_save[4]) ##1 (Serial_out==databus_save[5])
                                              ##1 (Serial_out==databus_save[6]) ##1 (Serial_out==databus_save[7])                                             
);
//RESET_CHECK : // TODO -  need to review documentation


// Coverage


endmodule


