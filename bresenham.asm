include "variables.asm"
include "routines.asm"
include "dx_larger.asm"
include "dy_larger.asm"
;include "plot.asm"
include "plot2.asm"

org	$8000
start:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; in variables.asm
; you will find x1, y1, x2 and y2
; as
; gfx_x1, gfx_y1, gfx_x2, gfx_y1
; gfx_x, gfx_y as used exclusively for
; _joffa_pixel2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;int deltaX = abs(xx2 - xx1);
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
calculate_deltaX:       ; #
    ld A, (line_x1)
    ld H, A
    ld A, (line_x2)
    ld L, A
    sbc A, H
    ;now calculate the absolute value
    call absA
    ld (deltaX), A          ; Store the result in deltaX

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;now we are calculating STEP X to determine the direction
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;int stepX = (xx1 < xx2) ? 1 : -1;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
calculate_stepX:
;    or A                        ;clear carry flag attention, optimized out
    ld A, H                     ;ld line_x1 into A
    cp L                        ;compare against line_x2
    jr c, stepX_positive

    ld A, -1                    ; Default to -1
    jr stepX_answer

stepX_positive:
    ld A, 1                     ; otherwise 1

stepX_answer:
    ld (stepX), A               ;answer in A

dx_step_end:

;<---------------------
; stepX has answer -1 if X2 is larger
; stepX has answer  1 if X1 is larger or equal

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;int deltaY = abs(yy2 - yy1);
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
calculate_deltaY:       ; #
    ld A, (line_y1)
    ld H, A
    ld A, (line_y2)
    ld L, A
    sbc A, H
    ;now calculate the absolute value
    call absA
    ld (deltaY), A              ; Store the result in deltaX

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;now we are calculating STEP X to determine the direction
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;int stepX = (xx1 < xx2) ? 1 : -1;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
calculate_stepY:
;    or A                        ;clear carry flag attention, optimized out
    ld A, H                     ;ld line_x1 into A
    cp L                        ;compare against line_x2
    jr c, stepY_positive

    ld A, -1                    ; Default to -1
    jr stepY_answer

stepY_positive:
    ld A, 1                     ; otherwise 1

stepY_answer:
    ld (stepY), A               ;answer in A

dy_step_end:

;<---------------------
; stepY has answer -1 if Y2 is larger
; stepY has answer  1 if Y1 is larger or equal


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;steps = max (deltaX,deltaY)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;    xor A			;clear flags attention, optimized out
    ld A, (deltaY)
    ld H, A
    ld A, (deltaX)              ; load deltaX into register A

    cp H                        ; compare A with H
    jp c, set_deltaY_MAX        ; if A < H, jump to set_deltaY

set_deltaX_MAX:
    ld (steps), A               ; if A >= H, set steps to deltaX
    jr steps_answer

set_deltaY_MAX:
    ld A, H                     ; set A to deltaY
    ld (steps), A               ; set steps to deltaY

steps_answer:
    ; steps now contains the maximum of deltaX and deltaY

DYorDY_start:
;	xor A			;clear flags attention, optimized out
	ld A, (deltaX)
	ld H, A
	ld A, (deltaY)
	cp H                        ; compare A with H


	;jp z, dyLarger
	jp m, dxLarger      ;check to see if greater
                        ; sign flag IS set
                        ;$9200

    ;dxLarger = #9200
    ;dyLarger = #9300


    ;if not dxLarger, must be dyLarger

	;jp p, dyLarger      ;check to see if lesser
                        ; sign flag NOT set
                        ;$9300

	;jp z, dyLarger      ;check to see if equal
                        ;if so the DY larger
                        ;$9300
    jp dyLarger



PUBLIC bresenham_end
bresenham_end:


ret

