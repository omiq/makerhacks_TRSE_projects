 processor 6502
	org $1100
	; Starting new memory block at $1100
StartBlock1100
	; LineNumber: 8
	jmp block1
	; LineNumber: 5
i	dc.b	$00
	; LineNumber: 5
x	dc.b	$00
	; LineNumber: 5
y	dc.b	$00
	; LineNumber: 5
w	dc.b	$00
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
	; ***********  Defining procedure : initrandom256
	;    Procedure type : User-defined procedure
	; init random256
Random
	lda #$01
	asl
	bcc initrandom256_RandomSkip2
	eor #$4d
initrandom256_RandomSkip2
	sta Random+1
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
BBC_Textmode_move_to_block4
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
BBC_Textmode_screen_mode_block6
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
BBC_Textmode_text_colour_block7
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
BBC_Textmode_print_string_block8
BBC_Textmode_print_string
	; LineNumber: 87
	; Assigning single variable : BBC_Textmode_next_ch
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_next_ch
	; LineNumber: 89
BBC_Textmode_print_string_while9
BBC_Textmode_print_string_loopstart13
	; Binary clause Simplified: NOTEQUALS
	; Load pointer array
	ldy BBC_Textmode_next_ch
	lda (BBC_Textmode_in_str),y
	; Compare with pure num / var optimization
	cmp #$0;keep
	beq BBC_Textmode_print_string_elsedoneblock12
BBC_Textmode_print_string_ConditionalTrueBlock10: ;Main true block ;keep 
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
	jmp BBC_Textmode_print_string_while9
BBC_Textmode_print_string_elsedoneblock12
BBC_Textmode_print_string_loopend14
	; LineNumber: 97
	; Binary clause Simplified: NOTEQUALS
	lda BBC_Textmode_CRLF
	; Compare with pure num / var optimization
	cmp #$0;keep
	beq BBC_Textmode_print_string_elsedoneblock22
BBC_Textmode_print_string_ConditionalTrueBlock20: ;Main true block ;keep 
	; LineNumber: 96
	jsr $ffe7
BBC_Textmode_print_string_elsedoneblock22
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
	; LineNumber: 10
	
; // Set to 20 column, 16 colour mode
	; Assigning single variable : BBC_Textmode_selected_mode
	lda #$2
	; Calling storevariable
	sta BBC_Textmode_selected_mode
	jsr BBC_Textmode_screen_mode
	; LineNumber: 13
	
; // Clear acreen
	jsr BBC_Textmode_cls
	; LineNumber: 16
	
; // No flashing cursor
	jsr BBC_Textmode_cursor_off
	; LineNumber: 19
MainProgram_while26
MainProgram_loopstart30
	; Binary clause Simplified: NOTEQUALS
	lda #$1
	; Compare with pure num / var optimization
	cmp #$0;keep
	beq MainProgram_localfailed244
	jmp MainProgram_ConditionalTrueBlock27
MainProgram_localfailed244
	jmp MainProgram_elsedoneblock29
MainProgram_ConditionalTrueBlock27: ;Main true block ;keep 
	; LineNumber: 20
	; LineNumber: 21
	
; // infinite loop
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr246
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr246
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	; LineNumber: 22
	inc i
	lda i
	cmp #$30 ; keep
	bne MainProgram_incmax249
	lda #$0
	sta i
