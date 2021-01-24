 processor 6502
	org $1100
	; Starting new memory block at $1100
StartBlock1100
	; LineNumber: 7
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
	; ***********  Defining procedure : BBC_Textmode_move_to
	;    Procedure type : User-defined procedure
	; LineNumber: 23
	; LineNumber: 22
BBC_Textmode__text_x	dc.b	0
	; LineNumber: 22
BBC_Textmode__text_y	dc.b	0
BBC_Textmode_move_to_block3
BBC_Textmode_move_to
	; LineNumber: 24
	; Assigning memory location
	; Assigning single variable : $0
	lda #$1f
	; Calling storevariable
	sta $0
	; LineNumber: 25
	jsr $ffee
	; LineNumber: 26
	; Assigning memory location
	; Assigning single variable : $0
	lda BBC_Textmode__text_x
	; Calling storevariable
	sta $0
	; LineNumber: 27
	jsr $ffee
	; LineNumber: 28
	; Assigning memory location
	; Assigning single variable : $0
	lda BBC_Textmode__text_y
	; Calling storevariable
	sta $0
	; LineNumber: 29
	jsr $ffee
	; LineNumber: 30
	rts
	; NodeProcedureDecl -1
	; ***********  Defining procedure : BBC_Textmode_screen_mode
	;    Procedure type : User-defined procedure
	; LineNumber: 40
	; LineNumber: 39
BBC_Textmode_selected_mode	dc.b	0
BBC_Textmode_screen_mode_block4
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
	; ***********  Defining procedure : BBC_Textmode_text_colour
	;    Procedure type : User-defined procedure
	; LineNumber: 73
	; LineNumber: 72
BBC_Textmode__chosen_text_colour	dc.b	0
BBC_Textmode_text_colour_block5
BBC_Textmode_text_colour
	; LineNumber: 74
	; Assigning memory location
	; Assigning single variable : $0
	lda #$11
	; Calling storevariable
	sta $0
	; LineNumber: 75
	jsr $ffee
	; LineNumber: 76
	; Assigning memory location
	; Assigning single variable : $0
	lda BBC_Textmode__chosen_text_colour
	; Calling storevariable
	sta $0
	; LineNumber: 77
	
; // should use _chosen_text_colour but that doesn't work
	jsr $ffee
	; LineNumber: 78
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
BBC_Textmode_in_str	= $02
	; LineNumber: 80
BBC_Textmode_CRLF	dc.b	$01
BBC_Textmode_print_string_block6
BBC_Textmode_print_string
	; LineNumber: 87
	; Assigning single variable : BBC_Textmode_next_ch
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_next_ch
	; LineNumber: 89
BBC_Textmode_print_string_while7
BBC_Textmode_print_string_loopstart11
	; Binary clause Simplified: NOTEQUALS
	; Load pointer array
	ldy BBC_Textmode_next_ch
	lda (BBC_Textmode_in_str),y
	; Compare with pure num / var optimization
	cmp #$0;keep
	beq BBC_Textmode_print_string_elsedoneblock10
BBC_Textmode_print_string_ConditionalTrueBlock8: ;Main true block ;keep 
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
	jmp BBC_Textmode_print_string_while7
BBC_Textmode_print_string_elsedoneblock10
BBC_Textmode_print_string_loopend12
	; LineNumber: 97
	; Binary clause Simplified: NOTEQUALS
	lda BBC_Textmode_CRLF
	; Compare with pure num / var optimization
	cmp #$0;keep
	beq BBC_Textmode_print_string_elsedoneblock20
BBC_Textmode_print_string_ConditionalTrueBlock18: ;Main true block ;keep 
	; LineNumber: 96
	jsr $ffe7
BBC_Textmode_print_string_elsedoneblock20
	; LineNumber: 98
	rts
block1
	; LineNumber: 10
	
; // Clear acreen
	jsr BBC_Textmode_cls
	; LineNumber: 13
	
; // Set to 4x colour screen mode, 40x25
	; Assigning single variable : BBC_Textmode_selected_mode
	lda #$1
	; Calling storevariable
	sta BBC_Textmode_selected_mode
	jsr BBC_Textmode_screen_mode
	; LineNumber: 16
	
; // Yellow
	; Assigning single variable : BBC_Textmode__chosen_text_colour
	lda #$2
	; Calling storevariable
	sta BBC_Textmode__chosen_text_colour
	jsr BBC_Textmode_text_colour
	; LineNumber: 19
	
; // Move to 20,20 char location on screen
	; Assigning single variable : BBC_Textmode__text_x
	lda #$14
	; Calling storevariable
	sta BBC_Textmode__text_x
	; Assigning single variable : BBC_Textmode__text_y
	; Calling storevariable
	sta BBC_Textmode__text_y
	jsr BBC_Textmode_move_to
	; LineNumber: 22
	
; // Print with no return			
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr23
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr23
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	; LineNumber: 25
	; End of program
	; Ending memory block
EndBlock1100
MainProgram_stringassignstr23	.dc "Hello BBC Micro! ",0
