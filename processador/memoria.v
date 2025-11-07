module memory (
    input wire clk,
    input wire MemWrite,  // 1 para escrever
    input wire MemRead,   // 1 para ler
    input wire [31:0] instructionAddress,
    input wire [31:0] MemAddress,
    input wire [31:0] WriteData,
    output reg [31:0] ReadData,
    output wire [31:0] instruction

);

    reg [31:0] mem_array [0:63]; // reg pra permitir a escrita no array, 64 bytes por palavra

    wire [5:0] word_index = MemAddress[7:2]; // 6 bits para indexar 64 palavras

    assign instruction = mem_array[instructionAddress[7:2]];

    integer i;
    initial begin
        mem_array[0] = 32'h00100040;
        mem_array[1] = 32'h01210000;
        mem_array[2] = 32'h03210000;
        mem_array[3] = 32'h02320000;
        mem_array[4] = 32'h05000003;
        mem_array[5] = 32'h004000FF;
        mem_array[6] = 32'h004000FF;
        mem_array[7] = 32'h004000FF;
        mem_array[8] = 32'h09120000;
        mem_array[9] = 32'h0A120000;
        mem_array[10] = 32'h0B140000;
        mem_array[11] = 32'h0C120000;
        mem_array[12] = 32'hFF000000;
        for (i = 13; i < 63; i = i + 1) begin
            mem_array[i] = 32'b0;  // Inicializa todos com zero
        end
    end
    
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


