module Subtraction_4bit(
    input [3:0] A, 
    input [3:0] B,
    output reg [3:0] Difference,
    output reg Borrow
);

  // Internal variables to hold the cascading borrow bits
  reg b1, b2, b3; 

  always @* begin
      // ---------------------------------------------------------
      // BIT 0 (Half Subtractor: No previous borrow to worry about)
      // ---------------------------------------------------------
      // The difference is still an XOR gate, just like addition!
      Difference[0] = A[0] ^ B[0];         
      
      // A borrow is ONLY generated if A is 0 and B is 1 (0 - 1)
      b1            = (~A[0]) & B[0];      

      // ---------------------------------------------------------
      // BIT 1 (Full Subtractor: Must include borrow 'b1' from Bit 0)
      // ---------------------------------------------------------
      Difference[1] = A[1] ^ B[1] ^ b1;    
      
      // Borrow Out = (~A & B) OR (Borrow_In & ~(A XOR B))
      b2            = ((~A[1]) & B[1]) | (b1 & ~(A[1] ^ B[1])); 

      // ---------------------------------------------------------
      // BIT 2 (Full Subtractor: Must include borrow 'b2' from Bit 1)
      // ---------------------------------------------------------
      Difference[2] = A[2] ^ B[2] ^ b2;
      b3            = ((~A[2]) & B[2]) | (b2 & ~(A[2] ^ B[2]));

      // ---------------------------------------------------------
      // BIT 3 (Full Subtractor: Must include borrow 'b3' from Bit 2)
      // ---------------------------------------------------------
      Difference[3] = A[3] ^ B[3] ^ b3;
      
      // The final borrow out of the entire 4-bit module
      Borrow        = ((~A[3]) & B[3]) | (b3 & ~(A[3] ^ B[3]));
  end

endmodule