`timescale 1ns / 1ps

module tb_TopModule();

    // 1. Inputs to the TopModule
    reg [3:0] A;
    reg [3:0] B;
    reg [2:0] Opcode;

    // 2. Outputs from the TopModule
    wire [3:0] Result;
    wire Carry_out;

    // 3. Variables for our automated checking loop
    reg [4:0] expected_result; // 5 bits wide to catch the addition carry bit
    integer i, j, errors;

    // 4. Instantiate your corrected TopModule
    TopModule dut (
        .A(A),
        .B(B),
        .Opcode(Opcode),
        .Result(Result),
        .Carry_out(Carry_out)
    );

    initial begin
        // Initialize Inputs
        A = 0;
        B = 0;
        Opcode = 0;
        errors = 0;

        // Wait 100 ns for the simulator to stabilize
        #100;

        $display("===============================================");
        $display("--- Starting Exhaustive ALU Testbench ---");
        $display("===============================================");

        // -----------------------------------------------------
        // TEST 1: Addition (Opcode: 3'b000)
        // Tests all 256 combinations of A and B
        // -----------------------------------------------------
        Opcode = 3'b000;
        $display("Testing Addition (All 256 states)...");
        
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                A = i;
                B = j;
                expected_result = A + B; // Standard Verilog math to check against
                
                #10; // 10ns delay for the logic gates to compute
                
                // Check if the 4-bit Result AND the 1-bit Carry match the expectation
                if (Result !== expected_result[3:0] || Carry_out !== expected_result[4]) begin
                    $display("ERROR (ADD): A=%d, B=%d | Expected Result=%d, Carry=%b | Got Result=%d, Carry=%b", 
                             A, B, expected_result[3:0], expected_result[4], Result, Carry_out);
                    errors = errors + 1;
                end
            end
        end

        // -----------------------------------------------------
        // TEST 2: Subtraction (Opcode: 3'b001)
        // Tests all 256 combinations of A and B
        // -----------------------------------------------------
        Opcode = 3'b001;
        $display("Testing Subtraction (All 256 states)...");
        
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                A = i;
                B = j;
                expected_result = A - B;
                
                #10; 
                
                if (Result !== expected_result[3:0]) begin
                    $display("ERROR (SUB): A=%d, B=%d | Expected=%d | Got=%d", 
                             A, B, expected_result[3:0], Result);
                    errors = errors + 1;
                end
            end
        end

        // -----------------------------------------------------
        // TEST 3: Bitwise XOR (Opcode: 3'b100)
        // Tests all 256 combinations of A and B
        // -----------------------------------------------------
        Opcode = 3'b100;
        $display("Testing Bitwise XOR (All 256 states)...");
        
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                A = i;
                B = j;
                expected_result = A ^ B;
                
                #10; 
                
                if (Result !== expected_result[3:0]) begin
                    $display("ERROR (XOR): A=%b, B=%b | Expected=%b | Got=%b", 
                             A, B, expected_result[3:0], Result);
                    errors = errors + 1;
                end
            end
        end
        // -----------------------------------------------------
        // TEST 4: Bitwise AND (Opcode: 3'b010)
        // -----------------------------------------------------
        Opcode = 3'b010;
        $display("Testing Bitwise AND (All 256 states)...");
        
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                A = i;
                B = j;
                expected_result = A & B; // Bitwise AND operator
                
                #10; 
                
                if (Result !== expected_result[3:0]) begin
                    $display("ERROR (AND): A=%b, B=%b | Expected=%b | Got=%b", 
                             A, B, expected_result[3:0], Result);
                    errors = errors + 1;
                end
            end
        end
        // -----------------------------------------------------
        // TEST 5: Bitwise OR (Opcode: 3'b011)
        // -----------------------------------------------------
        Opcode = 3'b011;
        $display("Testing Bitwise OR (All 256 states)...");
        
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                A = i;
                B = j;
                expected_result = A | B; // Bitwise OR operator
                
                #10; 
                
                if (Result !== expected_result[3:0]) begin
                    $display("ERROR (OR): A=%b, B=%b | Expected=%b | Got=%b", 
                             A, B, expected_result[3:0], Result);
                    errors = errors + 1;
                end
            end
        end
        // -----------------------------------------------------
        // FINAL VERIFICATION REPORT
        // -----------------------------------------------------
        $display("===============================================");
        if (errors == 0) begin
            $display("SUCCESS: TopModule passed all combinations with 0 errors!");
        end else begin
            $display("FAILED: Testbench completed with %d errors.", errors);
        end
        $display("===============================================");

        $finish;
    end
endmodule