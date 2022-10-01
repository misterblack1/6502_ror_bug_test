; 6502 early/late test code
; Runs on Apple IIe at $E000 on 8k ROM
; Rev 0.3a
; IZ8DWF 2022

; VIDEO RAM is mapped from $0400 to $07FF

	* = $E000
reset
	SEI
	CLD
	LDX #$FF
	TXS		; initialize the stack pointer
	
; soft switches
	LDX $C051	; text mode
	LDX $C054	; page 2 off

; we then use $00,$01 as pointer for video memory 
	LDA #$00
	STA $00
	LDA #$04	
	STA $01
	LDA #$08	; end of video memory (page)
	STA $02
; clears the entire screen
	LDY #$00
npcl:	LDA #$20
cls:	STA ($00),Y
	INY
	BNE cls
	INC $01
	LDA $02
	CMP $01
	BNE npcl
;prints the welcome string
	LDA #$00
	STA $00
	LDA #$04	
	STA $01
	LDA #<welc
	STA $10		; pointer to source string 
	LDA #>welc
	STA $11
	JSR print
; set up the second video row's address
	LDA #$80
	STA $00
	LDA #$04	
	STA $01
;let's test the ROR now
	LDA #$00
	SEC
	ROR		; an early 6502 will just "ASL" so A will be still zero
	BNE nobug
	LDA #<rorb
	STA $10
	LDA #>rorb
	STA $11
	JSR print
ever:	JMP ever		; we may want to reset?
nobug:	LDA #<rorok
	STA $10
	LDA #>rorok
	STA $11
	JSR print
	JMP ever

print:
	LDY #$00
pnext:	LDA ($10),Y	; pointer to the string
	BEQ pexit	; end of string
	STA ($00),Y	; video memory pointer
	INC $00
	CPY $00
	BNE skipv
	INC $01
skipv:	INC $10
	CPY $10
	BNE pnext
	INC $11
	JMP pnext
pexit:	RTS

welc:
.aasc "WELCOME TO THE 6502 EARLY/LATE TEST: ", 0

rorb:
.aasc "THIS 6502 HAS THE ROR BUG!!! ", 0

rorok:
.aasc "THIS IS A 'REGULAR' 6502 ", 0

endofrom
; fills the unused space with $FF 
        * = $FFFA
.dsb (*-endofrom), $FF

; vectors
	* = $FFFA

.db $00,$E0,$00,$E0,$00,$E0

