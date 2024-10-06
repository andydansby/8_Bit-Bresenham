org $9300

PUBLIC dyLarger
dyLarger:

    jp dyLarger

;fraction = deltaX - (deltaY >> 1);
    ld HL, (deltaY)

    ; Right shift deltaX by 1 (equivalent to dividing by 2)
    srl H                       ; Shift the high byte right
    rr L                        ; Rotate right through carry the low byte

    ; Store shifted deltaY in DE for subtraction
    ;optimize out the next two steps
    ;ld D, H
    ;ld E, L
    ex de, hl

    ; Load deltaX into HL
    ld HL, (deltaX)

    ; Subtract (deltaX >> 1) from deltaY
    or A                        ; Clear the carry flag
    sbc HL, DE                  ; Subtract DE from HL with carry

    ; Store the result in fraction
    LD (fraction), HL


;for (iterations = 0; iterations <= steps; iterations++)
    ;initilize iterations loop
    xor A                       ; Clear A (equivalent to ld A, 0)
    ld (iterations), A          ; set iterations to 0


deltaY_iteration:
    ;ld A, (iterations)          ; this probally can be optimized out
    ld HL, (steps)              ; Load steps into H
    cp L                        ; Compare iterations (A) with steps (L)
    jp z, deltaY_iteration_end  ; If iterations = steps, exit loop

DY_iteration_loop:
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
    jp m, DY_fraction_negative  ;check Sign flag

; only if fraction is Greater than 0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;inside IF
;fraction -= deltaY;
    ;fraction is already in HL
    ld DE, (deltaY)
    sbc HL, DE
    ld (fraction), HL

;line_x1 += stepX;
    ld a, (stepX)
    ld hl, (line_x1) ; Load line_y1 into HL

    ; Load stepY into E and clear D
    ld e, a          ; Load stepY into E
    xor a            ; clear D
    ld d, a          ;

    add hl, de
    ld (line_x1), hl    ;save answer
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;inside IF

;if fraction is less than 0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;outside IF
DY_fraction_negative:   ; #934D
; line_y1 += stepY;
    xor A           ; set D to 0
    ld D, A
    ld A, (stepY)   ; Load stepY into E
    ld E, A
    ld HL, (line_y1); Load line_x1 into HL
    add HL, DE
    ld (line_y1), HL; answer

;fraction += deltaX;    //
    ld HL, (fraction)
    ld DE, (deltaX)
    add HL, DE
    ld (fraction), HL

; iterations++
    ;increase iterations, place just before deltaX_iteration_end
    ld A, (iterations)      ; Load iterations into A
    inc A                   ; Increment iterations
    ld (iterations), A      ; Store the incremented value back to iterations
    jp deltaY_iteration    ; Repeat the loop

deltaY_iteration_end:
    jp bresenham_end

end_DY_larger:
