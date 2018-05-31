
module SRAMCELL ( InData, OutData, bCS, bWE );
  input InData, bCS, bWE;
  output OutData;
  wire   latch, N5, n2, n3, n4;
  tri   OutData;

  LATCH latch_reg ( .CLK(N5), .D(InData), .Q(latch) );
  TBUFX1 OutData_tri ( .A(n2), .EN(n3), .Y(OutData) );
  NOR2X1 U6 ( .A(bCS), .B(n4), .Y(n3) );
  INVX1 U7 ( .A(bWE), .Y(n4) );
  INVX1 U8 ( .A(latch), .Y(n2) );
  NOR2X1 U9 ( .A(bWE), .B(bCS), .Y(N5) );
endmodule

