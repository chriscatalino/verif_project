// Module Definition
module Control_Unit (
	Load_XMT_DR,			// Loads Data_Bus into XMT_datareg
	Load_XMT_shftreg,			// Loads XMT_datareg into XMT_shftreg
	start,				// Launches shifting of bits in XMT_shftreg
	shift,				// Shifts bits in XMT_shftreg
	clear,				// Clears bit_count after last bit is sent

	Load_XMT_datareg,			// Asserts Load_XMT_DR in state idle
	Byte_ready,				// Asserts Load_XMT_shftreg in state idle
	T_byte,				// Asserts start signal in state waiting
	BC_lt_BCmax,			// Indicates status of bit counter
	Clock,
	rst_b
	);
	
	// Declare internal parameters (You may use these parameters.)
      parameter       one_hot_count = 3;              // Number of one-hot states
      parameter       state_count = one_hot_count;    // Number of bits in state register
      parameter       size_bit_count = 3;             // Size of the bit counter, e.g., 4
      parameter       idle = 3'b001;                  // one-hot state encoding
      parameter       waiting = 3'b010;
      parameter       sending = 3'b100;
      parameter       all_ones = 9'b1_1111_1111;      // Word + 1 extra bit

      // Declare input/output
      output          Load_XMT_DR;                    // Loads Data_Bus into XMT_datareg
      output          Load_XMT_shftreg;               // Loads XMT_datareg into XMT_shftreg
      output          start;                          // Launches shifting of bits in XMT_shftreg
      output          shift;                          // Shifts bits in XMT_shftreg
      output          clear;                          // Clears bit_count after last bit is sent
	reg		    Load_XMT_DR, Load_XMT_shftreg, start, shift, clear;

      input           Load_XMT_datareg;               // Asserts Load_XMT_DR in state idle
      input           Byte_ready;                     // Asserts Load_XMT_shftreg in state idle
      input           T_byte;                         // Asserts start signal in state waiting
      input           BC_lt_BCmax;                    // Indicates status of bit counter
      input           Clock;
      input           rst_b;

	// Declare internal reg variable
	reg [state_count-1:0]	state, next_state;	// State machine controller

	// Control Unit for UART Transmitter
	always @ (Load_XMT_datareg or Byte_ready or T_byte or BC_lt_BCmax or rst_b)
	begin
		// -----------------------------------
		// Insert your code here
		// -----------------------------------
		case(state)
			idle: 
				begin
					case({Load_XMT_datareg,Byte_ready})
						2'b00: 
							begin
								next_state <= idle;
								Load_XMT_DR <= 1'b0;
								Load_XMT_shftreg <= 1'b0;
								start <= 1'b0;
								shift <= 1'b0;
								clear <= 1'b0;
							end 
						2'b10: 
							begin
								Load_XMT_DR <= 1'b1;
								Load_XMT_shftreg <= 1'b0;
								start <= 1'b0;
								shift <= 1'b0;
								clear <= 1'b0;
								next_state <= idle;
							end
						2'b01:
							begin
								Load_XMT_shftreg <= 1'b1;
								Load_XMT_DR <= 1'b0;
								start <= 1'b0;
								shift <= 1'b0;
								clear <= 1'b0;
								next_state <= waiting;
							end
						2'b11:
							begin
								Load_XMT_shftreg <= 1'b0;
								Load_XMT_DR <= 1'b0;
								start <= 1'b0;
								shift <= 1'b0;
								clear <= 1'b0;
								next_state <= idle;
							end
					endcase
						 
				end
				
			waiting: 
				begin
					case(T_byte)
						1'b0:
							begin
								Load_XMT_DR <= 1'b0;
								Load_XMT_shftreg <= 1'b0;
								start <= 1'b0;
								shift <= 1'b0;
								clear <= 1'b0;
								next_state <= waiting;
							end
						1'b1:
							begin
								Load_XMT_DR <= 1'b0;
								Load_XMT_shftreg <= 1'b0;
								start <= 1'b1;
								shift <= 1'b0;
								clear <= 1'b0;
								next_state <= sending ;
							end
					endcase
				end 
				
			sending: 
				begin
					case(BC_lt_BCmax)
						1'b0:
							begin
								Load_XMT_DR <= 1'b0;
								Load_XMT_shftreg <= 1'b0;
								start <= 1'b0;
								shift <= 1'b0;
								clear <= 1'b1;
								next_state <= idle;
							end
						1'b1:
							begin
								Load_XMT_DR <= 1'b0;
								Load_XMT_shftreg <= 1'b0;
								start <= 1'b0;
								shift <= 1'b1;
								clear <= 1'b0;
								next_state <= sending;
							end
					endcase
				end	
		endcase
	end

	// Sequential Block
	always @ (posedge Clock or negedge rst_b) 
	begin
		if(rst_b == 1'b0)
			state <= idle;
		else
			state <= next_state;
	end
endmodule
		
