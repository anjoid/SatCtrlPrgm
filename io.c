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
发送单个字符
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
接收单个字符
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
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         