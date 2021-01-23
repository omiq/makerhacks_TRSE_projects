 processor 6502
	org $1100
	; Starting new memory block at $1100
StartBlock1100
	; LineNumber: 184
	jmp block1
	; LineNumber: 3
i	dc.b	$00
	; LineNumber: 3
x	dc.b	$00
	; LineNumber: 3
y	dc.b	$00
	; LineNumber: 3
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
move_to_block4
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
	; ***********  Defining procedure : wait_vsync
	;    Procedure type : User-defined procedure
	; LineNumber: 50
wait_vsync
	; LineNumber: 51
	; ****** Inline assembler section
 LDA #19
	; LineNumber: 52
	jsr $fff4
	; LineNumber: 53
	rts
	; NodeProcedureDecl -1
	; ***********  Defining procedure : screen_mode
	;    Procedure type : User-defined procedure
	; LineNumber: 56
	; LineNumber: 55
selected_mode	dc.b	0
screen_mode_block6
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
text_colour_block7
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
print_string_block8
print_string
	; LineNumber: 103
	; Assigning single variable : next_ch
	lda #$0
	; Calling storevariable
	sta next_ch
	; LineNumber: 105
print_string_while9
print_string_loopstart13
	; Binary clause Simplified: NOTEQUALS
	; Load pointer array
	ldy next_ch
	lda (in_str),y
	; Compare with pure num / var optimization
	cmp #$0;keep
	beq print_string_elsedoneblock12
print_string_ConditionalTrueBlock10: ;Main true block ;keep 
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
	jmp print_string_while9
print_string_elsedoneblock12
print_string_loopend14
	; LineNumber: 113
	; Binary clause Simplified: NOTEQUALS
	lda CRLF
	; Compare with pure num / var optimization
	cmp #$0;keep
	beq print_string_elsedoneblock22
print_string_ConditionalTrueBlock20: ;Main true block ;keep 
	; LineNumber: 112
	jsr $ffe7
print_string_elsedoneblock22
	; LineNumber: 114
	rts
	
; //CURSOR_OFF
	; NodeProcedureDecl -1
	; ***********  Defining procedure : cursor_off
	;    Procedure type : User-defined procedure
	; LineNumber: 173
cursor_off
	; LineNumber: 175
	; ****** Inline assembler section
 LDA #10
	; LineNumber: 176
	; ****** Inline assembler section
 STA CRTC_V
	; LineNumber: 177
	; ****** Inline assembler section
 LDA #32
	; LineNumber: 178
	; ****** Inline assembler section
 STA CUR_OF
	; LineNumber: 180
	rts
block1
	; LineNumber: 186
	
; // Cursor start line and blink type
; // Set to 20 column, 16 colour mode
	; Assigning single variable : selected_mode
	lda #$2
	; Calling storevariable
	sta selected_mode
	jsr screen_mode
	; LineNumber: 189
	
; // Clear acreen
	jsr cls
	; LineNumber: 192
	
; // No flashing cursor
	jsr cursor_off
	; LineNumber: 195
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
	; LineNumber: 196
	; LineNumber: 197
	
; // infinite loop
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr246
	sta in_str
	lda #>MainProgram_stringassignstr246
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	; LineNumber: 198
	inc i
	lda i
	cmp #$30 ; keep
	bne MainProgram_incmax249
	lda #$0
	sta i
