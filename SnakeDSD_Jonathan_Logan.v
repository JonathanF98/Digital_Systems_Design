`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2020 01:44:42 PM
// Design Name: 
// Module Name: Snake
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Snake(start, CLK, BTNU, BTND, BTNL, BTNR, BTNC, RED, GRN, BLU, HSYNC, VSYNC);
    input start, CLK, BTNU, BTND, BTNL, BTNR, BTNC;
    output HSYNC, VSYNC;
    output reg [3:0] RED, BLU, GRN;
	wire [9:0] xCount; //x pixel
	wire [9:0] yCount; //y pixel
	reg [9:0] appleX;
	reg [8:0] appleY;
	wire [9:0]rand_X;
	wire [8:0]rand_Y;
	wire displayArea; //is it in the active display area?
	wire R;
	wire G;
	wire B;
	wire lethal, nonLethal;
	reg bad_collision, good_collision, game_over;
	reg apple_inX, apple_inY, apple, border, found; //---------------------------------------------------------------Added border
	integer appleCount, count1, count2, count3;
	reg [6:0] size;
	reg [9:0] snakeX[0:127];
	reg [8:0] snakeY[0:127];
	reg [9:0] snakeHeadX;
	reg [9:0] snakeHeadY;
	reg snakeHead;
	reg snakeBody;
	wire speed_Clk;
	integer maxSize = 16;
    
    parameter width = 100000000;
    
    //INSTANTIATIONS
    slow_Clk IN0 (CLK, Buffer_Clk);
    slow_Clk IN1 (Buffer_Clk, VGA_Clk);
    VGA_gen IN2(VGA_Clk, xCount, yCount, displayArea, HSYNC, VSYNC, blank_n);
    randomGen IN3 (VGA_Clk, rand_X, rand_Y);
    gameSpeed IN4 (CLK, speed_Clk);
    
	always @(posedge VGA_Clk)//---------------------------------------------------------------Added border function
	begin
		border <= (((xCount >= 0) && (xCount < 11) || (xCount >= 630) && (xCount < 641)) || ((yCount >= 0) && (yCount < 11) || (yCount >= 470) && (yCount < 481)));
    end
    
	always@(posedge VGA_Clk)
	begin
	appleCount = appleCount+1;
		if(appleCount == 1)
		begin
			appleX <= 20;
			appleY <= 20;
		end
		else
		begin	
			if(good_collision)
			begin
				if((rand_X<10) || (rand_X>630) || (rand_Y<10) || (rand_Y>470))
				begin
					appleX <= 40;
					appleY <= 30;
				end
				else
				begin
					appleX <= rand_X;
					appleY <= rand_Y;
				end
			end
			else if(~start)
			begin
				if((rand_X<10) || (rand_X>630) || (rand_Y<10) || (rand_Y>470))
				begin
					appleX <=340;
					appleY <=430;
				end
				else
				begin
					appleX <= rand_X;
					appleY <= rand_Y;
				end
			end
		end
	end
	
	always @(posedge VGA_Clk)
	begin
		apple_inX <= (xCount > appleX && xCount < (appleX + 10));
		apple_inY <= (yCount > appleY && yCount < (appleY + 10));
		apple = apple_inX && apple_inY;
	end
	
	
	always@(posedge speed_Clk)
	begin
	if(start)
	begin
		for(count1 = 127; count1 > 0; count1 = count1 - 1)
			begin
				if(count1 <= size - 1)
				begin
					snakeX[count1] = snakeX[count1 - 1];
					snakeY[count1] = snakeY[count1 - 1];
				end
			end
		if(BTND)
		      snakeY[0] <= (snakeY[0] + 10);
		else if(BTNL)
		      snakeX[0] <= (snakeX[0] - 10);
		else if(BTNU)
		      snakeY[0] <= (snakeY[0] - 10);
		else if(BTNR)
		      snakeX[0] <= (snakeX[0] + 10);
    end
	else if(~start)
	begin
		for(count3 = 1; count3 < 128; count3 = count3+1)
			begin
			snakeX[count3] = 700;
			snakeY[count3] = 500;
			end
	end
	
	end
	
		
	always@(posedge VGA_Clk)
	begin
		found = 0;
		
		for(count2 = 1; count2 < size; count2 = count2 + 1)
		begin
			if(~found)
			begin				
				snakeBody = ((xCount > snakeX[count2] && xCount < snakeX[count2]+10) && (yCount > snakeY[count2] && yCount < snakeY[count2]+10));
				found = snakeBody;
			end
		end
	end


	
	always@(posedge VGA_Clk)
	begin	
		snakeHead = (xCount > snakeX[0] && xCount < (snakeX[0]+10)) && (yCount > snakeY[0] && yCount < (snakeY[0]+10));
	end
		
	assign lethal = border || snakeBody;
	assign nonLethal = apple;
	always @(posedge VGA_Clk) if(nonLethal && snakeHead) begin good_collision<=1;
																					size = size+1;
																					end
										else if(~start) size = 1;										
										else good_collision=0;
	always @(posedge VGA_Clk) if(lethal && snakeHead) bad_collision<=1;
										else bad_collision=0;
	always @(posedge VGA_Clk) if(bad_collision) game_over<=1;
										else if(~start) game_over=0;
										
	
									
	assign R = (displayArea && (apple || game_over));
	assign G = (displayArea && ((snakeHead||snakeBody) && ~game_over));
	assign B = (displayArea && (border && ~game_over) );//---------------------------------------------------------------Added border
	always@(posedge VGA_Clk)
	begin
		RED = {4{R}};
	    GRN = {4{G}};
		BLU = {4{B}};
	end 

endmodule

////////////////////////////////////////////////////////////////////////////////////

module VGA_gen(VGA_Clk, xCount, yCount, displayArea, VGA_hSync, VGA_vSync, blank_n);
	input VGA_Clk;
	output reg [9:0]xCount, yCount; 
	output reg displayArea;  
	output VGA_hSync, VGA_vSync, blank_n;

	reg p_hSync, p_vSync; 

	always@(posedge VGA_Clk)
	begin
		if(xCount === 793)
			xCount <= 0;
		else
			xCount <= xCount + 1;
	end

	always@(posedge VGA_Clk)
	begin
		if(xCount === 793)
		begin
			if(yCount === 525)
				yCount <= 0;
			else
			yCount <= yCount + 1;
		end
	end
	
	always@(posedge VGA_Clk)
	begin
		displayArea <= ((xCount < 640) && (yCount < 480)); 
	end

	always@(posedge VGA_Clk)
	begin
		p_hSync <= ((xCount >= 655) && (xCount < 747)); 
		p_vSync <= ((yCount >= 490) && (yCount < 492)); 
	end
 
	assign VGA_vSync = ~p_vSync; 
	assign VGA_hSync = ~p_hSync;
	assign blank_n = displayArea;
endmodule

////////////////////////////////////////////////////////////////////////////////////

module randomGen(VGA_Clk, rand_X, rand_Y);
	input VGA_Clk;
	output reg [9:0]rand_X;
	output reg [8:0]rand_Y;
	reg [5:0]pointX, pointY = 10;

	always @(posedge VGA_Clk)
		pointX <= pointX + 3;	
	always @(posedge VGA_Clk)
		pointY <= pointY + 1;
	always @(posedge VGA_Clk)
	begin	
		if(pointX>62)
			rand_X <= 620;
		else if (pointX<2)
			rand_X <= 20;
		else
			rand_X <= (pointX * 10);
	end
	
	always @(posedge VGA_Clk)
	begin	
		if(pointY>46)
			rand_Y <= 460;
		else if (pointY<2)
			rand_Y <= 20;
		else
			rand_Y <= (pointY * 10);
	end
endmodule

////////////////////////////////////////////////////////////////////////////////////

module slow_Clk(master_clk, VGA_clk);

	input master_clk; //50MHz clock
	output reg VGA_clk; //25MHz clock
	reg q;

	always@(posedge master_clk)
	begin
		q <= ~q; 
		VGA_clk <= q;
	end
endmodule

////////////////////////////////////////////////////////////////////////////////////

module gameSpeed(master_clk, speed_Clk);
	input master_clk;
	output reg speed_Clk;
	reg [21:0]count;	

	always@(posedge master_clk)
	begin
		count <= count + 1;
		if(count == 1777777)
		begin
			speed_Clk <= ~speed_Clk;
			count <= 0;
		end	
	end
endmodule