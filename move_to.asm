 processor 6502
	org $1100
	; Starting new memory block at $1100
StartBlock1100
	; LineNumber: 185
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
	; ***********  Defining procedure : move_to
	;    Procedure type : User-defined procedure
	; LineNumber: 39
	; LineNumber: 38
_text_x	dc.b	0
	; LineNumber: 38
_text_y	dc.b	0
move_to_block3
move_to
	; LineNumber: 40
	; ****** Inline assembler section
 LDA #31
	; LineNumber: 41
	jsr $ffee
	; LineNumber: 42
	; ****** Inline assembler section
 LDA _text_x
	; LineNumber: 43
	jsr $ffee
	; LineNumber: 44
	; ****** Inline assembler section
 LDA _text_y
	; LineNumber: 45
	jsr $ffee
	; LineNumber: 46
	rts
	; NodeProcedureDecl -1
	; ***********  Defining procedure : screen_mode
	;    Procedure type : User-defined procedure
	; LineNumber: 56
	; LineNumber: 55
selected_mode	dc.b	0
screen_mode_block4
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
text_colour_block5
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
print_string_block6
print_string
	; LineNumber: 103
	; Assigning single variable : next_ch
	lda #$0
	; Calling storevariable
	sta next_ch
	; LineNumber: 105
print_string_while7
print_string_loopstart11
	; Binary clause Simplified: NOTEQUALS
	; Load pointer array
	ldy next_ch
	lda (in_str),y
	; Compare with pure num / var optimization
	cmp #$0;keep
	beq print_string_elsedoneblock10
print_string_ConditionalTrueBlock8: ;Main true block ;keep 
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
	jmp print_string_while7
print_string_elsedoneblock10
print_string_loopend12
	; LineNumber: 113
	; Binary clause Simplified: NOTEQUALS
	lda CRLF
	; Compare with pure num / var optimization
	cmp #$0;keep
	beq print_string_elsedoneblock20
print_string_ConditionalTrueBlock18: ;Main true block ;keep 
	; LineNumber: 112
	jsr $ffe7
print_string_elsedoneblock20
	; LineNumber: 114
	rts
block1
	; LineNumber: 188
	
; // Cursor start line and blink type
; // Clear acreen
	jsr cls
	; LineNumber: 191
	
; // Set to 4x colour screen mode, 40x25
	; Assigning single variable : selected_mode
	lda #$1
	; Calling storevariable
	sta selected_mode
	jsr screen_mode
	; LineNumber: 194
	
; // Yellow
	; Assigning single variable : _chosen_text_colour
	lda #$2
	; Calling storevariable
	sta _chosen_text_colour
	jsr text_colour
	; LineNumber: 197
	
; // Move to 20,20 char location on screen
	; Assigning single variable : _text_x
	lda #$14
	; Calling storevariable
	sta _text_x
	; Assigning single variable : _text_y
	; Calling storevariable
	sta _text_y
	jsr move_to
	; LineNumber: 200
	
; // Print with no return			
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr23
	sta in_str
	lda #>MainProgram_stringassignstr23
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	; LineNumber: 203
	; End of program
	; Ending memory block
EndBlock1100
MainProgram_stringassignstr23	.dc "Hello BBC Micro! ",0
