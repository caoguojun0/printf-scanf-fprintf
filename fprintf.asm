section .data
    format_string db "My name is: %s", 0xa, "And my surname: %s",0xa, "Not random char: %c",  0
    string_to_print_1 db "Alex", 0
    string_to_print_2 db "Sazonov", 0
    char_to_print db "!", 0xA, 0
    file_name db "printf.txt", 0

section .bss
    fd resb 4
   
section .text

global _start

_start:

    ; put the lines you want to enter on the stack in reverse order
    push char_to_print
    push string_to_print_2
    push string_to_print_1
    ; put a format string in edi
    mov edi, format_string
    

    
    call print

print:
    mov eax, 8
    mov ebx, file_name
    mov ecx, 420
    int 0x80

    mov [fd], eax    

    push ebp
    mov ebp, esp
    add ebp, 4
    jmp start_print
    
start_print:

  cmp byte[edi], 0
  je end_ret
  
  cmp byte[edi], 0x25
  je check_format
  
  mov ecx, edi
  mov ebx, [fd]
  mov edx, 1
  mov eax,4
  int 0x80
  
  inc edi
  
  jmp start_print

check_format:
    inc edi 

    cmp byte[edi], 0x73
    je print_smth
    
    cmp byte[edi], 0x63
    je print_smth
    
    jmp start_print

print_smth:
    inc edi
    
    add ebp, 4 
   
    mov esi, [ebp]
    ;add ebp, 4
   

    jmp print_loop
    
print_loop:
    cmp byte[esi], 0
    je end_print_loop
   
    mov ecx, esi
    mov ebx, [fd]
    mov edx, 1
    mov eax,4
    int 0x80
  
    inc esi
    jmp print_loop
    
end_print_loop:
    jmp start_print

end_ret:
    mov eax, 6
    mov ebx, [fd]
    int 0x80
   
    mov     eax, 1
    mov     ebx, 0
    int     0x80