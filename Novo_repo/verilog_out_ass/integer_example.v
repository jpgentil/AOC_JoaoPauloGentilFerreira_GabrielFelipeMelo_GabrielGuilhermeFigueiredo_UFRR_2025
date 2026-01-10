module integer_example
  (input  clk,
   input  rst,
   output [1:0] counter);
  reg [1:0] c;
  wire [31:0] n5_o;
  wire n7_o;
  wire [31:0] n8_o;
  wire [31:0] n10_o;
  wire [1:0] n11_o;
  wire [1:0] n13_o;
  wire [1:0] n15_o;
  reg [1:0] n18_q;
  assign counter = c;
  /* integer_ex.vhd:13:10  */
  always @*
    c = n18_q; // (isignal)
  initial
    c = 2'b00;
  /* integer_ex.vhd:21:14  */
  assign n5_o = {30'b0, c};  //  uext
  /* integer_ex.vhd:21:14  */
  assign n7_o = n5_o == 32'b00000000000000000000000000000011;
  /* integer_ex.vhd:24:18  */
  assign n8_o = {30'b0, c};  //  uext
  /* integer_ex.vhd:24:18  */
  assign n10_o = n8_o + 32'b00000000000000000000000000000001;
  /* integer_ex.vhd:24:16  */
  assign n11_o = n10_o[1:0];  // trunc
  /* integer_ex.vhd:21:9  */
  assign n13_o = n7_o ? 2'b00 : n11_o;
  /* integer_ex.vhd:18:7  */
  assign n15_o = rst ? 2'b00 : n13_o;
  /* integer_ex.vhd:17:5  */
  always @(posedge clk)
    n18_q <= n15_o;
  initial
    n18_q = 2'b00;
endmodule

