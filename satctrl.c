/*****************************************************
This program was produced by the
CodeWizardAVR V1.24.4 Standard
Automatic Program Generator
© Copyright 1998-2004 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com
e-mail:office@hpinfotech.com

Project : SatCtrl
Version : V0.00
Date    : 2012-9-7
Author  : zhangjing                       
Company : zhangjing                       
Comments:                       
Used for PCB SatController1.00 
V0.00 created by AnJoid 20120907  
V0.01 Able to do basic in port operation,by AnJoid  2013-1-23

Chip type           : ATmega128
Program type        : Application
Clock frequency     : 16.000000 MHz
Memory model        : Small
External SRAM size  : 0
Data Stack size     : 1024
*****************************************************/

#include "include.h"

unsigned int temp_para = 0; 
 

void init(void)
{  
 
// Input/Output Ports initialization
// Port A initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTA=0x00;
DDRA=0x00;

// Port B initialization
// Func7=In Func6=In Func5=Out Func4=Out Func3=In Func2=Out Func1=Out Func0=Out 
// State7=T State6=T State5=0 State4=0 State3=T State2=0 State1=0 State0=1 
PORTB=0x01;
DDRB=0x37;

// Port C initialization
// Func7=In Func6=Out Func5=Out Func4=In Func3=Out Func2=Out Func1=In Func0=In 
// State7=T State6=0 State5=0 State4=T State3=0 State2=0 State1=T State0=T 
PORTC=0x00;
DDRC=0x6C;

// Port D initialization
// Func7=Out Func6=Out Func5=Out Func4=Out Func3=Out Func2=In Func1=Out Func0=Out 
// State7=0 State6=0 State5=0 State4=1 State3=0 State2=T State1=0 State0=0 
PORTD=0x10;
DDRD=0xFB;

// Port E initialization
// Func7=In Func6=In Func5=In Func4=In Func3=Out Func2=Out Func1=Out Func0=In 
// State7=T State6=T State5=T State4=T State3=0 State2=0 State1=0 State0=T 
PORTE=0x00;
DDRE=0x0E;

// Port F initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTF=0x00;
DDRF=0x00;

// Port G initialization
// Func4=Out Func3=Out Func2=In Func1=In Func0=In 
// State4=0 State3=0 State2=T State1=T State0=T 
PORTG=0x00;
DDRG=0x18;

// Timer/Counter 0 initialization
// Clock source: System Clock
// Clock value: 15.625 kHz
// Mode: Normal top=FFh
// OC0 output: Disconnected
ASSR=0x00;
TCCR0=0x07;
TCNT0=0x82;
OCR0=0x00;

// Timer/Counter 1 initialization
// Clock source: System Clock
// Clock value: Timer 1 Stopped
// Mode: Normal top=FFFFh
// OC1A output: Discon.
// OC1B output: Discon.
// OC1C output: Discon.
// Noise Canceler: Off
// Input Capture on Falling Edge
TCCR1A=0x00;
TCCR1B=0x00;
TCNT1H=0x00;
TCNT1L=0x00;
ICR1H=0x00;
ICR1L=0x00;
OCR1AH=0x00;
OCR1AL=0x00;
OCR1BH=0x00;
OCR1BL=0x00;
OCR1CH=0x00;
OCR1CL=0x00;

// Timer/Counter 2 initialization
// Clock source: System Clock
// Clock value: Timer 2 Stopped
// Mode: Normal top=FFh
// OC2 output: Disconnected
TCCR2=0x00;
TCNT2=0x00;
OCR2=0x00;

// Timer/Counter 3 initialization
// Clock source: System Clock
// Clock value: Timer 3 Stopped
// Mode: Normal top=FFFFh
// Noise Canceler: Off
// Input Capture on Falling Edge
// OC3A output: Discon.
// OC3B output: Discon.
// OC3C output: Discon.
TCCR3A=0x00;
TCCR3B=0x00;
TCNT3H=0x00;
TCNT3L=0x00;
ICR3H=0x00;
ICR3L=0x00;
OCR3AH=0x00;
OCR3AL=0x00;
OCR3BH=0x00;
OCR3BL=0x00;
OCR3CH=0x00;
OCR3CL=0x00;

// External Interrupt(s) initialization
// INT0: Off
// INT1: Off
// INT2: Off
// INT3: Off
// INT4: Off
// INT5: Off
// INT6: Off
// INT7: Off
EICRA=0x00;
EICRB=0x00;
EIMSK=0x00;

// Timer(s)/Counter(s) Interrupt(s) initialization
TIMSK=0x00;
ETIMSK=0x00;

// USART0 initialization
// Communication Parameters: 8 Data, 1 Stop, No Parity
// USART0 Receiver: On
// USART0 Transmitter: On
// USART0 Mode: Asynchronous
// USART0 Baud rate: 56000
UCSR0A=0x00;
UCSR0B=0x18;
UCSR0C=0x06;
UBRR0H=0x00;
UBRR0L=0x11;

// USART1 initialization
// Communication Parameters: 8 Data, 1 Stop, No Parity
// USART1 Receiver: On
// USART1 Transmitter: On
// USART1 Mode: Asynchronous
// USART1 Baud rate: 9600
UCSR1A=0x00;
UCSR1B=0x18;
UCSR1C=0x06;
UBRR1H=0x00;
UBRR1L=0x67;

// Analog Comparator initialization
// Analog Comparator: Off
// Analog Comparator Input Capture by Timer/Counter 1: Off
ACSR=0x80;
SFIOR=0x00;

// ADC initialization
// ADC Clock frequency: 125.000 kHz
// ADC Voltage Reference: AVCC pin
// Only the 8 most significant bits of
// the AD conversion result are used
ADMUX=ADC_VREF_TYPE;
ADCSRA=0x87;

 delay_ms(1000);
              
 TUNER_18V;
 printf("\n...............\n"); 
 printf("\n......◊‘ºÏ.....\n");    
 printf("13/18VµÁ—π %f\n",((float)LNB_VTG/9.21));   
 printf("AGCµÁ—π %f\n",((float)AGC_ORG/51));   
 printf("AGCµ˜¿ÌµÁ—π %f\n",((float)AGC_AMP/51));          
 printf("1.8VµÁ—π %f\n",((float)VTG1V8/51));
 printf("3.3VµÁ—π %f\n",((float)VTG3V3/51)); 
 printf("AD5µÁ—π %f\n",((float)ANLG_A/51)); 
 printf("AD6µÁ—π %f\n",((float)ANLG_B/51)); 
 printf("AD7µÁ—π %f\n",((float)ANLG_C/51)); 
 printf("........DONE...........\n");  
}


 void gyro(void)
 {
    long int dir_x,dir_y;
    unsigned int x,y,xx,yy;  
    dir_x=dir_y=1000000;
    while(!Rx0())  
      {
         while(!(TIFR & 0x01))       //wait TC0    125Hz
                ;
         TIFR = TIFR | 0x01;         //clear TOV0
         TCNT0=0x82;                 //init timer from 130
         x = ANLG_A;
         y = ANLG_B;
         dir_x = dir_x+x-508;
         dir_y = dir_y+y-510;  
         xx = (dir_x-775000)/625;
         yy = (dir_y-775000)/625;  
         printf("%u %u %u %u\n",x,y,xx,yy);
         //printf("%u %u \n",x,y);
      }
      
  }



