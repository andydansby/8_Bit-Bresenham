org $9200

PUBLIC dxLarger
dxLarger:

jp dxLarger

;fraction = deltaY - (deltaX / 2);
;fraction = deltaY - (deltaX >> 1);
    ld HL, (deltaX)

    ; Shift deltaX right by 1 (HL >> 1)
    srl H         ; Shift high byte to the right
    rr L          ; Rotate right through carry into low byte

    ; Store shifted deltaX in DE for subtraction
    ;optimize out the next two steps
    ;ld D, H
    ;ld E, L
    ex de, hl

    ; Load deltaY into HL
    ld HL, (deltaY)

    ; Subtract (deltaX >> 1) from deltaY
    or A                        ; Clear the carry flag
    sbc HL, DE                  ; Subtract DE from HL with carry

    ; Store the result in fraction
    LD (fraction), HL


;for (iterations = 0; iterations <= steps; iterations++)
    ;initilize iterations loop
    xor A                       ; Clear A (equivalent to ld A, 0)
    ld (iterations), A          ; set iterations to 0


deltaX_iteration:
    ;ld A, (iterations)         ; this probally can be optimized out
    ld HL, (steps)              ; Load steps into H
    cp L                        ; Compare iterations (A) with steps (L)
    jp z, deltaX_iteration_end  ; If iterations = steps, exit loop

DX_iteration_loop:
    ; Code for the loop body goes here

    ;plot or point code goes here
    ;buffer_plotX = line_x1;        line_x1
    ;buffer_plotY = line_y1;        line_y1
    ;buffer_plot();
    ;buffer_point();
    ld A, (line_x1)
    ld (plot_x),A
    ld A, (line_y1)
    ld (plot_y),A
    call _joffa_pixel2

;if (fraction >= 0)
    ld HL, (fraction)           ; Load fraction into HL
    ; check to see if fraction is less than 0
    ;ld A, H
    ;or L
    bit 7, H
    jp m, DX_fraction_negative  ;check Sign flag

; only if fraction is Greater than 0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;inside IF
; fraction -= deltaX
    ;fraction is already in HL
    ld DE, (deltaX)
    xor A
    sbc HL, DE
    ld (fraction), HL

;line_y1 += stepY;
    ld a, (stepY)
    ld hl, (line_y1) ; Load line_y1 into HL

    ; Load stepY into E and clear D
    ld e, a          ; Load stepY into E
    xor a            ; clear D
    ld d, a          ;

    add hl, de
    ld (line_y1), hl    ;save answer
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;inside IF

;if fraction is less than 0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;outside IF
DX_fraction_negative:
; line_x1 += stepX
    xor A           ; set D to 0
    ld D, A
    ld A, (stepX)   ; Load stepX into E
    ld E, A
    ld HL, (line_x1); Load line_x1 into HL
    add HL, DE
    ld (line_x1), HL; answer

;fraction += deltaY;
    ld HL, (fraction)
    ld DE, (deltaY)
    add HL, DE
    ld (fraction), HL

; iterations++
    ;increase iterations, place just before deltaX_iteration_end
    ld A, (iterations)      ; Load iterations into A
    inc A                   ; Increment iterations
    ld (iterations), A      ; Store the incremented value back to iterations
    jp deltaX_iteration    ; Repeat the loop

deltaX_iteration_end:
    jp bresenham_end

end_DX_larger:
