`timescale 1ns / 1ps
module Addition_4bit(
    input [3:0] A, B,
    output reg [3:0] Sum,
    output reg Carry
);

  // Internal variables to hold the cascading carry bits
  reg c1, c2, c3; 

  always @* begin
      // ---------------------------------------------------------
      // BIT 0 (Half Adder: No previous carry to worry about)
      // ---------------------------------------------------------
      Sum[0] = A[0] ^ B[0];         // XOR gate for Sum
      c1     = A[0] & B[0];         // AND gate for Carry to next bit

      // ---------------------------------------------------------
      // BIT 1 (Full Adder: Must include carry 'c1' from Bit 0)
      // ---------------------------------------------------------
      Sum[1] = A[1] ^ B[1] ^ c1;    
      c2     = (A[1] & B[1]) | (c1 & (A[1] ^ B[1])); 

      // ---------------------------------------------------------
      // BIT 2 (Full Adder: Must include carry 'c2' from Bit 1)
      // ---------------------------------------------------------
      Sum[2] = A[2] ^ B[2] ^ c2;
      c3     = (A[2] & B[2]) | (c2 & (A[2] ^ B[2]));

      // ---------------------------------------------------------
      // BIT 3 (Full Adder: Must include carry 'c3' from Bit 2)
      // ---------------------------------------------------------
      Sum[3] = A[3] ^ B[3] ^ c3;
      
      // The final carry out of the entire 4-bit module
      Carry  = (A[3] & B[3]) | (c3 & (A[3] ^ B[3]));
  end

endmodule
