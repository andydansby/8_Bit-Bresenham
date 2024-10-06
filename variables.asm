org $8080

;input variables
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
line_x1:	defb 15 		;$8080	line start point X
line_y1:	defb 15 		;$8082	line start point Y
line_x2:	defb 0  	;$8084	line end point X
line_y2:	defb 0  	;$8086	line end point Y
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



PUBLIC deltaX
	deltaX:			defb 00   ;$
PUBLIC deltaY
	deltaY:			defb 00   ;$

PUBLIC fraction			        ;$
fraction:	defb 00


;----------------
PUBLIC stepX
    stepX:		defb 00         ;$
PUBLIC stepY
    stepY:		defb 00		    ;$
PUBLIC steps
    steps:      defb 00         ;$



iterations:	defb 00


PUBLIC plot_x			;$
plot_x:		defb 00

PUBLIC plot_y			;$
plot_y:		defb 00


PUBLIC _gfx_xy
_gfx_xy:		defw 0000



PUBLIC X_PositionBits	;$
X_PositionBits:
defb 128,64,32,16,8,4,2,1


;Bit 7: Sign Flag               (S)
;Bit 6: Zero Flag               (Z)
;Bit 5: Not Used                (Y)
;Bit 4: Half Carry Flag         (H)
;Bit 3: Not Used                (X)
;Bit 2: Parity / Overflow Flag  (P)
;Bit 1: Add / Subtract Flag     (N)
;Bit 0: Carry Flag              (C)
;S Z Y H X P N C









