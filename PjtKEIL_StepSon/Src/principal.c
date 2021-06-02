
#include "DriverJeuLaser.h"
#include "GestionSon.h"

extern int Index;
extern int LongueurSon;

void StartSon(){
	if (Index==LongueurSon)
		Index = 0;
}

int main(void)
{

// ===========================================================================
// ============= INIT PERIPH (faites qu'une seule fois)  =====================
// ===========================================================================

// Apr�s ex�cution : le coeur CPU est clock� � 72MHz ainsi que tous les timers
CLOCK_Configure();
	

Timer_1234_Init_ff( TIM4, 6552);
Active_IT_Debordement_Timer( TIM4, 2, CallbackSon );


PWM_Init_ff( TIM3, 3, 720);
GPIO_Configure(GPIOB, 0, OUTPUT, ALT_PPULL);

//============================================================================	


while	(1)
	{
		StartSon();
	}
}

