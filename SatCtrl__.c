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
#include "include.h"      



// Read the AD conversion result
unsigned int read_adc(unsigned char adc_input)
{
ADMUX=adc_input|ADC_VREF_TYPE;
// Start the AD conversion
ADCSRA|=0x40;
// Wait for the AD conversion to complete
while ((ADCSRA & 0x10)==0);
ADCSRA|=0x10;
return ADCW;
}

                            
#pragma used+  
/**********************
∑¢ÀÕµ•∏ˆ◊÷∑˚
***********************/
void Tx0(unsigned char c)
{              
        UDR0 = c;
        while(!(UCSR0A & 0x40))
                ;
        UCSR0A |= 0x40;
        
}                         
#pragma used-

#pragma used+
/**********************
Ω” ’µ•∏ˆ◊÷∑˚
***********************/    
unsigned char Rx0(void)
{              
        if(UCSR0A & 0x80)
           return UDR0;    
        else 
           return 0;
}                                   
#pragma used-
                                


// Get a character from the USART1 Receiver
#pragma used+
char getchar1(void)
{
char status,data;
while (1)
      {
      while (((status=UCSR1A) & RX_COMPLETE)==0);
      data=UDR1;
      if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
         return data;
      };
}
#pragma used-

// Write a character to the USART1 Transmitter
#pragma used+
void putchar1(char c)
{
while ((UCSR1A & DATA_REGISTER_EMPTY)==0);
UDR1=c;
}
#pragma used-         
                      


char rx_buffer0[RX_BUFFER_SIZE0];

#if RX_BUFFER_SIZE0<256
unsigned char rx_wr_index0,rx_rd_index0,rx_counter0;
#else
unsigned int rx_wr_index0,rx_rd_index0,rx_counter0;
#endif

// This flag is set on USART0 Receiver buffer overflow
bit rx_buffer_overflow0;

// USART0 Receiver interrupt service routine
interrupt [USART0_RXC] void usart0_rx_isr(void)
{
char status,data;
status=UCSR0A;
data=UDR0;
if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
   {
   rx_buffer0[rx_wr_index0]=data;
   if (++rx_wr_index0 == RX_BUFFER_SIZE0) rx_wr_index0=0;
   if (++rx_counter0 == RX_BUFFER_SIZE0)
      {
      rx_counter0=0;
      rx_buffer_overflow0=1;
      };
   };
}

#ifndef _DEBUG_TERMINAL_IO_
// Get a character from the USART0 Receiver buffer
#define _ALTERNATE_GETCHAR_
#pragma used+
char getchar(void)
{
  char data;
  while (rx_counter0==0);
  data=rx_buffer0[rx_rd_index0];
  if (++rx_rd_index0 == RX_BUFFER_SIZE0) 
    rx_rd_index0=0;
  #asm("cli")
  --rx_counter0;
  #asm("sei")
  return data;
}
#pragma used-
#endif         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
#include "include.h"

#define SCLH PORTD.0=1
#define SCLL PORTD.0=0
#define SDAH PORTD.1=1
#define SDAL PORTD.1=0

      
flash	unsigned	long	LVCO_FREQS[3][2] =
{
	{950000,970000},
	{970000,1065000},
	{1065000,1170000}
};
flash	unsigned	long	HVCO_FREQS[7][2] =
{
	{1170000,1300000},
	{1300000,1445000},
	{1445000,1607000},
	{1607000,1778000},
	{1778000,1942000},
	{1942000,2131000},
	{2131000,2150000}
};
                     


void TunerRst(void)
{
	PORTD.4=0;
	delay_ms(50);
	PORTD.4=1; 
}   



/***********************************  
I2Cø™ ºŒª  SDA SCL…ËŒ™ ‰≥ˆ  
SDA‘⁄SCLŒ™∏ﬂ ±¥”∏ﬂ±‰Œ™µÕ
***********************************/
void i2c_sta(void)
{
	DDRD |= 0x03;      //PD0 PD1(SCL SDA) as output
	SDAH;
	SCLH;
	delay_us(4);
	SDAL;
	delay_us(2);
}                         

