`include "processador/ALU.v"
`include "processador/extensao_sinal.v"
`include "processador/memoria.v"
`include "processador/Registradores.v"
`include "processador/ControlLogicUnit.v"
`include "processador/ALUControl.v"
`include "processador/ShiftLeft2.v"

module PQP(
    input i_Clk,
    input i_Rst
);

    wire [31:0] instrucao;
    wire Jump, MemRead, MemWrite, ALUSrc, RegWrite, RegToReg, Halt;
    wire [1:0] CLU_ALUOp;

    wire [31:0] Reg_ReadData1, Reg_ReadData2, Reg_WriteData;

    wire [31:0] sinalExtendido;
    wire [31:0] ALU_entradaA;
    wire [31:0] ALU_entradaB;
    wire [31:0] Mem_Address;

    wire [3:0] AC_ALUOp;
    wire [31:0] ALUResult;

    wire [31:0] Mem_ReadData;

    wire [31:0] sinalShift;

    reg [31:0] PC;
    wire [31:0] PC_mais4;
    wire [31:0] PC_Jump;
    wire [31:0] proximo_PC;

    always@(posedge i_Clk or posedge i_Rst) begin
        if (i_Rst) begin
            PC <= 32'b0;
        end else begin;
            if (Halt) PC <= PC;
            else PC <= proximo_PC;
        end
    end

    ALU soma_pc(
        .A(PC),
        .B(32'd4),
        .ALUOperation(4'b1001),
        .ALUResult(PC_mais4),
        .Zero()
    );

    assign Mem_Address = (MemRead) ? Reg_ReadData2 : Reg_ReadData1;

    memory memoria(
        .clk(i_Clk),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .MemAddress(Mem_Address),
        .WriteData(Reg_ReadData2),
        .ReadData(Mem_ReadData),
        .instructionAddress(PC),
        .instruction(instrucao)
    );

    extensao_sinal extensor(
        .in(instrucao[15:0]),
        .out(sinalExtendido)
    );

    assign Reg_WriteData = (MemRead) ? Mem_ReadData : ALUResult;
    Registradores banco(
        .ReadRegister1(instrucao[23:20]),
        .ReadRegister2(instrucao[19:16]),
        .WriteRegister(instrucao[23:20]),
        .WriteData(Reg_WriteData),
        .RegWrite(RegWrite),
        .clock(i_Clk),
        .ReadData1(Reg_ReadData1),
        .ReadData2(Reg_ReadData2)
    );
    
    ControlLogicUnit clu(
        .Opcode(instrucao[31:24]),
        .Jump(Jump),
        .MemRead(MemRead),
        .ALUOp(CLU_ALUOp),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite),
        .RegToReg(RegToReg),
        .Halt(Halt)
    );

    ALUControl aluc(
        .i_ALUOp(CLU_ALUOp),
        .o_Op(AC_ALUOp)
    );
    assign ALU_entradaA = (RegToReg) ? 32'b0 : Reg_ReadData1;
    assign ALU_entradaB = (ALUSrc) ? sinalExtendido : Reg_ReadData2;
    ALU mainALU(
        .A(ALU_entradaA),
        .B(ALU_entradaB),
        .ALUOperation(AC_ALUOp),
        .ALUResult(ALUResult),
        .Zero()
    );

    ShiftLeft2 shift(
        .in(instrucao[15:0]),
        .out(sinalShift)
    );

    assign proximo_PC = (Jump) ? PC_Jump : PC_mais4;
    ALU ALUJump(
        .A(sinalShift),
        .B(PC_mais4),
        .ALUOperation(4'b1001),
        .ALUResult(PC_Jump),
        .Zero()
    );

endmodule
