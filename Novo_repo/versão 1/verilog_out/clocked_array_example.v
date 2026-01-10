module clocked_array_example
  (input  clk,
   input  addr,
   output [3:0] q);
  reg [7:0] r;
  wire n6_o;
  reg [3:0] n14_data; // mem_rd
  assign q = n14_data;
  /* clocked_array_ex.vhd:14:10  */
  always @*
    r = 8'b00010010; // (isignal)
  initial
    r = 8'b00010010;
  /* clocked_array_ex.vhd:19:14  */
  assign n6_o = 1'b1 - addr;
  /* clocked_array_ex.vhd:8:5  */
  reg [3:0] n12[1:0] ; // memory
  initial begin
    n12[1] = 4'b0001;
    n12[0] = 4'b0010;
    end
  always @(posedge clk)
    if (1'b1)
      n14_data <= n12[n6_o];
endmodule

