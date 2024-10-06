
org $9500

;optimized by andy dansby
;using DE/HL
PUBLIC _joffa_pixel2
_joffa_pixel2:

; Load X and Y coordinates

    ;ld de, (_gfx_xy)
	ld A, (plot_x)
	ld E, A
	ld A, (plot_y)
	ld D, A

; Calculate screen address
    ;ld A, D    ;optimize out the next step
    rrca
    rrca
    rrca            ; A = Y / 8 (divide Y by 8)

; Combine Y / 8 with bitmask to create the high byte of the address
    and %00011000   ; Keep only bits 3 and 4 (multiply Y / 8 by 32)
    or  %01000000   ; Add the base address (64)
    ld H, A         ; Store the result in H (high byte of address)

    ; Combine Y % 8 into the high byte for the row within the character block
    ld A, D
    and 7           ; A = Y % 8
    or H            ; Add to H
    ld H, A

    ; Calculate the low byte of the address
    ld A, D
    add A, A        ; Multiply Y % 8 by 8 (shift left 3 bits)
    add A, A
    and %11100000   ; Mask the lower bits
    ld L, A         ; Store in L (low byte of address)

    ; Combine X coordinate into the low byte
    ld A, E
    rrca
    rrca
    rrca            ; Shift X right by 3 bits (divide by 8)
	and %00011111   ; Mask the upper 3 bits
    or L            ; Add to L
    ld L, A         ; hl = screen address.

;lookup table for speed optimization
    ld A, E
    and 7
    ld DE, X_PositionBits
    add A, E
    ld E, A
    ld A, (DE)

    ;output to screen
    or (HL)
    ld (HL), A
ret



;X_PositionBits:
;defb $80,$40,$20,$10,$08,$04,$02,$01











