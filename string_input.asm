 processor 6502
	org $1100
	; Starting new memory block at $1100
StartBlock1100
	; LineNumber: 185
	jmp block1
	; LineNumber: 3
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
; //unit BBC_Textmode;
; //
; //var
; //	
; // Address Locations of operating system functions
; //	const	OSBYTE: address =  $FFF4; 
; // Entry point for OSBYTE http:
; //beebwiki.mdfs.net/OSBYTE
; //	const 	OSWRCH: address =  $FFEE; 
; // Print the char in accumulator 
; //	const 	OSNEWL: address =  $FFE7; 
; // Newline carriage return + new line
; //	const 	OSASCI: address =  $FFE3; 
; // Print text + CRNL at ch13 in string
; //	const	CRTC_V: address =  $FE00; 
; // Video controller register
; //	const	SCR_MO: address =  $FE20; 
; // screen mode register 
; //	const	OSRDCH: address =  $FFE0; 
; // Read Character
; //	const	CUR_OF: address =  $FE01; 
; // Cursor off
; //
	; NodeProcedureDecl -1
	; ***********  Defining procedure : cls
	;    Procedure type : User-defined procedure
	; LineNumber: 32
cls
	; LineNumber: 33
	; ****** Inline assembler section
 LDA #12
	; LineNumber: 34
	jsr $ffee
	; LineNumber: 35
	; ****** Inline assembler section
 LDA #30
	; LineNumber: 36
	jsr $ffee
	; LineNumber: 37
	rts
	; NodeProcedureDecl -1
	; ***********  Defining procedure : screen_mode
	;    Procedure type : User-defined procedure
	; LineNumber: 57
	; LineNumber: 56
selected_mode	dc.b	0
screen_mode_block3
screen_mode
	; LineNumber: 59
	; ****** Inline assembler section
 LDA #22
	; LineNumber: 60
	jsr $ffee
	; LineNumber: 61
	; ****** Inline assembler section
 LDA selected_mode
	; LineNumber: 62
	
; // Again, need to replace with a mode param
	jsr $ffee
	; LineNumber: 64
	rts
	; NodeProcedureDecl -1
	; ***********  Defining procedure : mode_1
	;    Procedure type : User-defined procedure
	; LineNumber: 67
mode_1
	; LineNumber: 69
	; Assigning single variable : selected_mode
	lda #$1
	; Calling storevariable
	sta selected_mode
	jsr screen_mode
	; LineNumber: 71
	rts
	; NodeProcedureDecl -1
	; ***********  Defining procedure : red
	;    Procedure type : User-defined procedure
	; LineNumber: 74
red
	; LineNumber: 75
	; ****** Inline assembler section
 LDA #17
	; LineNumber: 76
	jsr $ffee
	; LineNumber: 77
	; ****** Inline assembler section
 LDA #1;
	; LineNumber: 78
	
; // should use _chosen_text_colour but that doesn't work
	jsr $ffee
	; LineNumber: 79
	rts
	; NodeProcedureDecl -1
	; ***********  Defining procedure : yellow
	;    Procedure type : User-defined procedure
	; LineNumber: 82
yellow
	; LineNumber: 83
	; ****** Inline assembler section
 LDA #17
	; LineNumber: 84
	jsr $ffee
	; LineNumber: 85
	; ****** Inline assembler section
 LDA #2
	; LineNumber: 86
	
; // should use _chosen_text_colour but that doesn't work
	jsr $ffee
	; LineNumber: 87
	rts
	; NodeProcedureDecl -1
	; ***********  Defining procedure : print_string
	;    Procedure type : User-defined procedure
	; LineNumber: 102
	; LineNumber: 99
ch	dc.b	0
	; LineNumber: 100
next_ch	dc.b	0
	; LineNumber: 97
in_str	= $04
	; LineNumber: 97
CRLF	dc.b	$01
print_string_block7
print_string
	; LineNumber: 104
	; Assigning single variable : next_ch
	lda #$0
	; Calling storevariable
	sta next_ch
	; LineNumber: 106
