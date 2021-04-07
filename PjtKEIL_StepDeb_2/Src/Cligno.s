	PRESERVE8
	THUMB   
	include DriverJeuLaser.inc
	EXPORT FlagCligno
	EXPORT timer_callback
			

; ====================== zone de r�servation de donn�es,  ======================================
;Section RAM (read only) :
	area    mesdata,data,readonly
		



;Section RAM (read write):
	area    maram,data,readwrite

FlagCligno dcd 0	

	
; ===============================================================================================
	


		
;Section ROM code (read only) :		
	area    moncode,code,readonly
; �crire le code ici		




timer_callback proc
	
	;push {lr}

	ldr r2,=FlagCligno; pas d'acces memoire juste une copie d'adresse
	ldr r1, [r2]
	mov r0,#1
	
	cmp r1,#1
	beq FlagCligno_1
	mov r1, #1; FlagCligno vaut 0 et on lui met 1 (else)
	str r1,[r2]
	b GPIOB_Clear ; optimisation ( tail recursion pr les fonctions recursives mais qui marche ici) qui ne marche que pas si c'etait pas la dernier fonction appel�e
	; en mettant b seulement au lieu de bl il ne modifiera pas lr qui restera egal � la ligne � laquelle on retourne apres l'interruption
	;pop {pc} ; au lieu de pop lr et bx lr (il met la valeur de lr qui est dans la pile dans le pc directement)
	
FlagCligno_1
	mov r1, #0
	str r1,[r2]
	b GPIOB_Set
	;pop {pc}
	

	
	endp


		
		
	END	