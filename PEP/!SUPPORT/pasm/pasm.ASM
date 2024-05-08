


format PE GUI 4.0 DLL  at 0x20000000
entry depoint

align 8


include '..\version.inc'

include '..\errors.inc'
include '..\symbdump.inc'
include '..\preproce.inc'
include '..\parser.inc'
include '..\exprpars.inc'
include '..\assemble.inc'
include '..\exprcalc.inc'
include '..\formats.inc'
include '..\x86_64.inc'
include '..\avx.inc'

include '..\tables.inc'
include '..\messages.inc'
include '..\variable.inc'
include '..\..\INCLUDE\win32a.inc'


 lib_io dd 0
 lib_w dd 0
 lib_r dd 0
 lib_in dd 0
 lib_in_size dd 0
 lib_out dd 0
 in_file db  '', 0

 lib_en  dd 0
 lib_es  dd 0


section '.code' code readable writeable executable

proc depoint hinstDLL,fdwReason,lpvReserved

     init_stack_frame:
	mov	[input_file],in_file
	mov	[output_file], in_file
	mov	[symbols_file],in_file
	mov	[memory_setting],0
	mov	[passes_limit],100
	mov	[start_time],0

	mov    eax, [fdwReason]
	cmp    eax, 1
	je   attach_lib
	cmp    eax, 0
	je   dettach_lib
	mov	eax,TRUE
	jmp  clear_stack_frame


     attach_lib:
init_memory:
	xor	eax,eax
	mov	[memory_start],eax
	mov	eax,esp
	and	eax,not 0FFFh
	add	eax,1000h-10000h
	mov	[stack_limit],eax
	mov	eax, 300000h ; //[memory_setting]
	;shl     eax,10
       ; jnz     allocate_memory
       ; push    buffer
       ; call    [GlobalMemoryStatus]
       ; mov     eax,dword [buffer+20]
       ; shr     eax,2
       ; add     eax,dword [buffer+12]
    allocate_memory:
	mov	edx,eax
	shr	edx,2
	mov	ecx,eax
	sub	ecx,edx
	mov	[memory_end],ecx
	mov	[additional_memory_end],edx
	push	PAGE_READWRITE
	push	MEM_COMMIT
	push	eax  ; // fixed size, eax
	push	0
	call	[VirtualAlloc]
	or	eax,eax
	jz	not_enough_memory
	mov	[memory_start],eax
	add	eax,[memory_end]
	mov	[memory_end],eax
	mov	[additional_memory],eax
	add	[additional_memory_end],eax
	mov	eax,TRUE
	jmp  clear_stack_frame
    not_enough_memory:
	mov	eax,[additional_memory_end]
	shl	eax,1
	cmp	eax,4000h
	jb	out_of_memory2
	jmp	allocate_memory

	mov	eax,TRUE
	jmp  clear_stack_frame
    out_of_memory2:
	mov	eax,FALSE
	jmp  clear_stack_frame


     dettach_lib:
	push	MEM_RELEASE
	push	0
	mov  eax, [memory_start]
	push	eax
	call	[VirtualFree]
	mov	eax,TRUE
	jmp  clear_stack_frame

    clear_stack_frame:
       ret
endp




; VOID aline();
; eax -> in_buffer as ansistring
; ecx -> in_size
; ebx -> out_buf

proc aline  var_in_buf, var_in_size, var_out_buf

start:
     init_proc_stack_frame:
      pushad
	mov eax, [var_in_buf]
	mov	[lib_in], eax

	mov eax, [var_in_size]
	mov	[lib_in_size], eax

	mov eax, [var_out_buf]
	mov	[lib_out], eax

	mov	[input_file],in_file
	mov	[output_file],in_file
	mov	[symbols_file],in_file
	mov	[memory_setting],0
	mov	[passes_limit],100
	mov	[start_time],0

	mov	eax,esp
	and	eax,not 0FFFh
	add	eax,1000h-10000h
	mov	[stack_limit],eax

	mov	[lib_w], 0
	mov	[lib_r], 0
	mov	[lib_es], 0
	mov	[lib_en], 0
	mov	[lib_io], 0

	call	preprocessor
	call	parser
	call	assembler
	call	formatter
	mov eax, [code_size]
	mov	[lib_io],eax

    exit_program:
    clear_proc_stack_frame:
     popad
       mov eax, [lib_io]
       mov ecx, [lib_es]
       mov edx, [lib_en]
       ret
endp





make_timestamp:
	nop
	ret

display_block:
	nop
	ret

get_environment_variable:
	nop
	ret

open:
      mov eax, 1
      clc
      ret


create:
      mov eax, 2
      clc
      ret



write:
   pushad
      push ecx
      mov esi, edx	    ; edx - buffer
      mov edi, [lib_out]
      add edi, [lib_w]
      rep movsb
      pop ecx
      add [lib_w], ecx
   popad
      mov eax, 1
      clc
      ret


read:
      ; can we read ecx count ?
      mov eax, [lib_in_size] ; size
      sub eax, [lib_r]	   ; position
      cmp eax, 0
      jg n1
       mov eax, 0
       stc
       ret
    n1:
  pushad
      cmp eax, ecx
      jge n3; >= can read
      mov ecx, eax ; max read

    n3:
     push ecx
     mov esi, [lib_in]
     add esi, [lib_r]
     mov edi, edx
     rep movsb
     pop ecx
     add [lib_r], ecx
     clc
     jmp end_read
    n4:
     push ecx
     mov esi, [lib_in]
     add esi, [lib_r]
     mov edi, edx
     rep movsb
     pop ecx
     add [lib_r], ecx
     stc
     jmp end_read
   end_read:
    popad
     mov eax, 1
     ret



 close:
	ret



lseek:
    pushad
	movzx	eax,al
	cmp eax ,0
	je fb
	cmp eax, 1
	je fc
	cmp eax, 2
	je fe
	jmp ex_f


      fb:
	mov [lib_r], edx
	jmp ex_f

      fc:
	mov eax, [lib_r]
	add eax, edx
	mov [lib_r], eax
	jmp ex_f

      fe:
	 mov eax, [lib_in_size]
	 add eax, edx
	 mov [lib_r], eax
	 jmp ex_f
      ex_f:
    popad
      mov eax, [lib_r]
	ret




fatal_error:
	pop [lib_es]
	jmp	exit_program


assembler_error:
	pop [lib_es]
	mov ebx,[current_line]
	mov [lib_en], ebx
	pop eax  ; 2 calls from unknown parser
	pop eax
	jmp	exit_program





MEM_COMMIT	       = 1000h
MEM_RELEASE	       = 8000h

PAGE_READWRITE	       = 4









con_handle dd ?
memory_setting dd ? ; //1024 kb  ~ 3 Mb
start_time dd ?

params rb 1000h
options rb 1000h
buffer rb 4000h

stack 10000h

section '.edata' export data readable

  export ' ',\
	 aline,'aline'



section '.idata' import data readable writeable

  dd 0,0,0,rva kernel_name,rva kernel_table
  dd 0,0,0,0,0

  kernel_table:
    VirtualAlloc dd rva _VirtualAlloc
    VirtualFree dd rva _VirtualFree
    GlobalMemoryStatus dd rva _GlobalMemoryStatus
    dd 0

  kernel_name db 'KERNEL32.DLL',0


  _VirtualAlloc dw 0
    db 'VirtualAlloc',0
  _VirtualFree dw 0
    db 'VirtualFree',0
  _GlobalMemoryStatus dw 0
    db 'GlobalMemoryStatus',0

section '.reloc' fixups data readable discardable
