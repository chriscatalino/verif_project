// Module Definition
module Datapath_Unit (
	Serial_out,
	BC_lt_BCmax,
	Data_Bus,
	Load_XMT_DR,
	Load_XMT_shftreg,
	start,
	shift,
	clear,
	Clock,
	rst_b);

	// Declare internal parameters
	parameter		word_size = 8;
	parameter		size_bit_count = 3;
	parameter		all_ones = {(word_size + 1){1'b1}};	// 9 bits of ones

	// Declare input/output
	output		Serial_out;
	output		BC_lt_BCmax;

	input [word_size-1:0]	Data_Bus;
	input			Load_XMT_DR;
	input			Load_XMT_shftreg;
	input			start;
	input			shift;
	input			clear;
	input 		Clock;
	input			rst_b;

	// Declare internal reg variable
	reg [word_size-1:0]	XMT_datareg;	// Transmit Data Register
	reg [word_size:0]		XMT_shftreg;	// Transmit Shift Register:{data, start bit}
	reg [size_bit_count:0]	bit_count;		// Counts the bits that are transmitted
	
	assign Serial_out = XMT_shftreg[0];

	// Connect your UDP (User Defined Primitive)
	// Insert your code here.
	
	// UDP logic for comparator
	/*wire lessthan0, lessthan1, lessthan2, lessthan3;
	wire equal0, equal1, equal2, equal3;
	comparator C0(lessthan0,bit_count[0],1'b1);
	comparator C1(lessthan1,bit_count[1],1'b0);
	comparator C2(lessthan2,bit_count[2],1'b0);
	comparator C3(lessthan3,bit_count[3],1'b1);
	comparator_eq CE0(equal0,bit_count[0],1'b1);
	comparator_eq CE1(equal1,bit_count[1],1'b0);
	comparator_eq CE2(equal2,bit_count[2],1'b0);
	comparator_eq CE3(equal3,bit_count[3],1'b1);
	assign BC_lt_BCmax = (lessthan3)|(equal3 & lessthan2)|(equal3 & equal2 & lessthan1)|(equal3 & equal2 & equal1 & lessthan0);*/
	assign BC_lt_BCmax = (bit_count < word_size+1);
	// Data Path for UART Transmitter
	always @(posedge Clock or negedge rst_b)
	begin
		// -----------------------------------
		// Insert your code here.
		// -----------------------------------
		if(rst_b==1'b0)
		begin
			bit_count <= 0;
			XMT_datareg <= 8'bz;
			XMT_shftreg <= 9'b1_1111_1111;
		end
		
		else
		begin
			case(Load_XMT_DR)
				1'b0: begin XMT_datareg <= XMT_datareg; end 
				1'b1: begin XMT_datareg <=  Data_Bus; end
			endcase
		
			case({Load_XMT_shftreg,start,shift})
				3'b000: begin XMT_shftreg <= XMT_shftreg; end 
				3'b100: begin XMT_shftreg <= {XMT_datareg,1'b1}; end
				3'b010: begin XMT_shftreg <= XMT_shftreg & (9'b1_1111_1110); end
				3'b001: begin XMT_shftreg <= {1'b1,XMT_shftreg [word_size:1]}; end
				default: begin XMT_shftreg <= 9'bz; end  
			endcase
		
		
			case({shift,clear})
				2'b00: begin bit_count <= bit_count; end
				2'b01: begin bit_count <= 0; end
				2'b10: begin bit_count <= bit_count+1;end
				2'b11: begin bit_count <= 0; end
			endcase 
			
		end
	end
endmodule

// UDP (User Defined Primitive)
// -----------------------------------
// Insert your UDP here.
// -----------------------------------
/*primitive comparator(less_than,a,b);
	output less_than;
	input a,b;
	table
		//
		0 0 : 0 ; 
		0 1 : 1 ;
		1 0 : 0 ;
		1 1 : 0 ;
	endtable
endprimitive

primitive comparator_eq(equal,a,b);
	output equal;
	input a,b;
	table
		//
		0 0 : 1 ; 
		0 1 : 0 ;
		1 0 : 0 ;
		1 1 : 1 ;
	endtable
endprimitive */
