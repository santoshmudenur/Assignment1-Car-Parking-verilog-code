`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:09:50 03/25/2022 
// Design Name: 
// Module Name:    s_carpark 
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
`timescale 1ns / 1ps

module Car_Parking(clk,reset,entrance_sen,exit_sen,password,result);
input clk,reset,entrance_sen,exit_sen;
input[2:0] password;
output [3:0]result;
reg[3:0] result;
parameter idle=3'b000,check=3'b001,opengate=3'b010,closegate=3'b011;
reg[2:0]current_state,next_state;


//NEXT STATE
always@(posedge clk or posedge reset)
begin
if(reset)
current_state=idle;
else
current_state=next_state;
end

//CHANGE STATE
always@(*)
begin
case(current_state)
idle:begin
     if(entrance_sen==1)
	  next_state=check;
	  else
	  next_state=idle;
	  end
check:begin
               if(password==3'b111)
					next_state=opengate;
					else
					next_state=check;
					end
opengate:begin
               if(exit_sen==1)
               next_state=closegate;
					else
					next_state=opengate;
			      end
closegate:begin
     if(entrance_sen==1 && exit_sen==0)
	  next_state=check;
	  else if(exit_sen==0 && entrance_sen==0)
	  next_state=idle;
	  else 
	  next_state=closegate;
	  end
default:next_state=idle;
endcase
end

//OUTPUT
always@(posedge clk)
begin
case(current_state)
idle:begin
   result=4'b0000;
	end
check:begin
               result=4'b0001;
					end
opengate:begin
     result=4'b0010;
	  end
closegate:begin
     result=4'b0011;
	  end
endcase
end
endmodule
