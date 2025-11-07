mov x1, 64   ; add 64(0x40) no reg 1
mov x2, x1   ; mover (0x40)
mov [x2], x1 ; carregar na memoria no endereco 0x40
mov x3, [x2] ; pegar da memoria e colocar no reg 3
jmp 3
mov x4, 31   ; pula
mov x4, 31   ; pula
mov x4, 31   ; pula
add x1, x2   ; 0x40 + 0x40 = 0x80
sub x1, x2   ; 0x80 - 0x40 = 0x40
and x1, x4   ; 0x40 & 0x00 = 0x00
or x1, x2    ; 0x00 | 0x40 = 0x40
halt         ; parou, maos pro alto
