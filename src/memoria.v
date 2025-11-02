module memory (
    input wire clk,
    input wire MemWrite,  // 1 para escrever
    input wire MemRead,   // 1 para ler
    input wire [31:0] MemAddress,
    input wire [31:0] WriteData,
    output reg [31:0] ReadData
);

    reg [31:0] mem_array [0:63]; // reg pra permitir a escrita no array, 64 bytes por palavra

    wire [5:0] word_index = MemAddress[7:2]; // 6 bits para indexar 64 palavras

    



endmodule


