module ShiftLeft2(
    input [15:0] in, 
    output [31:0] out
);

    assign out = {14'b0, in << 2};

endmodule
