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
I2C开始位  SDA SCL设为输出  
SDA在SCL为高时从高变为低
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
I2C结束位  SDA SCL设为输出  
SDA在SCL为高时变为高
***********************************/
void i2c_stp(void)
{
	SCLH;
	delay_us(2);
	SDAL;
}


/*****************************
读取ACK  在SCL变高后2us读取SDA
从机将SDA拉低为ACK响应  
有ACK返回1  无ACK返回0
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
发送一个字节的数据，发送完成收到ACK返回1  否则返回0
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
读取一个字节的数据并返回该字节
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
主机读取I2C  参数分别为 从机地址，读回的字节存放的数组指针，读回的字节数   
slave address,pointer to be written,number to be read   
从机响应了地址返回1 否则返回0
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
发送一组字节到从机        
pointer to the first byte,number of bytes to be written    
发送完成返回1  否则返回0
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
计算频率 将之转换为tuner初始化需要的字节数据,并写入芯片
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
STV0288芯片初始化
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
        set register about DAC (该寄存器设置不影响锁定)
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
设定符号率
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
        byte[5]=0;     //CFRM  载波频率
        byte[6]=0;     //CFRL
        i2c_tran(pointer,7); 
        printf("SetSymbolRate Done\n");
}  



/***************************************************************
7395初始化
master clock设置为100M                           
测试使用Asia6  12395MHz frequency  27500K symbol rate
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


        
