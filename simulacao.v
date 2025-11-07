`timescale 1ns/1ns
`include "processador/PQP.v"


module Simulacao;

    reg clk;
    reg reset;

    PQP pqp(
        .i_Clk(clk),
        .i_Rst(reset)
    );

    // Gera o clock
    always #5 clk = ~clk;

    initial begin
        // Inicializa sinais
        clk = 0;
        reset = 0;  // Desabilita o reset. No comeco, PC desconhecido.
        #5
        reset = 1;
        #10
        reset = 0;
        #150
        $finish;
    end

    // Monitora as instruções buscadas
    always @(posedge clk) begin
        $display("PC: %d | Instrucao: %x | Instrucao jump: %b", pqp.PC, pqp.instrucao, pqp.Jump);
    end
    
    // Bloco para inicializar o dump de formas de onda
    // em um VCD para ver no GTK Wave.
    integer i;
    initial begin
        $dumpfile("sim.vcd"); // Nome do arquivo de saída
        $dumpvars(0, Simulacao);    // Registrar todas as variáveis deste módulo
        for (i=0; i<16; i=i+1) begin
            $dumpvars(1, Simulacao.pqp.banco.registers[i]);
        end
    end

endmodule
