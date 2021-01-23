 processor 6502
	org $1100
	; Starting new memory block at $1100
StartBlock1100
		jsr initsine_calculate
	; LineNumber: 187
	jmp block1
	; LineNumber: 5
x	dc.b	$00
	; LineNumber: 5
y	dc.b	$00
	; LineNumber: 5
old_x	dc.b	$00
	; LineNumber: 5
old_y	dc.b	$00
	; LineNumber: 5
time	dc.b	$00
	; LineNumber: 5
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
	; LineNumber: 34
cls
	; LineNumber: 35
	; ****** Inline assembler section
 LDA #12
	; LineNumber: 36
	jsr $ffee
	; LineNumber: 37
	; ****** Inline assembler section
 LDA #30
	; LineNumber: 38
	jsr $ffee
	; LineNumber: 39
	rts
	; NodeProcedureDecl -1
	; ***********  Defining procedure : move_to
	;    Procedure type : User-defined procedure
	; LineNumber: 42
	; LineNumber: 41
_text_x	dc.b	0
	; LineNumber: 41
_text_y	dc.b	0
move_to_block3
move_to
	; LineNumber: 43
	; ****** Inline assembler section
 LDA #31
	; LineNumber: 44
	jsr $ffee
	; LineNumber: 45
	; ****** Inline assembler section
 LDA _text_x
	; LineNumber: 46
	jsr $ffee
	; LineNumber: 47
	; ****** Inline assembler section
 LDA _text_y
	; LineNumber: 48
	jsr $ffee
	; LineNumber: 49
	rts
	; NodeProcedureDecl -1
	; ***********  Defining procedure : wait_vsync
	;    Procedure type : User-defined procedure
	; LineNumber: 53
wait_vsync
	; LineNumber: 54
	; ****** Inline assembler section
 LDA #19
	; LineNumber: 55
	jsr $fff4
	; LineNumber: 56
	rts
	; NodeProcedureDecl -1
	; ***********  Defining procedure : screen_mode
	;    Procedure type : User-defined procedure
	; LineNumber: 59
	; LineNumber: 58
selected_mode	dc.b	0
screen_mode_block5
screen_mode
	; LineNumber: 61
	; ****** Inline assembler section
 LDA #22
	; LineNumber: 62
	jsr $ffee
	; LineNumber: 63
	; ****** Inline assembler section
 LDA selected_mode
	; LineNumber: 64
	
; // Again, need to replace with a mode param
	jsr $ffee
	; LineNumber: 66
	rts
	; NodeProcedureDecl -1
	; ***********  Defining procedure : print_string
	;    Procedure type : User-defined procedure
	; LineNumber: 104
	; LineNumber: 101
ch	dc.b	0
	; LineNumber: 102
next_ch	dc.b	0
	; LineNumber: 99
in_str	= $02
	; LineNumber: 99
CRLF	dc.b	$01
print_string_block6
print_string
	; LineNumber: 106
	; Assigning single variable : next_ch
	lda #$0
	; Calling storevariable
	sta next_ch
	; LineNumber: 108
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
	; LineNumber: 109
	; LineNumber: 110
	; Assigning single variable : ch
	; Load pointer array
	ldy next_ch
	lda (in_str),y
	; Calling storevariable
	sta ch
	; LineNumber: 111
	; ****** Inline assembler section
	; LineNumber: 112
	jsr $ffee
	; LineNumber: 113
	inc next_ch
	; LineNumber: 114
	jmp print_string_while7
print_string_elsedoneblock10
print_string_loopend12
	; LineNumber: 116
	; Binary clause Simplified: NOTEQUALS
	lda CRLF
	; Compare with pure num / var optimization
	cmp #$0;keep
	beq print_string_elsedoneblock20
print_string_ConditionalTrueBlock18: ;Main true block ;keep 
	; LineNumber: 115
	jsr $ffe7
print_string_elsedoneblock20
	; LineNumber: 117
	rts
	
; //CURSOR_OFF
	; NodeProcedureDecl -1
	; ***********  Defining procedure : cursor_off
	;    Procedure type : User-defined procedure
	; LineNumber: 176
