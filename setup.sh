#!/bin/bash
echo "instalando dependências do projeto para o PSEL da CoreTech"

sudo apt update
sudo apt install -y iverilog gtkwave make

echo " ambiente pronto"
echo "   make sim"


#rodar isso no terminal:
# chmod +x setup.sh
# ./setup.sh