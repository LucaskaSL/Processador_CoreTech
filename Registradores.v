module Registradores(
    input wire [3:0] ReadRegister1,  // Endereço do registrador para leitura 1
    input wire [3:0] ReadRegister2,  // Endereço do registrador para leitura 2
    input wire [3:0] WriteRegister,  // Endereço do registrador para escrita
    input wire [32:0] WriteData,     // Dados a serem escritos
    input wire RegWrite,             // Habilitação de escrita
    input wire clock,                // sincronizar com o clock do sistema
    output wire [32:0] ReadData1,    // Dados lidos do registrador 1
    output wire [32:0] ReadData2     // Dados lidos do registrador 2
);

    // Banco de registradores: 32 registradores de 32 bits
    reg [31:0] registers [15:0];

    // Inicialização dos registradores (opcional, apenas para simulação)
    integer i;
    initial begin
        for (i = 0; i < 16; i = i + 1) begin
            registers[i] = 32'b0;  // Inicializa todos com zero
        end
    end

    // Leitura combinacional
    assign ReadData1 = registers[ReadRegister1];
    assign ReadData2 = registers[ReadRegister2];

    // Escrita síncrona
    always @(posedge clock) begin
        if (RegWrite && WriteRegister != 4'b0) begin
            registers[WriteRegister] <= WriteData;  // Escreve no registrador
        end
    end

endmodule