/***********************************  
I2CΩ· ¯Œª  SDA SCL…ËŒ™ ‰≥ˆ  
SDA‘⁄SCLŒ™∏ﬂ ±±‰Œ™∏ﬂ
***********************************/
void i2c_stp(void)
{
	SCLH;
	delay_us(2);
	SDAL;
}


/*****************************
∂¡»°ACK  ‘⁄SCL±‰∏ﬂ∫Û2us∂¡»°SDA
¥”ª˙Ω´SDA¿≠µÕŒ™ACKœÏ”¶  
”–ACK∑µªÿ1  ŒﬁACK∑µªÿ0
******************************/
char SDA_in(void)
{

DDRD &=0xFD;       //SDA  input
PORTD |= 0x02;       //SDA pull-up
delay_us(6);
SCLH;
delay_us(2);
if(PIND.1==0)  
  {
//         temp_para++;
//         printf("xiang ying: temp_para = %d\n",temp_para);
  delay_us(2);
  SCLL;
	DDRD |=0x02;          //SDA output
	PORTD.1=1;            //SDA high
	return 1;
	}
else
	{
	 //temp_para++;
	 //Tx0('X');
	 DDRD |=0x02;
	 return 0;
	}
}


/**************************************
∑¢ÀÕ“ª∏ˆ◊÷Ω⁄µƒ ˝æ›£¨∑¢ÀÕÕÍ≥… ’µΩACK∑µªÿ1  ∑Ò‘Ú∑µªÿ0
***************************************/       
char i2c_send(unsigned char data)
{
	char i;
	
	for(i=0;i<8;i++)
	{
        	SCLL;
        	delay_us(4);
        	if(data & 0x80)
        		SDAH;
        	else
        		SDAL;
        	data=(data<<1);
        	
        	
        	delay_us(2);
        	SCLH;
        	delay_us(4);
	}	
	SCLL;

	if(SDA_in()==1)
		{
		delay_us(2);
		//Tx0('P');
		return 1;
		}
	else
		{
		delay_us(2);
		Tx0('!');
		return 0;
		}

} 
/****************************************
∂¡»°“ª∏ˆ◊÷Ω⁄µƒ ˝æ›≤¢∑µªÿ∏√◊÷Ω⁄
****************************************/
unsigned char i2c_byte_read(void)
{
        unsigned char i,data;
        data=0; 
        DDRD &=0xFD;       //SDA  input
        PORTD |= 0x02;       //SDA pull-up
        //SCLL;    
        //delay_us(3);   
        //data=(data |(PIND & 0x02)); 
        for(i=0;i<7;i++)
        {         
                SCLH;
                delay_us(2);  
                data=data<<1;
                data=(data |(PIND & 0x02));                  
                delay_us(2);
               
                SCLL;
                delay_us(4);        
        }         
        data=(data |((PIND & 0x02)?1:0));
        DDRD.1=1;
        SDAL;   
        SCLH;
        delay_us(4);       
        SCLL;
        delay_us(4);
        return data;

}                                                



/******************************************************    
÷˜ª˙∂¡»°I2C  ≤Œ ˝∑÷±Œ™ ¥”ª˙µÿ÷∑£¨∂¡ªÿµƒ◊÷Ω⁄¥Ê∑≈µƒ ˝◊È÷∏’Î£¨∂¡ªÿµƒ◊÷Ω⁄ ˝   
slave address,pointer to be written,number to be read   
¥”ª˙œÏ”¶¡Àµÿ÷∑∑µªÿ1 ∑Ò‘Ú∑µªÿ0
*******************************************************/            
char i2c_rd(unsigned char addr,unsigned char *ddata,unsigned char counter)     
{
 unsigned char i;
 unsigned char *pdata;
 i=counter;  
 pdata=ddata;
 i2c_sta();
 if(i2c_send(addr|0x01)==1)
   {    
         while(i)
        	{
        		*pdata=i2c_byte_read();
        		pdata++;
        		i--;
        	}    	
         i2c_stp(); 
         return 1;
    }
 else 
        return 0;   
    
}
/**********************************************  
∑¢ÀÕ“ª◊È◊÷Ω⁄µΩ¥”ª˙        
pointer to the first byte,number of bytes to be written    
∑¢ÀÕÕÍ≥…∑µªÿ1  ∑Ò‘Ú∑µªÿ0
**********************************************/
char i2c_tran(char *data,char num)
{
	char i; 
	i2c_sta(); 
	for(i=0;i<num;i++)
	{
        	if(i2c_send(*data))
        		data++;
        	else
        		return 0;
	}	
	i2c_stp();
	return 1;

}  

     