MainProgram_incmax249
	; LineNumber: 23
	; Assigning single variable : BBC_Textmode__chosen_text_colour
	lda i
	; Calling storevariable
	sta BBC_Textmode__chosen_text_colour
	jsr BBC_Textmode_text_colour
	; LineNumber: 25
	; Assigning single variable : x
	lda #$0
	; Calling storevariable
	sta x
	; LineNumber: 26
	; Assigning single variable : y
	; Right is PURE NUMERIC : Is word =0
	; 8 bit div
	jsr Random
	sta div8x8_d
	; Load right hand side
	lda #$a
	sta div8x8_c
	jsr div8x8_procedure
	; Calling storevariable
	sta y
	; LineNumber: 28
	; Assigning single variable : BBC_Textmode__text_x
	lda x
	; Calling storevariable
	sta BBC_Textmode__text_x
	; Assigning single variable : BBC_Textmode__text_y
	lda y
	; Calling storevariable
	sta BBC_Textmode__text_y
	jsr BBC_Textmode_move_to
	; LineNumber: 29
	lda i
	cmp #$0 ;keep
	bne MainProgram_casenext253
	; LineNumber: 29
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr255
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr255
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	jmp MainProgram_caseend252
MainProgram_casenext253
	lda i
	cmp #$1 ;keep
	bne MainProgram_casenext257
	; LineNumber: 30
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr259
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr259
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	jmp MainProgram_caseend252
MainProgram_casenext257
	lda i
	cmp #$2 ;keep
	bne MainProgram_casenext261
	; LineNumber: 31
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr263
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr263
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	jmp MainProgram_caseend252
MainProgram_casenext261
	lda i
	cmp #$3 ;keep
	bne MainProgram_casenext265
	; LineNumber: 32
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr267
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr267
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	jmp MainProgram_caseend252
MainProgram_casenext265
	lda i
	cmp #$4 ;keep
	bne MainProgram_casenext269
	; LineNumber: 33
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr271
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr271
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	jmp MainProgram_caseend252
MainProgram_casenext269
	lda i
	cmp #$5 ;keep
	bne MainProgram_casenext273
	; LineNumber: 34
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr275
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr275
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	jmp MainProgram_caseend252
MainProgram_casenext273
	lda i
	cmp #$6 ;keep
	bne MainProgram_casenext277
	; LineNumber: 35
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr279
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr279
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	jmp MainProgram_caseend252
MainProgram_casenext277
	lda i
	cmp #$7 ;keep
	bne MainProgram_casenext281
	; LineNumber: 36
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr283
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr283
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	jmp MainProgram_caseend252
MainProgram_casenext281
	lda i
	cmp #$8 ;keep
	bne MainProgram_casenext285
	; LineNumber: 37
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr287
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr287
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	jmp MainProgram_caseend252
MainProgram_casenext285
	lda i
	cmp #$9 ;keep
	bne MainProgram_casenext289
	; LineNumber: 38
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr291
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr291
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	jmp MainProgram_caseend252
MainProgram_casenext289
	lda i
	cmp #$a ;keep
	bne MainProgram_casenext293
	; LineNumber: 39
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr295
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr295
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	jmp MainProgram_caseend252
MainProgram_casenext293
	lda i
	cmp #$b ;keep
	bne MainProgram_casenext297
	; LineNumber: 40
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr299
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr299
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	jmp MainProgram_caseend252
MainProgram_casenext297
	lda i
	cmp #$c ;keep
	bne MainProgram_casenext301
	; LineNumber: 41
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr303
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr303
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	jmp MainProgram_caseend252
MainProgram_casenext301
	lda i
	cmp #$d ;keep
	bne MainProgram_casenext305
	; LineNumber: 42
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr307
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr307
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	jmp MainProgram_caseend252
MainProgram_casenext305
	lda i
	cmp #$e ;keep
	bne MainProgram_casenext309
	; LineNumber: 43
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr311
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr311
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	jmp MainProgram_caseend252
MainProgram_casenext309
	lda i
	cmp #$f ;keep
	bne MainProgram_casenext313
	; LineNumber: 44
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr315
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr315
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	jmp MainProgram_caseend252
MainProgram_casenext313
	lda i
	cmp #$10 ;keep
	bne MainProgram_casenext317
	; LineNumber: 45
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr319
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr319
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	jmp MainProgram_caseend252
MainProgram_casenext317
	lda i
	cmp #$11 ;keep
	bne MainProgram_casenext321
	; LineNumber: 46
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr323
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr323
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	jmp MainProgram_caseend252
MainProgram_casenext321
	lda i
	cmp #$12 ;keep
	bne MainProgram_casenext325
	; LineNumber: 47
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr327
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr327
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	jmp MainProgram_caseend252
MainProgram_casenext325
	lda i
	cmp #$13 ;keep
	bne MainProgram_casenext329
	; LineNumber: 48
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr331
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr331
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	jmp MainProgram_caseend252
MainProgram_casenext329
	lda i
	cmp #$14 ;keep
	bne MainProgram_casenext333
	; LineNumber: 49
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr335
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr335
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	jmp MainProgram_caseend252
MainProgram_casenext333
	lda i
	cmp #$15 ;keep
	bne MainProgram_casenext337
	; LineNumber: 50
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr339
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr339
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	jmp MainProgram_caseend252
MainProgram_casenext337
	lda i
	cmp #$16 ;keep
	bne MainProgram_casenext341
	; LineNumber: 51
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr343
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr343
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	jmp MainProgram_caseend252
MainProgram_casenext341
	lda i
	cmp #$17 ;keep
	bne MainProgram_casenext345
	; LineNumber: 52
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr347
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr347
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	jmp MainProgram_caseend252
MainProgram_casenext345
	lda i
	cmp #$18 ;keep
	bne MainProgram_casenext349
	; LineNumber: 53
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr351
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr351
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	jmp MainProgram_caseend252
MainProgram_casenext349
	lda i
	cmp #$19 ;keep
	bne MainProgram_casenext353
	; LineNumber: 54
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr355
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr355
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	jmp MainProgram_caseend252
MainProgram_casenext353
	lda i
	cmp #$1a ;keep
	bne MainProgram_casenext357
	; LineNumber: 55
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr359
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr359
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	jmp MainProgram_caseend252
MainProgram_casenext357
	lda i
	cmp #$1b ;keep
	bne MainProgram_casenext361
	; LineNumber: 56
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr363
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr363
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	jmp MainProgram_caseend252
MainProgram_casenext361
	lda i
	cmp #$1c ;keep
	bne MainProgram_casenext365
	; LineNumber: 57
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr367
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr367
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	jmp MainProgram_caseend252
MainProgram_casenext365
	lda i
	cmp #$1d ;keep
	bne MainProgram_casenext369
	; LineNumber: 58
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr371
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr371
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	jmp MainProgram_caseend252
MainProgram_casenext369
	lda i
	cmp #$1e ;keep
	bne MainProgram_casenext373
	; LineNumber: 59
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr375
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr375
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	jmp MainProgram_caseend252
MainProgram_casenext373
	lda i
	cmp #$1f ;keep
	bne MainProgram_casenext377
	; LineNumber: 60
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr379
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr379
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	jmp MainProgram_caseend252
MainProgram_casenext377
	lda i
	cmp #$20 ;keep
	bne MainProgram_casenext381
	; LineNumber: 61
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr383
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr383
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	jmp MainProgram_caseend252
MainProgram_casenext381
	lda i
	cmp #$21 ;keep
	bne MainProgram_casenext385
	; LineNumber: 62
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr387
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr387
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	jmp MainProgram_caseend252
MainProgram_casenext385
	lda i
	cmp #$22 ;keep
	bne MainProgram_casenext389
	; LineNumber: 63
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr391
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr391
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	jmp MainProgram_caseend252
MainProgram_casenext389
	lda i
	cmp #$23 ;keep
	bne MainProgram_casenext393
	; LineNumber: 64
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr395
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr395
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	jmp MainProgram_caseend252
MainProgram_casenext393
	lda i
	cmp #$24 ;keep
	bne MainProgram_casenext397
	; LineNumber: 65
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr399
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr399
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	jmp MainProgram_caseend252
MainProgram_casenext397
	lda i
	cmp #$25 ;keep
	bne MainProgram_casenext401
	; LineNumber: 66
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr403
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr403
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	jmp MainProgram_caseend252
MainProgram_casenext401
	lda i
	cmp #$26 ;keep
	bne MainProgram_casenext405
	; LineNumber: 67
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr407
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr407
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	jmp MainProgram_caseend252
MainProgram_casenext405
	lda i
	cmp #$27 ;keep
	bne MainProgram_casenext409
	; LineNumber: 68
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr411
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr411
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	jmp MainProgram_caseend252
MainProgram_casenext409
	lda i
	cmp #$28 ;keep
	bne MainProgram_casenext413
	; LineNumber: 69
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr415
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr415
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	jmp MainProgram_caseend252
MainProgram_casenext413
	lda i
	cmp #$29 ;keep
	bne MainProgram_casenext417
	; LineNumber: 70
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr419
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr419
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	jmp MainProgram_caseend252
MainProgram_casenext417
	lda i
	cmp #$2a ;keep
	bne MainProgram_casenext421
	; LineNumber: 71
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr423
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr423
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	jmp MainProgram_caseend252
MainProgram_casenext421
	lda i
	cmp #$2b ;keep
	bne MainProgram_casenext425
	; LineNumber: 72
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr427
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr427
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	jmp MainProgram_caseend252
MainProgram_casenext425
	lda i
	cmp #$2c ;keep
	bne MainProgram_casenext429
	; LineNumber: 73
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr431
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr431
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	jmp MainProgram_caseend252
MainProgram_casenext429
	lda i
	cmp #$2d ;keep
	bne MainProgram_casenext433
	; LineNumber: 74
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr435
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr435
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	jmp MainProgram_caseend252
MainProgram_casenext433
	lda i
	cmp #$2e ;keep
	bne MainProgram_casenext437
	; LineNumber: 75
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr439
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr439
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	jmp MainProgram_caseend252
MainProgram_casenext437
	lda i
	cmp #$2f ;keep
	bne MainProgram_casenext441
	; LineNumber: 76
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr443
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr443
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	jmp MainProgram_caseend252
MainProgram_casenext441
	lda i
	cmp #$30 ;keep
	bne MainProgram_casenext445
	; LineNumber: 77
	; Assigning single variable : BBC_Textmode_in_str
	lda #<MainProgram_stringassignstr447
	sta BBC_Textmode_in_str
	lda #>MainProgram_stringassignstr447
	sta BBC_Textmode_in_str+1
	; Assigning single variable : BBC_Textmode_CRLF
	lda #$0
	; Calling storevariable
	sta BBC_Textmode_CRLF
	jsr BBC_Textmode_print_string
	jmp MainProgram_caseend252
