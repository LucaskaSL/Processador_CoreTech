# Nome do arquivo de saída
OUTPUT = sim.out

# arquivos Verilog (procura todos na pasta atual e em subpastas)
SRC = $(shell find . -name "*.v")

# arquivo de teste (caso exista)
TB = tb_top.v

# Regra padrão
all: sim

# compila e simula
sim:
	@echo "🔧 Compilando com iverilog..."
	iverilog -o $(OUTPUT) $(SRC)
	@echo "▶️ Executando simulação..."
	vvp $(OUTPUT)

# ver onda (se dump.vcd existir)
wave:
	@if [ -f dump.vcd ]; then \
		echo "🔍 Abrindo GTKWave..."; \
		gtkwave dump.vcd & \
	else \
		echo "⚠️ Nenhum arquivo dump.vcd encontrado. Rode 'make sim' primeiro."; \
	fi

# limpa arquivos gerados
clean:
	rm -f $(OUTPUT) dump.vcd
