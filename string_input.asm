 processor 6502
	org $1100
	; Starting new memory block at $1100
StartBlock1100
	; LineNumber: 8
	jmp block1
	; LineNumber: 6
reply_pointer	= $02
	
; // Address Locations of operating system functions
; // Entry point for OSBYTE http:
; //beebwiki.mdfs.net/OSBYTE
; // Print the char in accumulator 
; // Newline carriage return + new line
; // Print text + CRNL at ch13 in string
; // Video controller register
; // screen mode register 
; // Read Character
; // Cursor off
	; NodeProcedureDecl -1
	; ***********  Defining procedure : BBC_Textmode_cls
	;    Procedure type : User-defined procedure
	; LineNumber: 15
BBC_Textmode_cls
	; LineNumber: 16
	; Assigning memory location
	; Assigning single variable : $0
	lda #$c
	; Calling storevariable
	sta $0
	; LineNumber: 17
	jsr $ffee
	; LineNumber: 18
	; Assigning memory location
	; Assigning single variable : $0
	lda #$1e
	; Calling storevariable
	sta $0
	; LineNumber: 19
	jsr $ffee
	; LineNumber: 20
	rts
	; NodeProcedureDecl -1
	; ***********  Defining procedure : BBC_Textmode_screen_mode
	;    Procedure type : User-defined procedure
	; LineNumber: 40
	; LineNumber: 39
BBC_Textmode_selected_mode	dc.b	0
BBC_Textmode_screen_mode_block3
BBC_Textmode_screen_mode
	; LineNumber: 42
	; Assigning memory location
	; Assigning single variable : $0
	lda #$16
	; Calling storevariable
	sta $0
	; LineNumber: 43
	jsr $ffee
	; LineNumber: 44
	; Assigning memory location
	; Assigning single variable : $0
	lda BBC_Textmode_selected_mode
	; Calling storevariable
	sta $0
	; LineNumber: 45
	
; // Again, need to replace with a mode param
	jsr $ffee
	; LineNumber: 47
	rts
	; NodeProcedureDecl -1
	; ***********  Defining procedure : BBC_Textmode_mode_1
	;    Procedure type : User-defined procedure
	; LineNumber: 50
BBC_Textmode_mode_1
	; LineNumber: 52
	; Assigning single variable : BBC_Textmode_selected_mode
	lda #$1
	; Calling storevariable
	sta BBC_Textmode_selected_mode
	jsr BBC_Textmode_screen_mode
	; LineNumber: 54
	rts
	; NodeProcedureDecl -1
	; ***********  Defining procedure : BBC_Textmode_red
	;    Procedure type : User-defined procedure
	; LineNumber: 57
BBC_Textmode_red
	; LineNumber: 58
	; Assigning memory location
	; Assigning single variable : $0
	lda #$11
	; Calling storevariable
	sta $0
	; LineNumber: 59
	jsr $ffee
	; LineNumber: 60
	; Assigning memory location
	; Assigning single variable : $0
	lda #$1
	; Calling storevariable
	sta $0
	; LineNumber: 61
	
; // should use _chosen_text_colour but that doesn't work
	jsr $ffee
	; LineNumber: 62
	rts
	; NodeProcedureDecl -1
	; ***********  Defining procedure : BBC_Textmode_yellow
	;    Procedure type : User-defined procedure
	; LineNumber: 65
BBC_Textmode_yellow
	; LineNumber: 66
	; Assigning memory location
	; Assigning single variable : $0
	lda #$11
	; Calling storevariable
	sta $0
	; LineNumber: 67
	jsr $ffee
	; LineNumber: 68
	; Assigning memory location
	; Assigning single variable : $0
	lda #$2
	; Calling storevariable
	sta $0
	; LineNumber: 69
	
; // should use _chosen_text_colour but that doesn't work
	jsr $ffee
	; LineNumber: 70
	rts
	; NodeProcedureDecl -1
	; ***********  Defining procedure : BBC_Textmode_print_string
	;    Procedure type : User-defined procedure
	; LineNumber: 85
	; LineNumber: 82
BBC_Textmode_ch	dc.b	0
	; LineNumber: 83
BBC_Textmode_next_ch	dc.b	0
	; LineNumber: 80
BBC_Textmode_in_str	= $04
	; LineNumber: 80
BBC_Textmode_CRLF	dc.b	$01
BBC_Textmode_print_string_block7
BBC_Textmode_print_string
	; LineNumber: 87
	; Assigning single variable : BBC_Textmode_next_ch
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_next_ch
	; LineNumber: 89
BBC_Textmode_print_string_while8
BBC_Textmode_print_string_loopstart12
	; Binary clause Simplified: NOTEQUALS
	; Load pointer array
	ldy BBC_Textmode_next_ch
	lda (BBC_Textmode_in_str),y
	; Compare with pure num / var optimization
	cmp #$0;keep
	beq BBC_Textmode_print_string_elsedoneblock11
