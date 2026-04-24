module TopModule(
  input [3:0] A, B,
  input [2:0] Opcode,
  output reg [3:0] Result,
  output reg Carry_out    // Fix 1: Added as an output port to the main module
);
  
  // Wires for module outputs
  wire [3:0] result_add;
  wire [3:0] result_sub;
  wire [3:0] result_and;
  wire [3:0] result_or;
  wire [3:0] result_xor;
  
  // Fix 2: Independent wires to prevent multiple-driver errors
  wire carry_add;         
  wire borrow_sub;        

  // Addition module
  Addition_4bit adder(.A(A), .B(B), .Sum(result_add), .Carry(carry_add));

  // Subtraction module
  Subtraction_4bit subtractor(.A(A), .B(B), .Difference(result_sub), .Borrow(borrow_sub));

  // Bitwise AND module
  BitwiseAND_4bit and_gate(.A(A), .B(B), .Result(result_and));

  // Bitwise OR module
  BitwiseOR_4bit or_gate(.A(A), .B(B), .Result(result_or));

  // Bitwise XOR module
  BitwiseXOR_4bit xor_gate(.A(A), .B(B), .Result(result_xor));

  // Multiplexor for selecting the operation based on Opcode
  always @*
  begin
    // Default values to prevent unintended latches
    Result = 4'b0000;
    Carry_out = 1'b0;

    case (Opcode)
      3'b000: 
        begin 
            Result = result_add;       // Addition
            Carry_out = carry_add;     // Fix 3: Route the correct carry flag
        end
      3'b001: 
        begin 
            Result = result_sub;       // Subtraction
            Carry_out = borrow_sub;    // Fix 3: Route the correct borrow flag
        end
      3'b010: Result = result_and;       // Bitwise AND
      3'b011: Result = result_or;        // Bitwise OR
      3'b100: Result = result_xor;       // Bitwise XOR
      
      default: 
        begin 
            Result = 4'b0000;      
            Carry_out = 1'b0;
        end
    endcase
  end

endmodule