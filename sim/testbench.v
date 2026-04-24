module TopModule_Test;
  
  reg [3:0] A, B;
  reg [2:0] Opcode;
  wire [3:0] Result;
  wire Carry_out;     // FIX 1: Added wire to catch the carry flag
  
  // Instantiate the TopModule
  TopModule dut (
    .A(A),
    .B(B),
    .Opcode(Opcode),
    .Result(Result),
    .Carry_out(Carry_out) // FIX 1: Connected the carry flag
  );
  
  // Testbench stimulus
  initial begin
    // Initialize inputs
    A = 4'b0101;
    B = 4'b0010;
    Opcode = 3'b000;  // Addition operation
    
    // FIX 2: Replaced @(posedge clk) with #10
    
    // Test Addition operation
    #10; 
    $display("Addition Test 1: A + B = %b, Carry = %b", Result, Carry_out);
    
    A = 4'b1010;
    B = 4'b1100;
    #10;
    $display("Addition Test 2: A + B = %b, Carry = %b", Result, Carry_out);
    
    // Test Subtraction operation
    A = 4'b0101;
    B = 4'b0010;
    Opcode = 3'b001;  // Subtraction operation
    #10;
    $display("Subtraction Test 1: A - B = %b", Result);
    
    A = 4'b1010;
    B = 4'b1100;
    #10;
    $display("Subtraction Test 2: A - B = %b", Result);
    
    // Test Bitwise AND operation
    A = 4'b0101;
    B = 4'b0010;
    Opcode = 3'b010;  // Bitwise AND operation
    #10;
    $display("Bitwise AND Test 1: A & B = %b", Result);
    
    A = 4'b1010;
    B = 4'b1100;
    #10;
    $display("Bitwise AND Test 2: A & B = %b", Result);
    
    // Test Bitwise OR operation
    A = 4'b0101;
    B = 4'b0010;
    Opcode = 3'b011;  // Bitwise OR operation
    #10;
    $display("Bitwise OR Test 1: A | B = %b", Result);
    
    A = 4'b1010;
    B = 4'b1100;
    #10;
    $display("Bitwise OR Test 2: A | B = %b", Result);
    
    // Test Bitwise XOR operation
    A = 4'b0101;
    B = 4'b0010;
    Opcode = 3'b100;  // Bitwise XOR operation
    #10;
    $display("Bitwise XOR Test 1: A ^ B = %b", Result);
    
    A = 4'b1010;
    B = 4'b1100;
    #10;
    $display("Bitwise XOR Test 2: A ^ B = %b", Result);
    
    // End simulation
    $finish;
  end
  
endmodule