BBC_Textmode_print_string_ConditionalTrueBlock9: ;Main true block ;keep 
	; LineNumber: 90
	; LineNumber: 91
	; Assigning single variable : BBC_Textmode_ch
	; Load pointer array
	ldy BBC_Textmode_next_ch
	lda (BBC_Textmode_in_str),y
	; Calling storevariable
	sta BBC_Textmode_ch
	; LineNumber: 92
	; Assigning memory location
	; Assigning single variable : $0
	; Calling storevariable
	sta $0
	; LineNumber: 93
	jsr $ffee
	; LineNumber: 94
	inc BBC_Textmode_next_ch
	; LineNumber: 95
	jmp BBC_Textmode_print_string_while8
BBC_Textmode_print_string_elsedoneblock11
BBC_Textmode_print_string_loopend13
	; LineNumber: 97
	; Binary clause Simplified: NOTEQUALS
	lda BBC_Textmode_CRLF
	; Compare with pure num / var optimization
	cmp #$0;keep
	beq BBC_Textmode_print_string_elsedoneblock21
BBC_Textmode_print_string_ConditionalTrueBlock19: ;Main true block ;keep 
	; LineNumber: 96
	jsr $ffe7
BBC_Textmode_print_string_elsedoneblock21
	; LineNumber: 98
	rts
	; NodeProcedureDecl -1
	; ***********  Defining procedure : BBC_Textmode_get_ch
	;    Procedure type : User-defined procedure
	; LineNumber: 102
	; LineNumber: 101
BBC_Textmode_show_ch	dc.b	$00
BBC_Textmode_get_ch_block24
BBC_Textmode_get_ch
	; LineNumber: 104
	; Assigning memory location
	; Assigning single variable : $0
	lda #$1
	; Calling storevariable
	sta $0
	; LineNumber: 105
	; Assigning memory location
	; Assigning single variable : $0
	lda #$f
	; Calling storevariable
	sta $0
	; LineNumber: 106
	jsr $fff4
	; LineNumber: 107
	jsr $ffe0
	; LineNumber: 108
	jsr $ffee
	; LineNumber: 109
	rts
	; NodeProcedureDecl -1
	; ***********  Defining procedure : BBC_Textmode_get_string
	;    Procedure type : User-defined procedure
	; LineNumber: 119
	; LineNumber: 113
BBC_Textmode_this_ch	dc.b	0
	; LineNumber: 113
BBC_Textmode_buffer_counter	dc.b	0
	; LineNumber: 116
BBC_Textmode_str_buffer	dc.b	 
	org BBC_Textmode_str_buffer+40
	; LineNumber: 117
BBC_Textmode_str_pointer	= $04
BBC_Textmode_get_string_block25
BBC_Textmode_get_string
	; LineNumber: 120
	
; //    temporary uuntil figure out returning strings from functions	
	; Assigning single variable : BBC_Textmode_this_ch
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_this_ch
	; LineNumber: 121
	; Assigning single variable : BBC_Textmode_buffer_counter
	; Calling storevariable
	sta BBC_Textmode_buffer_counter
	; LineNumber: 122
	; Assigning single variable : BBC_Textmode_str_pointer
	lda #<BBC_Textmode_str_buffer
	ldx #>BBC_Textmode_str_buffer
	sta BBC_Textmode_str_pointer
	stx BBC_Textmode_str_pointer+1
	; LineNumber: 123
	ldy #$28 ; optimized, look out for bugs
	lda #$41
BBC_Textmode_get_string_fill26
	sta (BBC_Textmode_str_pointer),y
	dey
	bpl BBC_Textmode_get_string_fill26
	; LineNumber: 125
BBC_Textmode_get_string_while27
BBC_Textmode_get_string_loopstart31
	; Binary clause Simplified: NOTEQUALS
	lda BBC_Textmode_this_ch
	; Compare with pure num / var optimization
	cmp #$d;keep
	beq BBC_Textmode_get_string_elsedoneblock30
BBC_Textmode_get_string_localsuccess35: ;keep
	; ; logical AND, second requirement
	; Binary clause Simplified: LESS
	lda BBC_Textmode_buffer_counter
	; Compare with pure num / var optimization
	cmp #$28;keep
	bcs BBC_Textmode_get_string_elsedoneblock30
