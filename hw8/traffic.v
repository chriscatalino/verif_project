module traffic(light,pedx,clk,rstb);
	// directions of ports
	output reg [1:0] light; 
	
	input pedx;
	input clk;
	input rstb;
	
	// internal signals of the module
	wire [15:0] clk_count;
	wire [1:0] light_color;
	wire change_to_yellow;
	
	// instantiation of the counter 
	counter C01(.clk_count(clk_count),.clk(clk), .clk_count(clk_count), .rstb(rstb), .change_to_yellow(change_to_yellow));
	
	// instantiation of the color_select module
	color_select CS01(.light_color(light_color), .clk_count(clk_count));
	
	// Logic for assigning the traffic light a color
	always@(posedge clk or negedge rstb or light_color)
	begin
		if(rstb == 1'b0)
			light <= 2'b00;
		else
			light <= light_color; 
	end
	
	// Logic for changing the traffic light depending on pedx --> Done asynchronously
	assign change_to_yellow = (pedx) & (clk_count < 120);
	/*always@(posedge pedx)
	begin
		if(clk_count < 120)
		begin
			// Current light is green, then we should change it to yellow
			change_to_yellow <= 1'b1;
		end
	end */
endmodule

module counter(output reg [15:0] clk_count, input change_to_yellow, input clk, input rstb);
	
	always@(negedge clk or negedge rstb or posedge change_to_yellow)
	begin
		if(rstb == 0)
		begin
			clk_count <= 16'b0; 
		end
		
		else
		begin
			if(change_to_yellow == 1'b1)
			begin
				// changes the clk_count so that the light color changes
				clk_count <= 120;
			end
			
			else if(clk_count < 169)
			begin 
				clk_count <= clk_count + 1;
			end
			
			else
			begin
				clk_count <= 16'b0;
			end	
		end
	end
endmodule

module color_select(light_color,clk_count);
	output reg [1:0] light_color;
	input [15:0] clk_count;
	always@(clk_count)
	begin
		if(clk_count < 120)
			begin
				// output the green light
				light_color <= 2'b11;
			end
			
		else if(clk_count < 140)
			begin
				// output the yellow light
				light_color <= 2'b10;
			end
	
		else if(clk_count < 169)
			begin
				// output the red light
				light_color <= 2'b01;
			end
	end
endmodule
