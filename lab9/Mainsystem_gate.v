/*
module SRAM ( InData, OutData, Address, bCE, bWE );
  input [7:0] InData;
  output [7:0] OutData;
  input [17:0] Address;
  input bCE, bWE;
  wire   N0;

  LATCH \OutData_reg[7]  ( .CLK(N0), .D(InData[7]), .Q(OutData[7]) );
  LATCH \OutData_reg[6]  ( .CLK(N0), .D(InData[6]), .Q(OutData[6]) );
  LATCH \OutData_reg[5]  ( .CLK(N0), .D(InData[5]), .Q(OutData[5]) );
  LATCH \OutData_reg[4]  ( .CLK(N0), .D(InData[4]), .Q(OutData[4]) );
  LATCH \OutData_reg[3]  ( .CLK(N0), .D(InData[3]), .Q(OutData[3]) );
  LATCH \OutData_reg[2]  ( .CLK(N0), .D(InData[2]), .Q(OutData[2]) );
  LATCH \OutData_reg[1]  ( .CLK(N0), .D(InData[1]), .Q(OutData[1]) );
  LATCH \OutData_reg[0]  ( .CLK(N0), .D(InData[0]), .Q(OutData[0]) );
  NOR2X1 U2 ( .A(bWE), .B(bCE), .Y(N0) );
endmodule
*/

