org $8080

;input variables
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
line_x1:	defb 0 		;$8080	line start point X
line_y1:	defb 0 		;$8082	line start point Y
line_x2:	defb 5  	;$8084	line end point X
line_y2:	defb 5  	;$8086	line end point Y
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


PUBLIC plot_x			;$809A
plot_x:		defb 00

PUBLIC plot_y			;$809B
plot_y:		defb 00

PUBLIC X_PositionBits	;$80A5
X_PositionBits:
defb 128,64,32,16,8,4,2,1


;Bit 7: Sign Flag
;Bit 6: Zero Flag
;Bit 5: Not Used
;Bit 4: Half Carry Flag
;Bit 3: Not Used
;Bit 2: Parity / Overflow Flag
;Bit 1: Add / Subtract Flag
;Bit 0: Carry Flag
;S Z Y H X P N C









