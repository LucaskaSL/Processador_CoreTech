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

    always @(*) begin
        // a saída é 0.
        ReadData = 32'h0;
        if (MemRead) begin
            //verifica se o esta dentro dos limites (0,63)
            //se o endreco for maior que 0xFF (255),ele nao ta no espaco
            ReadData = mem_array[word_index];// ve a posicao do array
        end
    end
    //logica de escrita (store - mov [rx], ry)

    always @(posedge clk) begin
        if (MemWrite) begin
            //escreve os dados no indice da palavra selec
            mem_array[word_index] = WriteData;
        end
    end




endmodule


