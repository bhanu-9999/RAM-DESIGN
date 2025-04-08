module ram_tb();

   reg clk,rst,wr,rd;
   reg [3:0] add;
   reg [7:0] din;
   wire [7:0] dout;
   
   integer i;
   
   ram dut(clk,rst,wr,rd,add,din,dout);
   
   always
    begin
	 #5
	  clk = ~clk;
	end
   
    task reset();
	 begin
	  @(posedge clk)
	   rst = 1'b1;
	  @(posedge clk)
	   rst = 1'b0;
	 end
	endtask
	
	task write(input [7:0] data_in, input [3:0] address, input wr_in,rd_in);
	 begin
	  @(posedge clk)
	  din = data_in;
	  add = address;
	  wr = wr_in;
	  rd = rd_in;
	 end
	endtask
	
	task read(input [3:0] address, input wr_in,rd_in);
	 begin
	  @(posedge clk)
	  add = address;
	  wr = wr_in;
	  rd = rd_in;
	 end
	endtask
	
	initial 
	 begin
	  clk = 0;
	  reset;
	  for(i=0;i<16;i=i+1)
	   begin
	    write(i,i,1,0);
		#10
		read(i,0,1);
	   end
	 end
	  /*
	  repeat(10)
	  write({$random}%256, {$random}%16,1'b1,1'b0);
	  repeat(10)
	  read({$random}%16, 1'b0,1'b1);
	 end
	 */
	initial
	 $monitor($time, "input rst=%b , wr=%b , rd=%b , add=%b , din=%b , output dout=%b",rst,wr,rd,add,din,dout);
	initial 
	 #400 $finish;
	 
endmodule