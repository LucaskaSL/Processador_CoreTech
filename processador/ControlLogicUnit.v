module ControlLogicUnit(
    input [7:0] Opcode,
    output reg Jump,
    output reg MemRead,
    output reg [1:0] ALUOp,
    output reg MemWrite,
    output reg ALUSrc,
    output reg RegWrite,
    output reg RegToReg,
    output reg Halt

);

    always@(*) begin
        case (Opcode)
            8'h00: begin // mov imm
                Jump     = 0;
                MemRead  = 0;
                ALUOp    = 2'b10;
                MemWrite = 0;
                ALUSrc   = 1;
                RegWrite = 1;
                RegToReg = 0;
                Halt     = 0;
                end
            8'h01: begin // mov reg
                Jump     = 0;
                MemRead  = 0;
                ALUOp    = 2'b10;
                MemWrite = 0;
                ALUSrc   = 0;
                RegWrite = 1;
                RegToReg = 1;
                Halt     = 0;
                end
            8'h02: begin // mov from mem
                Jump     = 0;
                MemRead  = 1;
                ALUOp    = 2'b10;
                MemWrite = 0;
                ALUSrc   = 0;
                RegWrite = 1;
                RegToReg = 0;
                Halt     = 0;
                end
            8'h03: begin // mov to mem
                Jump     = 0;
                MemRead  = 0;
                ALUOp    = 2'b00;
                MemWrite = 1;
                ALUSrc   = 0;
                RegWrite = 0;
                RegToReg = 0;
                Halt     = 0;
                end
            8'h05: begin // jmp
                Jump     = 1;
                MemRead  = 0;
                ALUOp    = 10;
                MemWrite = 0;
                ALUSrc   = 1;
                RegWrite = 0;
                RegToReg = 0;
                Halt     = 0;
                end
            8'h09: begin // add
                Jump     = 0;
                MemRead  = 0;
                ALUOp    = 2'b10;
                MemWrite = 0;
                ALUSrc   = 0;
                RegWrite = 1;
                RegToReg = 0;
                Halt     = 0;
                end
            8'h0A: begin // sub
                Jump     = 0;
                MemRead  = 0;
                ALUOp    = 2'b11;
                MemWrite = 0;
                ALUSrc   = 0;
                RegWrite = 1;
                RegToReg = 0;
                Halt     = 0;
                end
            8'h0B: begin // and
                Jump     = 0;
                MemRead  = 0;
                ALUOp    = 2'b00;
                MemWrite = 0;
                ALUSrc   = 0;
                RegWrite = 1;
                RegToReg = 0;
                Halt     = 0;
                end
            8'h0C: begin // or
                Jump     = 0;
                MemRead  = 0;
                ALUOp    = 2'b01;
                MemWrite = 0;
                ALUSrc   = 0;
                RegWrite = 1;
                RegToReg = 0;
                Halt     = 0;
                end
            8'hFF: begin // halt
                Jump     = 0;
                MemRead  = 0;
                ALUOp    = 2'b00;
                MemWrite = 0;
                ALUSrc   = 0;
                RegWrite = 0;
                RegToReg = 0;
                Halt     = 1;
                end
            default: begin
                Jump     = 0;
                MemRead  = 0;
                ALUOp    = 00;
                MemWrite = 0;
                ALUSrc   = 0;
                RegWrite = 0;
                RegToReg = 0;
                Halt     = 0;
            end
        endcase
    end

endmodule