module WRAP_SRAM ( DataBus, AddressBus, ControlBus, InData, OutData, Address, 
        bCE, bWE, Breq, Bgnt, clk, bReset );
  inout [7:0] DataBus;
  inout [31:0] AddressBus;
  output [7:0] InData;
  input [7:0] OutData;
  output [17:0] Address;
  input Bgnt, clk, bReset;
  output bCE, bWE, Breq;
  inout ControlBus;
  wire   IntEnable, n44, n52, n53, n54, n55, n56, n57, n58, n59, n60, n61, n62,
         n63, n64, n65, n66, n67, n68, n69, n70, n71, n72, n73, n74, n75, n76,
         n77, n78, n79, n80, n81, n35, n36, n37, n38, n39, n40, n41, n42, n43,
         n45, n46, n47, n48, n49, n50, n51, n82, n83, n84, n85, n86, n87, n88,
         n89, n90, n91, n92, n93, n94, n95, n96, n97, n98, n99, n100, n101,
         n102, n103, n104, n105, n106, n107, n108, n109, n110, n111, n112,
         n113, n114;
  tri   [7:0] DataBus;
  tri   AddressBus_31;
  tri   AddressBus_30;
  tri   AddressBus_29;
  tri   AddressBus_28;
  tri   [31:0] AddressBus;
  tri   ControlBus;
  tran( AddressBus_31, AddressBus[31]);
  tran( AddressBus_30, AddressBus[30]);
  tran( AddressBus_29, AddressBus[29]);
  tran( AddressBus_28, AddressBus[28]);

  DFFPOSX1 IntEnable_reg ( .D(n81), .CLK(clk), .Q(IntEnable) );
  DFFPOSX1 \InData_reg[7]  ( .D(n53), .CLK(clk), .Q(InData[7]) );
  DFFPOSX1 \InData_reg[6]  ( .D(n54), .CLK(clk), .Q(InData[6]) );
  DFFPOSX1 \InData_reg[5]  ( .D(n55), .CLK(clk), .Q(InData[5]) );
  DFFPOSX1 \InData_reg[4]  ( .D(n56), .CLK(clk), .Q(InData[4]) );
  DFFPOSX1 \InData_reg[3]  ( .D(n57), .CLK(clk), .Q(InData[3]) );
  DFFPOSX1 \InData_reg[2]  ( .D(n58), .CLK(clk), .Q(InData[2]) );
  DFFPOSX1 \InData_reg[1]  ( .D(n59), .CLK(clk), .Q(InData[1]) );
  DFFPOSX1 \InData_reg[0]  ( .D(n60), .CLK(clk), .Q(InData[0]) );
  DFFPOSX1 \Address_reg[17]  ( .D(n61), .CLK(clk), .Q(Address[17]) );
  DFFPOSX1 \Address_reg[16]  ( .D(n62), .CLK(clk), .Q(Address[16]) );
  DFFPOSX1 \Address_reg[15]  ( .D(n63), .CLK(clk), .Q(Address[15]) );
  DFFPOSX1 \Address_reg[14]  ( .D(n64), .CLK(clk), .Q(Address[14]) );
  DFFPOSX1 \Address_reg[13]  ( .D(n65), .CLK(clk), .Q(Address[13]) );
  DFFPOSX1 \Address_reg[12]  ( .D(n66), .CLK(clk), .Q(Address[12]) );
  DFFPOSX1 \Address_reg[11]  ( .D(n67), .CLK(clk), .Q(Address[11]) );
  DFFPOSX1 \Address_reg[10]  ( .D(n68), .CLK(clk), .Q(Address[10]) );
  DFFPOSX1 \Address_reg[9]  ( .D(n69), .CLK(clk), .Q(Address[9]) );
  DFFPOSX1 \Address_reg[8]  ( .D(n70), .CLK(clk), .Q(Address[8]) );
  DFFPOSX1 \Address_reg[7]  ( .D(n71), .CLK(clk), .Q(Address[7]) );
  DFFPOSX1 \Address_reg[6]  ( .D(n72), .CLK(clk), .Q(Address[6]) );
  DFFPOSX1 \Address_reg[5]  ( .D(n73), .CLK(clk), .Q(Address[5]) );
  DFFPOSX1 \Address_reg[4]  ( .D(n74), .CLK(clk), .Q(Address[4]) );
  DFFPOSX1 \Address_reg[3]  ( .D(n75), .CLK(clk), .Q(Address[3]) );
  DFFPOSX1 \Address_reg[2]  ( .D(n76), .CLK(clk), .Q(Address[2]) );
  DFFPOSX1 \Address_reg[1]  ( .D(n77), .CLK(clk), .Q(Address[1]) );
  DFFPOSX1 \Address_reg[0]  ( .D(n78), .CLK(clk), .Q(Address[0]) );
  DFFPOSX1 bCE_reg ( .D(n79), .CLK(clk), .Q(bCE) );
  DFFPOSX1 bWE_reg ( .D(n80), .CLK(clk), .Q(bWE) );
  DFFPOSX1 Breq_reg ( .D(n52), .CLK(clk), .Q(Breq) );
  TBUFX1 \DataBus_tri[0]  ( .A(n42), .EN(n44), .Y(DataBus[0]) );
  TBUFX1 \DataBus_tri[1]  ( .A(n41), .EN(n44), .Y(DataBus[1]) );
  TBUFX1 \DataBus_tri[2]  ( .A(n40), .EN(n44), .Y(DataBus[2]) );
  TBUFX1 \DataBus_tri[3]  ( .A(n39), .EN(n44), .Y(DataBus[3]) );
  TBUFX1 \DataBus_tri[4]  ( .A(n38), .EN(n44), .Y(DataBus[4]) );
  TBUFX1 \DataBus_tri[5]  ( .A(n37), .EN(n44), .Y(DataBus[5]) );
  TBUFX1 \DataBus_tri[6]  ( .A(n36), .EN(n44), .Y(DataBus[6]) );
  TBUFX1 \DataBus_tri[7]  ( .A(n35), .EN(n44), .Y(DataBus[7]) );
  TBUFX1 ControlBus_tri ( .A(1'b1), .EN(IntEnable), .Y(ControlBus) );
  INVX2 U2 ( .A(n110), .Y(n43) );
  AND2X1 U3 ( .A(bReset), .B(n45), .Y(n81) );
  OAI21X1 U4 ( .A(IntEnable), .B(n46), .C(n43), .Y(n45) );
  INVX1 U5 ( .A(Bgnt), .Y(n46) );
  INVX1 U6 ( .A(n48), .Y(n80) );
  MUX2X1 U7 ( .B(AddressBus[18]), .A(bWE), .S(n43), .Y(n48) );
  INVX1 U8 ( .A(n49), .Y(n79) );
  MUX2X1 U9 ( .B(AddressBus[19]), .A(bCE), .S(n43), .Y(n49) );
  INVX1 U10 ( .A(n50), .Y(n78) );
  MUX2X1 U11 ( .B(AddressBus[0]), .A(Address[0]), .S(n43), .Y(n50) );
  INVX1 U12 ( .A(n51), .Y(n77) );
  MUX2X1 U13 ( .B(AddressBus[1]), .A(Address[1]), .S(n43), .Y(n51) );
  INVX1 U14 ( .A(n82), .Y(n76) );
  MUX2X1 U15 ( .B(AddressBus[2]), .A(Address[2]), .S(n47), .Y(n82) );
  INVX1 U16 ( .A(n83), .Y(n75) );
  MUX2X1 U17 ( .B(AddressBus[3]), .A(Address[3]), .S(n47), .Y(n83) );
  INVX1 U18 ( .A(n84), .Y(n74) );
  MUX2X1 U19 ( .B(AddressBus[4]), .A(Address[4]), .S(n47), .Y(n84) );
  INVX1 U20 ( .A(n85), .Y(n73) );
  MUX2X1 U21 ( .B(AddressBus[5]), .A(Address[5]), .S(n47), .Y(n85) );
  INVX1 U22 ( .A(n86), .Y(n72) );
  MUX2X1 U23 ( .B(AddressBus[6]), .A(Address[6]), .S(n47), .Y(n86) );
  INVX1 U24 ( .A(n87), .Y(n71) );
  MUX2X1 U25 ( .B(AddressBus[7]), .A(Address[7]), .S(n47), .Y(n87) );
  INVX1 U26 ( .A(n88), .Y(n70) );
  MUX2X1 U27 ( .B(AddressBus[8]), .A(Address[8]), .S(n47), .Y(n88) );
  INVX1 U28 ( .A(n89), .Y(n69) );
  MUX2X1 U29 ( .B(AddressBus[9]), .A(Address[9]), .S(n47), .Y(n89) );
  INVX1 U30 ( .A(n90), .Y(n68) );
  MUX2X1 U31 ( .B(AddressBus[10]), .A(Address[10]), .S(n47), .Y(n90) );
  INVX1 U32 ( .A(n91), .Y(n67) );
  MUX2X1 U33 ( .B(AddressBus[11]), .A(Address[11]), .S(n47), .Y(n91) );
  INVX1 U34 ( .A(n92), .Y(n66) );
  MUX2X1 U35 ( .B(AddressBus[12]), .A(Address[12]), .S(n47), .Y(n92) );
  INVX1 U36 ( .A(n93), .Y(n65) );
  MUX2X1 U37 ( .B(AddressBus[13]), .A(Address[13]), .S(n47), .Y(n93) );
  INVX1 U38 ( .A(n94), .Y(n64) );
  MUX2X1 U39 ( .B(AddressBus[14]), .A(Address[14]), .S(n47), .Y(n94) );
  INVX1 U40 ( .A(n95), .Y(n63) );
  MUX2X1 U41 ( .B(AddressBus[15]), .A(Address[15]), .S(n47), .Y(n95) );
  INVX1 U42 ( .A(n96), .Y(n62) );
  MUX2X1 U43 ( .B(AddressBus[16]), .A(Address[16]), .S(n47), .Y(n96) );
  INVX1 U44 ( .A(n97), .Y(n61) );
  MUX2X1 U45 ( .B(AddressBus[17]), .A(Address[17]), .S(n47), .Y(n97) );
  INVX1 U46 ( .A(n98), .Y(n60) );
  MUX2X1 U47 ( .B(DataBus[0]), .A(InData[0]), .S(n47), .Y(n98) );
  INVX1 U48 ( .A(n99), .Y(n59) );
  MUX2X1 U49 ( .B(DataBus[1]), .A(InData[1]), .S(n47), .Y(n99) );
  INVX1 U50 ( .A(n100), .Y(n58) );
  MUX2X1 U51 ( .B(DataBus[2]), .A(InData[2]), .S(n47), .Y(n100) );
  INVX1 U52 ( .A(n101), .Y(n57) );
  MUX2X1 U53 ( .B(DataBus[3]), .A(InData[3]), .S(n47), .Y(n101) );
  INVX1 U54 ( .A(n102), .Y(n56) );
  MUX2X1 U55 ( .B(DataBus[4]), .A(InData[4]), .S(n47), .Y(n102) );
  INVX1 U56 ( .A(n103), .Y(n55) );
  MUX2X1 U57 ( .B(DataBus[5]), .A(InData[5]), .S(n47), .Y(n103) );
  INVX1 U58 ( .A(n104), .Y(n54) );
  MUX2X1 U59 ( .B(DataBus[6]), .A(InData[6]), .S(n47), .Y(n104) );
  INVX1 U60 ( .A(n105), .Y(n53) );
  MUX2X1 U61 ( .B(DataBus[7]), .A(InData[7]), .S(n47), .Y(n105) );
  NOR2X1 U62 ( .A(n106), .B(n107), .Y(n52) );
  INVX1 U63 ( .A(bReset), .Y(n107) );
  AOI22X1 U64 ( .A(n108), .B(n109), .C(Breq), .D(n110), .Y(n106) );
  INVX1 U65 ( .A(n47), .Y(n110) );
  NAND2X1 U66 ( .A(IntEnable), .B(n109), .Y(n47) );
  INVX1 U67 ( .A(n111), .Y(n109) );
  NAND3X1 U68 ( .A(AddressBus_28), .B(n112), .C(n113), .Y(n111) );
  NOR2X1 U69 ( .A(AddressBus_31), .B(AddressBus_30), .Y(n113) );
  INVX1 U70 ( .A(AddressBus_29), .Y(n112) );
  NOR2X1 U71 ( .A(IntEnable), .B(Bgnt), .Y(n108) );
  NOR2X1 U72 ( .A(AddressBus[19]), .B(n114), .Y(n44) );
  INVX1 U73 ( .A(AddressBus[18]), .Y(n114) );
  INVX1 U74 ( .A(OutData[0]), .Y(n42) );
  INVX1 U75 ( .A(OutData[1]), .Y(n41) );
  INVX1 U76 ( .A(OutData[2]), .Y(n40) );
  INVX1 U77 ( .A(OutData[3]), .Y(n39) );
  INVX1 U78 ( .A(OutData[4]), .Y(n38) );
  INVX1 U79 ( .A(OutData[5]), .Y(n37) );
  INVX1 U80 ( .A(OutData[6]), .Y(n36) );
  INVX1 U81 ( .A(OutData[7]), .Y(n35) );
endmodule


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


module WRAP_UART ( DataBus, AddressBus, ControlBus, InData, Load_XMT_datareg, 
        Byte_ready, T_byte, Breq, Bgnt, clk, bReset );
  inout [7:0] DataBus;
  inout [31:0] AddressBus;
  output [7:0] InData;
  input Bgnt, clk, bReset;
  output Load_XMT_datareg, Byte_ready, T_byte, Breq;
  inout ControlBus;
  wire   IntEnable, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36,
         n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50,
         n51, n52, n53, n54, n55, n56, n57, n58, n59, n60;
  tri   [7:0] DataBus;
  tri   [31:0] AddressBus;
  tri   AddressBus_2;
  tri   AddressBus_1;
  tri   AddressBus_0;
  tri   ControlBus;
  tran( AddressBus_2, AddressBus[2]);
  tran( AddressBus_1, AddressBus[1]);
  tran( AddressBus_0, AddressBus[0]);

  DFFPOSX1 IntEnable_reg ( .D(n37), .CLK(clk), .Q(IntEnable) );
  DFFPOSX1 Load_XMT_datareg_reg ( .D(n26), .CLK(clk), .Q(Load_XMT_datareg) );
  DFFPOSX1 Byte_ready_reg ( .D(n27), .CLK(clk), .Q(Byte_ready) );
  DFFPOSX1 T_byte_reg ( .D(n28), .CLK(clk), .Q(T_byte) );
  DFFPOSX1 \InData_reg[7]  ( .D(n29), .CLK(clk), .Q(InData[7]) );
  DFFPOSX1 \InData_reg[6]  ( .D(n30), .CLK(clk), .Q(InData[6]) );
  DFFPOSX1 \InData_reg[5]  ( .D(n31), .CLK(clk), .Q(InData[5]) );
  DFFPOSX1 \InData_reg[4]  ( .D(n32), .CLK(clk), .Q(InData[4]) );
  DFFPOSX1 \InData_reg[3]  ( .D(n33), .CLK(clk), .Q(InData[3]) );
  DFFPOSX1 \InData_reg[2]  ( .D(n34), .CLK(clk), .Q(InData[2]) );
  DFFPOSX1 \InData_reg[1]  ( .D(n35), .CLK(clk), .Q(InData[1]) );
  DFFPOSX1 \InData_reg[0]  ( .D(n36), .CLK(clk), .Q(InData[0]) );
  DFFPOSX1 Breq_reg ( .D(n25), .CLK(clk), .Q(Breq) );
  TBUFX1 ControlBus_tri ( .A(1'b1), .EN(IntEnable), .Y(ControlBus) );
  NOR2X1 U3 ( .A(n38), .B(n39), .Y(n37) );
  MUX2X1 U4 ( .B(Bgnt), .A(n40), .S(IntEnable), .Y(n39) );
  INVX1 U5 ( .A(bReset), .Y(n38) );
  INVX1 U6 ( .A(n41), .Y(n36) );
  AOI22X1 U7 ( .A(DataBus[0]), .B(n42), .C(InData[0]), .D(n43), .Y(n41) );
  INVX1 U8 ( .A(n44), .Y(n35) );
  AOI22X1 U9 ( .A(DataBus[1]), .B(n42), .C(InData[1]), .D(n43), .Y(n44) );
  INVX1 U10 ( .A(n45), .Y(n34) );
  AOI22X1 U11 ( .A(DataBus[2]), .B(n42), .C(InData[2]), .D(n43), .Y(n45) );
  INVX1 U12 ( .A(n46), .Y(n33) );
  AOI22X1 U13 ( .A(DataBus[3]), .B(n42), .C(InData[3]), .D(n43), .Y(n46) );
  INVX1 U14 ( .A(n47), .Y(n32) );
  AOI22X1 U15 ( .A(DataBus[4]), .B(n42), .C(InData[4]), .D(n43), .Y(n47) );
  INVX1 U16 ( .A(n48), .Y(n31) );
  AOI22X1 U17 ( .A(DataBus[5]), .B(n42), .C(InData[5]), .D(n43), .Y(n48) );
  INVX1 U18 ( .A(n49), .Y(n30) );
  AOI22X1 U19 ( .A(DataBus[6]), .B(n42), .C(InData[6]), .D(n43), .Y(n49) );
  INVX1 U20 ( .A(n50), .Y(n29) );
  AOI22X1 U21 ( .A(DataBus[7]), .B(n42), .C(InData[7]), .D(n43), .Y(n50) );
  INVX1 U22 ( .A(n51), .Y(n28) );
  AOI22X1 U23 ( .A(AddressBus_2), .B(n42), .C(T_byte), .D(n43), .Y(n51) );
  INVX1 U24 ( .A(n52), .Y(n27) );
  AOI22X1 U25 ( .A(AddressBus_1), .B(n42), .C(Byte_ready), .D(n43), .Y(n52) );
  INVX1 U26 ( .A(n53), .Y(n26) );
  AOI22X1 U27 ( .A(AddressBus_0), .B(n42), .C(Load_XMT_datareg), .D(n43), .Y(
        n53) );
  INVX1 U28 ( .A(n54), .Y(n43) );
  AND2X1 U29 ( .A(IntEnable), .B(n54), .Y(n42) );
  NAND2X1 U30 ( .A(IntEnable), .B(n55), .Y(n54) );
  NOR2X1 U31 ( .A(n56), .B(n57), .Y(n25) );
  NAND2X1 U32 ( .A(n40), .B(bReset), .Y(n57) );
  INVX1 U33 ( .A(n55), .Y(n40) );
  NAND3X1 U34 ( .A(AddressBus[29]), .B(n58), .C(n59), .Y(n55) );
  NOR2X1 U35 ( .A(AddressBus[31]), .B(AddressBus[30]), .Y(n59) );
  INVX1 U36 ( .A(AddressBus[28]), .Y(n58) );
  MUX2X1 U37 ( .B(n60), .A(Breq), .S(IntEnable), .Y(n56) );
  INVX1 U38 ( .A(Bgnt), .Y(n60) );
endmodule


module Arbiter ( BREQn, BGNTn );
  input [2:0] BREQn;
  output [2:0] BGNTn;
  wire   \BREQn[2] , n4, n5, n6;
  assign BGNTn[2] = \BREQn[2] ;
  assign \BREQn[2]  = BREQn[2];

  INVX1 U1 ( .A(n4), .Y(BGNTn[1]) );
  NAND3X1 U2 ( .A(n5), .B(n6), .C(BREQn[1]), .Y(n4) );
  INVX1 U3 ( .A(\BREQn[2] ), .Y(n6) );
  NOR2X1 U4 ( .A(\BREQn[2] ), .B(n5), .Y(BGNTn[0]) );
  INVX1 U5 ( .A(BREQn[0]), .Y(n5) );
endmodule


module MAINSYSTEM ( Serial_out, clk, Breq, Bgnt, DataBus, AddressBus, 
        ControlBus, bReset );
  inout [7:0] DataBus;
  inout [31:0] AddressBus;
  input clk, Breq, bReset;
  output Serial_out, Bgnt;
  inout ControlBus;
  wire   bCE, bWE, Load_XMT_datareg, Byte_ready, T_byte;
  wire   [1:0] Bgntn;
  wire   [1:0] Breqn;
  wire   [7:0] InData;
  wire   [7:0] OutData;
  wire   [17:0] Address;
  wire   [7:0] DataToUART;
  tri   Serial_out;
  tri   [7:0] DataBus;
  tri   [31:0] AddressBus;
  tri   ControlBus;

  SRAM SRAM_01 ( .InData(InData), .OutData(OutData), .Address(Address), .bCE(
        bCE), .bWE(bWE) );
  WRAP_SRAM WRAP_SRAM_01 ( .DataBus(DataBus), .AddressBus(AddressBus), 
        .ControlBus(ControlBus), .InData(InData), .OutData(OutData), .Address(
        Address), .bCE(bCE), .bWE(bWE), .Breq(Breqn[0]), .Bgnt(Bgntn[0]), 
        .clk(clk), .bReset(bReset) );
  UART_XMTR UART_XMTR_01 ( .Serial_out(Serial_out), .Data_Bus(DataToUART), 
        .Load_XMT_datareg(Load_XMT_datareg), .Byte_ready(Byte_ready), .T_byte(
        T_byte), .Clock(clk), .rst_b(bReset) );
  WRAP_UART WRAP_UART_01 ( .DataBus(DataBus), .AddressBus(AddressBus), 
        .ControlBus(ControlBus), .InData(DataToUART), .Load_XMT_datareg(
        Load_XMT_datareg), .Byte_ready(Byte_ready), .T_byte(T_byte), .Breq(
        Breqn[1]), .Bgnt(Bgntn[1]), .clk(clk), .bReset(bReset) );
  Arbiter Arbiter_01 ( .BREQn({Breq, Breqn}), .BGNTn({Bgnt, Bgntn}) );
endmodule

