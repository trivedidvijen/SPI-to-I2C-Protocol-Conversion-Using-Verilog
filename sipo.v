`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:19:41 03/19/2018 
// Design Name: 
// Module Name:    sipo 
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
module sipo (
                output  reg [7:0] dout ,
                input din ,
                input clk ,
                input ss,
					 output reg siso
					 //output reg ndone
            );

reg [7:0]s;
initial begin
s <= 8'b01111110;
//ndone<=1;
end

always @ (posedge (clk))
begin
     if(ss==0)
      begin
              s[0] <= din;
              s[1] <= s[0];
              s[2] <= s[1];
              s[3] <= s[2];
              s[4] <= s[3];
              s[5] <= s[4];
              s[6] <= s[5];
              s[7] <= s[6];
				  siso <= s[7];
      end
      else if(ss==1)
      begin
            dout = s;
				//ndone<=0;
      end
     else;
end
 
// always@(posedge ss)
// begin
//	 ndone<=0;
// end
 
endmodule

