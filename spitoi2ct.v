`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:46:48 03/19/2018
// Design Name:   spitoi2c
// Module Name:   C:/Users/bat/Desktop/spi to i2c 2/spitoi2c/spitoi2ct.v
// Project Name:  spitoi2c
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: spitoi2c
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module spitoi2ct;

	// Inputs
	reg start;
	reg [7:0] data;
	reg clk;
	reg reset;

	// Outputs
	wire i2c_sda;
	wire i2c_scl;

	// Instantiate the Unit Under Test (UUT)
	spitoi2c uut (
		.start(start), 
		.data(data), 
		.clk(clk), 
		.reset(reset), 
		.i2c_sda(i2c_sda), 
		.i2c_scl(i2c_scl)
	);

	initial begin
		// Initialize Inputs
		start = 0;
		data = 8'b10101010;
		clk = 0;
		reset = 1;

		forever #10 clk=~clk;
		end
        
		// Add stimulus here
		initial begin
		#90
		data = 8'b10101010;
		reset=0;
		start=1;
	end
      
endmodule