/******************************
open tuner interface
*******************************/ 
void EnableTunerOperation(void)
{
    unsigned char byte[3];                                 
     byte[0]=0xD0;
     byte[1]=0x01;
     byte[2]=0xC0; 
     i2c_tran(byte,3); 
     //printf("Enable Tuner Operation\n");
}

/*******************************
close tuner interface
*******************************/ 
void DisableTunerOperation(void)
{
    unsigned char byte[3];                                
    byte[0]=0xD0;
    byte[1]=0x01;
    byte[2]=0x40; 
    i2c_tran(byte,3);  
    //printf("Disable Tuner Operation\n");
}

/******************************************************
º∆À„∆µ¬  Ω´÷Æ◊™ªªŒ™tuner≥ı ºªØ–Ë“™µƒ◊÷Ω⁄ ˝æ›,≤¢–¥»Î–æ∆¨
*******************************************************/    
unsigned char TFC(unsigned long _TunerFrequency) //TunerFrequencyCalculate  KHZ
{

	unsigned long long_tmp, TunerFrequency  ;
	unsigned int i;
	unsigned char B[5] = {0x00},temp[5] = {0x00};
	unsigned int ddata,pd2,pd3,pd4,pd5 ;
        printf("TunerFreq %ld.\n",_TunerFrequency);

	B[0] = 0xc0;
	if ((_TunerFrequency>=900000)&&(_TunerFrequency<1170000)) 	//
	{
		B[4]=0x0e;
		for (i=0; i<3; i++)
		{
	        if (_TunerFrequency < LVCO_FREQS[i][1]) break;
		}
		i=i+0x05;
		i=i<<5;
    		B[4]= B[4]+i;
	}
	else													//
	{
		B[4]=0x0c;
		for (i=0; i<7; i++)
		{
	        if (_TunerFrequency < HVCO_FREQS[i][1]) break;
		}
		i=i+0x01;
		i=i<<5;
		B[4]= B[4]+i;
	}
	TunerFrequency = _TunerFrequency/500;
	long_tmp = TunerFrequency/32;
	i = TunerFrequency%32;
 	B[1] = (int)((long_tmp>>3)&0x000000ff);
	B[2] = (int)((long_tmp<<5)&0x000000ff);
	B[2] = (int)(B[2] + i);
	i=0;  
	//printf("TFC byte1~5:0x%x,0x%x,0x%x,0x%x,0x%x\n",B[0],B[1],B[2],B[3],B[4]);         
    do
      {   
//             temp_para = 0;
// 	    printf("the cation of i2c acknowlede in function TFC\n");
	    temp[0] = B[0];
	    temp[1] = B[1];
	    temp[2] = B[2];
	    temp[4] = B[4];
	    
            temp[3] = 0xe1;
            temp[4] = B[4] & 0xf3;
//             printf("B1. byte1~5  0x%x,0x%x,0x%x,0x%x,0x%x\n",B[0],B[1],B[2],B[3],B[4]);
             //printf("temp1. byte1~5  0x%x,0x%x,0x%x,0x%x,0x%x\n",temp[0],temp[1],temp[2],temp[3],temp[4]);

            EnableTunerOperation();
            i2c_tran(temp,5);                   //write byte1 byte2 byte3 byte4 byte5
            //DisableTunerOperation(); 
            
            temp[1] = temp[3] | 0x04;
             //printf("temp2. byte1,4  0x%x,0x%x\n",temp[0],temp[1]); 
            //EnableTunerOperation();
            i2c_tran(temp,2);           //write byte1 byte4
            //DisableTunerOperation();
            delay_ms(10);           
            
            B[3] = 0xfd;
            ddata =  (30000/1000)/2 - 2;
            pd2 = (ddata>>1)&0x04	;
            pd3 = (ddata<<1)&0x08	;
            pd4 = (ddata<<2)&0x08	;
            pd5 = (ddata<<4)&0x10	;
            B[3] &= 0xE7	;
            B[4] &= 0xF3	;
            B[3] |= (pd5|pd4)	;
            B[4] |= (pd3|pd2)	; 
            
//             printf("B2. byte1~5  0x%x,0x%x,0x%x,0x%x,0x%x\n",B[0],B[1],B[2],B[3],B[4]);
            
            temp[1] = B[3] | 0x04;
            temp[2] = B[4];
            // printf("temp3. byte1,4,5  0x%x,0x%x,0x%x\n",temp[0],temp[1],temp[2]);
            //EnableTunerOperation();
            i2c_tran(temp,3);                   //write byte1 byte4 byte5
            DisableTunerOperation();
            
            delay_ms(1);
            i++;
            if(pll_lk())
            {                                         
                printf("TunerFrequency Calculate & set Success!\n");
                return 1;
            }
        }while(i < 4);  
        printf("TunerFrequency Calculate & set Failed!\n");
        return 0; 
}


