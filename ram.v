module ram(input clk, rst, wr,rd,
		   input [3:0] add,
		   input [7:0] din,
		   output reg [7:0] dout);
		   
	reg [7:0] mem [0:15];   // Memory declaration: 16 x 8-bit RAM (2^4 = 16 locations, 8 bits each)
	
	always@(posedge clk)
	 begin
	  if(rst)
	   begin 
	    dout <= 0;
	   end
	  else 
	   begin
		if(wr)
	     mem[add] <= din;   //write data
	    else if(rd)
		  dout <= mem[add];  //Read data
	   end
	 end
endmodule 
