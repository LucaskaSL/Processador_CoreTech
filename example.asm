mov r1, 64   ; add 64(0x40) no reg 1
mov r2, r1   ; mover (0x40)
mov [r2], r1 ; carregar na memoria no endereco 0x40
mov r3, [r2] ; pegar da memoria e colocar no reg 3
jmp 3
mov r4, 31   ; pula
mov r4, 31   ; pula
mov r4, 31   ; pula
add r1, r2   ; 0x40 + 0x40 = 0x80
sub r1, r2   ; 0x80 - 0x40 = 0x40
and r1, r4   ; 0x40 & 0x00 = 0x00
or r1, r2    ; 0x00 | 0x40 = 0x40
halt         ; parou, maos pro alto
