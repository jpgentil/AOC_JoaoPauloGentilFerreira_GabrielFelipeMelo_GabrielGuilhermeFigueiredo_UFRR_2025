module array_example
  (input  [1:0] addr,
   output [7:0] dout);
  reg [31:0] mem;
  wire [1:0] n3_o;
  wire [7:0] n7_data; // mem_rd
  assign dout = n7_data;
  /* array_ex.vhd:13:10  */
  always @*
    mem = 32'b00000001000000100000010000001000; // (isignal)
  initial
    mem = 32'b00000001000000100000010000001000;
  /* array_ex.vhd:20:15  */
  assign n3_o = 2'b11 - addr;
  /* array_ex.vhd:7:5  */
  reg [7:0] n6[3:0] ; // memory
  initial begin
    n6[3] = 8'b00000001;
    n6[2] = 8'b00000010;
    n6[1] = 8'b00000100;
    n6[0] = 8'b00001000;
    end
  assign n7_data = n6[n3_o];
  /* array_ex.vhd:20:15  */
endmodule

