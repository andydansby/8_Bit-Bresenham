
org $9400

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PUBLIC _buffer_plotX
_buffer_plotX:
defw 0000
;128 dec	80 hex
;;;;;;;;;;;
PUBLIC _buffer_plotY
_buffer_plotY:
defw 0000
;096 dec	60 hex
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;_Ball_char_X
PUBLIC _buffer_plot_charX
_buffer_plot_charX:
defb 00

PUBLIC _buffer_plot_charY
_buffer_plot_charY:
defb 00

PUBLIC _buffer_address
_buffer_address:
defw 0000

PUBLIC _pixel_on_off
_pixel_on_off:
defb 00

PUBLIC _screen_address
_screen_address:
defw $4000
;defw $C000


PUBLIC _screen_addy
_screen_addy:
defw $0000

;PUBLIC _calculate_char_plotxy
;_calculate_char_plotxy:





PUBLIC _buffer_plot
_buffer_plot:
;;using DE, BC

	ld DE, (_buffer_plotY)   ;uses DE
    ld BC, (_buffer_plotX)   ;using C only
	;ok


	call _calculate_char_X_space1
	call _buffer_address_calculation3

	;address is in HL

	;now calculate which bit we are plotting
    ld A,C
    and 7
    ld DE, X_PositionBits
    add A,E
    ld E,A
    ld A,(DE)
    xor (HL)
    ld (HL),A

;    call _calculate_address
	;address is in HL & _buffer_address


	;write to buffer
    or (HL) ; OR with screen contents
    ld (HL),A   ; write to screen
ret






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 PUBLIC _calculate_char_X_space1
_calculate_char_X_space1:
        ;input C - X position in pixel space
        ;output BC -  B char position X, C pixel position X
        ;destroys A
        ;convert pixel space to character space
        ;divide by 8 and mask of remaining bits
        ;_Ball_Pixel_X is 8 bit number
        ;;;;;;
    ld A, C
    ld (_buffer_plotX), A
    rrca                        ; divide by 2
	rrca                        ; divide by 4
	rrca                        ; divide by 8
	and 31                      ; mask remaining bits
	ld B, A                     ; reload back into B
	ld (_buffer_plot_charX), A        ; store in variable that can be read into C
ret


;speccy screen
; 256 X		128
; 192 Y		96

;Y not quite right
;enter with DE = screen Y
;destroys
; A, HL
PUBLIC _buffer_address_calculation3
_buffer_address_calculation3:

        ; output = x + y * width
        ;reformulate
        ; output = (Y * Width) + X

    push BC                     ;save BC
    push DE                     ;save DE, do we really need to save?

        ;multiply_x_26:
    ld H, D
    ld L, E

    add HL, HL                  ; multiply by 2
    add HL, HL                  ; multiply by 4
    add HL, HL                  ; multiply by 8
    add HL, HL                  ; multiply by 16


    ld B, H
    ld C, L
        ;copy to BC for temp storage

    ld H, D
    ld L, E
        ; load in original value

    add HL, HL                  ; multiply by 2
    add HL, HL                  ; multiply by 4
    add HL, HL                  ; multiply by 8
    add HL, BC                  ; sum of 16 + 8 = multiply by 24
    add HL, DE                  ; multiply by 25
    add HL, DE                  ; multiply by 26

        ;now lets add answer and X

    ld A, (_buffer_plot_charX)

    ld B, 0
    ld C, A
    add HL, BC
        ;HL should now have (Y * Width) + X

        ;now put in range
    ;ld BC, $C000
	ld BC, (_screen_address)

    add HL, BC
    ;finished product is in HL

 ATTENTION_temp:
    ld (_screen_addy), HL


    pop DE                      ; restore de
    pop BC                      ; restore bc
ret


PUBLIC _buffer_point
_buffer_point:
;;using DE, BC
    ld DE, (_buffer_plotY)   ;uses DE
    ld BC, (_buffer_plotX)   ;using C only
	call _calculate_char_X_space1
	call _buffer_address_calculation3

	;address is in HL

	;now calculate which bit we are plotting
    ld A,C
    and 7
    ld DE, X_PositionBits
    add A,E
    ld E,A
    ld A,(DE)
    xor (HL)
    ld (HL),A

    ld C,A              ; save the mask on. bit in reg. C
    and (HL)            ; check the pixel on the screen

_endPoint:
    jp z, _noPixelPoint     ;jump only if Z(ero) flag is off, no pixel there
    ;;fall through if there is a pixel there

;    jp nz, hella_yesPixel   ;
;ret                         ; exit procedure

_yesPixelPoint:
    ld a, 1
    ld hl, _pixel_on_off
    ld (hl), a
ret
_noPixelPoint:
    ld a, 0
    ld hl, _pixel_on_off
    ld (hl), a
ret

;PUBLIC _buffer_unplot
;_buffer_unplot:
;;using DE, BC

;	ld DE, (_buffer_plotY)   ;uses DE
;    ld BC, (_buffer_plotX)   ;using C only
;	call _calculate_char_X_space1
;	call _buffer_address_calculation3

	;address is in HL

	;now calculate which bit we are plotting
;    ld A,C
;    and 7
;    ld DE, X_PositionBits
;    add A,E
;    ld E,A
;    ld A,(DE)
;    xor (HL)
;    ld (HL),A

	;write to buffer
;    and (HL) ; AND with screen contents
;    ld (HL),A   ; write to screen
;ret
;974
;1004
;1032
;1010
