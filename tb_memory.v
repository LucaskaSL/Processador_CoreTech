`timescale 1ns / 1ps

module tb_memory;

    // sinais para a memmria 
    reg clk;
    reg MemWrite;
    reg MemRead;
    reg [31:0] MemAddress;
    reg [31:0] WriteData;
    
    // saida da memoria
    wire [31:0] ReadData;

    // instancia do modulo da memoria
    memory UUT ( 
        .clk(clk),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .MemAddress(MemAddress),
        .WriteData(WriteData),
        .ReadData(ReadData)
    );

   
    parameter CLK_PERIOD = 10;
    initial begin
        clk = 0;
        forever #(CLK_PERIOD / 2) clk = ~clk;
    end
    
  
    initial begin
       
        MemWrite = 0;
        MemRead = 0;
        MemAddress = 32'h0;
        WriteData = 32'h0;

        $display("--- Iniciando Teste da Memoria ---");
        
        #5; 

       
        MemAddress = 32'h00000000;
        MemRead = 1;
        
        #CLK_PERIOD; 
        $display("Tempo %0t: ReadData (Addr 0x00): %h", $time, ReadData);
        
        MemRead = 0; 
    
        $display("Tentando escrever o dado 0xDEADBEEF no endereco 0x40...");
        
        MemAddress = 32'h00000040;
        WriteData = 32'hDEADBEEF;
        MemWrite = 1;

        #CLK_PERIOD; 
        $display("Tempo %0t: Escrita concluida.", $time);
        
        MemWrite = 0;

        $display("Tentando ler o dado do endereco 0x40...");
        
       
        MemRead = 1;
        
        #5; 
        $display("Tempo %0t: ReadData (Addr 0x40): %h", $time, ReadData);
        
        if (ReadData === 32'hDEADBEEF) begin
            $display("SUCESSO: Escrita e Leitura de dados confirmada.");
        end else begin
            $display("FALHA: Dado lido (%h) nao corresponde ao esperado (DEADBEEF).", ReadData);
        end
        
        MemRead = 0;

        
        $finish;
    end

endmodule