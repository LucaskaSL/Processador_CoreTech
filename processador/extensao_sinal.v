module extensao_sinal(
  input wire [15:0] in,    // Entrada de 16 bits a ser estendida
  output wire [31:0] out   // Saída de 32 bits com sinal estendido
);
  assign out = {{16{in[15]}}, in};

endmodule
