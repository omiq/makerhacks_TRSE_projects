 processor 6502
	org $1100
	; Starting new memory block at $1100
StartBlock1100
	; LineNumber: 184
	jmp block1
	
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
	; LineNumber: 31
cls
	; LineNumber: 32
	; ****** Inline assembler section
 LDA #12
	; LineNumber: 33
	jsr $ffee
	; LineNumber: 34
	; ****** Inline assembler section
 LDA #30
	; LineNumber: 35
	jsr $ffee
	; LineNumber: 36
	rts
	; NodeProcedureDecl -1
	; ***********  Defining procedure : screen_mode
	;    Procedure type : User-defined procedure
	; LineNumber: 56
	; LineNumber: 55
selected_mode	dc.b	0
screen_mode_block3
screen_mode
	; LineNumber: 58
	; ****** Inline assembler section
 LDA #22
	; LineNumber: 59
	jsr $ffee
	; LineNumber: 60
	; ****** Inline assembler section
 LDA selected_mode
	; LineNumber: 61
	
; // Again, need to replace with a mode param
	jsr $ffee
	; LineNumber: 63
	rts
	; NodeProcedureDecl -1
	; ***********  Defining procedure : text_colour
	;    Procedure type : User-defined procedure
	; LineNumber: 89
	; LineNumber: 88
_chosen_text_colour	dc.b	0
text_colour_block4
text_colour
	; LineNumber: 90
	; ****** Inline assembler section
 LDA #17
	; LineNumber: 91
	jsr $ffee
	; LineNumber: 92
	; ****** Inline assembler section
 LDA _chosen_text_colour
	; LineNumber: 93
	
; // should use _chosen_text_colour but that doesn't work
	jsr $ffee
	; LineNumber: 94
	rts
	; NodeProcedureDecl -1
	; ***********  Defining procedure : print_string
	;    Procedure type : User-defined procedure
	; LineNumber: 101
	; LineNumber: 98
ch	dc.b	0
	; LineNumber: 99
next_ch	dc.b	0
	; LineNumber: 96
in_str	= $02
	; LineNumber: 96
CRLF	dc.b	$01
print_string_block5
print_string
	; LineNumber: 103
	; Assigning single variable : next_ch
	lda #$0
	; Calling storevariable
	sta next_ch
	; LineNumber: 105
print_string_while6
print_string_loopstart10
	; Binary clause Simplified: NOTEQUALS
	; Load pointer array
	ldy next_ch
	lda (in_str),y
	; Compare with pure num / var optimization
	cmp #$0;keep
	beq print_string_elsedoneblock9
print_string_ConditionalTrueBlock7: ;Main true block ;keep 
	; LineNumber: 106
	; LineNumber: 107
	; Assigning single variable : ch
	; Load pointer array
	ldy next_ch
	lda (in_str),y
	; Calling storevariable
	sta ch
	; LineNumber: 108
	; ****** Inline assembler section
	; LineNumber: 109
	jsr $ffee
	; LineNumber: 110
	inc next_ch
	; LineNumber: 111
	jmp print_string_while6
print_string_elsedoneblock9
print_string_loopend11
	; LineNumber: 113
	; Binary clause Simplified: NOTEQUALS
	lda CRLF
	; Compare with pure num / var optimization
	cmp #$0;keep
	beq print_string_elsedoneblock19
print_string_ConditionalTrueBlock17: ;Main true block ;keep 
	; LineNumber: 112
	jsr $ffe7
print_string_elsedoneblock19
	; LineNumber: 114
	rts
	; NodeProcedureDecl -1
	; ***********  Defining procedure : get_ch
	;    Procedure type : User-defined procedure
	; LineNumber: 118
	; LineNumber: 117
show_ch	dc.b	$00
get_ch_block22
get_ch
	; LineNumber: 120
	; ****** Inline assembler section
 LDX #1
	; LineNumber: 121
	; ****** Inline assembler section
 LDA #15
	; LineNumber: 122
	jsr $fff4
	; LineNumber: 123
	jsr $ffe0
	; LineNumber: 124
	jsr $ffee
	; LineNumber: 125
	rts
	; NodeProcedureDecl -1
	; ***********  Defining procedure : wait_key
	;    Procedure type : User-defined procedure
	; LineNumber: 155
wait_key
	; LineNumber: 156
wait_key_while24
wait_key_loopstart28
	; Binary clause Simplified: EQUALS
	; Assigning single variable : show_ch
	lda #$0
	; Calling storevariable
	sta show_ch
	jsr get_ch
	; Compare with pure num / var optimization
	cmp #$0;keep
	bne wait_key_elsedoneblock27
wait_key_ConditionalTrueBlock25: ;Main true block ;keep 
	; LineNumber: 157
	; LineNumber: 159
	jmp wait_key_while24
wait_key_elsedoneblock27
wait_key_loopend29
	; LineNumber: 160
	rts
block1
	; LineNumber: 187
	
; // Cursor start line and blink type
; // Clear acreen
	jsr cls
	; LineNumber: 190
	
; // Set to 4x colour screen mode, 40x25
	; Assigning single variable : selected_mode
	lda #$1
	; Calling storevariable
	sta selected_mode
	jsr screen_mode
	; LineNumber: 193
	
; // Yellow
	; Assigning single variable : _chosen_text_colour
	lda #$2
	; Calling storevariable
	sta _chosen_text_colour
	jsr text_colour
	; LineNumber: 196
	
; // Print with no return			
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr32
	sta in_str
	lda #>MainProgram_stringassignstr32
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	; LineNumber: 199
	
; // Red
	; Assigning single variable : _chosen_text_colour
	lda #$1
	; Calling storevariable
	sta _chosen_text_colour
	jsr text_colour
	; LineNumber: 202
	
; // Print with carriage return and linefeed					
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr34
	sta in_str
	lda #>MainProgram_stringassignstr34
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$1
	; Calling storevariable
	sta CRLF
	jsr print_string
	; LineNumber: 205
	
; // Wait for a keypress
	jsr wait_key
	; LineNumber: 208
	
; // Clear acreen
	jsr cls
	; LineNumber: 211
	
; // White
	; Assigning single variable : _chosen_text_colour
	lda #$3
	; Calling storevariable
	sta _chosen_text_colour
	jsr text_colour
	; LineNumber: 212
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr36
	sta in_str
	lda #>MainProgram_stringassignstr36
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$1
	; Calling storevariable
	sta CRLF
	jsr print_string
	; LineNumber: 214
	; End of program
	; Ending memory block
EndBlock1100
MainProgram_stringassignstr32	.dc "Hello BBC Micro! ",0
MainProgram_stringassignstr34	.dc "Hello World!",0
MainProgram_stringassignstr36	.dc "Done!",0