print_string_while8
print_string_loopstart12
	; Binary clause Simplified: NOTEQUALS
	; Load pointer array
	ldy next_ch
	lda (in_str),y
	; Compare with pure num / var optimization
	cmp #$0;keep
	beq print_string_elsedoneblock11
print_string_ConditionalTrueBlock9: ;Main true block ;keep 
	; LineNumber: 107
	; LineNumber: 108
	; Assigning single variable : ch
	; Load pointer array
	ldy next_ch
	lda (in_str),y
	; Calling storevariable
	sta ch
	; LineNumber: 109
	; ****** Inline assembler section
	; LineNumber: 110
	jsr $ffee
	; LineNumber: 111
	inc next_ch
	; LineNumber: 112
	jmp print_string_while8
print_string_elsedoneblock11
print_string_loopend13
	; LineNumber: 114
	; Binary clause Simplified: NOTEQUALS
	lda CRLF
	; Compare with pure num / var optimization
	cmp #$0;keep
	beq print_string_elsedoneblock21
print_string_ConditionalTrueBlock19: ;Main true block ;keep 
	; LineNumber: 113
	jsr $ffe7
print_string_elsedoneblock21
	; LineNumber: 115
	rts
	; NodeProcedureDecl -1
	; ***********  Defining procedure : get_ch
	;    Procedure type : User-defined procedure
	; LineNumber: 119
	; LineNumber: 118
show_ch	dc.b	$00
get_ch_block24
get_ch
	; LineNumber: 121
	; ****** Inline assembler section
 LDX #1
	; LineNumber: 122
	; ****** Inline assembler section
 LDA #15
	; LineNumber: 123
	jsr $fff4
	; LineNumber: 124
	jsr $ffe0
	; LineNumber: 125
	jsr $ffee
	; LineNumber: 126
	rts
	; NodeProcedureDecl -1
	; ***********  Defining procedure : get_string
	;    Procedure type : User-defined procedure
	; LineNumber: 136
	; LineNumber: 130
this_ch	dc.b	0
	; LineNumber: 130
buffer_counter	dc.b	0
	; LineNumber: 133
str_buffer	dc.b	 
	org str_buffer+40
	; LineNumber: 134
str_pointer	= $04
get_string_block25
get_string
	; LineNumber: 137
	
; //    temporary uuntil figure out returning strings from functions	
	; Assigning single variable : this_ch
	lda #$0
	; Calling storevariable
	sta this_ch
	; LineNumber: 138
	; Assigning single variable : buffer_counter
	; Calling storevariable
	sta buffer_counter
	; LineNumber: 139
	; Assigning single variable : str_pointer
	lda #<str_buffer
	ldx #>str_buffer
	sta str_pointer
	stx str_pointer+1
	; LineNumber: 140
	ldy #$28 ; optimized, look out for bugs
	lda #$41
get_string_fill26
	sta (str_pointer),y
	dey
	bpl get_string_fill26
	; LineNumber: 142
get_string_while27
get_string_loopstart31
	; Binary clause Simplified: NOTEQUALS
	lda this_ch
	; Compare with pure num / var optimization
	cmp #$d;keep
	beq get_string_elsedoneblock30
get_string_localsuccess35: ;keep
	; ; logical AND, second requirement
	; Binary clause Simplified: LESS
	lda buffer_counter
	; Compare with pure num / var optimization
	cmp #$28;keep
	bcs get_string_elsedoneblock30
get_string_ConditionalTrueBlock28: ;Main true block ;keep 
	; LineNumber: 143
	; LineNumber: 144
	; Assigning single variable : this_ch
	; Assigning single variable : show_ch
	lda #$1
	; Calling storevariable
	sta show_ch
	jsr get_ch
	; Calling storevariable
	sta this_ch
	; LineNumber: 145
	; Assigning single variable : str_buffer
	; Store Variable simplified optimization : right-hand term is pure
	ldx buffer_counter ; optimized, look out for bugs
	sta str_buffer,x
	; LineNumber: 146
	inc buffer_counter
	; LineNumber: 147
	jmp get_string_while27