// Declare your global variables here

void main(void)
{
// Declare your local variables here               
long int LNB_frequence; 
long int sate_frequence;//
unsigned long TunerFreq;
float symbol_rate;            
unsigned char addrbyte,databyte;     
LNB_frequence =10750;//11300;      
sate_frequence =11880; //92.2
symbol_rate  = 28800;   //
TunerFreq = (labs(LNB_frequence-sate_frequence))*1000; 

TUNER_18V;

 
                   
init();   
LED1_ON;
LED2_ON;
delay_ms(1500);
LED1_OFF;       
LED2_OFF;      

TunerRst();
     
while (1)
{
    //if()
     //   break; 
    LED1_OFF; 
    switch (Rx0()) 
    {
        case 'H': 
            {                                    
            LED1_ON;
            TUNER_18V;
            printf("Set Tuner Voltage 18V!!!\n");
            }
            break;    
        case 'A': 
            {
                 LED1_ON;
                 printf("\n......ADCÕ®µ¿≤‚¡ø.....\n");    
                 printf("13/18VµÁ—π %f\n",((float)LNB_VTG/9.21));   
                 printf("AGCµÁ—π %f\n",((float)AGC_ORG/51));   
                 printf("AGCµ˜¿ÌµÁ—π %f\n",((float)AGC_AMP/51));          
                 printf("1.8VµÁ—π %f\n",((float)VTG1V8/51));
                 printf("3.3VµÁ—π %f\n",((float)VTG3V3/51)); 
                 printf("AD5µÁ—π %f\n",((float)ANLG_A/51)); 
                 printf("AD6µÁ—π %f\n",((float)ANLG_B/51)); 
                 printf("AD7µÁ—π %f\n",((float)ANLG_C/51)); 
                 printf("........DONE...........\n");  
            }
            break;   
         case 'G': 
            {
                 LED1_ON;
                 gyro();
            }
            break;              
        case 'L': 
            {     
            LED1_ON;
            TUNER_13V;
            printf("Set Tuner Voltage 13V!!!\n");
            }
            break;   
        case 'R': 
            {     
            LED1_ON;
            printf("Enter register addr:");
            addrbyte = Rx0();  
            while(addrbyte == 0)
                addrbyte = Rx0();
            if(addrbyte == 0xff)
                addrbyte =0;       
            printf("Register 0x%x value is 0x%x\n",addrbyte,Get0288Register(addrbyte)); 
            }
            break; 
        case 'S': 
            {     
            LED1_ON;
            printf("Enter register addr & byte:");
            addrbyte = Rx0();  
            while(addrbyte == 0)
                addrbyte = Rx0(); 
            databyte = Rx0();  
            while(databyte == 0)
                databyte = Rx0();      
            printf("Write %x to Reg 0x%x,and value is 0x%x\n",databyte,addrbyte,Set0288Register(addrbyte,databyte)); 
            }
            break;     
        case 'T': 
            {     
            LED1_ON;
            Track(); 
            }
            break;               
        case 'I': 
            {           
            LED1_ON; 
            printf("TunerFreq to be set %ld.\n",TunerFreq);
            tuner(TunerFreq,symbol_rate);
            printf("Init Tuner!!!\n");
            }
            break;    
    default:
    };
   
                          

}
      
      
      
      
      
}
