	PRESERVE8
	THUMB   
		

; ====================== zone de r�servation de donn�es,  ======================================
;Section RAM (read only) :
	area    mesdata,data,readonly


;Section RAM (read write):
	area    maram,data,readwrite
		
VarTime	dcd 0; VarTime est une adresse m�moire (c'est un label)

	
; ===============================================================================================
	
;constantes (�quivalent du #define en C)
TimeValue	equ 900000; remplace juste 900000 par TimeValue (ce n'est pas un label, il n'existe pas en m�moire)


	EXPORT Delay_100ms ; la fonction Delay_100ms est rendue publique donc utilisable par d'autres modules.
	EXPORT VarTime
		
;Section ROM code (read only) :		
	area    moncode,code,readonly
		


; REMARQUE IMPORTANTE 
; Cette mani�re de cr�er une temporisation n'est clairement pas la bonne mani�re de proc�der :
; - elle est peu pr�cise
; - la fonction prend tout le temps CPU pour... ne rien faire...
;
; Pour autant, la fonction montre :
; - les boucles en ASM
; - l'acc�s �cr/lec de variable en RAM
; - le m�canisme d'appel / retour sous programme
;
; et donc poss�de un int�r�t pour d�buter en ASM pur

Delay_100ms proc
	
	    ldr r0,=VarTime  	; r0 contient l'adresse VarTime 	  
						  
		ldr r1,=TimeValue  ; r1 contient la valeur timeValue
		str r1,[r0]  ; copie timeValue (dans r1) � l'adresse varTime dans (r0)
		
BoucleTempo	
		ldr r1,[r0]     				; copie timeValue dans r1
						
		subs r1,#1  ; timeValue--
		str  r1,[r0] ; on copie le resultat dans r0
		bne	 BoucleTempo; on revient au debut de la boucle jusqu'� ce que timeValue soit  egal � 0
			
		bx lr  ; retourn � la ligne de code � ex�cuter sans retour de fonction (pas de retour on cherche � perdre du temps
		endp
		
		
	END	