cursor_off
	; LineNumber: 178
	; ****** Inline assembler section
 LDA #10
	; LineNumber: 179
	; ****** Inline assembler section
 STA CRTC_V
	; LineNumber: 180
	; ****** Inline assembler section
 LDA #32
	; LineNumber: 181
	; ****** Inline assembler section
 STA CUR_OF
	; LineNumber: 183
	rts
block1
	; LineNumber: 191
	
; // Cursor start line and blink type
; // Set to 80 column mode
	; Assigning single variable : selected_mode
	lda #$0
	; Calling storevariable
	sta selected_mode
	jsr screen_mode
	; LineNumber: 195
	
; // Clear acreen
	jsr cls
	; LineNumber: 198
	
; // No flashing cursor
	jsr cursor_off
	; LineNumber: 201
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
	; LineNumber: 202
	; LineNumber: 204
	; Assigning single variable : i
	lda #$0
	; Calling storevariable
	sta i
MainProgram_forloop62
	; LineNumber: 202
	
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
	; LineNumber: 205
	; Assigning single variable : _text_x
	lda old_x
	; Calling storevariable
	sta _text_x
	; Assigning single variable : _text_y
	lda old_y
	; Calling storevariable
	sta _text_y
	jsr move_to
	; LineNumber: 206
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr70
	sta in_str
	lda #>MainProgram_stringassignstr70
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	; LineNumber: 210
	
; // Calculate x,y some sine values(making a circle)
; // if sine[x] then sine[x+64] is equal to cosine 
	; Assigning single variable : old_x
	lda x
	; Calling storevariable
	sta old_x
	; LineNumber: 211
	; Assigning single variable : old_y
	lda y
	; Calling storevariable
	sta old_y
	; LineNumber: 212
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
	; LineNumber: 213
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
	; LineNumber: 216
	
; // move cursor to x,y 
	; Assigning single variable : _text_x
	lda x
	; Calling storevariable
	sta _text_x
	; Assigning single variable : _text_y
	lda y
	; Calling storevariable
	sta _text_y
	jsr move_to
	; LineNumber: 218
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
	; LineNumber: 220
	cmp #$0 ;keep
	bne MainProgram_casenext75
	; LineNumber: 220
	
; // i will now have values between 0 and 3(since time is between 0 and 255)
; // Print some random string
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr77
	sta in_str
	lda #>MainProgram_stringassignstr77
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	jmp MainProgram_caseend74
MainProgram_casenext75
	lda i
	cmp #$1 ;keep
	bne MainProgram_casenext79
	; LineNumber: 221
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr81
	sta in_str
	lda #>MainProgram_stringassignstr81
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	jmp MainProgram_caseend74
MainProgram_casenext79
	lda i
	cmp #$2 ;keep
	bne MainProgram_casenext83
	; LineNumber: 222
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr85
	sta in_str
	lda #>MainProgram_stringassignstr85
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	jmp MainProgram_caseend74
MainProgram_casenext83
	lda i
	cmp #$3 ;keep
	bne MainProgram_casenext87
	; LineNumber: 223
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr89
	sta in_str
	lda #>MainProgram_stringassignstr89
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	jmp MainProgram_caseend74
MainProgram_casenext87
MainProgram_caseend74
	; LineNumber: 227
	
; // Increase the timer
	; Assigning single variable : time
	inc time
	; LineNumber: 228
	jsr wait_vsync
	; LineNumber: 229
	jmp MainProgram_while24
MainProgram_elsedoneblock27
MainProgram_loopend29
	; LineNumber: 231
	; End of program
	; Ending memory block
EndBlock1100
MainProgram_stringassignstr70	.dc "            ",0
MainProgram_stringassignstr77	.dc "I AM FISH",0
MainProgram_stringassignstr81	.dc "ARE YOU FISH",0
MainProgram_stringassignstr85	.dc "ME AM CAT",0
MainProgram_stringassignstr89	.dc "OM NOM NOM",0
