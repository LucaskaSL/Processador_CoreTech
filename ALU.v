module ALU(
    input wire clk,
    input wire [31:0] A,           // Operando 1
    input wire [31:0] B,           // Operando 2
    input wire [3:0] ALUOperation, // Código da operação ALU
    output reg [31:0] ALUResult,   // Resultado da ALU
    output wire Zero               // Sinal Zero (ativo quando ALUResult é 0)
);

    // Define o comportamento da ALU
    always @(*) begin
        if(clk == 1) begin
            case (ALUOperation)
                4'b1011: ALUResult = A & B;          // opcode 0x0B -> AND
                4'b1100: ALUResult = A | B;          // opcode 0x0C -> OR
                4'b1001: ALUResult = A + B;          // opcode 0x09 -> Soma
                4'b1010: ALUResult = A - B;          // opcode 0x0A -> Subtração
                //4'b0111: ALUResult = (A < B) ? 1 : 0; // SLT (Set Less Than)
                //4'b1100: ALUResult = ~(A | B);       // NOR
                default: ALUResult = 32'b0;          // Operação inválida
            endcase
        end
    end

    // Define o sinal Zero
    assign Zero = (ALUResult == 32'b0) ? 1'b1 : 1'b0;

endmodule
