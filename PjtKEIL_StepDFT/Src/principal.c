

#include "DriverJeuLaser.h"

extern short int LeSignal;

extern int DFT_ModuleAuCarre( short int * Signal64ech, char k);
int tab[64];
int main(void)
{

// ===========================================================================
// ============= INIT PERIPH (faites qu'une seule fois)  =====================
// ===========================================================================

// Apr?s ex?cution : le coeur CPU est clock? ? 72MHz ainsi que tous les timers
CLOCK_Configure();


	
	

//============================================================================	
int i;
for (i=0; i<64;i++)
	tab[i]=DFT_ModuleAuCarre(&LeSignal,i);
	
while	(1)
	{
	}
}

