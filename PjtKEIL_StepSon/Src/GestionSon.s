	PRESERVE8
	THUMB  
	include DriverJeuLaser.inc
	EXPORT SortieSon
	EXPORT CallbackSon
	EXPORT Index
	IMPORT Son
	IMPORT LongueurSon
		



; ====================== zone de réservation de données,  ======================================
;Section RAM (read only) :
	area    mesdata,data,readonly


;Section RAM (read write):
	area    maram,data,readwrite
		
SortieSon dcd 0
Index dcd 0

	

	
; ===============================================================================================
	


		
;Section ROM code (read only) :		
	area    moncode,code,readonly
; écrire le code ici		

CallbackSon proc
	
	ldr r1, =Son
	ldr r2, =Index ; on charge l'adresse du tableau
	

	ldr r0, =LongueurSon; 4 * 5512 index final
	ldr r0, [r0]
	
	ldr r3,[r2] ; r3 est l'index courant
	cmp r3, r0
	ble calcul
	bx lr
	
calcul
	
	ldrsh	r0, [r1,r3,LSL #1]
	
	add r3,#1
	str r3, [r2]; on sauvegarde l'index
	
	;calcul
	add r0, #32768
	mov r3, #720
	mul r0, r3
	lsr r0,#16
	
	ldr r1,=SortieSon
	str r0, [r1]; on copie le resultat dans SortieSon
	
	b PWM_Set_Value_TIM3_Ch3

	endp
		

	END	