`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:18:58 03/19/2018 
// Design Name: 
// Module Name:    spitoi2c 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module spitoi2c(
input start,
input [7:0]data,
input clk,
input reset,
output i2c_sda,
output i2c_scl
    );
	 
//wire mosi;
wire ss;	
wire din; 
wire done;
wire siso;
wire [7:0]in;
wire i2cmreset;
	 
spi_fsm spi_fsm1(
.clk(clk),
.reset(reset),
.data(data),
.start(start),
.mosi(din),
.ss(ss),
.done(i2cmreset),
.miso(siso)
);

sipo sipo1(
.din(din),
.clk(clk),
.ss(ss),
.dout(in),
.siso(siso)
//.ndone(i2cmreset)
);

i2cmaster i2cmaster1(
.clk(clk),
.reset(i2cmreset),
.in(in),
.i2c_sda(i2c_sda),
.i2c_scl(i2c_scl)
);

//bridge bridge1(
//.mosi(mosi),
//.ss(ss),
//.clk(clk),
//.miso(siso),
//.i2c_sda(i2c_sda),
//.i2c_scl(i2c_scl)
//);

//i2cslave i2cslave1(
//.i2c_sda(i2c_sda),
//.i2c_scl(i2c_scl)
//);

endmodule

