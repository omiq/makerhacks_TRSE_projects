 processor 6502
	org $1100
	; Starting new memory block at $1100
StartBlock1100
		jsr initsine_calculate
	; LineNumber: 8
	jmp block1
	; LineNumber: 6
x	dc.b	$00
	; LineNumber: 6
y	dc.b	$00
	; LineNumber: 6
old_x	dc.b	$00
	; LineNumber: 6
old_y	dc.b	$00
	; LineNumber: 6
time	dc.b	$00
	; LineNumber: 6
i	dc.b	$00
	; NodeProcedureDecl -1
	; ***********  Defining procedure : init16x8div
	;    Procedure type : Built-in function
	;    Requires initialization : no
initdiv16x8_divisor = $4c     ;$59 used for hi-byte
initdiv16x8_dividend = $4e	  ;$fc used for hi-byte
initdiv16x8_remainder = $50	  ;$fe used for hi-byte
initdiv16x8_result = $4e ;save memory by reusing divident to store the result
divide16x8	lda #0	        ;preset remainder to 0
	sta initdiv16x8_remainder
	sta initdiv16x8_remainder+1
	ldx #16	        ;repeat for each bit: ...
divloop16	asl initdiv16x8_dividend	;dividend lb & hb*2, msb -> Carry
	rol initdiv16x8_dividend+1
	rol initdiv16x8_remainder	;remainder lb & hb * 2 + msb from carry
	rol initdiv16x8_remainder+1
	lda initdiv16x8_remainder
	sec
	sbc initdiv16x8_divisor	;substract divisor to see if it fits in
	tay	        ;lb result -> Y, for we may need it later
	lda initdiv16x8_remainder+1
	sbc initdiv16x8_divisor+1
	bcc skip16	;if carry=0 then divisor didn't fit in yet
	sta initdiv16x8_remainder+1	;else save substraction result as new remainder,
	sty initdiv16x8_remainder
	inc initdiv16x8_result	;and INCrement result cause divisor fit in 1 times
skip16	dex
	bne divloop16
	rts
	; NodeProcedureDecl -1
	; ***********  Defining procedure : init8x8div
	;    Procedure type : Built-in function
	;    Requires initialization : no
div8x8_c = $4c
div8x8_d = $4e
div8x8_e = $50
	; Normal 8x8 bin div
div8x8_procedure
	lda #$00
	ldx #$07
	clc
div8x8_loop1 rol div8x8_d
	rol
	cmp div8x8_c
	bcc div8x8_loop2
	sbc div8x8_c
div8x8_loop2 dex
	bpl div8x8_loop1
	rol div8x8_d
	lda div8x8_d
div8x8_def_end
	rts
	; NodeProcedureDecl -1
	; ***********  Defining procedure : initsinetable
	;    Procedure type : User-defined procedure
sine .byte 0 
	org sine +#255
value .word 0
delta .word 0
initsine_calculate
	ldy #$3f
	ldx #$00
initsin_a
	lda value
	clc
	adc delta
	sta value
	lda value+1
	adc delta+1
	sta value+1
	sta sine+$c0,x
	sta sine+$80,y
	eor #$ff
	sta sine+$40,x
	sta sine+$00,y
	lda delta
	adc #$10   ; this value adds up to the proper amplitude
	sta delta
	bcc initsin_b
	inc delta+1
initsin_b
	inx
	dey
	bpl initsin_a
	rts
	
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
	; ***********  Defining procedure : BBC_Textmode_wait_vsync
	;    Procedure type : User-defined procedure
	; LineNumber: 34
BBC_Textmode_wait_vsync
	; LineNumber: 35
	; Assigning memory location
	; Assigning single variable : $0
	lda #$13
	; Calling storevariable
	sta $0
	; LineNumber: 36
	jsr $fff4
	; LineNumber: 37
	rts
	; NodeProcedureDecl -1
	; ***********  Defining procedure : BBC_Textmode_screen_mode
	;    Procedure type : User-defined procedure
	; LineNumber: 40
	; LineNumber: 39
BBC_Textmode_selected_mode	dc.b	0
BBC_Textmode_screen_mode_block5
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
	
; //CURSOR_OFF
	; NodeProcedureDecl -1
	; ***********  Defining procedure : BBC_Textmode_cursor_off
	;    Procedure type : User-defined procedure
	; LineNumber: 157
BBC_Textmode_cursor_off
	; LineNumber: 164
	
; //		_A:=10;				
; // Cursor start line and blink type
; //		asm(" STA CRTC_V");
; //		_A:=32;
; //		asm(" STA CUR_OF");
; //
	; Poke
	; Optimization: shift is zero
	lda #$a
	sta $fe00
	; LineNumber: 165
	; Poke
	; Optimization: shift is zero
	lda #$20
	sta $fe01
	; LineNumber: 167
	rts
block1
	; LineNumber: 12
	
; // Set to 80 column mode
	; Assigning single variable : BBC_Textmode_selected_mode
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_selected_mode
	jsr BBC_Textmode_screen_mode
	; LineNumber: 16
	
; // Clear acreen
	jsr BBC_Textmode_cls
	; LineNumber: 19
	