/******************************    
STV0288–æ∆¨≥ı ºªØ
***************************/
void STV0288Init(void)
{
 unsigned char byte[10];  //i = 0;
 unsigned char *pointer;  

        // temp_para = 0;
        // printf("the cation of i2c acknowlede in function STV0288Init\n");      
        
        byte[0]=0xD0;
        pointer= &byte[0];
                           
        /********************************
        set clock     
        PLL_DIV=100
        clock inputfrom CLKI,Fmclk=4M*PLL_DIV/4=100M                    
        ********************************/
        byte[1]= 0x40;    
        byte[2]= 0x64;             //PLLCTRL
        byte[3]= 0x04;             //SYNTCTRL
        i2c_tran(pointer,4); 
                                           
        
                  
        byte[1]=0x02;                 //ACR
        byte[2]=0x20; 
        i2c_tran(pointer,3); 
        
        
        
        
        /*********************
        set register about AGC
        **********************/
        byte[1]=0x0F;
        byte[2]=0x54;               //AGC1REF
        i2c_tran(pointer,3);  
        //printf("AGC1REF*");
        /*******************************
        set register about timing loop
        ********************************/ 
        
        byte[1]=0x11;
        byte[2]=0x7a;                 //RTC
        i2c_tran(pointer,3); 
        //printf("RTC*");
        byte[1]=0x22;
        byte[2]=0x00;               //RTFM
        byte[3]=0x00;               //RTFL               
        i2c_tran(pointer,4); 
        //printf("RTF*");                     
        
        /**********************************************
        set register about DAC (∏√ºƒ¥Ê∆˜…Ë÷√≤ª”∞œÏÀ¯∂®)
        **********************************************/         
        
        byte[1]=0x1b;
        byte[2]=0x8f;                    //DACR1 
        byte[3]=0xf0;               //DACR2              
        i2c_tran(pointer,4);       
        //printf("DACR*");
        /*******************************
        set register about carrier loop
        ********************************/ 
        byte[1]=0x15;
        byte[2]=0xf7;                   //CFD
        byte[3]=0x88;                 //ACLC
        byte[4]=0x58;                 //BCLC
        i2c_tran(pointer,5); 
        
        
        byte[1]=0x19;
        byte[2]=0xa6;                   //LDT
        byte[3]=0x88;                 //LDT2
        i2c_tran(pointer,4); 
        
        byte[1]=0x2B;
        byte[2]=0xFF;                   //CFRM
        byte[3]=0xF7;                 //CFRL
        i2c_tran(pointer,4); 
                      
        
        /*******************************
        set register about FEC and SYNC
        ********************************/                                 
        byte[1]=0x37;
        byte[2]=0x2f;                   //PR
        byte[3]=0x16;                 //VSEARCH
        byte[4]=0xbd;                 //RS
        i2c_tran(pointer,5); 
        
        // byte[1]=0x3B;
        // byte[2]=0x13;                   //ERRCTRL
        // byte[3]=0x12;                 //VITPROG
        // byte[4]=0x30;                 //ERRCTRL2
        // i2c_tran(pointer,5);    
        
        byte[1]=0x3c;               
        byte[2]=0x12;                 //VITPROG
        i2c_tran(pointer,3);    
        
        byte[1]=0x02;         //ACR
        byte[2]=0x20; 
        i2c_tran(pointer,3);                               
        
        /********************************
        set clock     
        PLL_DIV=100
        clock inputfrom CLKI,Fmclk=4M*PLL_DIV/4=100M                    
        ********************************/    
        byte[1]= 0x40;    
        byte[2]= 0x63;             //PLLCTRL
        byte[3]= 0x04;             //SYNTCTRL
        byte[4]= 0x20;             //TSTTNR1
        i2c_tran(pointer,5);   
                
        
        byte[1]=0xB2;
        byte[2]=0x10;                   //AGCCFG
        byte[3]=0x82;                 //DIRCLKCFG
        byte[4]=0x80;                 //AUXCKCFG  
        byte[5]=0x82;                 //STDBYCFG
        byte[6]=0x82;                 //CS0CFG
        byte[7]=0x82;                 //CS1CFG  
        i2c_tran(pointer,8); 
        //printf("STV0288 Init Done\n");
} 


