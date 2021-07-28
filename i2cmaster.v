`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:20:00 03/19/2018 
// Design Name: 
// Module Name:    i2cmaster 
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
module i2cmaster(
    input wire clk,
    input wire reset,
	 input [7:0] in,
    inout  i2c_sda,
    output  i2c_scl
    );
	 
	 reg a;
	 reg i2c_scl2;
	 reg temp;
	 reg direction;
	 reg ack;
	 reg [7:0]state;
	 reg[6:0]addr;
	reg [7:0]data;
	 reg[8:0]count;
	 reg[8:0]countd;
	 localparam STATE_IDLE=0;
	 localparam STATE_START=1;
	 localparam STATE_ADDR=2;
	 localparam STATE_RW=3;
	 localparam STATE_WACK=4;
	 localparam STATE_DATA=5;
    localparam STATE_WACK2=6;	
	 localparam STATE_STOP=7;
	
i2cslave i2cslave1(.i2c_sda(i2c_sda),.i2c_scl(i2c_scl));
//initial begin
//data<=in;
//end

always@(*)
begin
data<=in;
end

assign i2c_sda = direction ? temp : 1'bZ ;
assign i2c_scl=(reset || a)?1'b1:clk;


always@(posedge clk)
begin
	 if (reset==1)
	  begin 
	   direction<=1;
	   state<=0;
		temp<=1;
		addr <=7'b0001000;
		count <= 8'd6;
		countd <= 8'd7;
//		data <= 8'b11101110;
		a<=1;
	  end
    
	  else begin
	     case(state)
	  	     
			 STATE_IDLE: begin                  //idle state
		    direction<=1;
			 temp<=1;
			 a<=1;
			 state<=STATE_START;
			 end
			 
			 STATE_START:begin                   //start state
			 direction<=1;
			 temp<=0;
			 #5 a<=0;
			 state<=STATE_ADDR;
			 end
			 
			 STATE_ADDR:begin                   //address bits
			 a<=0;
			 temp<=addr[count];
			 if(count==0) state<=STATE_RW;
			 else count<=count-8'd1;
          end
			 
			 
			 STATE_RW:begin                   //read/write
			 temp  <= 0;
			 state<= STATE_WACK;
			 end
			 
			 
			 STATE_WACK:begin 			 //COMPLICATED STATE
			 direction<=0;
			 ack<=i2c_sda;
					  if(ack == 0)
					  begin
					     a<=0;
						 state<= STATE_DATA;
					 end
					 else if(ack == 1)
					 begin
					     a<=0;
				        state<= STATE_ADDR;
					 end
					 else 
					 begin
					   a<=1;
					 end
					 
			  end
			 
			
			  
			 STATE_DATA:begin                   //DATA
			 direction<=1;
			 temp<=data[countd];
			 if(countd==0) state<=STATE_WACK2;
			 else countd<=countd-8'd1;
			 end
			 
			 STATE_WACK2:begin
			 state<= STATE_STOP;
			 end
			 
			 
			 
			 STATE_STOP:begin
			 direction<=1;
			 a<=1;
          #5 temp<=1;
			 end

	    endcase
		 
   end
end
endmodule
