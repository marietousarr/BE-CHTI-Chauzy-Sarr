	PRESERVE8
	THUMB   
		

; ====================== zone de réservation de données,  ======================================
;Section RAM (read only) :
	area    mesdata,data,readonly


;Section RAM (read write):
	area    maram,data,readwrite
		
VarTime	dcd 0; VarTime est une adresse mémoire (c'est un label)

	
; ===============================================================================================
	
;constantes (équivalent du #define en C)
TimeValue	equ 900000; remplace juste 900000 par TimeValue (ce n'est pas un label, il n'existe pas en mémoire)


	EXPORT Delay_100ms ; la fonction Delay_100ms est rendue publique donc utilisable par d'autres modules.
	EXPORT VarTime
		
;Section ROM code (read only) :		
	area    moncode,code,readonly
		


; REMARQUE IMPORTANTE 
; Cette manière de créer une temporisation n'est clairement pas la bonne manière de procéder :
; - elle est peu précise
; - la fonction prend tout le temps CPU pour... ne rien faire...
;
; Pour autant, la fonction montre :
; - les boucles en ASM
; - l'accés écr/lec de variable en RAM
; - le mécanisme d'appel / retour sous programme
;
; et donc possède un intérêt pour débuter en ASM pur

Delay_100ms proc
	
	    ldr r0,=VarTime  	; r0 contient l'adresse VarTime 	  
						  
		ldr r1,=TimeValue  ; r1 contient la valeur timeValue
		str r1,[r0]  ; copie timeValue (dans r1) à l'adresse varTime dans (r0)
		
BoucleTempo	
		ldr r1,[r0]     				; copie timeValue dans r1
						
		subs r1,#1  ; timeValue--
		str  r1,[r0] ; on copie le resultat dans r0
		bne	 BoucleTempo; on revient au debut de la boucle jusqu'à ce que timeValue soit  egal à 0
			
		bx lr  ; retourn à la ligne de code à exécuter sans retour de fonction (pas de retour on cherche à perdre du temps
		endp
		
		
	END	