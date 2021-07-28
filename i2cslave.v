`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:21:17 03/19/2018 
// Design Name: 
// Module Name:    i2cslave 
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
module i2cslave(
    inout  i2c_sda,
    input  i2c_scl
    );
	 

	 reg temp;
	 reg direction;
	 reg rw;
	 reg [7:0]state;
	 reg[6:0]addr;
	 reg[6:0]raddr;
	 reg [7:0]rdata;
	 reg [7:0]addrw;
	 reg[7:0]counta;
	 reg[7:0]countd;
	 reg en;
	 reg dis;


    localparam STATE_ADDR=1;
	 localparam STATE_RW=3;
	 localparam STATE_WACK=4;
	 localparam STATE_DATA=5;
	 localparam STATE_WACK2=6;
	 localparam STATE_STOP=7;
	
initial begin
  addr<=7'b0001000;
  direction<=1;
  state<=8'd1;
  counta<=8'd8;
  countd<=8'd7;
end

assign i2c_sda=direction?1'bz:temp; //direction 1 for input and 0 for output

initial begin
temp<=0;
end


always@(negedge i2c_sda)         //start condition
begin
  if(i2c_scl==1)
    begin
	  en<=1;
	 end
  else en<=0;
end

always@(posedge i2c_sda)      //end condition
begin
  if(i2c_scl==1)
    begin
	  dis<=1;
	 end
  else dis<=0;
end

always@(negedge i2c_scl)
begin
   if(en==1)
	 begin
	    case(state)
		    STATE_ADDR:begin                   //address bits
			 direction<=1;
			 raddr[countd]<=i2c_sda;
			 if(countd==0) state<=STATE_RW;
			 else countd<=countd-8'd1;
          end
			 
			 STATE_RW:begin                   //read/write
			 rw  <= i2c_sda;
			 if(raddr == addr) temp<=0;
			 else temp<=1;
			 state<=STATE_WACK; 
			 end
			 
			 STATE_WACK:begin         //acknowledgement 1
           	direction<=0;		
				 if(temp == 0) 
					begin
					 direction<=1;
//					repeat(2)
//					begin			   	
//						 rdata[counta]<=i2c_sda;
//						 counta<=counta-1'd1;
//					 end
					 state<=STATE_DATA;
					end
				 else
					begin
   					 state<=STATE_ADDR;
					end
			  end
			 
			 
			 STATE_DATA:begin                   //DATA
				 if(counta==0)
				 begin
              direction<=1;
				 rdata[counta]<=i2c_sda;
				 state<=STATE_WACK2;
				 end
				 else 
				 rdata[counta]<=i2c_sda;
				 counta<=counta-8'd1;
			 end
			 
			 STATE_WACK2:begin             //acknowledgement 2
			 end
	 
	    endcase
    end
end
//assign out=rdata;
endmodule




