module SRAMCELL (InData, OutData, bCS, bWE);
	// Declare input/output signals
	// ...
	output  OutData;
	input InData;
	input bCS; 
	input bWE; 
	// Internal register/wire
	// ...
	reg latch;
	// Functional Module Description
	// Always block with all inputs in its sensitivity list
	assign OutData = (bCS==1'b0)&&(bWE==1'b1)?latch:1'bZ;
	always @(bCS or bWE)	
	begin
		// ...
		// Final logic based on bCS and DLatch
		case(bCS)
			1'b0: 
				case(bWE)
					1'b0: latch <= InData;
					1'b1: latch <= latch;
				endcase
			1'b1: latch <= latch;
		endcase
	end
	
endmodule