MainProgram_incmax249
	; LineNumber: 199
	; Assigning single variable : _chosen_text_colour
	lda i
	; Calling storevariable
	sta _chosen_text_colour
	jsr text_colour
	; LineNumber: 201
	; Assigning single variable : x
	lda #$0
	; Calling storevariable
	sta x
	; LineNumber: 202
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
	; LineNumber: 204
	; Assigning single variable : _text_x
	lda x
	; Calling storevariable
	sta _text_x
	; Assigning single variable : _text_y
	lda y
	; Calling storevariable
	sta _text_y
	jsr move_to
	; LineNumber: 205
	lda i
	cmp #$0 ;keep
	bne MainProgram_casenext253
	; LineNumber: 205
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr255
	sta in_str
	lda #>MainProgram_stringassignstr255
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	jmp MainProgram_caseend252
MainProgram_casenext253
	lda i
	cmp #$1 ;keep
	bne MainProgram_casenext257
	; LineNumber: 206
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr259
	sta in_str
	lda #>MainProgram_stringassignstr259
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	jmp MainProgram_caseend252
MainProgram_casenext257
	lda i
	cmp #$2 ;keep
	bne MainProgram_casenext261
	; LineNumber: 207
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr263
	sta in_str
	lda #>MainProgram_stringassignstr263
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	jmp MainProgram_caseend252
MainProgram_casenext261
	lda i
	cmp #$3 ;keep
	bne MainProgram_casenext265
	; LineNumber: 208
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr267
	sta in_str
	lda #>MainProgram_stringassignstr267
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	jmp MainProgram_caseend252
MainProgram_casenext265
	lda i
	cmp #$4 ;keep
	bne MainProgram_casenext269
	; LineNumber: 209
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr271
	sta in_str
	lda #>MainProgram_stringassignstr271
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	jmp MainProgram_caseend252
MainProgram_casenext269
	lda i
	cmp #$5 ;keep
	bne MainProgram_casenext273
	; LineNumber: 210
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr275
	sta in_str
	lda #>MainProgram_stringassignstr275
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	jmp MainProgram_caseend252
MainProgram_casenext273
	lda i
	cmp #$6 ;keep
	bne MainProgram_casenext277
	; LineNumber: 211
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr279
	sta in_str
	lda #>MainProgram_stringassignstr279
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	jmp MainProgram_caseend252
MainProgram_casenext277
	lda i
	cmp #$7 ;keep
	bne MainProgram_casenext281
	; LineNumber: 212
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr283
	sta in_str
	lda #>MainProgram_stringassignstr283
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	jmp MainProgram_caseend252
MainProgram_casenext281
	lda i
	cmp #$8 ;keep
	bne MainProgram_casenext285
	; LineNumber: 213
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr287
	sta in_str
	lda #>MainProgram_stringassignstr287
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	jmp MainProgram_caseend252
MainProgram_casenext285
	lda i
	cmp #$9 ;keep
	bne MainProgram_casenext289
	; LineNumber: 214
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr291
	sta in_str
	lda #>MainProgram_stringassignstr291
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	jmp MainProgram_caseend252
MainProgram_casenext289
	lda i
	cmp #$a ;keep
	bne MainProgram_casenext293
	; LineNumber: 215
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr295
	sta in_str
	lda #>MainProgram_stringassignstr295
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	jmp MainProgram_caseend252
MainProgram_casenext293
	lda i
	cmp #$b ;keep
	bne MainProgram_casenext297
	; LineNumber: 216
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr299
	sta in_str
	lda #>MainProgram_stringassignstr299
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	jmp MainProgram_caseend252
MainProgram_casenext297
	lda i
	cmp #$c ;keep
	bne MainProgram_casenext301
	; LineNumber: 217
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr303
	sta in_str
	lda #>MainProgram_stringassignstr303
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	jmp MainProgram_caseend252
MainProgram_casenext301
	lda i
	cmp #$d ;keep
	bne MainProgram_casenext305
	; LineNumber: 218
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr307
	sta in_str
	lda #>MainProgram_stringassignstr307
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	jmp MainProgram_caseend252
MainProgram_casenext305
	lda i
	cmp #$e ;keep
	bne MainProgram_casenext309
	; LineNumber: 219
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr311
	sta in_str
	lda #>MainProgram_stringassignstr311
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	jmp MainProgram_caseend252
MainProgram_casenext309
	lda i
	cmp #$f ;keep
	bne MainProgram_casenext313
	; LineNumber: 220
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr315
	sta in_str
	lda #>MainProgram_stringassignstr315
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	jmp MainProgram_caseend252
MainProgram_casenext313
	lda i
	cmp #$10 ;keep
	bne MainProgram_casenext317
	; LineNumber: 221
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr319
	sta in_str
	lda #>MainProgram_stringassignstr319
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	jmp MainProgram_caseend252
MainProgram_casenext317
	lda i
	cmp #$11 ;keep
	bne MainProgram_casenext321
	; LineNumber: 222
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr323
	sta in_str
	lda #>MainProgram_stringassignstr323
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	jmp MainProgram_caseend252
MainProgram_casenext321
	lda i
	cmp #$12 ;keep
	bne MainProgram_casenext325
	; LineNumber: 223
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr327
	sta in_str
	lda #>MainProgram_stringassignstr327
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	jmp MainProgram_caseend252
MainProgram_casenext325
	lda i
	cmp #$13 ;keep
	bne MainProgram_casenext329
	; LineNumber: 224
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr331
	sta in_str
	lda #>MainProgram_stringassignstr331
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	jmp MainProgram_caseend252
MainProgram_casenext329
	lda i
	cmp #$14 ;keep
	bne MainProgram_casenext333
	; LineNumber: 225
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr335
	sta in_str
	lda #>MainProgram_stringassignstr335
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	jmp MainProgram_caseend252
MainProgram_casenext333
	lda i
	cmp #$15 ;keep
	bne MainProgram_casenext337
	; LineNumber: 226
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr339
	sta in_str
	lda #>MainProgram_stringassignstr339
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	jmp MainProgram_caseend252
MainProgram_casenext337
	lda i
	cmp #$16 ;keep
	bne MainProgram_casenext341
	; LineNumber: 227
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr343
	sta in_str
	lda #>MainProgram_stringassignstr343
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	jmp MainProgram_caseend252
MainProgram_casenext341
	lda i
	cmp #$17 ;keep
	bne MainProgram_casenext345
	; LineNumber: 228
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr347
	sta in_str
	lda #>MainProgram_stringassignstr347
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	jmp MainProgram_caseend252
MainProgram_casenext345
	lda i
	cmp #$18 ;keep
	bne MainProgram_casenext349
	; LineNumber: 229
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr351
	sta in_str
	lda #>MainProgram_stringassignstr351
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	jmp MainProgram_caseend252
MainProgram_casenext349
	lda i
	cmp #$19 ;keep
	bne MainProgram_casenext353
	; LineNumber: 230
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr355
	sta in_str
	lda #>MainProgram_stringassignstr355
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	jmp MainProgram_caseend252
MainProgram_casenext353
	lda i
	cmp #$1a ;keep
	bne MainProgram_casenext357
	; LineNumber: 231
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr359
	sta in_str
	lda #>MainProgram_stringassignstr359
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	jmp MainProgram_caseend252
MainProgram_casenext357
	lda i
	cmp #$1b ;keep
	bne MainProgram_casenext361
	; LineNumber: 232
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr363
	sta in_str
	lda #>MainProgram_stringassignstr363
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	jmp MainProgram_caseend252
MainProgram_casenext361
	lda i
	cmp #$1c ;keep
	bne MainProgram_casenext365
	; LineNumber: 233
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr367
	sta in_str
	lda #>MainProgram_stringassignstr367
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	jmp MainProgram_caseend252
MainProgram_casenext365
	lda i
	cmp #$1d ;keep
	bne MainProgram_casenext369
	; LineNumber: 234
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr371
	sta in_str
	lda #>MainProgram_stringassignstr371
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	jmp MainProgram_caseend252
MainProgram_casenext369
	lda i
	cmp #$1e ;keep
	bne MainProgram_casenext373
	; LineNumber: 235
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr375
	sta in_str
	lda #>MainProgram_stringassignstr375
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	jmp MainProgram_caseend252
MainProgram_casenext373
	lda i
	cmp #$1f ;keep
	bne MainProgram_casenext377
	; LineNumber: 236
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr379
	sta in_str
	lda #>MainProgram_stringassignstr379
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	jmp MainProgram_caseend252
MainProgram_casenext377
	lda i
	cmp #$20 ;keep
	bne MainProgram_casenext381
	; LineNumber: 237
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr383
	sta in_str
	lda #>MainProgram_stringassignstr383
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	jmp MainProgram_caseend252
MainProgram_casenext381
	lda i
	cmp #$21 ;keep
	bne MainProgram_casenext385
	; LineNumber: 238
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr387
	sta in_str
	lda #>MainProgram_stringassignstr387
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	jmp MainProgram_caseend252
MainProgram_casenext385
	lda i
	cmp #$22 ;keep
	bne MainProgram_casenext389
	; LineNumber: 239
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr391
	sta in_str
	lda #>MainProgram_stringassignstr391
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	jmp MainProgram_caseend252
MainProgram_casenext389
	lda i
	cmp #$23 ;keep
	bne MainProgram_casenext393
	; LineNumber: 240
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr395
	sta in_str
	lda #>MainProgram_stringassignstr395
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	jmp MainProgram_caseend252
MainProgram_casenext393
	lda i
	cmp #$24 ;keep
	bne MainProgram_casenext397
	; LineNumber: 241
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr399
	sta in_str
	lda #>MainProgram_stringassignstr399
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	jmp MainProgram_caseend252
MainProgram_casenext397
	lda i
	cmp #$25 ;keep
	bne MainProgram_casenext401
	; LineNumber: 242
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr403
	sta in_str
	lda #>MainProgram_stringassignstr403
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	jmp MainProgram_caseend252
MainProgram_casenext401
	lda i
	cmp #$26 ;keep
	bne MainProgram_casenext405
	; LineNumber: 243
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr407
	sta in_str
	lda #>MainProgram_stringassignstr407
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	jmp MainProgram_caseend252
MainProgram_casenext405
	lda i
	cmp #$27 ;keep
	bne MainProgram_casenext409
	; LineNumber: 244
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr411
	sta in_str
	lda #>MainProgram_stringassignstr411
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	jmp MainProgram_caseend252
MainProgram_casenext409
	lda i
	cmp #$28 ;keep
	bne MainProgram_casenext413
	; LineNumber: 245
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr415
	sta in_str
	lda #>MainProgram_stringassignstr415
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	jmp MainProgram_caseend252
MainProgram_casenext413
	lda i
	cmp #$29 ;keep
	bne MainProgram_casenext417
	; LineNumber: 246
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr419
	sta in_str
	lda #>MainProgram_stringassignstr419
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	jmp MainProgram_caseend252
MainProgram_casenext417
	lda i
	cmp #$2a ;keep
	bne MainProgram_casenext421
	; LineNumber: 247
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr423
	sta in_str
	lda #>MainProgram_stringassignstr423
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	jmp MainProgram_caseend252
MainProgram_casenext421
	lda i
	cmp #$2b ;keep
	bne MainProgram_casenext425
	; LineNumber: 248
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr427
	sta in_str
	lda #>MainProgram_stringassignstr427
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	jmp MainProgram_caseend252
MainProgram_casenext425
	lda i
	cmp #$2c ;keep
	bne MainProgram_casenext429
	; LineNumber: 249
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr431
	sta in_str
	lda #>MainProgram_stringassignstr431
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	jmp MainProgram_caseend252
MainProgram_casenext429
	lda i
	cmp #$2d ;keep
	bne MainProgram_casenext433
	; LineNumber: 250
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr435
	sta in_str
	lda #>MainProgram_stringassignstr435
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	jmp MainProgram_caseend252
MainProgram_casenext433
	lda i
	cmp #$2e ;keep
	bne MainProgram_casenext437
	; LineNumber: 251
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr439
	sta in_str
	lda #>MainProgram_stringassignstr439
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	jmp MainProgram_caseend252
MainProgram_casenext437
	lda i
	cmp #$2f ;keep
	bne MainProgram_casenext441
	; LineNumber: 252
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr443
	sta in_str
	lda #>MainProgram_stringassignstr443
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	jmp MainProgram_caseend252
MainProgram_casenext441
	lda i
	cmp #$30 ;keep
	bne MainProgram_casenext445
	; LineNumber: 253
	; Assigning single variable : in_str
	lda #<MainProgram_stringassignstr447
	sta in_str
	lda #>MainProgram_stringassignstr447
	sta in_str+1
	; Assigning single variable : CRLF
	lda #$0
	; Calling storevariable
	sta CRLF
	jsr print_string
	jmp MainProgram_caseend252
MainProgram_casenext445
MainProgram_caseend252
	; LineNumber: 261
	; Assigning single variable : w
	lda #$1
	; Calling storevariable
	sta w
MainProgram_forloop449
	; LineNumber: 258
	; LineNumber: 259
	jsr wait_vsync
	; LineNumber: 260
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
	; LineNumber: 261
	jmp MainProgram_while26
MainProgram_elsedoneblock29
MainProgram_loopend31
	; LineNumber: 263
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
