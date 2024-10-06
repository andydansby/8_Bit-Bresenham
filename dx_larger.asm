org $9200

PUBLIC dxLarger
dxLarger:

jp dxLarger

;fraction = deltaY - (deltaX / 2);
;fraction = deltaY - (deltaX >> 1);
    ld A, (deltaX)     ; load deltaX into register A
    srl A              ; shift right to divide by 2
    ld H, A            ; store the result in register H (deltaX / 2)

    ld A, (deltaY)     ; load deltaY into register A
    sub H              ; subtract (deltaX / 2)
    ld (fraction), A   ; store the result in fraction


;<<<<<<    WORKING ON      >>>>>>





;<<<<<<    STOP      >>>>>>


;for (iterations = 0; iterations <= steps; iterations++)
    ;initilize iterations loop
    xor A                       ; Clear A (equivalent to ld A, 0)
    ld (iterations), A          ; set iterations to 0


deltaX_iteration:
    ld A, (steps)
    ld H, A
    ld A, (iterations)
    cp H                        ; Compare iterations (A) with steps (H)
    jp z, deltaX_iteration_end  ; If iterations = steps, exit loop

;<<<<<<    WORKING ON      >>>>>>


;<<<<<<    STOP      >>>>>>


DX_iteration_loop:
    ; Code for the loop body goes here

    ;plot or point code goes here

    ld A, (line_x1)
    ld (plot_x),A
    ld A, (line_y1)
    ld (plot_y),A
    call _joffa_pixel2
    ;ATTENTION, need to rework, so that HL is _gfx_xy and save those cycles






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