get_string_elsedoneblock30
get_string_loopend32
	; LineNumber: 150
	
; // Using an array so needs a 0		
	; Assigning single variable : str_buffer
	; Store Variable simplified optimization : right-hand term is pure
	ldx buffer_counter ; optimized, look out for bugs
	lda #$0
	sta str_buffer,x
	; LineNumber: 151
	; Assigning single variable : str_pointer
	lda #<str_buffer
	ldx #>str_buffer
	sta str_pointer
	stx str_pointer+1
	; LineNumber: 153
	; LineNumber: 153
	; integer assignment NodeVar
	ldy str_pointer+1 ; Next one
	rts
	; NodeProcedureDecl -1
	; ***********  Defining procedure : wait_key
	;    Procedure type : User-defined procedure
	; LineNumber: 156
wait_key
	; LineNumber: 157
wait_key_while39
wait_key_loopstart43
	; Binary clause Simplified: EQUALS
	; Assigning single variable : show_ch
	lda str_pointer#$0
	; Calling storevariable
	sta show_ch
	jsr get_ch
	; Compare with pure num / var optimization
	cmp #$0;keep
	bne wait_key_elsedoneblock42
wait_key_ConditionalTrueBlock40: ;Main true block ;keep 
	; LineNumber: 158
	; LineNumber: 160
	jmp wait_key_while39
wait_key_elsedoneblock42
wait_key_loopend44
	; LineNumber: 161
	rts
	; NodeProcedureDecl -1
	; ***********  Defining procedure : beep
	;    Procedure type : User-defined procedure
	; LineNumber: 166
	; LineNumber: 165
beep_string		dc.b	7
	dc.b	0
	dc.b	0
beep_block47
beep
	; LineNumber: 167
	; Assigning single variable : in_str
	lda #<beep_string
	ldx #>beep_string
	sta in_str
	stx in_str+1
	; Assigning single variable : CRLF
	lda #$1
	; Calling storevariable
	sta CRLF
	jsr print_string
	; LineNumber: 168
	rts
block1
	; LineNumber: 188
	
; // Cursor start line and blink type
; // Set screen to mode 1 and red text
	jsr mode_1
	; LineNumber: 189
	jsr cls
	; LineNumber: 190
	jsr red
	; LineNumber: 191
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr48
	sta in_str
	lda #>MainProgram_stringassignstr48
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$1
	; Calling storevariable
	sta CRLF
	jsr print_string
	; LineNumber: 192
	jsr wait_key
	; LineNumber: 195
	
; // Clear screen and show question in yellow
	jsr cls
	; LineNumber: 196
	jsr yellow
	; LineNumber: 197
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr50
	sta in_str
	lda #>MainProgram_stringassignstr50
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$1
	; Calling storevariable
	sta CRLF
	jsr print_string
	; LineNumber: 198
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr52
	sta in_str
	lda #>MainProgram_stringassignstr52
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	; LineNumber: 201
	
; // can't return string so return pointer to a string
	; Assigning single variable : reply_pointer
	jsr get_string
	sta reply_pointer
	sty reply_pointer+1
	; LineNumber: 204
	
; // Output result:
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr54
	sta in_str
	lda #>MainProgram_stringassignstr54
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	; LineNumber: 205
	; Assigning single variable : in_str
	lda reply_pointer
	ldx reply_pointer+1
	sta in_str
	stx in_str+1
	; Assigning single variable : CRLF
	lda #$1
	; Calling storevariable
	sta CRLF
	jsr print_string
	; LineNumber: 206
	jsr beep
	; LineNumber: 208
	; End of program
	; Ending memory block
EndBlock1100
MainProgram_stringassignstr48	.dc "Press a key ...",0
MainProgram_stringassignstr50	.dc "What is your name?",0
MainProgram_stringassignstr52	.dc "> ",0
MainProgram_stringassignstr54	.dc "Hello ",0