BBC_Textmode_get_string_ConditionalTrueBlock28: ;Main true block ;keep 
	; LineNumber: 126
	; LineNumber: 127
	; Assigning single variable : BBC_Textmode_this_ch
	; Assigning single variable : BBC_Textmode_show_ch
	lda #$1
	; Calling storevariable
	sta BBC_Textmode_show_ch
	jsr BBC_Textmode_get_ch
	; Calling storevariable
	sta BBC_Textmode_this_ch
	; LineNumber: 128
	; Assigning single variable : BBC_Textmode_str_buffer
	; Store Variable simplified optimization : right-hand term is pure
	ldx BBC_Textmode_buffer_counter ; optimized, look out for bugs
	sta BBC_Textmode_str_buffer,x
	; LineNumber: 129
	inc BBC_Textmode_buffer_counter
	; LineNumber: 130
	jmp BBC_Textmode_get_string_while27
BBC_Textmode_get_string_elsedoneblock30
BBC_Textmode_get_string_loopend32
	; LineNumber: 133
	
; // Using an array so needs a 0		
	; Assigning single variable : BBC_Textmode_str_buffer
	; Store Variable simplified optimization : right-hand term is pure
	ldx BBC_Textmode_buffer_counter ; optimized, look out for bugs
	lda #$0
	sta BBC_Textmode_str_buffer,x
	; LineNumber: 134
	; Assigning single variable : BBC_Textmode_str_pointer
	lda #<BBC_Textmode_str_buffer
	ldx #>BBC_Textmode_str_buffer
	sta BBC_Textmode_str_pointer
	stx BBC_Textmode_str_pointer+1
	; LineNumber: 136
	; LineNumber: 136
	; integer assignment NodeVar
	ldy BBC_Textmode_str_pointer+1 ; Next one
	rts
	; NodeProcedureDecl -1
	; ***********  Defining procedure : BBC_Textmode_wait_key
	;    Procedure type : User-defined procedure
	; LineNumber: 139
BBC_Textmode_wait_key
	; LineNumber: 140
BBC_Textmode_wait_key_while39
BBC_Textmode_wait_key_loopstart43
	; Binary clause Simplified: EQUALS
	; Assigning single variable : BBC_Textmode_show_ch
	lda BBC_Textmode_str_pointer#$0
	; Calling storevariable
	sta BBC_Textmode_show_ch
	jsr BBC_Textmode_get_ch
	; Compare with pure num / var optimization
	cmp #$0;keep
	bne BBC_Textmode_wait_key_elsedoneblock42
BBC_Textmode_wait_key_ConditionalTrueBlock40: ;Main true block ;keep 
	; LineNumber: 141
	; LineNumber: 143
	jmp BBC_Textmode_wait_key_while39
BBC_Textmode_wait_key_elsedoneblock42
BBC_Textmode_wait_key_loopend44
	; LineNumber: 144
	rts
	; NodeProcedureDecl -1
	; ***********  Defining procedure : BBC_Textmode_beep
	;    Procedure type : User-defined procedure
	; LineNumber: 149
	; LineNumber: 148
BBC_Textmode_beep_string		dc.b	7
	dc.b	0
	dc.b	0
BBC_Textmode_beep_block47
BBC_Textmode_beep
	; LineNumber: 150
	; Assigning single variable : BBC_Textmode_in_str
	lda #<BBC_Textmode_beep_string
	ldx #>BBC_Textmode_beep_string
	sta BBC_Textmode_in_str
	stx BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$1
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	; LineNumber: 151
	rts
block1
	; LineNumber: 11
	
; // Set screen to mode 1 and red text
	jsr BBC_Textmode_mode_1
	; LineNumber: 12
	jsr BBC_Textmode_cls
	; LineNumber: 13
	jsr BBC_Textmode_red
	; LineNumber: 14
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr48
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr48
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$1
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	; LineNumber: 15
	jsr BBC_Textmode_wait_key
	; LineNumber: 18
	
; // Clear screen and show question in yellow
	jsr BBC_Textmode_cls
	; LineNumber: 19
	jsr BBC_Textmode_yellow
	; LineNumber: 20
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr50
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr50
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$1
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	; LineNumber: 21
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr52
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr52
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	; LineNumber: 24
	
; // can't return string so return pointer to a string
	; Assigning single variable : reply_pointer
	jsr BBC_Textmode_get_string
	sta reply_pointer
	sty reply_pointer+1
	; LineNumber: 27
	
; // Output result:
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr54
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr54
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	; LineNumber: 28
	; Assigning single variable : BBC_Textmode_in_str
	lda reply_pointer
	ldx reply_pointer+1
	sta BBC_Textmode_in_str
	stx BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$1
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	; LineNumber: 29
	jsr BBC_Textmode_beep
	; LineNumber: 31
	; End of program
	; Ending memory block
EndBlock1100
MainProgram_stringassignstr48	.dc "Press a key ...",0
MainProgram_stringassignstr50	.dc "What is your name?",0
MainProgram_stringassignstr52	.dc "> ",0
MainProgram_stringassignstr54	.dc "Hello ",0
