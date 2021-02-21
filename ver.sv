//------------------- desing file start ------------------- // 
`timescale 1ns/1ns
// O0 design
module O0(output O0, input A0, B0);
  xor #3 g1(O0, A0,B0);
endmodule

  // O1 desing
module O1(output O1 ,input A0,A1,B0,B1);
    wire w1,w2,w3,w4,w5,w6;
  	and #2 g1(w1, B1,~A1,~A0);
    and #2 g2(w2, B1,~B0,~A1);
    and #2 g3(w3,A1,~B1,~B0);
    and #2 g4(w4,A1,~A0,~B1);
    and #3 g5(w5,A0,B0,~A1,~B1);
  	and #3 g6(w6,A1,A0,B1,B0);
  or #5 g7(O1,w1,w2,w3,w4,w5,w6);
endmodule 


// design O2
module O2(output O2,input A1,B1,A0,B0);
wire w1,w2,w3;
  and #1 g1(w1,A1,B1);
  and #2 g2(w2,A0,B0,A1);
  and #2 g3(w3,A0,B1,B0);
  or #3 g4(O2,w1,w2,w3);
endmodule 


// module instantiation for all O0 O1 O2
module module_two_bits(output O0,O1,O2, input A0,A1,B0,B1);
  O0 M0(O0,A0,B0);
  O1 M1(O1,A0,A1,B0,B1);
  O2 M2(O2,A0,A1,B0,B1);
endmodule


// using assign 
module full_Adder(output O0,O1,O2, input A0,A1,B0,B1);
  assign #3 O0 = A0 ^ B0;
  assign #8 O1 = (B1 & ~A1 & ~A0) | (B1 & ~B0 & ~A1) | (A1 & ~B1 & ~B0) | (A1 & ~A1 & ~B1) & (A0 & B0 & ~A1 & ~B1) | (A1 & A0 & B1 & B0);
  assign #5 O2 = (A1 & B1) | (A1 & A0 & B0) | (A0 & B1 & B0);
endmodule 


//------------------- desing file END ------------------- // 


//------------------- Test file Start ------------------- // 
`timescale 1ns/1ns

// test bench code 
module Test_O0(); 
  reg A0,B0,A1,B1;
  wire O0,O1,O2;
  
  
  module_two_bits m1(O0,O1,O2,A0,A1,B0,B1);
      initial begin
   	  $dumpfile("Test_O0.vcd");
      $dumpvars(1,Test_O0);
        A1=0; A0=0; B1=0; B0=1; // at t = 0 
        #20 A1=1; A0=0; B1=0; B0=0; // at t =20 
        #20 A1=0; A0=1; B1=0; B0=1; // at t=40 
        #20 A1=0; A0=1; B1=1; B0=1;  // at t=60 
        #20 A1=1; A0=1; B1=0; B0=1; //at t=80 
        #20 A1=1; A0=0; B1=1; B0=1; //at t=100 
        #20 A1=1; A0=1; B1=1; B0=1; //at = t= 120 
  	    #20 $finish;  // at t = 140  
    end
  	endmodule

//------------------- Test file END ------------------- // 