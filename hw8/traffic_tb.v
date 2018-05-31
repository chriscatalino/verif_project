`include "traffic.v"
module traffic_tb;
	// Register for Module inputs
	reg clk;
	reg rstb;
	reg pedx;
	
	// Wire for Module outputs
	wire [1:0] light;
	
	// instantiation for the traffic module
	traffic DUT(.light(light),.pedx(pedx), .clk(clk), .rstb(rstb));
	
	// initial block to generate the clock
	initial
	begin
		clk = 1'b0;
		forever 
		begin 
			#5; clk = ~clk;
		end
	end 
	
	// initial block to generate the pedx signal
	initial 
	begin
		pedx = 1'b0;
		#147; pedx = 1'b1;
		#45; pedx = 1'b0;
		#13; pedx = 1'b1;
		#7; pedx = 1'b0; 
	end
	// initial block for rstb signal
	initial
	begin 
		rstb = 0;
		#2; rstb = 1;
	end 
	
	// initial block to terminate the simulation
	initial
	begin
		#2000; $finish;
	end 
	
	// initial block for the wavedump
	initial
	begin
		$dumpfile ("wave.dump");
		$dumpvars (0, traffic_tb);
	end
	
	// initial block to monitor statements
	initial
	begin
		$monitor(" Traffic Light is %h, pedex is %b at time %d ",light,pedx,$time);
	end
endmodule
