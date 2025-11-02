module memory (
    input wire clk,
    input wire MemWrite,  // 1 para escrever
    input wire MemRead,   // 1 para ler
    input wire [31:0] MemAddress,
    input wire [31:0] WriteData,
    output reg [31:0] ReadData
);