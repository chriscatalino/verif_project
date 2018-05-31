`include "SRAMCELL.v"
module SRAM (Address, InData, OutData, bCE, bWE);

	parameter AddressSize = 18;		// 2^18 = 256K
	parameter WordSize = 8;			// 8 bits
	// Port Declaration
	// ...
	// ...
	// Ports with input/output directions and with given Address and Data Bus Sizes
	input [AddressSize-1:0] Address;
	input [WordSize-1:0] InData;
	output reg [WordSize-1:0] OutData;
	input bCE;
	input bWE;
	// Internal Variable
	// ...
	// Internal Reg Variable to act as memory
	reg [WordSize-1:0] Memory[(2**AddressSize)-1:0];
	
	// Function Read
	always @(bCE or bWE or Address)
	begin
		// ...
		// Case Statements to check the bCE, bWE signal values for Read Operation
		case(bCE)
			1'b0:
			begin
				case(bWE)
					1'b1:
					begin
						OutData <= Memory[Address]; 
					end
				endcase
			end
			1'b1:
			begin
				OutData <= 8'bZZZZZZZZ;
			end
		endcase
	end

	// Function Write
	always @(bCE or bWE or Address or InData)
	begin
		// ...
		// Case Statements to check the bCE, bWE signal values for  Write Operation
		case(bCE)
			1'b0:
			begin
				case(bWE)
					1'b0:
					begin
						Memory[Address] <= InData; 
					end
				endcase
			end
			1'b1:
			begin
				Memory[Address] <= Memory[Address]; 
			end
		endcase
	end

endmodule
