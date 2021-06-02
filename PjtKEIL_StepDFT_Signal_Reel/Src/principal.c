

#include "DriverJeuLaser.h"

extern short int LeSignal;

extern int DFT_ModuleAuCarre( short int * Signal64ech, char k);
short int dma_buf[64];
int tab[64];

int tab_score[6]={0,0,0,0,0,0};

void cible_touchee(int k){
	switch (k){
		case 17 :
			tab_score[0]+=1;
			break;
			
		case 18 :
			tab_score[1]+=1;
			break;
			
		case 19 :
			tab_score[2]+=1;
			break;
			
		case 20 :
			tab_score[3]+=1;
			break;
			
		case 23 :
			tab_score[4]+=1;
			break;
			
		case 24 :
			tab_score[5]+=1;
			break;
			
		default :
			break;
			//printf("Erreur !!!! REPOSE CE PISTOLET TOUT DE SUITE !!!!!!\n");
	}
}

int max;
int k;

void callback_Systick(void){
	Start_DMA1(64);
	Wait_On_End_Of_DMA1();
	Stop_DMA1;
	int i;
	for (i=0; i<33;i++)
	tab[i]=DFT_ModuleAuCarre(dma_buf,i);
		
	//calcul des scores
	max=0;
	k=-1;
	for (i=1; i<33;i++){
		if (tab[i]> max){
			max=tab[i];
			k=i;
		}
	}
	cible_touchee(k);
}





int main(void)
{

// ===========================================================================
// ============= INIT PERIPH (faites qu'une seule fois)  =====================
// ===========================================================================

// Après exécution : le coeur CPU est clocké à 72MHz ainsi que tous les timers
CLOCK_Configure();
	
	
// partie ADC&DMA
	//timer Systick
Systick_Period_ff(360000); // 5ms*72MHz
Systick_Prio_IT(2,callback_Systick);
SysTick_On;
SysTick_Enable_IT;
	
	// mesure
Init_TimingADC_ActiveADC_ff( ADC1, 72 );
Single_Channel_ADC( ADC1, 2 );
Init_Conversion_On_Trig_Timer_ff( ADC1, TIM2_CC2, 225 );
Init_ADC1_DMA1( 0, dma_buf );

//============================================================================	

	
	
while	(1)
{
}

}