/**********************************          
…Ë∂®∑˚∫≈¬ 
**********************************/
void SetSymbolRate(float sym_rate)
{
        char byte[8];
        char *pointer; 
        long int ksy_rate;     
        pointer = &byte[0]; 
       // temp_para = 0;
//         printf("the cation of i2c acknowlede in function SetSymbolRate\n");       
        
        byte[0]=0xD0;       
        
        /********************************
        set clock     
        PLL_DIV=100
        clock inputfrom CLKI,Fmclk=4M*PLL_DIV/4=100M                    
        ********************************/
        byte[1]= 0x40;    
        byte[2]= 0x63;             //PLLCTRL
        byte[3]= 0x04;             //SYNTCTRL
        i2c_tran(pointer,4); 
                                           
        
                  
        byte[1]=0x02;                 //ACR
        byte[2]=0x20; 
        i2c_tran(pointer,3);         
        
        /*****************************
        set symbol rate   
        //SFRH,SFRM,SFRL = 27.5/100*2e20 =0x46666   27.49996
        *****************************/               
        ksy_rate =(sym_rate*1048576/100000);        
        byte[1]=0x28;    

        byte[2]=(ksy_rate >> 12)& 0xFF;
        byte[3]=(ksy_rate >> 4)& 0xFF;
        byte[4]=(ksy_rate << 4)& 0xFF;
        
        printf("symbol %f, 0x%x 0x%x 0x%x\n",sym_rate,byte[2],byte[3],byte[4] );
        byte[5]=0;     //CFRM  ‘ÿ≤®∆µ¬ 
        byte[6]=0;     //CFRL
        i2c_tran(pointer,7); 
        printf("SetSymbolRate Done\n");
}  



/***************************************************************
7395≥ı ºªØ
master clock…Ë÷√Œ™100M                           
≤‚ ‘ π”√Asia6  12395MHz frequency  27500K symbol rate
12395-10750=1645=fvco=32*51+13
11880-10750=1030
****************************************************************/
unsigned char tuner(unsigned long F,float S)
{

        char i;                   
        TunerRst();
        delay_ms(50);        
        
        
        TFC(F);                                           
        STV0288Init();            
        SetSymbolRate(S);              
        
        i = 0;
        while(i<4)
        {
            i++;
            delay_us(900);
            if(locked())
            {
               printf("locked\n");
               return 1;
            }
        }  
        printf("not locked\n");
        return 0;                                 
        
}
                      
