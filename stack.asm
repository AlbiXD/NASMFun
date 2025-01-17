section .bss
        stack resb 5
        input resb 5 ;POP\0, PSH

section .data
        prompt db "Please Type POP/PUSH to add/remove from stack or ESC to Terminate: ", 0xA
        len equ $-prompt
section .text
        global _start


_start: ;Infinietly Loop Until ESC (MAIN LOGIC)
        call    _prompt1
        call    _userInput

        mov     al, [rsi]

        if_first_ESCAPE: ;CHECKS IF USER TERMINATES
                cmp     al, 0x1B
                je      done
         ;LOOP DONE INDICATOR

        if_pop:



        jmp     _start



_prompt1: ;Prompt to POP or PUSH or Terminate
        mov     rax, 1
        mov     rdi, 1
        mov     rsi, prompt
        mov     rdx, len
        syscall
        ret


_userInput:;Gets User Input
        mov     rax, 0
        mov     rdi, 0
        mov     rsi, input
        mov     rdx, 5
        syscall
        cmp     rax, 3
        je      je_its3
        jne     je_its4
        ret

je_its3:
        mov     byte [input+3], 0
        ret
je_its4:
        mov     byte [input+4], 0
        ret

done:
        mov     rax, 60
        mov     rdi, 0
        syscall