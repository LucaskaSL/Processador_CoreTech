module ALUControl(
    input [1:0] i_ALUOp,
    output reg [3:0] o_Op
);

    always@(*) begin
        case (i_ALUOp)
            2'b00: begin
                o_Op = 4'b1011;
            end
            2'b01: begin
                o_Op = 4'b1100;
            end
            2'b10: begin
                o_Op = 4'b1001;
            end
            2'b11: begin
                o_Op = 4'b1010;
            end
            default: begin
                o_Op = 4'b0000;
            end
        endcase
    end

endmodule