; // No flashing cursor
	jsr BBC_Textmode_cursor_off
	; LineNumber: 22
MainProgram_while24
MainProgram_loopstart28
	; Binary clause Simplified: NOTEQUALS
	lda #$1
	; Compare with pure num / var optimization
	cmp #$0;keep
	beq MainProgram_localfailed60
	jmp MainProgram_ConditionalTrueBlock25
MainProgram_localfailed60
	jmp MainProgram_elsedoneblock27
MainProgram_ConditionalTrueBlock25: ;Main true block ;keep 
	; LineNumber: 23
	; LineNumber: 25
	; Assigning single variable : i
	lda #$0
	; Calling storevariable
	sta i
MainProgram_forloop62
	; LineNumber: 23
	
; // infinite loop
	; Wait
	ldx #$14 ; optimized, look out for bugs
	dex
	bne *-1
MainProgram_forloopcounter64
MainProgram_loopstart65
	; Compare is onpage
	inc i
	lda #$c8
	cmp i ;keep
	bne MainProgram_forloop62
MainProgram_loopdone69: ;keep
MainProgram_forloopend63
MainProgram_loopend66
	; LineNumber: 26
	; Assigning single variable : BBC_Textmode__text_x
	lda old_x
	; Calling storevariable
	sta BBC_Textmode__text_x
	; Assigning single variable : BBC_Textmode__text_y
	lda old_y
	; Calling storevariable
	sta BBC_Textmode__text_y
	jsr BBC_Textmode_move_to
	; LineNumber: 27
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr70
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr70
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	; LineNumber: 31
	
; // Calculate x,y some sine values(making a circle)
; // if sine[x] then sine[x+64] is equal to cosine 
	; Assigning single variable : old_x
	lda x
	; Calling storevariable
	sta old_x
	; LineNumber: 32
	; Assigning single variable : old_y
	lda y
	; Calling storevariable
	sta old_y
	; LineNumber: 33
	; Assigning single variable : x
	; 8 bit binop
	; Add/sub where right value is constant number
	; Right is PURE NUMERIC : Is word =0
	; 8 bit div
	; Load Unknown type array
	ldx time
	lda sine,x
	sta div8x8_d
	; Load right hand side
	lda #$6
	sta div8x8_c
	jsr div8x8_procedure
	clc
	adc #$c
	 ; end add / sub var with constant
	; Calling storevariable
	sta x
	; LineNumber: 34
	; Assigning single variable : y
	; 8 bit binop
	; Add/sub where right value is constant number
	; Right is PURE NUMERIC : Is word =0
	; 8 bit mul of power 2
	; Load Unknown type array
	; 8 bit binop
	; Add/sub where right value is constant number
	lda time
	clc
	adc #$40
	 ; end add / sub var with constant
	tax
	lda sine,x
	lsr
	lsr
	lsr
	lsr
	clc
	adc #$4
	 ; end add / sub var with constant
	; Calling storevariable
	sta y
	; LineNumber: 37
	
; // move cursor to x,y 
	; Assigning single variable : BBC_Textmode__text_x
	lda x
	; Calling storevariable
	sta BBC_Textmode__text_x
	; Assigning single variable : BBC_Textmode__text_y
	lda y
	; Calling storevariable
	sta BBC_Textmode__text_y
	jsr BBC_Textmode_move_to
	; LineNumber: 39
	; Assigning single variable : i
	; Right is PURE NUMERIC : Is word =0
	; 8 bit mul of power 2
	lda time
	lsr
	lsr
	lsr
	lsr
	lsr
	lsr
	; Calling storevariable
	sta i
	; LineNumber: 41
	cmp #$0 ;keep
	bne MainProgram_casenext75
	; LineNumber: 41
	
; // i will now have values between 0 and 3(since time is between 0 and 255)
; // Print some random string
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr77
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr77
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	jmp MainProgram_caseend74
MainProgram_casenext75
	lda i
	cmp #$1 ;keep
	bne MainProgram_casenext79
	; LineNumber: 42
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr81
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr81
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	jmp MainProgram_caseend74
MainProgram_casenext79
	lda i
	cmp #$2 ;keep
	bne MainProgram_casenext83
	; LineNumber: 43
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr85
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr85
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	jmp MainProgram_caseend74
MainProgram_casenext83
	lda i
	cmp #$3 ;keep
	bne MainProgram_casenext87
	; LineNumber: 44
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr89
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr89
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	jmp MainProgram_caseend74
MainProgram_casenext87
MainProgram_caseend74
	; LineNumber: 48
	
; // Increase the timer
	; Assigning single variable : time
	inc time
	; LineNumber: 49
	jsr BBC_Textmode_wait_vsync
	; LineNumber: 50
	jmp MainProgram_while24
MainProgram_elsedoneblock27
MainProgram_loopend29
	; LineNumber: 52
	; End of program
	; Ending memory block
EndBlock1100
MainProgram_stringassignstr70	.dc "            ",0
MainProgram_stringassignstr77	.dc "I AM FISH",0
MainProgram_stringassignstr81	.dc "ARE YOU FISH",0
MainProgram_stringassignstr85	.dc "ME AM CAT",0
MainProgram_stringassignstr89	.dc "OM NOM NOM",0
