 processor 6502
	org $1100
	; Starting new memory block at $1100
StartBlock1100
	; LineNumber: 3
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
	; ***********  Defining procedure : BBC_Textmode_text_colour
	;    Procedure type : User-defined procedure
	; LineNumber: 73
	; LineNumber: 72
BBC_Textmode__chosen_text_colour	dc.b	0
BBC_Textmode_text_colour_block4
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
BBC_Textmode_print_string_block5
BBC_Textmode_print_string
	; LineNumber: 87
	; Assigning single variable : BBC_Textmode_next_ch
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_next_ch
	; LineNumber: 89
BBC_Textmode_print_string_while6
BBC_Textmode_print_string_loopstart10
	; Binary clause Simplified: NOTEQUALS
	; Load pointer array
	ldy BBC_Textmode_next_ch
	lda (BBC_Textmode_in_str),y
	; Compare with pure num / var optimization
	cmp #$0;keep
	beq BBC_Textmode_print_string_elsedoneblock9
BBC_Textmode_print_string_ConditionalTrueBlock7: ;Main true block ;keep 
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
	jmp BBC_Textmode_print_string_while6
BBC_Textmode_print_string_elsedoneblock9
BBC_Textmode_print_string_loopend11
	; LineNumber: 97
	; Binary clause Simplified: NOTEQUALS
	lda BBC_Textmode_CRLF
	; Compare with pure num / var optimization
	cmp #$0;keep
	beq BBC_Textmode_print_string_elsedoneblock19
BBC_Textmode_print_string_ConditionalTrueBlock17: ;Main true block ;keep 
	; LineNumber: 96
	jsr $ffe7
BBC_Textmode_print_string_elsedoneblock19
	; LineNumber: 98
	rts
	; NodeProcedureDecl -1
	; ***********  Defining procedure : BBC_Textmode_get_ch
	;    Procedure type : User-defined procedure
	; LineNumber: 102
	; LineNumber: 101
BBC_Textmode_show_ch	dc.b	$00
BBC_Textmode_get_ch_block22
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
	; ***********  Defining procedure : BBC_Textmode_wait_key
	;    Procedure type : User-defined procedure
	; LineNumber: 139
BBC_Textmode_wait_key
	; LineNumber: 140
BBC_Textmode_wait_key_while24
BBC_Textmode_wait_key_loopstart28
	; Binary clause Simplified: EQUALS
	; Assigning single variable : BBC_Textmode_show_ch
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_show_ch
	jsr BBC_Textmode_get_ch
	; Compare with pure num / var optimization
	cmp #$0;keep
	bne BBC_Textmode_wait_key_elsedoneblock27
BBC_Textmode_wait_key_ConditionalTrueBlock25: ;Main true block ;keep 
	; LineNumber: 141
	; LineNumber: 143
	jmp BBC_Textmode_wait_key_while24
BBC_Textmode_wait_key_elsedoneblock27
BBC_Textmode_wait_key_loopend29
	; LineNumber: 144
	rts
block1
	; LineNumber: 6
	
; // Clear acreen
	jsr BBC_Textmode_cls
	; LineNumber: 9
	
; // Set to 4x colour screen mode, 40x25
	; Assigning single variable : BBC_Textmode_selected_mode
	lda #$1
	; Calling storevariable
	sta BBC_Textmode_selected_mode
	jsr BBC_Textmode_screen_mode
	; LineNumber: 12
	
; // Yellow
	; Assigning single variable : BBC_Textmode__chosen_text_colour
	lda #$2
	; Calling storevariable
	sta BBC_Textmode__chosen_text_colour
	jsr BBC_Textmode_text_colour
	; LineNumber: 15
	
; // Print with no return			
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr32
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr32
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	; LineNumber: 18
	
; // Red
	; Assigning single variable : BBC_Textmode__chosen_text_colour
	lda #$1
	; Calling storevariable
	sta BBC_Textmode__chosen_text_colour
	jsr BBC_Textmode_text_colour
	; LineNumber: 21
	
; // Print with carriage return and linefeed					
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr34
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr34
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$1
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	; LineNumber: 24
	
; // Wait for a keypress
	jsr BBC_Textmode_wait_key
	; LineNumber: 27
	
; // Clear acreen
	jsr BBC_Textmode_cls
	; LineNumber: 30
	
; // White
	; Assigning single variable : BBC_Textmode__chosen_text_colour
	lda #$3
	; Calling storevariable
	sta BBC_Textmode__chosen_text_colour
	jsr BBC_Textmode_text_colour
	; LineNumber: 31
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr36
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr36
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$1
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	; LineNumber: 33
	; End of program
	; Ending memory block
EndBlock1100
MainProgram_stringassignstr32	.dc "Hello BBC Micro! ",0
MainProgram_stringassignstr34	.dc "Hello World!",0
MainProgram_stringassignstr36	.dc "Done!",0
