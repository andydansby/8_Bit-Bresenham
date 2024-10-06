org $9200

PUBLIC dxLarger
dxLarger:

;jp dxLarger

;fraction = deltaY - (deltaX / 2);
;fraction = deltaY - (deltaX >> 1);
    ld A, (deltaX)     ; load deltaX into register A
    srl A              ; shift right to divide by 2
    ld H, A            ; store the result in register H (deltaX / 2)
    ld A, (deltaY)     ; load deltaY into register A
    sub H              ; subtract (deltaX / 2)
    ld (fraction), A   ; store the result in fraction


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



DX_iteration_loop:
    ; Code for the loop body goes here

    ;plot or point code goes here
    ld A, (line_x1)
    ld (plot_x), A
    ld A, (line_y1)
    ld (plot_y), A
    call _joffa_pixel2
    ;ATTENTION, need to rework, so that HL is _gfx_xy and save those cycles

;if (fraction >= 0)
    ld A, (fraction)           ; Load fraction into A
    ; check to see if fraction is less than 0
    bit 7, A
    jp m, DX_fraction_negative  ;check Sign flag

; only if fraction is Greater than 0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;inside IF
; fraction -= deltaX
    ld A, (deltaX)
    ld H, A
    ld A, (fraction)
    sub H
    ld (fraction), A
    ;;answer


;line_y1 += stepY;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;inside IF
    ld A, (stepY)
    ld H, A
    ld A, (line_y1)
    add A, H
    ld (line_y1), A    ;save answer
    ;answer


;if fraction is less than 0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;outside IF
DX_fraction_negative:
; line_x1 += stepX
    ld A, (stepX)
    ld H, A
    ld A, (line_x1)
    add A, H
    ld (line_x1), A
    ;answer

;fraction += deltaY;
    ld A, (fraction)
    ld H, A
    ld A, (deltaY)
    add A, H
    ld (fraction), A
    ;answer

; iterations++
    ;increase iterations, place just before deltaX_iteration_end
increase_deltaX_iterations:
    ld A, (iterations)      ; Load iterations into A
    inc A                   ; Increment iterations
    ld (iterations), A      ; Store the incremented value back to iterations
    jp deltaX_iteration    ; Repeat the loop

deltaX_iteration_end:
    jp bresenham_end

end_DX_larger:
