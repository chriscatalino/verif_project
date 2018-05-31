
module Control_Unit ( Load_XMT_DR, Load_XMT_shftreg, start, shift, clear, 
        Load_XMT_datareg, Byte_ready, T_byte, BC_lt_BCmax, Clock, rst_b );
  input Load_XMT_datareg, Byte_ready, T_byte, BC_lt_BCmax, Clock, rst_b;
  output Load_XMT_DR, Load_XMT_shftreg, start, shift, clear;
  wire   N29, N30, N31, N32, N33, N34, N35, N37, n4, n20, n21, n22, n23, n24,
         n25, n26, n27, n28, n29, n30, n31, n32, n33, n34;
  wire   [2:0] state;
  wire   [2:0] next_state;

  DFFSR \state_reg[0]  ( .D(next_state[0]), .CLK(Clock), .R(1'b1), .S(rst_b), 
        .Q(state[0]) );
  LATCH shift_reg ( .CLK(N29), .D(N30), .Q(shift) );
  LATCH clear_reg ( .CLK(N29), .D(N31), .Q(clear) );
  LATCH \next_state_reg[2]  ( .CLK(N29), .D(N34), .Q(next_state[2]) );
  DFFSR \state_reg[2]  ( .D(next_state[2]), .CLK(Clock), .R(rst_b), .S(1'b1), 
        .Q(state[2]) );
  LATCH \next_state_reg[1]  ( .CLK(N29), .D(N33), .Q(next_state[1]) );
  DFFSR \state_reg[1]  ( .D(next_state[1]), .CLK(Clock), .R(rst_b), .S(1'b1), 
        .Q(state[1]) );
  LATCH \next_state_reg[0]  ( .CLK(N29), .D(N32), .Q(next_state[0]) );
  LATCH Load_XMT_DR_reg ( .CLK(N29), .D(N35), .Q(Load_XMT_DR) );
  LATCH Load_XMT_shftreg_reg ( .CLK(N29), .D(n4), .Q(Load_XMT_shftreg) );
  LATCH start_reg ( .CLK(N29), .D(N37), .Q(start) );
  INVX1 U6 ( .A(n20), .Y(n4) );
  NOR2X1 U7 ( .A(n21), .B(n22), .Y(N35) );
  NAND2X1 U8 ( .A(n23), .B(n24), .Y(n22) );
  OR2X1 U9 ( .A(N37), .B(N30), .Y(N34) );
  NOR2X1 U10 ( .A(n25), .B(n26), .Y(N37) );
  INVX1 U11 ( .A(T_byte), .Y(n25) );
  OAI21X1 U12 ( .A(T_byte), .B(n26), .C(n20), .Y(N33) );
  NAND3X1 U13 ( .A(n23), .B(n21), .C(Byte_ready), .Y(n20) );
  INVX1 U14 ( .A(Load_XMT_datareg), .Y(n21) );
  NAND2X1 U15 ( .A(n27), .B(n28), .Y(N32) );
  OAI21X1 U16 ( .A(Load_XMT_datareg), .B(n24), .C(n23), .Y(n28) );
  INVX1 U17 ( .A(n29), .Y(n23) );
  INVX1 U18 ( .A(Byte_ready), .Y(n24) );
  INVX1 U19 ( .A(N31), .Y(n27) );
  NOR2X1 U20 ( .A(n30), .B(BC_lt_BCmax), .Y(N31) );
  NOR2X1 U21 ( .A(n31), .B(n30), .Y(N30) );
  INVX1 U22 ( .A(BC_lt_BCmax), .Y(n31) );
  NAND3X1 U23 ( .A(n26), .B(n30), .C(n29), .Y(N29) );
  NAND3X1 U24 ( .A(n32), .B(n33), .C(state[0]), .Y(n29) );
  NAND3X1 U25 ( .A(n34), .B(n32), .C(state[2]), .Y(n30) );
  INVX1 U26 ( .A(state[1]), .Y(n32) );
  NAND3X1 U27 ( .A(n34), .B(n33), .C(state[1]), .Y(n26) );
  INVX1 U28 ( .A(state[2]), .Y(n33) );
  INVX1 U29 ( .A(state[0]), .Y(n34) );
endmodule


module Datapath_Unit ( Serial_out, BC_lt_BCmax, Data_Bus, Load_XMT_DR, 
        Load_XMT_shftreg, start, shift, clear, Clock, rst_b );
  input [7:0] Data_Bus;
  input Load_XMT_DR, Load_XMT_shftreg, start, shift, clear, Clock, rst_b;
  output Serial_out, BC_lt_BCmax;
  wire   N55, N56, N57, N58, N59, N60, N61, N62, N63, N81, N82, N84, N85, N87,
         N88, N90, N91, N93, N94, N96, N97, N99, N100, N102, N103, N105, N106,
         N108, N109, N111, N112, N114, N115, N117, N118, N120, N121, N123,
         N124, N126, N127, N129, N130, n127, n128, n130, n2, n3, n5, n6, n8,
         n9, n11, n12, n14, n15, n17, n18, n20, n21, n23, n24, n26, n27, n29,
         n30, n32, n33, n35, n36, n38, n39, n41, n42, n44, n45, n47, n48, n49,
         n50, n58, n96, n129, n131, n132, n133, n134, n135, n136, n137, n51,
         n52, n53, n54, n55, n56, n57, n59, n60, n61, n62, n63, n64, n65, n66,
         n67, n68, n69, n70, n71, n72, n73, n74, n75, n76, n77, n78, n79, n80,
         n81, n82, n83, n84, n85, n86, n87, n88, n89, n90, n91, n92, n93, n94,
         n95, n138, n139, n140, n141, n142;
  wire   [3:0] bit_count;
  tri   Serial_out;
  tri   [8:1] XMT_shftreg;
  tri   [7:0] XMT_datareg;

  DFFSR \XMT_datareg_tri_enable_reg[7]  ( .D(1'b0), .CLK(Clock), .R(1'b1), .S(
        rst_b), .Q(N82) );
  DFFPOSX1 \XMT_datareg_reg[7]  ( .D(n96), .CLK(Clock), .Q(N81) );
  DFFSR \XMT_datareg_tri_enable_reg[6]  ( .D(1'b0), .CLK(Clock), .R(1'b1), .S(
        rst_b), .Q(N85) );
  DFFPOSX1 \XMT_datareg_reg[6]  ( .D(n129), .CLK(Clock), .Q(N84) );
  DFFSR \XMT_datareg_tri_enable_reg[5]  ( .D(1'b0), .CLK(Clock), .R(1'b1), .S(
        rst_b), .Q(N88) );
  DFFPOSX1 \XMT_datareg_reg[5]  ( .D(n131), .CLK(Clock), .Q(N87) );
  DFFSR \XMT_datareg_tri_enable_reg[4]  ( .D(1'b0), .CLK(Clock), .R(1'b1), .S(
        rst_b), .Q(N91) );
  DFFPOSX1 \XMT_datareg_reg[4]  ( .D(n132), .CLK(Clock), .Q(N90) );
  DFFSR \XMT_datareg_tri_enable_reg[3]  ( .D(1'b0), .CLK(Clock), .R(1'b1), .S(
        rst_b), .Q(N94) );
  DFFPOSX1 \XMT_datareg_reg[3]  ( .D(n133), .CLK(Clock), .Q(N93) );
  DFFSR \XMT_datareg_tri_enable_reg[2]  ( .D(1'b0), .CLK(Clock), .R(1'b1), .S(
        rst_b), .Q(N97) );
  DFFPOSX1 \XMT_datareg_reg[2]  ( .D(n134), .CLK(Clock), .Q(N96) );
  DFFSR \XMT_datareg_tri_enable_reg[1]  ( .D(1'b0), .CLK(Clock), .R(1'b1), .S(
        rst_b), .Q(N100) );
  DFFPOSX1 \XMT_datareg_reg[1]  ( .D(n135), .CLK(Clock), .Q(N99) );
  DFFSR \XMT_datareg_tri_enable_reg[0]  ( .D(1'b0), .CLK(Clock), .R(1'b1), .S(
        rst_b), .Q(N103) );
  DFFPOSX1 \XMT_datareg_reg[0]  ( .D(n136), .CLK(Clock), .Q(N102) );
  DFFSR \XMT_shftreg_tri_enable_reg[8]  ( .D(n58), .CLK(Clock), .R(rst_b), .S(
        1'b1), .Q(N106) );
  DFFSR \XMT_shftreg_reg[8]  ( .D(N63), .CLK(Clock), .R(1'b1), .S(rst_b), .Q(
        N105) );
  DFFSR \XMT_shftreg_tri_enable_reg[7]  ( .D(n58), .CLK(Clock), .R(rst_b), .S(
        1'b1), .Q(N109) );
  DFFSR \XMT_shftreg_reg[7]  ( .D(N62), .CLK(Clock), .R(1'b1), .S(rst_b), .Q(
        N108) );
  DFFSR \XMT_shftreg_tri_enable_reg[6]  ( .D(n58), .CLK(Clock), .R(rst_b), .S(
        1'b1), .Q(N112) );
  DFFSR \XMT_shftreg_reg[6]  ( .D(N61), .CLK(Clock), .R(1'b1), .S(rst_b), .Q(
        N111) );
  DFFSR \XMT_shftreg_tri_enable_reg[5]  ( .D(n58), .CLK(Clock), .R(rst_b), .S(
        1'b1), .Q(N115) );
  DFFSR \XMT_shftreg_reg[5]  ( .D(N60), .CLK(Clock), .R(1'b1), .S(rst_b), .Q(
        N114) );
  DFFSR \XMT_shftreg_tri_enable_reg[4]  ( .D(n58), .CLK(Clock), .R(rst_b), .S(
        1'b1), .Q(N118) );
  DFFSR \XMT_shftreg_reg[4]  ( .D(N59), .CLK(Clock), .R(1'b1), .S(rst_b), .Q(
        N117) );
  DFFSR \XMT_shftreg_tri_enable_reg[3]  ( .D(n58), .CLK(Clock), .R(rst_b), .S(
        1'b1), .Q(N121) );
  DFFSR \XMT_shftreg_reg[3]  ( .D(N58), .CLK(Clock), .R(1'b1), .S(rst_b), .Q(
        N120) );
  DFFSR \XMT_shftreg_tri_enable_reg[2]  ( .D(n58), .CLK(Clock), .R(rst_b), .S(
        1'b1), .Q(N124) );
  DFFSR \XMT_shftreg_reg[2]  ( .D(N57), .CLK(Clock), .R(1'b1), .S(rst_b), .Q(
        N123) );
  DFFSR \XMT_shftreg_tri_enable_reg[1]  ( .D(n58), .CLK(Clock), .R(rst_b), .S(
        1'b1), .Q(N127) );
  DFFSR \XMT_shftreg_reg[1]  ( .D(N56), .CLK(Clock), .R(1'b1), .S(rst_b), .Q(
        N126) );
  DFFSR \XMT_shftreg_tri_enable_reg[0]  ( .D(n58), .CLK(Clock), .R(rst_b), .S(
        1'b1), .Q(N130) );
  DFFSR \XMT_shftreg_reg[0]  ( .D(N55), .CLK(Clock), .R(1'b1), .S(rst_b), .Q(
        N129) );
  DFFSR \bit_count_reg[0]  ( .D(n130), .CLK(Clock), .R(rst_b), .S(1'b1), .Q(
        bit_count[0]) );
  DFFSR \bit_count_reg[1]  ( .D(n127), .CLK(Clock), .R(rst_b), .S(1'b1), .Q(
        bit_count[1]) );
  DFFSR \bit_count_reg[2]  ( .D(n137), .CLK(Clock), .R(rst_b), .S(1'b1), .Q(
        bit_count[2]) );
  DFFSR \bit_count_reg[3]  ( .D(n128), .CLK(Clock), .R(rst_b), .S(1'b1), .Q(
        bit_count[3]) );
  TBUFX1 \XMT_shftreg_tri[0]  ( .A(n50), .EN(n49), .Y(Serial_out) );
  TBUFX1 \XMT_shftreg_tri[1]  ( .A(n48), .EN(n47), .Y(XMT_shftreg[1]) );
  TBUFX1 \XMT_shftreg_tri[2]  ( .A(n45), .EN(n44), .Y(XMT_shftreg[2]) );
  TBUFX1 \XMT_shftreg_tri[3]  ( .A(n42), .EN(n41), .Y(XMT_shftreg[3]) );
  TBUFX1 \XMT_shftreg_tri[4]  ( .A(n39), .EN(n38), .Y(XMT_shftreg[4]) );
  TBUFX1 \XMT_shftreg_tri[5]  ( .A(n36), .EN(n35), .Y(XMT_shftreg[5]) );
  TBUFX1 \XMT_shftreg_tri[6]  ( .A(n33), .EN(n32), .Y(XMT_shftreg[6]) );
  TBUFX1 \XMT_shftreg_tri[7]  ( .A(n30), .EN(n29), .Y(XMT_shftreg[7]) );
  TBUFX1 \XMT_shftreg_tri[8]  ( .A(n27), .EN(n26), .Y(XMT_shftreg[8]) );
  TBUFX1 \XMT_datareg_tri[0]  ( .A(n24), .EN(n23), .Y(XMT_datareg[0]) );
  TBUFX1 \XMT_datareg_tri[1]  ( .A(n21), .EN(n20), .Y(XMT_datareg[1]) );
  TBUFX1 \XMT_datareg_tri[2]  ( .A(n18), .EN(n17), .Y(XMT_datareg[2]) );
  TBUFX1 \XMT_datareg_tri[3]  ( .A(n15), .EN(n14), .Y(XMT_datareg[3]) );
  TBUFX1 \XMT_datareg_tri[4]  ( .A(n12), .EN(n11), .Y(XMT_datareg[4]) );
  TBUFX1 \XMT_datareg_tri[5]  ( .A(n9), .EN(n8), .Y(XMT_datareg[5]) );
  TBUFX1 \XMT_datareg_tri[6]  ( .A(n6), .EN(n5), .Y(XMT_datareg[6]) );
  TBUFX1 \XMT_datareg_tri[7]  ( .A(n3), .EN(n2), .Y(XMT_datareg[7]) );
  INVX1 U3 ( .A(n51), .Y(n96) );
  MUX2X1 U4 ( .B(XMT_datareg[7]), .A(Data_Bus[7]), .S(Load_XMT_DR), .Y(n51) );
  INVX1 U5 ( .A(N87), .Y(n9) );
  INVX1 U6 ( .A(N88), .Y(n8) );
  INVX1 U7 ( .A(N84), .Y(n6) );
  OAI22X1 U8 ( .A(n52), .B(n53), .C(n54), .D(n55), .Y(n58) );
  INVX1 U9 ( .A(N129), .Y(n50) );
  INVX1 U10 ( .A(N85), .Y(n5) );
  INVX1 U11 ( .A(N130), .Y(n49) );
  INVX1 U12 ( .A(N126), .Y(n48) );
  INVX1 U13 ( .A(N127), .Y(n47) );
  INVX1 U14 ( .A(N123), .Y(n45) );
  INVX1 U15 ( .A(N124), .Y(n44) );
  INVX1 U16 ( .A(N120), .Y(n42) );
  INVX1 U17 ( .A(N121), .Y(n41) );
  INVX1 U18 ( .A(N117), .Y(n39) );
  INVX1 U19 ( .A(N118), .Y(n38) );
  INVX1 U20 ( .A(N114), .Y(n36) );
  INVX1 U21 ( .A(N115), .Y(n35) );
  INVX1 U22 ( .A(N111), .Y(n33) );
  INVX1 U23 ( .A(N112), .Y(n32) );
  INVX1 U24 ( .A(N108), .Y(n30) );
  INVX1 U25 ( .A(N81), .Y(n3) );
  INVX1 U26 ( .A(N109), .Y(n29) );
  INVX1 U27 ( .A(N105), .Y(n27) );
  INVX1 U28 ( .A(N106), .Y(n26) );
  INVX1 U29 ( .A(N102), .Y(n24) );
  INVX1 U30 ( .A(N103), .Y(n23) );
  INVX1 U31 ( .A(N99), .Y(n21) );
  INVX1 U32 ( .A(N100), .Y(n20) );
  INVX1 U33 ( .A(N82), .Y(n2) );
  INVX1 U34 ( .A(N96), .Y(n18) );
  INVX1 U35 ( .A(N97), .Y(n17) );
  INVX1 U36 ( .A(N93), .Y(n15) );
  INVX1 U37 ( .A(N94), .Y(n14) );
  INVX1 U38 ( .A(n56), .Y(n137) );
  MUX2X1 U39 ( .B(n57), .A(n59), .S(bit_count[2]), .Y(n56) );
  INVX1 U40 ( .A(n60), .Y(n136) );
  MUX2X1 U41 ( .B(XMT_datareg[0]), .A(Data_Bus[0]), .S(Load_XMT_DR), .Y(n60)
         );
  INVX1 U42 ( .A(n61), .Y(n135) );
  MUX2X1 U43 ( .B(XMT_datareg[1]), .A(Data_Bus[1]), .S(Load_XMT_DR), .Y(n61)
         );
  INVX1 U44 ( .A(n62), .Y(n134) );
  MUX2X1 U45 ( .B(XMT_datareg[2]), .A(Data_Bus[2]), .S(Load_XMT_DR), .Y(n62)
         );
  INVX1 U46 ( .A(n63), .Y(n133) );
  MUX2X1 U47 ( .B(XMT_datareg[3]), .A(Data_Bus[3]), .S(Load_XMT_DR), .Y(n63)
         );
  INVX1 U48 ( .A(n64), .Y(n132) );
  MUX2X1 U49 ( .B(XMT_datareg[4]), .A(Data_Bus[4]), .S(Load_XMT_DR), .Y(n64)
         );
  INVX1 U50 ( .A(n65), .Y(n131) );
  MUX2X1 U51 ( .B(XMT_datareg[5]), .A(Data_Bus[5]), .S(Load_XMT_DR), .Y(n65)
         );
  MUX2X1 U52 ( .B(n66), .A(n67), .S(bit_count[0]), .Y(n130) );
  OR2X1 U53 ( .A(clear), .B(shift), .Y(n67) );
  INVX1 U54 ( .A(n68), .Y(n129) );
  MUX2X1 U55 ( .B(XMT_datareg[6]), .A(Data_Bus[6]), .S(Load_XMT_DR), .Y(n68)
         );
  MUX2X1 U56 ( .B(n69), .A(n70), .S(bit_count[3]), .Y(n128) );
  AOI21X1 U57 ( .A(n71), .B(n72), .C(n59), .Y(n70) );
  OAI21X1 U58 ( .A(bit_count[1]), .B(n66), .C(n73), .Y(n59) );
  INVX1 U59 ( .A(bit_count[2]), .Y(n72) );
  NAND2X1 U60 ( .A(n57), .B(bit_count[2]), .Y(n69) );
  INVX1 U61 ( .A(n74), .Y(n57) );
  NAND3X1 U62 ( .A(bit_count[0]), .B(n71), .C(bit_count[1]), .Y(n74) );
  MUX2X1 U63 ( .B(n75), .A(n73), .S(bit_count[1]), .Y(n127) );
  INVX1 U64 ( .A(n76), .Y(n73) );
  OAI22X1 U65 ( .A(shift), .B(clear), .C(bit_count[0]), .D(n66), .Y(n76) );
  INVX1 U66 ( .A(n71), .Y(n66) );
  NAND2X1 U67 ( .A(bit_count[0]), .B(n71), .Y(n75) );
  NOR2X1 U68 ( .A(n53), .B(clear), .Y(n71) );
  INVX1 U69 ( .A(N90), .Y(n12) );
  INVX1 U70 ( .A(N91), .Y(n11) );
  OAI21X1 U71 ( .A(n77), .B(n78), .C(n79), .Y(N63) );
  AOI21X1 U72 ( .A(n80), .B(XMT_datareg[7]), .C(n81), .Y(n79) );
  INVX1 U73 ( .A(n82), .Y(n81) );
  OAI21X1 U74 ( .A(n78), .B(n82), .C(n83), .Y(N62) );
  AOI22X1 U75 ( .A(n80), .B(XMT_datareg[6]), .C(XMT_shftreg[7]), .D(n54), .Y(
        n83) );
  INVX1 U76 ( .A(XMT_shftreg[8]), .Y(n78) );
  OAI21X1 U77 ( .A(n84), .B(n82), .C(n85), .Y(N61) );
  AOI22X1 U78 ( .A(n80), .B(XMT_datareg[5]), .C(XMT_shftreg[6]), .D(n54), .Y(
        n85) );
  INVX1 U79 ( .A(XMT_shftreg[7]), .Y(n84) );
  OAI21X1 U80 ( .A(n82), .B(n86), .C(n87), .Y(N60) );
  AOI22X1 U81 ( .A(n80), .B(XMT_datareg[4]), .C(XMT_shftreg[5]), .D(n54), .Y(
        n87) );
  INVX1 U82 ( .A(XMT_shftreg[6]), .Y(n86) );
  OAI21X1 U83 ( .A(n82), .B(n88), .C(n89), .Y(N59) );
  AOI22X1 U84 ( .A(n80), .B(XMT_datareg[3]), .C(XMT_shftreg[4]), .D(n54), .Y(
        n89) );
  INVX1 U85 ( .A(XMT_shftreg[5]), .Y(n88) );
  OAI21X1 U86 ( .A(n82), .B(n90), .C(n91), .Y(N58) );
  AOI22X1 U87 ( .A(n80), .B(XMT_datareg[2]), .C(XMT_shftreg[3]), .D(n54), .Y(
        n91) );
  INVX1 U88 ( .A(XMT_shftreg[4]), .Y(n90) );
  OAI21X1 U89 ( .A(n82), .B(n92), .C(n93), .Y(N57) );
  AOI22X1 U90 ( .A(n80), .B(XMT_datareg[1]), .C(XMT_shftreg[2]), .D(n54), .Y(
        n93) );
  INVX1 U91 ( .A(XMT_shftreg[3]), .Y(n92) );
  OAI21X1 U92 ( .A(n82), .B(n94), .C(n95), .Y(N56) );
  AOI22X1 U93 ( .A(n80), .B(XMT_datareg[0]), .C(XMT_shftreg[1]), .D(n54), .Y(
        n95) );
  INVX1 U94 ( .A(n77), .Y(n54) );
  INVX1 U95 ( .A(XMT_shftreg[2]), .Y(n94) );
  OAI21X1 U96 ( .A(n82), .B(n138), .C(n139), .Y(N55) );
  AOI21X1 U97 ( .A(n140), .B(Serial_out), .C(n80), .Y(n139) );
  INVX1 U98 ( .A(n141), .Y(n80) );
  NAND3X1 U99 ( .A(n53), .B(n55), .C(Load_XMT_shftreg), .Y(n141) );
  NOR2X1 U100 ( .A(start), .B(n77), .Y(n140) );
  NAND2X1 U101 ( .A(n53), .B(n52), .Y(n77) );
  INVX1 U102 ( .A(shift), .Y(n53) );
  INVX1 U103 ( .A(XMT_shftreg[1]), .Y(n138) );
  NAND3X1 U104 ( .A(n52), .B(n55), .C(shift), .Y(n82) );
  INVX1 U105 ( .A(start), .Y(n55) );
  INVX1 U106 ( .A(Load_XMT_shftreg), .Y(n52) );
  OAI21X1 U107 ( .A(bit_count[0]), .B(n142), .C(bit_count[3]), .Y(BC_lt_BCmax)
         );
  OR2X1 U108 ( .A(bit_count[1]), .B(bit_count[2]), .Y(n142) );
endmodule


module UART_XMTR ( Serial_out, Data_Bus, Load_XMT_datareg, Byte_ready, T_byte, 
        Clock, rst_b );
  input [7:0] Data_Bus;
  input Load_XMT_datareg, Byte_ready, T_byte, Clock, rst_b;
  output Serial_out;
  wire   Load_XMT_DR, Load_XMT_shftreg, start, shift, clear, BC_lt_BCmax;
  tri   Serial_out;

  Control_Unit CONTROL_UNIT_INST ( .Load_XMT_DR(Load_XMT_DR), 
        .Load_XMT_shftreg(Load_XMT_shftreg), .start(start), .shift(shift), 
        .clear(clear), .Load_XMT_datareg(Load_XMT_datareg), .Byte_ready(
        Byte_ready), .T_byte(T_byte), .BC_lt_BCmax(BC_lt_BCmax), .Clock(Clock), 
        .rst_b(rst_b) );
  Datapath_Unit DATAPATH_UNIT_INST ( .Serial_out(Serial_out), .BC_lt_BCmax(
        BC_lt_BCmax), .Data_Bus(Data_Bus), .Load_XMT_DR(Load_XMT_DR), 
        .Load_XMT_shftreg(Load_XMT_shftreg), .start(start), .shift(shift), 
        .clear(clear), .Clock(Clock), .rst_b(rst_b) );
endmodule