/*
read lock register  
and save to pointer p 
*/            
void getstus(char *p)
  {
        char data[3];
        char *pdata;        
        char i,j;
        i = 1;
        j = 0;
        do
          {        
                 pdata = &data[0];        
                 data[0]= 0xD0;
                 data[1]= 0x24;                             
                 if (i2c_tran(pdata,2))
                   {             
                      if(i2c_rd(data[0],pdata,2))   
                      { 
                               p[j] = data[0];  
                               //printf("R 24-0x%x    ",data[0]);
                               j = 1;
                          
                                i=0;
                               
                      }
                   }                       
            }  
       while(i) ;
         
       i=1; 
       do
          {         
                 pdata = &data[0];        
                 data[0]= 0xD0;
                 data[1]= 0x1E;                     
                 if (i2c_tran(pdata,2))
                   {  
                         if(i2c_rd(data[0],pdata,2))   
                         {       
                              p[j] = data[0];
                              //printf("R 1E-0x%x\n",data[0]);                                          
                              i=0; 
                                
                         }
                   }                  
          } 
       while(i) ; 
  
  } 
   

char locked(void)   
{ 
    char t[2];
    getstus(t); 


    if(((t[0] & 0x80) == 0x80) && ((t[1] & 0x80) == 0x80))
    { 
        LED2_ON;
        return 1;             
    }
    else   
    {
       STV0288Init();          
       LED2_OFF;
       return 0;         
    }

 }
 
unsigned char Get0288Register(unsigned char addr)
{
    char data[3];
    char *pdata; 
    pdata = &data[0]; 
    data[0]= 0xD0;
    data[1]= addr;
    if (i2c_tran(pdata,2))
      {   
       if(i2c_rd(data[0],pdata,1))   
          {   
           return data[0];
          }
      }       
}
  
unsigned int GetAGC()
{               
    unsigned int AGC2;   
    char data[2];
    char *pdata; 
    pdata = &data[0]; 
    data[0]= 0xD0;
    data[1]= 0x20;
    if (i2c_tran(pdata,2))
      {   
       if(i2c_rd(data[0],pdata,2))   
          {   
           AGC2 = data[0]*256 + data[1];
           return AGC2;
          }
      }       
}

  
unsigned char Set0288Register(unsigned char addr,unsigned char dat,)
{
    char data[3];
    char *pdata; 
    pdata = &data[0]; 
    data[0]= 0xD0;
    data[1]= addr; 
    data[2]= dat;       
    i2c_tran(pdata,3);
    
    
    if (i2c_tran(pdata,2))
      {   
       if(i2c_rd(data[0],pdata,1))   
          {   
           return data[0];
          }
      }       
}
  
  
  
unsigned char pll_lk(void)
  {
      unsigned char byte[1] = {0xc0},i = 0; 
      
      EnableTunerOperation();
      do 
      {
          i2c_rd(byte[0],byte,1);
          i++;
          if((byte[0] & 0x40) != 0)
          {
              //printf("pll locked:0x%x\n",byte[0]);
              DisableTunerOperation();
              return 1;
          }
          else
          {   
             printf("pll no locked:0x%x\n",byte[0]);
          }
      }while(i < 3);
      DisableTunerOperation();
      return 0;
}                            

char Track()
{          
   unsigned int AGC,omgaX,omgaY;   
   
   while(!Rx0())  
      {
         while(!(TIFR & 0x01))       //wait TC0    125Hz
                ;
         TIFR = TIFR | 0x01;         //clear TOV0
         TCNT0=0x82;                 //init timer from 130
         
         AGC = GetAGC();          //read agc number
         omgaX = ANLG_A;          //read X grro
         omgaY = ANLG_B;          //read Y gyro
         printf("%u %u %u %d\n",omgaX,omgaY,AGC,locked());
         //printf("%u %u \n",x,y);
      }       
  return  ;
}


        
