module clocked_example
  (input  clk,
   input  d,
   output q);
  reg n6_q;
  assign q = n6_q;
  /* clock_ex.vhd:16:5  */
  always @(posedge clk)
    n6_q <= d;
endmodule

