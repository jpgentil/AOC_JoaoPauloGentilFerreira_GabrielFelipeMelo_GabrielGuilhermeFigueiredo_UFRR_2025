module downto_example
  (input  [7:0] a,
   output y);
  wire n1_o;
  assign y = n1_o;
  /* downto_ex.vhd:14:9  */
  assign n1_o = a[7];
endmodule

