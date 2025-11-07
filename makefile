# Variáveis
IVERILOG = iverilog
VVP = vvp
GTKWAVE = gtkwave
DUT = simulacao.v
EXEC = sim.vvp
VCD = sim.vcd

CLEAN_CMD = rm -f

ifeq ($(OS),Windows_NT)
	CLEAN_CMD = del /f /q 2>nul
endif
# Regras
.PHONY: all sim run view clean

# Regra principal
all: clean sim run view

# Compila o testbench e gera o executável da simulação
sim: $(DUT)
	$(IVERILOG) -o $(EXEC) $(DUT)

# Executa a simulação para gerar o arquivo .vcd
run: $(EXEC)
	$(VVP) $(EXEC)

# Abre o GTKWave para visualizar o arquivo .vcd
view: $(VCD)
	$(GTKWAVE) $(VCD)

# Limpa os arquivos gerados
clean:
	$(CLEAN_CMD) $(EXEC) $(VCD)
