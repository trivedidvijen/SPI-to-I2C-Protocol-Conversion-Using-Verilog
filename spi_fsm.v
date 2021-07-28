`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:19:18 03/19/2018 
// Design Name: 
// Module Name:    spi_fsm 
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
module spi_fsm(
	 input wire clk,
	 input wire reset,
	 input  [7:0]data,
	 input wire start,	
   output reg mosi,
	output reg ss,
	output reg done,
	input  miso
    );
	 
	 
	 reg [2:0]state;
	 reg [7:0]tdata;
	 reg[7:0]rdata;
	 localparam STATE_IDLE=0;
	 localparam STATE_SEND=1;
	 localparam STATE_FINISH=2;
	
	 reg [7:0]count;
	 reg[7:0]countr;
	 
initial begin
	ss<=1;
	//done<=0;
	done<=1;
	tdata <= data;
	count<=8'd7;
	countr<=8'd7;
end
	 
 always@(posedge clk)
 begin
	 if (reset==1)
	  begin 
	   state<=0;
		mosi<=0;
	  end
    
	  else begin
	  case(state)   
	         STATE_IDLE: begin                  //idle state
		      ss<=1;
			  //done<=0;
			  done<=1;
			  tdata<=data;
			  if(start==1)     state<=STATE_SEND; 
			  else state<=STATE_IDLE;
			 end
			 
			 STATE_SEND:begin                 //start state
					 ss<=0; 
					 mosi<=tdata[count];
					 rdata[countr]<=miso;
					 if((count==0) && (countr == 0))
					 begin
						state<=STATE_FINISH;
					 end
					 else 
					 begin
						 count<=count-8'd1;
						 countr<=countr-8'd1;
					 end
			 end
			
			 
			 
			 STATE_FINISH:begin        
				 //done<=1;
				 done<=0;
				 ss<=1;
				 mosi<=0;
			 end
       
	    endcase
   end
end
endmodule
