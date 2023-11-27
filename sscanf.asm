section .data
    buffer db "helloWorld !", 0x0
    format_string db "%s %c", 0x0
    test_ db 0xa
section .bss
    string resb 11
    char resb 2

section .text

global _start

_start:
   
    ; put the lines you want to enter on the stack in reverse order
    push char
    push string

    ; put a format string in edi
    mov edi, format_string
    

    
    call scanf
    jmp end
    
scanf:
    push ebp
    mov ebp, esp
    mov esi, buffer
    add ebp, 4
	
scanf_to_buffer:

    mov     eax, 3
    mov     ebx, 0
    mov     ecx, esi
    mov     edx, 100
    
    int     0x80
    
    xor     ecx, ecx
printf_buffer:
    ; mov     esi, buffer
    ; mov     eax, 4
    ; mov     ebx, 1
    ; mov     ecx, esi
    ; mov     edx, 100
    ; int     0x80
    
    
percent_counter:
    cmp     byte[edi], 0x0; цикл до конца строчки формата
    je      start_read
    
    cmp     byte[edi], 0x25; как только нашли процент
    je      percent_pp
    
    inc     edi
    
    jmp     percent_counter
percent_pp:

    inc     ebx; кол-во процентов в строке формата
    inc     edi
    jmp     percent_counter
    
start_read:

    cmp     ebx, 0; цикл, ebx уменьшается после каждого найденного пробела
    je      end
    
    add     ebp, 4
    mov     esi, [ebp]; лежит строчка в которую мы хотим записать значение из буфера
    
buffer_to_str:

    cmp     byte[buffer+ecx], 0x0 ; цикл по найденному слову, запись в буфер прекращается, как только встречаем пробел 
    je      end_scanf
    
    cmp     byte[buffer+ecx], 0xa ; цикл заканчивается, как только мы дошли до конца buffer
    je      end_scanf
    
    mov     al, byte[buffer+ecx]
    mov     [esi], al
    
    ; push    ebx
    ; push    ecx
    ; xor     ecx, ecx
    ; xor     ebx,ebx
    
    ; mov     eax, 4
    ; mov     ebx, 1
    ; mov     ecx, [esi]
    ; mov     edx, 1
    ; int     0x80
    
    ; pop     ecx
    ; pop     ebx
    
    inc     esi
    inc     ecx
    
    jmp     buffer_to_str
    
end_scanf:

    sub     ebx, 1
    jmp     start_read
    
ret_:
    ret
end:
   ;проверка путем вывода
   
;   вывод значения string после выполнения всей программы 
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, string
    mov     edx, 10
    int     0x80
    
    ;переход на новую строчку
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, test_
    mov     edx, 1
    int     0x80
    
    ;вывод значения char после выполнения всей программы 
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, char
    mov     edx, 1
    int     0x80
    
    
    mov     eax, 1
    mov     ebx, 0
    int     0x80
  