MainProgram_casenext445
MainProgram_caseend252
	; LineNumber: 85
	; Assigning single variable : w
	lda #$1
	; Calling storevariable
	sta w
MainProgram_forloop449
	; LineNumber: 82
	; LineNumber: 83
	jsr BBC_Textmode_wait_vsync
	; LineNumber: 84
MainProgram_forloopcounter451
MainProgram_loopstart452
	; Compare is onpage
	inc w
	lda #$7
	cmp w ;keep
	bcs MainProgram_forloop449
MainProgram_loopdone456: ;keep
MainProgram_forloopend450
MainProgram_loopend453
	; LineNumber: 85
	jmp MainProgram_while26
MainProgram_elsedoneblock29
MainProgram_loopend31
	; LineNumber: 87
	; End of program
	; Ending memory block
EndBlock1100
MainProgram_stringassignstr246	.dc "                               ",0
MainProgram_stringassignstr255	.dc "@MOS_8502",0
MainProgram_stringassignstr259	.dc "@futurewas8bit",0
MainProgram_stringassignstr263	.dc "@10MARC1",0
MainProgram_stringassignstr267	.dc "@JohnKennedyMSFT",0
MainProgram_stringassignstr271	.dc "@6502nerd",0
MainProgram_stringassignstr275	.dc "@LifeBegins8bit",0
MainProgram_stringassignstr279	.dc "@CodingAndThings",0
MainProgram_stringassignstr283	.dc "@MonstersGo",0
MainProgram_stringassignstr287	.dc "@bbcmicrobot",0
MainProgram_stringassignstr291	.dc "@geoff_suniga",0
MainProgram_stringassignstr295	.dc "@0xC0DE6502",0
MainProgram_stringassignstr299	.dc "@3DPProfessor",0
MainProgram_stringassignstr303	.dc "@ZxSpectROM",0
MainProgram_stringassignstr307	.dc "@Hewco64",0
MainProgram_stringassignstr311	.dc "@NickT6630",0
MainProgram_stringassignstr315	.dc "@BillieRubenMake",0
MainProgram_stringassignstr319	.dc "@MikeDancy",0
MainProgram_stringassignstr323	.dc "@AmethystAnswers",0
MainProgram_stringassignstr327	.dc "@jimblimey",0
MainProgram_stringassignstr331	.dc "@Barnacules",0
MainProgram_stringassignstr335	.dc "@electron_greg",0
MainProgram_stringassignstr339	.dc "@JCTrick",0
MainProgram_stringassignstr343	.dc "@joeltelling",0
MainProgram_stringassignstr347	.dc "@JAYTEEAU",0
MainProgram_stringassignstr351	.dc "@Lord_Arse",0
MainProgram_stringassignstr355	.dc "@BreakIntoProg",0
MainProgram_stringassignstr359	.dc "@leelegionsmith",0
MainProgram_stringassignstr363	.dc "@particlesbbs",0
MainProgram_stringassignstr367	.dc "@DeathStarPR",0
MainProgram_stringassignstr371	.dc "@kcimc",0
MainProgram_stringassignstr375	.dc "@susie_dent",0
MainProgram_stringassignstr379	.dc "@FriendlyWire",0
MainProgram_stringassignstr383	.dc "@Foone",0
MainProgram_stringassignstr387	.dc "@8bit_era",0
MainProgram_stringassignstr391	.dc "@TheReaperUK",0
MainProgram_stringassignstr395	.dc "@drkninja2k5",0
MainProgram_stringassignstr399	.dc "@setlahs",0
MainProgram_stringassignstr403	.dc "@ZZleeZZ",0
MainProgram_stringassignstr407	.dc "@8bitAlan",0
MainProgram_stringassignstr411	.dc "@news_xc",0
MainProgram_stringassignstr415	.dc "@SharpworksMZ",0
MainProgram_stringassignstr419	.dc "@_fabdigital_",0
MainProgram_stringassignstr423	.dc "@AshtonNorman6",0
MainProgram_stringassignstr427	.dc "@textfiles",0
MainProgram_stringassignstr431	.dc "@maded2",0
MainProgram_stringassignstr435	.dc "@KevEdwardsRetro",0
MainProgram_stringassignstr439	.dc "@ghidraninja",0
MainProgram_stringassignstr443	.dc "@chrispian",0
MainProgram_stringassignstr447	.dc "@DocPop",0
