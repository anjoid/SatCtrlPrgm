;CodeVisionAVR C Compiler V1.24.4 Standard
;(C) Copyright 1998-2004 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com
;e-mail:office@hpinfotech.com

;Chip type           : ATmega128
;Program type        : Application
;Clock frequency     : 16.000000 MHz
;Memory model        : Small
;Optimize for        : Speed
;(s)printf features  : long, width, precision
;(s)scanf features   : int, width
;External SRAM size  : 0
;Data Stack size     : 1024 byte(s)
;Heap size           : 0 byte(s)
;Promote char to int : No
;char is unsigned    : Yes
;8 bit enums         : Yes
;Enhanced core instructions    : On
;Automatic register allocation : On

	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU RAMPZ=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F
	.EQU XMCRA=0x6D
	.EQU XMCRB=0x6C

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __se_bit=0x20
	.EQU __sm_mask=0x1C
	.EQU __sm_adc_noise_red=0x08
	.EQU __sm_powerdown=0x10
	.EQU __sm_powersave=0x18
	.EQU __sm_standby=0x14
	.EQU __sm_ext_standby=0x1C

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __CLRD1S
	LDI  R30,0
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+@1)
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+@1)
	LDI  R31,HIGH(@0+@1)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+@1)
	LDI  R31,HIGH(2*@0+@1)
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+@1)
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+@1)
	LDI  R27,HIGH(@0+@1)
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+@2)
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+@3)
	LDI  R@1,HIGH(@2+@3)
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+@1
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	LDS  R22,@0+@1+2
	LDS  R23,@0+@1+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@2,@0+@1
	.ENDM

	.MACRO __GETWRMN
	LDS  R@2,@0+@1
	LDS  R@3,@0+@1+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+@1
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+@1
	LDS  R27,@0+@1+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+@1
	LDS  R27,@0+@1+1
	LDS  R24,@0+@1+2
	LDS  R25,@0+@1+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+@1,R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+@1,R30
	STS  @0+@1+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+@1,R30
	STS  @0+@1+1,R31
	STS  @0+@1+2,R22
	STS  @0+@1+3,R23
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+@1,R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+@1,R@2
	STS  @0+@1+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	ICALL
	.ENDM


	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+@1)
	LDI  R31,HIGH(2*@0+@1)
	CALL __GETW1PF
	ICALL
	.ENDM


	.MACRO __CALL2EN
	LDI  R26,LOW(@0+@1)
	LDI  R27,HIGH(@0+@1)
	CALL __EEPROMRDW
	ICALL
	.ENDM


	.MACRO __GETW1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CLR  R0
	ST   Z+,R0
	ST   Z,R0
	.ENDM

	.MACRO __CLRD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CLR  R0
	ST   Z+,R0
	ST   Z+,R0
	ST   Z+,R0
	ST   Z,R0
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R@1
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOV  R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOV  R30,R0
	.ENDM

	.CSEG
	.ORG 0

	.INCLUDE "SatCtrl.vec"
	.INCLUDE "SatCtrl.inc"

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  MCUCR,R31
	OUT  MCUCR,R30
	STS  XMCRB,R30
	OUT  RAMPZ,R30

;DISABLE WATCHDOG
	LDI  R31,0x18
	OUT  WDTCR,R31
	OUT  WDTCR,R30

;CLEAR R2-R14
	LDI  R24,13
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(0x1000)
	LDI  R25,HIGH(0x1000)
	LDI  R26,LOW(0x100)
	LDI  R27,HIGH(0x100)
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;STACK POINTER INITIALIZATION
	LDI  R30,LOW(0x10FF)
	OUT  SPL,R30
	LDI  R30,HIGH(0x10FF)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(0x500)
	LDI  R29,HIGH(0x500)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x500
;       1 /*****************************************************
;       2 This program was produced by the
;       3 CodeWizardAVR V1.24.4 Standard
;       4 Automatic Program Generator
;       5 © Copyright 1998-2004 Pavel Haiduc, HP InfoTech s.r.l.
;       6 http://www.hpinfotech.com
;       7 e-mail:office@hpinfotech.com
;       8 
;       9 Project : SatCtrl
;      10 Version : V0.00
;      11 Date    : 2012-9-7
;      12 Author  : zhangjing                       
;      13 Company : zhangjing                       
;      14 Comments:                       
;      15 Used for PCB SatController1.00 
;      16 V0.00 created by AnJoid 20120907  
;      17 V0.01 Able to do basic in port operation,by AnJoid  2013-1-23
;      18 
;      19 Chip type           : ATmega128
;      20 Program type        : Application
;      21 Clock frequency     : 16.000000 MHz
;      22 Memory model        : Small
;      23 External SRAM size  : 0
;      24 Data Stack size     : 1024
;      25 *****************************************************/
;      26 
;      27 #include "include.h"
;      28 
;      29 unsigned int temp_para = 0; 
;      30  
;      31 
;      32 void init(void)
;      33 {  

	.CSEG
_init:
;      34  
;      35 // Input/Output Ports initialization
;      36 // Port A initialization
;      37 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
;      38 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
;      39 PORTA=0x00;
	LDI  R30,LOW(0)
	OUT  0x1B,R30
;      40 DDRA=0x00;
	OUT  0x1A,R30
;      41 
;      42 // Port B initialization
;      43 // Func7=In Func6=In Func5=Out Func4=Out Func3=In Func2=Out Func1=Out Func0=Out 
;      44 // State7=T State6=T State5=0 State4=0 State3=T State2=0 State1=0 State0=1 
;      45 PORTB=0x01;
	LDI  R30,LOW(1)
	OUT  0x18,R30
;      46 DDRB=0x37;
	LDI  R30,LOW(55)
	OUT  0x17,R30
;      47 
;      48 // Port C initialization
;      49 // Func7=In Func6=Out Func5=Out Func4=In Func3=Out Func2=Out Func1=In Func0=In 
;      50 // State7=T State6=0 State5=0 State4=T State3=0 State2=0 State1=T State0=T 
;      51 PORTC=0x00;
	LDI  R30,LOW(0)
	OUT  0x15,R30
;      52 DDRC=0x6C;
	LDI  R30,LOW(108)
	OUT  0x14,R30
;      53 
;      54 // Port D initialization
;      55 // Func7=Out Func6=Out Func5=Out Func4=Out Func3=Out Func2=In Func1=Out Func0=Out 
;      56 // State7=0 State6=0 State5=0 State4=1 State3=0 State2=T State1=0 State0=0 
;      57 PORTD=0x10;
	LDI  R30,LOW(16)
	OUT  0x12,R30
;      58 DDRD=0xFB;
	LDI  R30,LOW(251)
	OUT  0x11,R30
;      59 
;      60 // Port E initialization
;      61 // Func7=In Func6=In Func5=In Func4=In Func3=Out Func2=Out Func1=Out Func0=In 
;      62 // State7=T State6=T State5=T State4=T State3=0 State2=0 State1=0 State0=T 
;      63 PORTE=0x00;
	LDI  R30,LOW(0)
	OUT  0x3,R30
;      64 DDRE=0x0E;
	LDI  R30,LOW(14)
	OUT  0x2,R30
;      65 
;      66 // Port F initialization
;      67 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
;      68 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
;      69 PORTF=0x00;
	LDI  R30,LOW(0)
	STS  0x62,R30
;      70 DDRF=0x00;
	STS  0x61,R30
;      71 
;      72 // Port G initialization
;      73 // Func4=Out Func3=Out Func2=In Func1=In Func0=In 
;      74 // State4=0 State3=0 State2=T State1=T State0=T 
;      75 PORTG=0x00;
	STS  0x65,R30
;      76 DDRG=0x18;
	LDI  R30,LOW(24)
	STS  0x64,R30
;      77 
;      78 // Timer/Counter 0 initialization
;      79 // Clock source: System Clock
;      80 // Clock value: 15.625 kHz
;      81 // Mode: Normal top=FFh
;      82 // OC0 output: Disconnected
;      83 ASSR=0x00;
	LDI  R30,LOW(0)
	OUT  0x30,R30
;      84 TCCR0=0x07;
	LDI  R30,LOW(7)
	OUT  0x33,R30
;      85 TCNT0=0x82;
	LDI  R30,LOW(130)
	OUT  0x32,R30
;      86 OCR0=0x00;
	LDI  R30,LOW(0)
	OUT  0x31,R30
;      87 
;      88 // Timer/Counter 1 initialization
;      89 // Clock source: System Clock
;      90 // Clock value: Timer 1 Stopped
;      91 // Mode: Normal top=FFFFh
;      92 // OC1A output: Discon.
;      93 // OC1B output: Discon.
;      94 // OC1C output: Discon.
;      95 // Noise Canceler: Off
;      96 // Input Capture on Falling Edge
;      97 TCCR1A=0x00;
	OUT  0x2F,R30
;      98 TCCR1B=0x00;
	OUT  0x2E,R30
;      99 TCNT1H=0x00;
	OUT  0x2D,R30
;     100 TCNT1L=0x00;
	OUT  0x2C,R30
;     101 ICR1H=0x00;
	OUT  0x27,R30
;     102 ICR1L=0x00;
	OUT  0x26,R30
;     103 OCR1AH=0x00;
	OUT  0x2B,R30
;     104 OCR1AL=0x00;
	OUT  0x2A,R30
;     105 OCR1BH=0x00;
	OUT  0x29,R30
;     106 OCR1BL=0x00;
	OUT  0x28,R30
;     107 OCR1CH=0x00;
	STS  0x79,R30
;     108 OCR1CL=0x00;
	STS  0x78,R30
;     109 
;     110 // Timer/Counter 2 initialization
;     111 // Clock source: System Clock
;     112 // Clock value: Timer 2 Stopped
;     113 // Mode: Normal top=FFh
;     114 // OC2 output: Disconnected
;     115 TCCR2=0x00;
	OUT  0x25,R30
;     116 TCNT2=0x00;
	OUT  0x24,R30
;     117 OCR2=0x00;
	OUT  0x23,R30
;     118 
;     119 // Timer/Counter 3 initialization
;     120 // Clock source: System Clock
;     121 // Clock value: Timer 3 Stopped
;     122 // Mode: Normal top=FFFFh
;     123 // Noise Canceler: Off
;     124 // Input Capture on Falling Edge
;     125 // OC3A output: Discon.
;     126 // OC3B output: Discon.
;     127 // OC3C output: Discon.
;     128 TCCR3A=0x00;
	STS  0x8B,R30
;     129 TCCR3B=0x00;
	STS  0x8A,R30
;     130 TCNT3H=0x00;
	STS  0x89,R30
;     131 TCNT3L=0x00;
	STS  0x88,R30
;     132 ICR3H=0x00;
	STS  0x81,R30
;     133 ICR3L=0x00;
	STS  0x80,R30
;     134 OCR3AH=0x00;
	STS  0x87,R30
;     135 OCR3AL=0x00;
	STS  0x86,R30
;     136 OCR3BH=0x00;
	STS  0x85,R30
;     137 OCR3BL=0x00;
	STS  0x84,R30
;     138 OCR3CH=0x00;
	STS  0x83,R30
;     139 OCR3CL=0x00;
	STS  0x82,R30
;     140 
;     141 // External Interrupt(s) initialization
;     142 // INT0: Off
;     143 // INT1: Off
;     144 // INT2: Off
;     145 // INT3: Off
;     146 // INT4: Off
;     147 // INT5: Off
;     148 // INT6: Off
;     149 // INT7: Off
;     150 EICRA=0x00;
	STS  0x6A,R30
;     151 EICRB=0x00;
	OUT  0x3A,R30
;     152 EIMSK=0x00;
	OUT  0x39,R30
;     153 
;     154 // Timer(s)/Counter(s) Interrupt(s) initialization
;     155 TIMSK=0x00;
	OUT  0x37,R30
;     156 ETIMSK=0x00;
	STS  0x7D,R30
;     157 
;     158 // USART0 initialization
;     159 // Communication Parameters: 8 Data, 1 Stop, No Parity
;     160 // USART0 Receiver: On
;     161 // USART0 Transmitter: On
;     162 // USART0 Mode: Asynchronous
;     163 // USART0 Baud rate: 56000
;     164 UCSR0A=0x00;
	OUT  0xB,R30
;     165 UCSR0B=0x18;
	LDI  R30,LOW(24)
	OUT  0xA,R30
;     166 UCSR0C=0x06;
	LDI  R30,LOW(6)
	STS  0x95,R30
;     167 UBRR0H=0x00;
	LDI  R30,LOW(0)
	STS  0x90,R30
;     168 UBRR0L=0x11;
	LDI  R30,LOW(17)
	OUT  0x9,R30
;     169 
;     170 // USART1 initialization
;     171 // Communication Parameters: 8 Data, 1 Stop, No Parity
;     172 // USART1 Receiver: On
;     173 // USART1 Transmitter: On
;     174 // USART1 Mode: Asynchronous
;     175 // USART1 Baud rate: 9600
;     176 UCSR1A=0x00;
	LDI  R30,LOW(0)
	STS  0x9B,R30
;     177 UCSR1B=0x18;
	LDI  R30,LOW(24)
	STS  0x9A,R30
;     178 UCSR1C=0x06;
	LDI  R30,LOW(6)
	STS  0x9D,R30
;     179 UBRR1H=0x00;
	LDI  R30,LOW(0)
	STS  0x98,R30
;     180 UBRR1L=0x67;
	LDI  R30,LOW(103)
	STS  0x99,R30
;     181 
;     182 // Analog Comparator initialization
;     183 // Analog Comparator: Off
;     184 // Analog Comparator Input Capture by Timer/Counter 1: Off
;     185 ACSR=0x80;
	LDI  R30,LOW(128)
	OUT  0x8,R30
;     186 SFIOR=0x00;
	LDI  R30,LOW(0)
	OUT  0x20,R30
;     187 
;     188 // ADC initialization
;     189 // ADC Clock frequency: 125.000 kHz
;     190 // ADC Voltage Reference: AVCC pin
;     191 // Only the 8 most significant bits of
;     192 // the AD conversion result are used
;     193 ADMUX=ADC_VREF_TYPE;
	OUT  0x7,R30
;     194 ADCSRA=0x87;
	LDI  R30,LOW(135)
	OUT  0x6,R30
;     195 
;     196  delay_ms(1000);
	LDI  R30,LOW(1000)
	LDI  R31,HIGH(1000)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;     197               
;     198  TUNER_18V;
	SBI  0x12,5
;     199  printf("\n...............\n"); 
	__POINTW1FN _0,0
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _printf
	ADIW R28,2
;     200  printf("\n......×Ô¼ì.....\n");    
	__POINTW1FN _0,18
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _printf
	ADIW R28,2
;     201  printf("13/18VµçÑ¹ %f\n",((float)LNB_VTG/9.21));   
	__POINTW1FN _0,36
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	RCALL _read_adc
	CLR  R22
	CLR  R23
	CALL __CDF1
	MOVW R26,R30
	MOVW R24,R22
	__GETD1N 0x41135C29
	CALL __DIVF21
	CALL __PUTPARD1
	LDI  R24,4
	CALL _printf
	ADIW R28,6
;     202  printf("AGCµçÑ¹ %f\n",((float)AGC_ORG/51));   
	__POINTW1FN _0,51
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(2)
	ST   -Y,R30
	RCALL _read_adc
	CLR  R22
	CLR  R23
	CALL __CDF1
	MOVW R26,R30
	MOVW R24,R22
	__GETD1N 0x424C0000
	CALL __DIVF21
	CALL __PUTPARD1
	LDI  R24,4
	CALL _printf
	ADIW R28,6
;     203  printf("AGCµ÷ÀíµçÑ¹ %f\n",((float)AGC_AMP/51));          
	__POINTW1FN _0,63
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	RCALL _read_adc
	CLR  R22
	CLR  R23
	CALL __CDF1
	MOVW R26,R30
	MOVW R24,R22
	__GETD1N 0x424C0000
	CALL __DIVF21
	CALL __PUTPARD1
	LDI  R24,4
	CALL _printf
	ADIW R28,6
;     204  printf("1.8VµçÑ¹ %f\n",((float)VTG1V8/51));
	__POINTW1FN _0,79
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(3)
	ST   -Y,R30
	RCALL _read_adc
	CLR  R22
	CLR  R23
	CALL __CDF1
	MOVW R26,R30
	MOVW R24,R22
	__GETD1N 0x424C0000
	CALL __DIVF21
	CALL __PUTPARD1
	LDI  R24,4
	CALL _printf
	ADIW R28,6
;     205  printf("3.3VµçÑ¹ %f\n",((float)VTG3V3/51)); 
	__POINTW1FN _0,92
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(4)
	ST   -Y,R30
	RCALL _read_adc
	CLR  R22
	CLR  R23
	CALL __CDF1
	MOVW R26,R30
	MOVW R24,R22
	__GETD1N 0x424C0000
	CALL __DIVF21
	CALL __PUTPARD1
	LDI  R24,4
	CALL _printf
	ADIW R28,6
;     206  printf("AD5µçÑ¹ %f\n",((float)ANLG_A/51)); 
	__POINTW1FN _0,105
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(5)
	ST   -Y,R30
	RCALL _read_adc
	CLR  R22
	CLR  R23
	CALL __CDF1
	MOVW R26,R30
	MOVW R24,R22
	__GETD1N 0x424C0000
	CALL __DIVF21
	CALL __PUTPARD1
	LDI  R24,4
	CALL _printf
	ADIW R28,6
;     207  printf("AD6µçÑ¹ %f\n",((float)ANLG_B/51)); 
	__POINTW1FN _0,117
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(6)
	ST   -Y,R30
	RCALL _read_adc
	CLR  R22
	CLR  R23
	CALL __CDF1
	MOVW R26,R30
	MOVW R24,R22
	__GETD1N 0x424C0000
	CALL __DIVF21
	CALL __PUTPARD1
	LDI  R24,4
	CALL _printf
	ADIW R28,6
;     208  printf("AD7µçÑ¹ %f\n",((float)ANLG_C/51)); 
	__POINTW1FN _0,129
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(7)
	ST   -Y,R30
	RCALL _read_adc
	CLR  R22
	CLR  R23
	CALL __CDF1
	MOVW R26,R30
	MOVW R24,R22
	__GETD1N 0x424C0000
	CALL __DIVF21
	CALL __PUTPARD1
	LDI  R24,4
	CALL _printf
	ADIW R28,6
;     209  printf("........DONE...........\n");  
	__POINTW1FN _0,141
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _printf
	RJMP _0x105
;     210 }
;     211 
;     212 
;     213  void gyro(void)
;     214  {
_gyro:
;     215     long int dir_x,dir_y;
;     216     unsigned int x,y,xx,yy;  
;     217     dir_x=dir_y=1000000;
	SBIW R28,10
	CALL __SAVELOCR6
;	dir_x -> Y+12
;	dir_y -> Y+8
;	x -> R16,R17
;	y -> R18,R19
;	xx -> R20,R21
;	yy -> Y+6
	__GETD1N 0xF4240
	__PUTD1S 8
	__PUTD1S 12
;     218     while(!Rx0())  
_0x3:
	RCALL _Rx0
	CPI  R30,0
	BREQ PC+3
	JMP _0x5
;     219       {
;     220          while(!(TIFR & 0x01))       //wait TC0    125Hz
_0x6:
	IN   R30,0x36
	ANDI R30,LOW(0x1)
	BREQ _0x6
;     221                 ;
;     222          TIFR = TIFR | 0x01;         //clear TOV0
	IN   R30,0x36
	ORI  R30,1
	OUT  0x36,R30
;     223          TCNT0=0x82;                 //init timer from 130
	LDI  R30,LOW(130)
	OUT  0x32,R30
;     224          x = ANLG_A;
	LDI  R30,LOW(5)
	ST   -Y,R30
	RCALL _read_adc
	__PUTW1R 16,17
;     225          y = ANLG_B;
	LDI  R30,LOW(6)
	ST   -Y,R30
	RCALL _read_adc
	__PUTW1R 18,19
;     226          dir_x = dir_x+x-508;
	__GETW1R 16,17
	__GETD2S 12
	CLR  R22
	CLR  R23
	CALL __ADDD21
	__GETD1N 0x1FC
	CALL __SWAPD12
	CALL __SUBD12
	__PUTD1S 12
;     227          dir_y = dir_y+y-510;  
	__GETW1R 18,19
	__GETD2S 8
	CLR  R22
	CLR  R23
	CALL __ADDD21
	__GETD1N 0x1FE
	CALL __SWAPD12
	CALL __SUBD12
	__PUTD1S 8
;     228          xx = (dir_x-775000)/625;
	__GETD1S 12
	__SUBD1N 775000
	MOVW R26,R30
	MOVW R24,R22
	__GETD1N 0x271
	CALL __DIVD21
	__PUTW1R 20,21
;     229          yy = (dir_y-775000)/625;  
	__GETD1S 8
	__SUBD1N 775000
	MOVW R26,R30
	MOVW R24,R22
	__GETD1N 0x271
	CALL __DIVD21
	STD  Y+6,R30
	STD  Y+6+1,R31
;     230          printf("%u %u %u %u\n",x,y,xx,yy);
	__POINTW1FN _0,166
	ST   -Y,R31
	ST   -Y,R30
	__GETW1R 16,17
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	__GETW1R 18,19
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	__GETW1R 20,21
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	LDD  R30,Y+20
	LDD  R31,Y+20+1
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	LDI  R24,16
	CALL _printf
	ADIW R28,18
;     231          //printf("%u %u \n",x,y);
;     232       }
	RJMP _0x3
_0x5:
;     233       
;     234   }
	CALL __LOADLOCR6
	ADIW R28,16
	RET
;     235 
;     236 
;     237 
;     238 // Declare your global variables here
;     239 
;     240 void main(void)
;     241 {
_main:
;     242 // Declare your local variables here               
;     243 long int LNB_frequence; 
;     244 long int sate_frequence;//
;     245 unsigned long TunerFreq;
;     246 float symbol_rate;            
;     247 unsigned char addrbyte,databyte;     
;     248 LNB_frequence =10750;//11300;      
	SBIW R28,16
;	LNB_frequence -> Y+12
;	sate_frequence -> Y+8
;	TunerFreq -> Y+4
;	symbol_rate -> Y+0
;	addrbyte -> R16
;	databyte -> R17
	__GETD1N 0x29FE
	__PUTD1S 12
;     249 sate_frequence =11880; //92.2
	__GETD1N 0x2E68
	__PUTD1S 8
;     250 symbol_rate  = 28800;   //
	__GETD1N 0x46E10000
	__PUTD1S 0
;     251 TunerFreq = (labs(LNB_frequence-sate_frequence))*1000; 
	__GETD2S 8
	__GETD1S 12
	CALL __SUBD12
	CALL __PUTPARD1
	RCALL _labs
	__GETD2N 0x3E8
	CALL __MULD12U
	__PUTD1S 4
;     252 
;     253 TUNER_18V;
	SBI  0x12,5
;     254 
;     255  
;     256                    
;     257 init();   
	CALL _init
;     258 LED1_ON;
	CBI  0x12,7
;     259 LED2_ON;
	CBI  0x12,6
;     260 delay_ms(1500);
	LDI  R30,LOW(1500)
	LDI  R31,HIGH(1500)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;     261 LED1_OFF;       
	SBI  0x12,7
;     262 LED2_OFF;      
	SBI  0x12,6
;     263 
;     264 TunerRst();
	RCALL _TunerRst
;     265      
;     266 while (1)
_0x9:
;     267 {
;     268     //if()
;     269      //   break; 
;     270     LED1_OFF; 
	SBI  0x12,7
;     271     switch (Rx0()) 
	RCALL _Rx0
;     272     {
;     273         case 'H': 
	CPI  R30,LOW(0x48)
	BRNE _0xF
;     274             {                                    
;     275             LED1_ON;
	CBI  0x12,7
;     276             TUNER_18V;
	SBI  0x12,5
;     277             printf("Set Tuner Voltage 18V!!!\n");
	__POINTW1FN _0,179
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _printf
	ADIW R28,2
;     278             }
;     279             break;    
	RJMP _0xE
;     280         case 'A': 
_0xF:
	CPI  R30,LOW(0x41)
	BREQ PC+3
	JMP _0x10
;     281             {
;     282                  LED1_ON;
	CBI  0x12,7
;     283                  printf("\n......ADCÍ¨µÀ²âÁ¿.....\n");    
	__POINTW1FN _0,205
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _printf
	ADIW R28,2
;     284                  printf("13/18VµçÑ¹ %f\n",((float)LNB_VTG/9.21));   
	__POINTW1FN _0,36
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	RCALL _read_adc
	CLR  R22
	CLR  R23
	CALL __CDF1
	MOVW R26,R30
	MOVW R24,R22
	__GETD1N 0x41135C29
	CALL __DIVF21
	CALL __PUTPARD1
	LDI  R24,4
	CALL _printf
	ADIW R28,6
;     285                  printf("AGCµçÑ¹ %f\n",((float)AGC_ORG/51));   
	__POINTW1FN _0,51
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(2)
	ST   -Y,R30
	RCALL _read_adc
	CLR  R22
	CLR  R23
	CALL __CDF1
	MOVW R26,R30
	MOVW R24,R22
	__GETD1N 0x424C0000
	CALL __DIVF21
	CALL __PUTPARD1
	LDI  R24,4
	CALL _printf
	ADIW R28,6
;     286                  printf("AGCµ÷ÀíµçÑ¹ %f\n",((float)AGC_AMP/51));          
	__POINTW1FN _0,63
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	RCALL _read_adc
	CLR  R22
	CLR  R23
	CALL __CDF1
	MOVW R26,R30
	MOVW R24,R22
	__GETD1N 0x424C0000
	CALL __DIVF21
	CALL __PUTPARD1
	LDI  R24,4
	CALL _printf
	ADIW R28,6
;     287                  printf("1.8VµçÑ¹ %f\n",((float)VTG1V8/51));
	__POINTW1FN _0,79
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(3)
	ST   -Y,R30
	RCALL _read_adc
	CLR  R22
	CLR  R23
	CALL __CDF1
	MOVW R26,R30
	MOVW R24,R22
	__GETD1N 0x424C0000
	CALL __DIVF21
	CALL __PUTPARD1
	LDI  R24,4
	CALL _printf
	ADIW R28,6
;     288                  printf("3.3VµçÑ¹ %f\n",((float)VTG3V3/51)); 
	__POINTW1FN _0,92
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(4)
	ST   -Y,R30
	RCALL _read_adc
	CLR  R22
	CLR  R23
	CALL __CDF1
	MOVW R26,R30
	MOVW R24,R22
	__GETD1N 0x424C0000
	CALL __DIVF21
	CALL __PUTPARD1
	LDI  R24,4
	CALL _printf
	ADIW R28,6
;     289                  printf("AD5µçÑ¹ %f\n",((float)ANLG_A/51)); 
	__POINTW1FN _0,105
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(5)
	ST   -Y,R30
	RCALL _read_adc
	CLR  R22
	CLR  R23
	CALL __CDF1
	MOVW R26,R30
	MOVW R24,R22
	__GETD1N 0x424C0000
	CALL __DIVF21
	CALL __PUTPARD1
	LDI  R24,4
	CALL _printf
	ADIW R28,6
;     290                  printf("AD6µçÑ¹ %f\n",((float)ANLG_B/51)); 
	__POINTW1FN _0,117
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(6)
	ST   -Y,R30
	RCALL _read_adc
	CLR  R22
	CLR  R23
	CALL __CDF1
	MOVW R26,R30
	MOVW R24,R22
	__GETD1N 0x424C0000
	CALL __DIVF21
	CALL __PUTPARD1
	LDI  R24,4
	CALL _printf
	ADIW R28,6
;     291                  printf("AD7µçÑ¹ %f\n",((float)ANLG_C/51)); 
	__POINTW1FN _0,129
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(7)
	ST   -Y,R30
	RCALL _read_adc
	CLR  R22
	CLR  R23
	CALL __CDF1
	MOVW R26,R30
	MOVW R24,R22
	__GETD1N 0x424C0000
	CALL __DIVF21
	CALL __PUTPARD1
	LDI  R24,4
	CALL _printf
	ADIW R28,6
;     292                  printf("........DONE...........\n");  
	__POINTW1FN _0,141
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _printf
	ADIW R28,2
;     293             }
;     294             break;   
	RJMP _0xE
;     295          case 'G': 
_0x10:
	CPI  R30,LOW(0x47)
	BRNE _0x11
;     296             {
;     297                  LED1_ON;
	CBI  0x12,7
;     298                  gyro();
	CALL _gyro
;     299             }
;     300             break;              
	RJMP _0xE
;     301         case 'L': 
_0x11:
	CPI  R30,LOW(0x4C)
	BRNE _0x12
;     302             {     
;     303             LED1_ON;
	CBI  0x12,7
;     304             TUNER_13V;
	CBI  0x12,5
;     305             printf("Set Tuner Voltage 13V!!!\n");
	__POINTW1FN _0,230
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _printf
	ADIW R28,2
;     306             }
;     307             break;   
	RJMP _0xE
;     308         case 'R': 
_0x12:
	CPI  R30,LOW(0x52)
	BRNE _0x13
;     309             {     
;     310             LED1_ON;
	CBI  0x12,7
;     311             printf("Enter register addr:");
	__POINTW1FN _0,256
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _printf
	ADIW R28,2
;     312             addrbyte = Rx0();  
	RCALL _Rx0
	MOV  R16,R30
;     313             while(addrbyte == 0)
_0x14:
	CPI  R16,0
	BRNE _0x16
;     314                 addrbyte = Rx0();
	RCALL _Rx0
	MOV  R16,R30
;     315             if(addrbyte == 0xff)
	RJMP _0x14
_0x16:
	CPI  R16,255
	BRNE _0x17
;     316                 addrbyte =0;       
	LDI  R16,LOW(0)
;     317             printf("Register 0x%x value is 0x%x\n",addrbyte,Get0288Register(addrbyte)); 
_0x17:
	__POINTW1FN _0,277
	ST   -Y,R31
	ST   -Y,R30
	MOV  R30,R16
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	ST   -Y,R16
	RCALL _Get0288Register
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	LDI  R24,8
	CALL _printf
	ADIW R28,10
;     318             }
;     319             break; 
	RJMP _0xE
;     320         case 'S': 
_0x13:
	CPI  R30,LOW(0x53)
	BRNE _0x18
;     321             {     
;     322             LED1_ON;
	CBI  0x12,7
;     323             printf("Enter register addr & byte:");
	__POINTW1FN _0,306
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _printf
	ADIW R28,2
;     324             addrbyte = Rx0();  
	RCALL _Rx0
	MOV  R16,R30
;     325             while(addrbyte == 0)
_0x19:
	CPI  R16,0
	BRNE _0x1B
;     326                 addrbyte = Rx0(); 
	RCALL _Rx0
	MOV  R16,R30
;     327             databyte = Rx0();  
	RJMP _0x19
_0x1B:
	RCALL _Rx0
	MOV  R17,R30
;     328             while(databyte == 0)
_0x1C:
	CPI  R17,0
	BRNE _0x1E
;     329                 databyte = Rx0();      
	RCALL _Rx0
	MOV  R17,R30
;     330             printf("Write %x to Reg 0x%x,and value is 0x%x\n",databyte,addrbyte,Set0288Register(addrbyte,databyte)); 
	RJMP _0x1C
_0x1E:
	__POINTW1FN _0,334
	ST   -Y,R31
	ST   -Y,R30
	MOV  R30,R17
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	MOV  R30,R16
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	ST   -Y,R16
	ST   -Y,R17
	RCALL _Set0288Register
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	LDI  R24,12
	CALL _printf
	ADIW R28,14
;     331             }
;     332             break;     
	RJMP _0xE
;     333         case 'T': 
_0x18:
	CPI  R30,LOW(0x54)
	BRNE _0x1F
;     334             {     
;     335             LED1_ON;
	CBI  0x12,7
;     336             Track(); 
	RCALL _Track
;     337             }
;     338             break;               
	RJMP _0xE
;     339         case 'I': 
_0x1F:
	CPI  R30,LOW(0x49)
	BRNE _0x21
;     340             {           
;     341             LED1_ON; 
	CBI  0x12,7
;     342             printf("TunerFreq to be set %ld.\n",TunerFreq);
	__POINTW1FN _0,374
	ST   -Y,R31
	ST   -Y,R30
	__GETD1S 6
	CALL __PUTPARD1
	LDI  R24,4
	CALL _printf
	ADIW R28,6
;     343             tuner(TunerFreq,symbol_rate);
	__GETD1S 4
	CALL __PUTPARD1
	__GETD1S 4
	CALL __PUTPARD1
	RCALL _tuner
;     344             printf("Init Tuner!!!\n");
	__POINTW1FN _0,400
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _printf
	ADIW R28,2
;     345             }
;     346             break;    
;     347     default:
_0x21:
;     348     };
_0xE:
;     349    
;     350                           
;     351 
;     352 }
	RJMP _0x9
;     353       
;     354       
;     355       
;     356       
;     357       
;     358 }
	ADIW R28,16
_0x22:
	RJMP _0x22
;     359 #include "include.h"      
;     360 
;     361 
;     362 
;     363 // Read the AD conversion result
;     364 unsigned int read_adc(unsigned char adc_input)
;     365 {
_read_adc:
;     366 ADMUX=adc_input|ADC_VREF_TYPE;
	LD   R30,Y
	OUT  0x7,R30
;     367 // Start the AD conversion
;     368 ADCSRA|=0x40;
	SBI  0x6,6
;     369 // Wait for the AD conversion to complete
;     370 while ((ADCSRA & 0x10)==0);
_0x23:
	SBIS 0x6,4
	RJMP _0x23
;     371 ADCSRA|=0x10;
	SBI  0x6,4
;     372 return ADCW;
	IN   R30,0x4
	IN   R31,0x4+1
	RJMP _0x10B
;     373 }
;     374 
;     375                             
;     376 #pragma used+  
;     377 /**********************
;     378 ·¢ËÍµ¥¸ö×Ö·û
;     379 ***********************/
;     380 void Tx0(unsigned char c)
;     381 {              
_Tx0:
;     382         UDR0 = c;
	LD   R30,Y
	OUT  0xC,R30
;     383         while(!(UCSR0A & 0x40))
_0x26:
	SBIS 0xB,6
;     384                 ;
	RJMP _0x26
;     385         UCSR0A |= 0x40;
	SBI  0xB,6
;     386         
;     387 }                         
_0x10B:
	ADIW R28,1
	RET
;     388 #pragma used-
;     389 
;     390 #pragma used+
;     391 /**********************
;     392 ½ÓÊÕµ¥¸ö×Ö·û
;     393 ***********************/    
;     394 unsigned char Rx0(void)
;     395 {              
_Rx0:
;     396         if(UCSR0A & 0x80)
	SBIS 0xB,7
	RJMP _0x29
;     397            return UDR0;    
	IN   R30,0xC
	RET
;     398         else 
_0x29:
;     399            return 0;
	LDI  R30,LOW(0)
	RET
;     400 }                                   
	RET
;     401 #pragma used-
;     402                                 
;     403 
;     404 
;     405 // Get a character from the USART1 Receiver
;     406 #pragma used+
;     407 char getchar1(void)
;     408 {
;     409 char status,data;
;     410 while (1)
;	status -> R16
;	data -> R17
;     411       {
;     412       while (((status=UCSR1A) & RX_COMPLETE)==0);
;     413       data=UDR1;
;     414       if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
;     415          return data;
;     416       };
;     417 }
;     418 #pragma used-
;     419 
;     420 // Write a character to the USART1 Transmitter
;     421 #pragma used+
;     422 void putchar1(char c)
;     423 {
;     424 while ((UCSR1A & DATA_REGISTER_EMPTY)==0);
;     425 UDR1=c;
;     426 }
;     427 #pragma used-         
;     428                       
;     429 
;     430 
;     431 char rx_buffer0[RX_BUFFER_SIZE0];

	.DSEG
_rx_buffer0:
	.BYTE 0x10
;     432 
;     433 #if RX_BUFFER_SIZE0<256
;     434 unsigned char rx_wr_index0,rx_rd_index0,rx_counter0;
;     435 #else
;     436 unsigned int rx_wr_index0,rx_rd_index0,rx_counter0;
;     437 #endif
;     438 
;     439 // This flag is set on USART0 Receiver buffer overflow
;     440 bit rx_buffer_overflow0;
;     441 
;     442 // USART0 Receiver interrupt service routine
;     443 interrupt [USART0_RXC] void usart0_rx_isr(void)
;     444 {

	.CSEG
_usart0_rx_isr:
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	IN   R30,SREG
	ST   -Y,R30
;     445 char status,data;
;     446 status=UCSR0A;
	ST   -Y,R17
	ST   -Y,R16
;	status -> R16
;	data -> R17
	IN   R16,11
;     447 data=UDR0;
	IN   R17,12
;     448 if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
	MOV  R30,R16
	ANDI R30,LOW(0x1C)
	BRNE _0x35
;     449    {
;     450    rx_buffer0[rx_wr_index0]=data;
	MOV  R26,R6
	LDI  R27,0
	SUBI R26,LOW(-_rx_buffer0)
	SBCI R27,HIGH(-_rx_buffer0)
	ST   X,R17
;     451    if (++rx_wr_index0 == RX_BUFFER_SIZE0) rx_wr_index0=0;
	INC  R6
	LDI  R30,LOW(16)
	CP   R30,R6
	BRNE _0x36
	CLR  R6
;     452    if (++rx_counter0 == RX_BUFFER_SIZE0)
_0x36:
	INC  R8
	LDI  R30,LOW(16)
	CP   R30,R8
	BRNE _0x37
;     453       {
;     454       rx_counter0=0;
	CLR  R8
;     455       rx_buffer_overflow0=1;
	SET
	BLD  R2,0
;     456       };
_0x37:
;     457    };
_0x35:
;     458 }
	LD   R16,Y+
	LD   R17,Y+
	LD   R30,Y+
	OUT  SREG,R30
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	RETI
;     459 
;     460 #ifndef _DEBUG_TERMINAL_IO_
;     461 // Get a character from the USART0 Receiver buffer
;     462 #define _ALTERNATE_GETCHAR_
;     463 #pragma used+
;     464 char getchar(void)
;     465 {
;     466   char data;
;     467   while (rx_counter0==0);
;	data -> R16
;     468   data=rx_buffer0[rx_rd_index0];
;     469   if (++rx_rd_index0 == RX_BUFFER_SIZE0) 
;     470     rx_rd_index0=0;
;     471   #asm("cli")
;     472   --rx_counter0;
;     473   #asm("sei")
;     474   return data;
;     475 }
;     476 #pragma used-
;     477 #endif         
;     478          
;     479          
;     480          
;     481          
;     482          
;     483          
;     484          
;     485          
;     486          
;     487          
;     488          
;     489          
;     490          
;     491          
;     492          
;     493 #include "include.h"
;     494 
;     495 #define SCLH PORTD.0=1
;     496 #define SCLL PORTD.0=0
;     497 #define SDAH PORTD.1=1
;     498 #define SDAL PORTD.1=0
;     499 
;     500       
;     501 flash	unsigned	long	LVCO_FREQS[3][2] =
;     502 {
;     503 	{950000,970000},
;     504 	{970000,1065000},
;     505 	{1065000,1170000}
;     506 };
;     507 flash	unsigned	long	HVCO_FREQS[7][2] =
;     508 {
;     509 	{1170000,1300000},
;     510 	{1300000,1445000},
;     511 	{1445000,1607000},
;     512 	{1607000,1778000},
;     513 	{1778000,1942000},
;     514 	{1942000,2131000},
;     515 	{2131000,2150000}
;     516 };
;     517                      
;     518 
;     519 
;     520 void TunerRst(void)
;     521 {
_TunerRst:
;     522 	PORTD.4=0;
	CBI  0x12,4
;     523 	delay_ms(50);
	LDI  R30,LOW(50)
	LDI  R31,HIGH(50)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;     524 	PORTD.4=1; 
	SBI  0x12,4
;     525 }   
	RET
;     526 
;     527 
;     528 
;     529 /***********************************  
;     530 I2C¿ªÊ¼Î»  SDA SCLÉèÎªÊä³ö  
;     531 SDAÔÚSCLÎª¸ßÊ±´Ó¸ß±äÎªµÍ
;     532 ***********************************/
;     533 void i2c_sta(void)
;     534 {
_i2c_sta:
;     535 	DDRD |= 0x03;      //PD0 PD1(SCL SDA) as output
	IN   R30,0x11
	ORI  R30,LOW(0x3)
	OUT  0x11,R30
;     536 	SDAH;
	SBI  0x12,1
;     537 	SCLH;
	SBI  0x12,0
;     538 	delay_us(4);
	__DELAY_USB 21
;     539 	SDAL;
	CBI  0x12,1
;     540 	delay_us(2);
	__DELAY_USB 11
;     541 }                         
	RET
;     542 
;     543 /***********************************  
;     544 I2C½áÊøÎ»  SDA SCLÉèÎªÊä³ö  
;     545 SDAÔÚSCLÎª¸ßÊ±±äÎª¸ß
;     546 ***********************************/
;     547 void i2c_stp(void)
;     548 {
_i2c_stp:
;     549 	SCLH;
	SBI  0x12,0
;     550 	delay_us(2);
	__DELAY_USB 11
;     551 	SDAL;
	CBI  0x12,1
;     552 }
	RET
;     553 
;     554 
;     555 /*****************************
;     556 ¶ÁÈ¡ACK  ÔÚSCL±ä¸ßºó2us¶ÁÈ¡SDA
;     557 ´Ó»ú½«SDAÀ­µÍÎªACKÏìÓ¦  
;     558 ÓÐACK·µ»Ø1  ÎÞACK·µ»Ø0
;     559 ******************************/
;     560 char SDA_in(void)
;     561 {
_SDA_in:
;     562 
;     563 DDRD &=0xFD;       //SDA  input
	CBI  0x11,1
;     564 PORTD |= 0x02;       //SDA pull-up
	SBI  0x12,1
;     565 delay_us(6);
	__DELAY_USB 32
;     566 SCLH;
	SBI  0x12,0
;     567 delay_us(2);
	__DELAY_USB 11
;     568 if(PIND.1==0)  
	SBIC 0x10,1
	RJMP _0x3C
;     569   {
;     570 //         temp_para++;
;     571 //         printf("xiang ying: temp_para = %d\n",temp_para);
;     572   delay_us(2);
	__DELAY_USB 11
;     573   SCLL;
	CBI  0x12,0
;     574 	DDRD |=0x02;          //SDA output
	SBI  0x11,1
;     575 	PORTD.1=1;            //SDA high
	SBI  0x12,1
;     576 	return 1;
	LDI  R30,LOW(1)
	RET
;     577 	}
;     578 else
_0x3C:
;     579 	{
;     580 	 //temp_para++;
;     581 	 //Tx0('X');
;     582 	 DDRD |=0x02;
	SBI  0x11,1
;     583 	 return 0;
	LDI  R30,LOW(0)
	RET
;     584 	}
;     585 }
	RET
;     586 
;     587 
;     588 /**************************************
;     589 ·¢ËÍÒ»¸ö×Ö½ÚµÄÊý¾Ý£¬·¢ËÍÍê³ÉÊÕµ½ACK·µ»Ø1  ·ñÔò·µ»Ø0
;     590 ***************************************/       
;     591 char i2c_send(unsigned char data)
;     592 {
_i2c_send:
;     593 	char i;
;     594 	
;     595 	for(i=0;i<8;i++)
	ST   -Y,R16
;	data -> Y+1
;	i -> R16
	LDI  R16,LOW(0)
_0x3F:
	CPI  R16,8
	BRSH _0x40
;     596 	{
;     597         	SCLL;
	CBI  0x12,0
;     598         	delay_us(4);
	__DELAY_USB 21
;     599         	if(data & 0x80)
	LDD  R30,Y+1
	ANDI R30,LOW(0x80)
	BREQ _0x41
;     600         		SDAH;
	SBI  0x12,1
;     601         	else
	RJMP _0x42
_0x41:
;     602         		SDAL;
	CBI  0x12,1
;     603         	data=(data<<1);
_0x42:
	LDD  R30,Y+1
	LSL  R30
	STD  Y+1,R30
;     604         	
;     605         	
;     606         	delay_us(2);
	__DELAY_USB 11
;     607         	SCLH;
	SBI  0x12,0
;     608         	delay_us(4);
	__DELAY_USB 21
;     609 	}	
	SUBI R16,-1
	RJMP _0x3F
_0x40:
;     610 	SCLL;
	CBI  0x12,0
;     611 
;     612 	if(SDA_in()==1)
	CALL _SDA_in
	CPI  R30,LOW(0x1)
	BRNE _0x43
;     613 		{
;     614 		delay_us(2);
	__DELAY_USB 11
;     615 		//Tx0('P');
;     616 		return 1;
	LDI  R30,LOW(1)
	RJMP _0x101
;     617 		}
;     618 	else
_0x43:
;     619 		{
;     620 		delay_us(2);
	__DELAY_USB 11
;     621 		Tx0('!');
	LDI  R30,LOW(33)
	ST   -Y,R30
	CALL _Tx0
;     622 		return 0;
	LDI  R30,LOW(0)
	RJMP _0x101
;     623 		}
;     624 
;     625 } 
	RJMP _0x101
;     626 /****************************************
;     627 ¶ÁÈ¡Ò»¸ö×Ö½ÚµÄÊý¾Ý²¢·µ»Ø¸Ã×Ö½Ú
;     628 ****************************************/
;     629 unsigned char i2c_byte_read(void)
;     630 {
_i2c_byte_read:
;     631         unsigned char i,data;
;     632         data=0; 
	ST   -Y,R17
	ST   -Y,R16
;	i -> R16
;	data -> R17
	LDI  R17,LOW(0)
;     633         DDRD &=0xFD;       //SDA  input
	CBI  0x11,1
;     634         PORTD |= 0x02;       //SDA pull-up
	SBI  0x12,1
;     635         //SCLL;    
;     636         //delay_us(3);   
;     637         //data=(data |(PIND & 0x02)); 
;     638         for(i=0;i<7;i++)
	LDI  R16,LOW(0)
_0x46:
	CPI  R16,7
	BRSH _0x47
;     639         {         
;     640                 SCLH;
	SBI  0x12,0
;     641                 delay_us(2);  
	__DELAY_USB 11
;     642                 data=data<<1;
	LSL  R17
;     643                 data=(data |(PIND & 0x02));                  
	IN   R30,0x10
	ANDI R30,LOW(0x2)
	OR   R17,R30
;     644                 delay_us(2);
	__DELAY_USB 11
;     645                
;     646                 SCLL;
	CBI  0x12,0
;     647                 delay_us(4);        
	__DELAY_USB 21
;     648         }         
	SUBI R16,-1
	RJMP _0x46
_0x47:
;     649         data=(data |((PIND & 0x02)?1:0));
	SBIS 0x10,1
	RJMP _0x48
	LDI  R30,LOW(1)
	RJMP _0x49
_0x48:
	LDI  R30,LOW(0)
_0x49:
	OR   R17,R30
;     650         DDRD.1=1;
	SBI  0x11,1
;     651         SDAL;   
	CBI  0x12,1
;     652         SCLH;
	SBI  0x12,0
;     653         delay_us(4);       
	__DELAY_USB 21
;     654         SCLL;
	CBI  0x12,0
;     655         delay_us(4);
	__DELAY_USB 21
;     656         return data;
	MOV  R30,R17
	LD   R16,Y+
	LD   R17,Y+
	RET
;     657 
;     658 }                                                
;     659 
;     660 
;     661 
;     662 /******************************************************    
;     663 Ö÷»ú¶ÁÈ¡I2C  ²ÎÊý·Ö±ðÎª ´Ó»úµØÖ·£¬¶Á»ØµÄ×Ö½Ú´æ·ÅµÄÊý×éÖ¸Õë£¬¶Á»ØµÄ×Ö½ÚÊý   
;     664 slave address,pointer to be written,number to be read   
;     665 ´Ó»úÏìÓ¦ÁËµØÖ··µ»Ø1 ·ñÔò·µ»Ø0
;     666 *******************************************************/            
;     667 char i2c_rd(unsigned char addr,unsigned char *ddata,unsigned char counter)     
;     668 {
_i2c_rd:
;     669  unsigned char i;
;     670  unsigned char *pdata;
;     671  i=counter;  
	CALL __SAVELOCR3
;	addr -> Y+6
;	*ddata -> Y+4
;	counter -> Y+3
;	i -> R16
;	*pdata -> R17,R18
	LDD  R16,Y+3
;     672  pdata=ddata;
	__GETWRS 17,18,4
;     673  i2c_sta();
	CALL _i2c_sta
;     674  if(i2c_send(addr|0x01)==1)
	LDD  R30,Y+6
	ORI  R30,1
	ST   -Y,R30
	CALL _i2c_send
	CPI  R30,LOW(0x1)
	BRNE _0x4B
;     675    {    
;     676          while(i)
_0x4C:
	CPI  R16,0
	BREQ _0x4E
;     677         	{
;     678         		*pdata=i2c_byte_read();
	CALL _i2c_byte_read
	__GETW2R 17,18
	ST   X,R30
;     679         		pdata++;
	__ADDWRN 17,18,1
;     680         		i--;
	SUBI R16,1
;     681         	}    	
	RJMP _0x4C
_0x4E:
;     682          i2c_stp(); 
	CALL _i2c_stp
;     683          return 1;
	LDI  R30,LOW(1)
	RJMP _0x10A
;     684     }
;     685  else 
_0x4B:
;     686         return 0;   
	LDI  R30,LOW(0)
;     687     
;     688 }
_0x10A:
	CALL __LOADLOCR3
	ADIW R28,7
	RET
;     689 /**********************************************  
;     690 ·¢ËÍÒ»×é×Ö½Úµ½´Ó»ú        
;     691 pointer to the first byte,number of bytes to be written    
;     692 ·¢ËÍÍê³É·µ»Ø1  ·ñÔò·µ»Ø0
;     693 **********************************************/
;     694 char i2c_tran(char *data,char num)
;     695 {
_i2c_tran:
;     696 	char i; 
;     697 	i2c_sta(); 
	ST   -Y,R16
;	*data -> Y+2
;	num -> Y+1
;	i -> R16
	CALL _i2c_sta
;     698 	for(i=0;i<num;i++)
	LDI  R16,LOW(0)
_0x51:
	LDD  R30,Y+1
	CP   R16,R30
	BRSH _0x52
;     699 	{
;     700         	if(i2c_send(*data))
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	LD   R30,X
	ST   -Y,R30
	CALL _i2c_send
	CPI  R30,0
	BREQ _0x53
;     701         		data++;
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	ADIW R30,1
	STD  Y+2,R30
	STD  Y+2+1,R31
;     702         	else
	RJMP _0x54
_0x53:
;     703         		return 0;
	LDI  R30,LOW(0)
	RJMP _0x109
;     704 	}	
_0x54:
	SUBI R16,-1
	RJMP _0x51
_0x52:
;     705 	i2c_stp();
	CALL _i2c_stp
;     706 	return 1;
	LDI  R30,LOW(1)
_0x109:
	LDD  R16,Y+0
	ADIW R28,4
	RET
;     707 
;     708 }  
;     709 
;     710      
;     711 
;     712 /******************************
;     713 open tuner interface
;     714 *******************************/ 
;     715 void EnableTunerOperation(void)
;     716 {
_EnableTunerOperation:
;     717     unsigned char byte[3];                                 
;     718      byte[0]=0xD0;
	SBIW R28,3
;	byte -> Y+0
	LDI  R30,LOW(208)
	ST   Y,R30
;     719      byte[1]=0x01;
	LDI  R30,LOW(1)
	STD  Y+1,R30
;     720      byte[2]=0xC0; 
	LDI  R30,LOW(192)
	STD  Y+2,R30
;     721      i2c_tran(byte,3); 
	MOVW R30,R28
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(3)
	ST   -Y,R30
	CALL _i2c_tran
;     722      //printf("Enable Tuner Operation\n");
;     723 }
	RJMP _0x108
;     724 
;     725 /*******************************
;     726 close tuner interface
;     727 *******************************/ 
;     728 void DisableTunerOperation(void)
;     729 {
_DisableTunerOperation:
;     730     unsigned char byte[3];                                
;     731     byte[0]=0xD0;
	SBIW R28,3
;	byte -> Y+0
	LDI  R30,LOW(208)
	ST   Y,R30
;     732     byte[1]=0x01;
	LDI  R30,LOW(1)
	STD  Y+1,R30
;     733     byte[2]=0x40; 
	LDI  R30,LOW(64)
	STD  Y+2,R30
;     734     i2c_tran(byte,3);  
	MOVW R30,R28
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(3)
	ST   -Y,R30
	CALL _i2c_tran
;     735     //printf("Disable Tuner Operation\n");
;     736 }
_0x108:
	ADIW R28,3
	RET
;     737 
;     738 /******************************************************
;     739 ¼ÆËãÆµÂÊ ½«Ö®×ª»»Îªtuner³õÊ¼»¯ÐèÒªµÄ×Ö½ÚÊý¾Ý,²¢Ð´ÈëÐ¾Æ¬
;     740 *******************************************************/    
;     741 unsigned char TFC(unsigned long _TunerFrequency) //TunerFrequencyCalculate  KHZ
;     742 {
_TFC:
;     743 
;     744 	unsigned long long_tmp, TunerFrequency  ;
;     745 	unsigned int i;
;     746 	unsigned char B[5] = {0x00},temp[5] = {0x00};
;     747 	unsigned int ddata,pd2,pd3,pd4,pd5 ;
;     748         printf("TunerFreq %ld.\n",_TunerFrequency);
	SBIW R28,24
	LDI  R24,10
	LDI  R26,LOW(6)
	LDI  R27,HIGH(6)
	LDI  R30,LOW(_0x55*2)
	LDI  R31,HIGH(_0x55*2)
	CALL __INITLOCB
	CALL __SAVELOCR6
;	_TunerFrequency -> Y+30
;	long_tmp -> Y+26
;	TunerFrequency -> Y+22
;	i -> R16,R17
;	B -> Y+17
;	temp -> Y+12
;	ddata -> R18,R19
;	pd2 -> R20,R21
;	pd3 -> Y+10
;	pd4 -> Y+8
;	pd5 -> Y+6
	__POINTW1FN _0,415
	ST   -Y,R31
	ST   -Y,R30
	__GETD1S 32
	CALL __PUTPARD1
	LDI  R24,4
	CALL _printf
	ADIW R28,6
;     749 
;     750 	B[0] = 0xc0;
	LDI  R30,LOW(192)
	STD  Y+17,R30
;     751 	if ((_TunerFrequency>=900000)&&(_TunerFrequency<1170000)) 	//
	__GETD2S 30
	__CPD2N 0xDBBA0
	BRLO _0x57
	__CPD2N 0x11DA50
	BRLO _0x58
_0x57:
	RJMP _0x56
_0x58:
;     752 	{
;     753 		B[4]=0x0e;
	LDI  R30,LOW(14)
	STD  Y+21,R30
;     754 		for (i=0; i<3; i++)
	__GETWRN 16,17,0
_0x5A:
	__CPWRN 16,17,3
	BRSH _0x5B
;     755 		{
;     756 	        if (_TunerFrequency < LVCO_FREQS[i][1]) break;
	LDI  R26,LOW(_LVCO_FREQS*2)
	LDI  R27,HIGH(_LVCO_FREQS*2)
	__GETW1R 16,17
	PUSH R27
	PUSH R26
	CALL __LSLW3
	POP  R26
	POP  R27
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,4
	CALL __GETD1PF
	__GETD2S 30
	CALL __CPD21
	BRLO _0x5B
;     757 		}
	__ADDWRN 16,17,1
	RJMP _0x5A
_0x5B:
;     758 		i=i+0x05;
	__ADDWRN 16,17,5
;     759 		i=i<<5;
	RJMP _0x10C
;     760     		B[4]= B[4]+i;
;     761 	}
;     762 	else													//
_0x56:
;     763 	{
;     764 		B[4]=0x0c;
	LDI  R30,LOW(12)
	STD  Y+21,R30
;     765 		for (i=0; i<7; i++)
	__GETWRN 16,17,0
_0x5F:
	__CPWRN 16,17,7
	BRSH _0x60
;     766 		{
;     767 	        if (_TunerFrequency < HVCO_FREQS[i][1]) break;
	LDI  R26,LOW(_HVCO_FREQS*2)
	LDI  R27,HIGH(_HVCO_FREQS*2)
	__GETW1R 16,17
	PUSH R27
	PUSH R26
	CALL __LSLW3
	POP  R26
	POP  R27
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,4
	CALL __GETD1PF
	__GETD2S 30
	CALL __CPD21
	BRLO _0x60
;     768 		}
	__ADDWRN 16,17,1
	RJMP _0x5F
_0x60:
;     769 		i=i+0x01;
	__ADDWRN 16,17,1
;     770 		i=i<<5;
_0x10C:
	__GETW2R 16,17
	LDI  R30,LOW(5)
	CALL __LSLW12
	__PUTW1R 16,17
;     771 		B[4]= B[4]+i;
	__GETW1R 16,17
	LDD  R26,Y+21
	LDI  R27,0
	ADD  R30,R26
	ADC  R31,R27
	STD  Y+21,R30
;     772 	}
;     773 	TunerFrequency = _TunerFrequency/500;
	__GETD2S 30
	__GETD1N 0x1F4
	CALL __DIVD21U
	__PUTD1S 22
;     774 	long_tmp = TunerFrequency/32;
	__GETD2S 22
	__GETD1N 0x20
	CALL __DIVD21U
	__PUTD1S 26
;     775 	i = TunerFrequency%32;
	__GETD1S 22
	__ANDD1N 0x1F
	__PUTW1R 16,17
;     776  	B[1] = (int)((long_tmp>>3)&0x000000ff);
	LDD  R30,Y+26
	LDD  R31,Y+26+1
	CALL __LSRW3
	__ANDD1N 0xFF
	STD  Y+18,R30
;     777 	B[2] = (int)((long_tmp<<5)&0x000000ff);
	__GETD2S 26
	LDI  R30,LOW(5)
	CALL __LSLD12
	__ANDD1N 0xFF
	STD  Y+19,R30
;     778 	B[2] = (int)(B[2] + i);
	__GETW1R 16,17
	LDD  R26,Y+19
	LDI  R27,0
	ADD  R30,R26
	ADC  R31,R27
	STD  Y+19,R30
;     779 	i=0;  
	__GETWRN 16,17,0
;     780 	//printf("TFC byte1~5:0x%x,0x%x,0x%x,0x%x,0x%x\n",B[0],B[1],B[2],B[3],B[4]);         
;     781     do
_0x63:
;     782       {   
;     783 //             temp_para = 0;
;     784 // 	    printf("the cation of i2c acknowlede in function TFC\n");
;     785 	    temp[0] = B[0];
	LDD  R30,Y+17
	STD  Y+12,R30
;     786 	    temp[1] = B[1];
	LDD  R30,Y+18
	STD  Y+13,R30
;     787 	    temp[2] = B[2];
	LDD  R30,Y+19
	STD  Y+14,R30
;     788 	    temp[4] = B[4];
	LDD  R30,Y+21
	STD  Y+16,R30
;     789 	    
;     790             temp[3] = 0xe1;
	LDI  R30,LOW(225)
	STD  Y+15,R30
;     791             temp[4] = B[4] & 0xf3;
	LDD  R30,Y+21
	ANDI R30,LOW(0xF3)
	STD  Y+16,R30
;     792 //             printf("B1. byte1~5  0x%x,0x%x,0x%x,0x%x,0x%x\n",B[0],B[1],B[2],B[3],B[4]);
;     793              //printf("temp1. byte1~5  0x%x,0x%x,0x%x,0x%x,0x%x\n",temp[0],temp[1],temp[2],temp[3],temp[4]);
;     794 
;     795             EnableTunerOperation();
	CALL _EnableTunerOperation
;     796             i2c_tran(temp,5);                   //write byte1 byte2 byte3 byte4 byte5
	MOVW R30,R28
	ADIW R30,12
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(5)
	ST   -Y,R30
	CALL _i2c_tran
;     797             //DisableTunerOperation(); 
;     798             
;     799             temp[1] = temp[3] | 0x04;
	LDD  R30,Y+15
	ORI  R30,4
	STD  Y+13,R30
;     800              //printf("temp2. byte1,4  0x%x,0x%x\n",temp[0],temp[1]); 
;     801             //EnableTunerOperation();
;     802             i2c_tran(temp,2);           //write byte1 byte4
	MOVW R30,R28
	ADIW R30,12
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(2)
	ST   -Y,R30
	CALL _i2c_tran
;     803             //DisableTunerOperation();
;     804             delay_ms(10);           
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;     805             
;     806             B[3] = 0xfd;
	LDI  R30,LOW(253)
	STD  Y+20,R30
;     807             ddata =  (30000/1000)/2 - 2;
	__GETWRN 18,19,13
;     808             pd2 = (ddata>>1)&0x04	;
	__GETW1R 18,19
	LSR  R31
	ROR  R30
	ANDI R30,LOW(0x4)
	ANDI R31,HIGH(0x4)
	__PUTW1R 20,21
;     809             pd3 = (ddata<<1)&0x08	;
	__GETW1R 18,19
	LSL  R30
	ROL  R31
	ANDI R30,LOW(0x8)
	ANDI R31,HIGH(0x8)
	STD  Y+10,R30
	STD  Y+10+1,R31
;     810             pd4 = (ddata<<2)&0x08	;
	__GETW1R 18,19
	CALL __LSLW2
	ANDI R30,LOW(0x8)
	ANDI R31,HIGH(0x8)
	STD  Y+8,R30
	STD  Y+8+1,R31
;     811             pd5 = (ddata<<4)&0x10	;
	__GETW1R 18,19
	CALL __LSLW4
	ANDI R30,LOW(0x10)
	ANDI R31,HIGH(0x10)
	STD  Y+6,R30
	STD  Y+6+1,R31
;     812             B[3] &= 0xE7	;
	MOVW R30,R28
	ADIW R30,20
	PUSH R31
	PUSH R30
	LD   R30,Z
	ANDI R30,LOW(0xE7)
	POP  R26
	POP  R27
	ST   X,R30
;     813             B[4] &= 0xF3	;
	MOVW R30,R28
	ADIW R30,21
	PUSH R31
	PUSH R30
	LD   R30,Z
	ANDI R30,LOW(0xF3)
	POP  R26
	POP  R27
	ST   X,R30
;     814             B[3] |= (pd5|pd4)	;
	MOVW R30,R28
	ADIW R30,20
	PUSH R31
	PUSH R30
	LD   R30,Z
	PUSH R30
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	OR   R30,R26
	OR   R31,R27
	POP  R26
	LDI  R27,0
	OR   R30,R26
	OR   R31,R27
	POP  R26
	POP  R27
	ST   X,R30
;     815             B[4] |= (pd3|pd2)	; 
	MOVW R30,R28
	ADIW R30,21
	PUSH R31
	PUSH R30
	LD   R30,Z
	PUSH R30
	__GETW1R 20,21
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	OR   R30,R26
	OR   R31,R27
	POP  R26
	LDI  R27,0
	OR   R30,R26
	OR   R31,R27
	POP  R26
	POP  R27
	ST   X,R30
;     816             
;     817 //             printf("B2. byte1~5  0x%x,0x%x,0x%x,0x%x,0x%x\n",B[0],B[1],B[2],B[3],B[4]);
;     818             
;     819             temp[1] = B[3] | 0x04;
	LDD  R30,Y+20
	ORI  R30,4
	STD  Y+13,R30
;     820             temp[2] = B[4];
	LDD  R30,Y+21
	STD  Y+14,R30
;     821             // printf("temp3. byte1,4,5  0x%x,0x%x,0x%x\n",temp[0],temp[1],temp[2]);
;     822             //EnableTunerOperation();
;     823             i2c_tran(temp,3);                   //write byte1 byte4 byte5
	MOVW R30,R28
	ADIW R30,12
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(3)
	ST   -Y,R30
	CALL _i2c_tran
;     824             DisableTunerOperation();
	CALL _DisableTunerOperation
;     825             
;     826             delay_ms(1);
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;     827             i++;
	__ADDWRN 16,17,1
;     828             if(pll_lk())
	RCALL _pll_lk
	CPI  R30,0
	BREQ _0x65
;     829             {                                         
;     830                 printf("TunerFrequency Calculate & set Success!\n");
	__POINTW1FN _0,431
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _printf
	ADIW R28,2
;     831                 return 1;
	LDI  R30,LOW(1)
	RJMP _0x107
;     832             }
;     833         }while(i < 4);  
_0x65:
	__CPWRN 16,17,4
	BRSH _0x64
	RJMP _0x63
_0x64:
;     834         printf("TunerFrequency Calculate & set Failed!\n");
	__POINTW1FN _0,472
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _printf
	ADIW R28,2
;     835         return 0; 
	LDI  R30,LOW(0)
_0x107:
	CALL __LOADLOCR6
	ADIW R28,34
	RET
;     836 }
;     837 
;     838 
;     839 /******************************    
;     840 STV0288Ð¾Æ¬³õÊ¼»¯
;     841 ***************************/
;     842 void STV0288Init(void)
;     843 {
_STV0288Init:
;     844  unsigned char byte[10];  //i = 0;
;     845  unsigned char *pointer;  
;     846 
;     847         // temp_para = 0;
;     848         // printf("the cation of i2c acknowlede in function STV0288Init\n");      
;     849         
;     850         byte[0]=0xD0;
	SBIW R28,10
	ST   -Y,R17
	ST   -Y,R16
;	byte -> Y+2
;	*pointer -> R16,R17
	LDI  R30,LOW(208)
	STD  Y+2,R30
;     851         pointer= &byte[0];
	MOVW R30,R28
	ADIW R30,2
	__PUTW1R 16,17
;     852                            
;     853         /********************************
;     854         set clock     
;     855         PLL_DIV=100
;     856         clock inputfrom CLKI,Fmclk=4M*PLL_DIV/4=100M                    
;     857         ********************************/
;     858         byte[1]= 0x40;    
	LDI  R30,LOW(64)
	STD  Y+3,R30
;     859         byte[2]= 0x64;             //PLLCTRL
	LDI  R30,LOW(100)
	STD  Y+4,R30
;     860         byte[3]= 0x04;             //SYNTCTRL
	LDI  R30,LOW(4)
	STD  Y+5,R30
;     861         i2c_tran(pointer,4); 
	ST   -Y,R17
	ST   -Y,R16
	ST   -Y,R30
	CALL _i2c_tran
;     862                                            
;     863         
;     864                   
;     865         byte[1]=0x02;                 //ACR
	LDI  R30,LOW(2)
	STD  Y+3,R30
;     866         byte[2]=0x20; 
	LDI  R30,LOW(32)
	STD  Y+4,R30
;     867         i2c_tran(pointer,3); 
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(3)
	ST   -Y,R30
	CALL _i2c_tran
;     868         
;     869         
;     870         
;     871         
;     872         /*********************
;     873         set register about AGC
;     874         **********************/
;     875         byte[1]=0x0F;
	LDI  R30,LOW(15)
	STD  Y+3,R30
;     876         byte[2]=0x54;               //AGC1REF
	LDI  R30,LOW(84)
	STD  Y+4,R30
;     877         i2c_tran(pointer,3);  
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(3)
	ST   -Y,R30
	CALL _i2c_tran
;     878         //printf("AGC1REF*");
;     879         /*******************************
;     880         set register about timing loop
;     881         ********************************/ 
;     882         
;     883         byte[1]=0x11;
	LDI  R30,LOW(17)
	STD  Y+3,R30
;     884         byte[2]=0x7a;                 //RTC
	LDI  R30,LOW(122)
	STD  Y+4,R30
;     885         i2c_tran(pointer,3); 
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(3)
	ST   -Y,R30
	CALL _i2c_tran
;     886         //printf("RTC*");
;     887         byte[1]=0x22;
	LDI  R30,LOW(34)
	STD  Y+3,R30
;     888         byte[2]=0x00;               //RTFM
	LDI  R30,LOW(0)
	STD  Y+4,R30
;     889         byte[3]=0x00;               //RTFL               
	STD  Y+5,R30
;     890         i2c_tran(pointer,4); 
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(4)
	ST   -Y,R30
	CALL _i2c_tran
;     891         //printf("RTF*");                     
;     892         
;     893         /**********************************************
;     894         set register about DAC (¸Ã¼Ä´æÆ÷ÉèÖÃ²»Ó°ÏìËø¶¨)
;     895         **********************************************/         
;     896         
;     897         byte[1]=0x1b;
	LDI  R30,LOW(27)
	STD  Y+3,R30
;     898         byte[2]=0x8f;                    //DACR1 
	LDI  R30,LOW(143)
	STD  Y+4,R30
;     899         byte[3]=0xf0;               //DACR2              
	LDI  R30,LOW(240)
	STD  Y+5,R30
;     900         i2c_tran(pointer,4);       
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(4)
	ST   -Y,R30
	CALL _i2c_tran
;     901         //printf("DACR*");
;     902         /*******************************
;     903         set register about carrier loop
;     904         ********************************/ 
;     905         byte[1]=0x15;
	LDI  R30,LOW(21)
	STD  Y+3,R30
;     906         byte[2]=0xf7;                   //CFD
	LDI  R30,LOW(247)
	STD  Y+4,R30
;     907         byte[3]=0x88;                 //ACLC
	LDI  R30,LOW(136)
	STD  Y+5,R30
;     908         byte[4]=0x58;                 //BCLC
	LDI  R30,LOW(88)
	STD  Y+6,R30
;     909         i2c_tran(pointer,5); 
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(5)
	ST   -Y,R30
	CALL _i2c_tran
;     910         
;     911         
;     912         byte[1]=0x19;
	LDI  R30,LOW(25)
	STD  Y+3,R30
;     913         byte[2]=0xa6;                   //LDT
	LDI  R30,LOW(166)
	STD  Y+4,R30
;     914         byte[3]=0x88;                 //LDT2
	LDI  R30,LOW(136)
	STD  Y+5,R30
;     915         i2c_tran(pointer,4); 
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(4)
	ST   -Y,R30
	CALL _i2c_tran
;     916         
;     917         byte[1]=0x2B;
	LDI  R30,LOW(43)
	STD  Y+3,R30
;     918         byte[2]=0xFF;                   //CFRM
	LDI  R30,LOW(255)
	STD  Y+4,R30
;     919         byte[3]=0xF7;                 //CFRL
	LDI  R30,LOW(247)
	STD  Y+5,R30
;     920         i2c_tran(pointer,4); 
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(4)
	ST   -Y,R30
	CALL _i2c_tran
;     921                       
;     922         
;     923         /*******************************
;     924         set register about FEC and SYNC
;     925         ********************************/                                 
;     926         byte[1]=0x37;
	LDI  R30,LOW(55)
	STD  Y+3,R30
;     927         byte[2]=0x2f;                   //PR
	LDI  R30,LOW(47)
	STD  Y+4,R30
;     928         byte[3]=0x16;                 //VSEARCH
	LDI  R30,LOW(22)
	STD  Y+5,R30
;     929         byte[4]=0xbd;                 //RS
	LDI  R30,LOW(189)
	STD  Y+6,R30
;     930         i2c_tran(pointer,5); 
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(5)
	ST   -Y,R30
	CALL _i2c_tran
;     931         
;     932         // byte[1]=0x3B;
;     933         // byte[2]=0x13;                   //ERRCTRL
;     934         // byte[3]=0x12;                 //VITPROG
;     935         // byte[4]=0x30;                 //ERRCTRL2
;     936         // i2c_tran(pointer,5);    
;     937         
;     938         byte[1]=0x3c;               
	LDI  R30,LOW(60)
	STD  Y+3,R30
;     939         byte[2]=0x12;                 //VITPROG
	LDI  R30,LOW(18)
	STD  Y+4,R30
;     940         i2c_tran(pointer,3);    
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(3)
	ST   -Y,R30
	CALL _i2c_tran
;     941         
;     942         byte[1]=0x02;         //ACR
	LDI  R30,LOW(2)
	STD  Y+3,R30
;     943         byte[2]=0x20; 
	LDI  R30,LOW(32)
	STD  Y+4,R30
;     944         i2c_tran(pointer,3);                               
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(3)
	ST   -Y,R30
	CALL _i2c_tran
;     945         
;     946         /********************************
;     947         set clock     
;     948         PLL_DIV=100
;     949         clock inputfrom CLKI,Fmclk=4M*PLL_DIV/4=100M                    
;     950         ********************************/    
;     951         byte[1]= 0x40;    
	LDI  R30,LOW(64)
	STD  Y+3,R30
;     952         byte[2]= 0x63;             //PLLCTRL
	LDI  R30,LOW(99)
	STD  Y+4,R30
;     953         byte[3]= 0x04;             //SYNTCTRL
	LDI  R30,LOW(4)
	STD  Y+5,R30
;     954         byte[4]= 0x20;             //TSTTNR1
	LDI  R30,LOW(32)
	STD  Y+6,R30
;     955         i2c_tran(pointer,5);   
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(5)
	ST   -Y,R30
	CALL _i2c_tran
;     956                 
;     957         
;     958         byte[1]=0xB2;
	LDI  R30,LOW(178)
	STD  Y+3,R30
;     959         byte[2]=0x10;                   //AGCCFG
	LDI  R30,LOW(16)
	STD  Y+4,R30
;     960         byte[3]=0x82;                 //DIRCLKCFG
	LDI  R30,LOW(130)
	STD  Y+5,R30
;     961         byte[4]=0x80;                 //AUXCKCFG  
	LDI  R30,LOW(128)
	STD  Y+6,R30
;     962         byte[5]=0x82;                 //STDBYCFG
	LDI  R30,LOW(130)
	STD  Y+7,R30
;     963         byte[6]=0x82;                 //CS0CFG
	STD  Y+8,R30
;     964         byte[7]=0x82;                 //CS1CFG  
	STD  Y+9,R30
;     965         i2c_tran(pointer,8); 
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(8)
	ST   -Y,R30
	CALL _i2c_tran
;     966         //printf("STV0288 Init Done\n");
;     967 } 
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,12
	RET
;     968 
;     969 
;     970 /**********************************          
;     971 Éè¶¨·ûºÅÂÊ
;     972 **********************************/
;     973 void SetSymbolRate(float sym_rate)
;     974 {
_SetSymbolRate:
;     975         char byte[8];
;     976         char *pointer; 
;     977         long int ksy_rate;     
;     978         pointer = &byte[0]; 
	SBIW R28,12
	ST   -Y,R17
	ST   -Y,R16
;	sym_rate -> Y+14
;	byte -> Y+6
;	*pointer -> R16,R17
;	ksy_rate -> Y+2
	MOVW R30,R28
	ADIW R30,6
	__PUTW1R 16,17
;     979        // temp_para = 0;
;     980 //         printf("the cation of i2c acknowlede in function SetSymbolRate\n");       
;     981         
;     982         byte[0]=0xD0;       
	LDI  R30,LOW(208)
	STD  Y+6,R30
;     983         
;     984         /********************************
;     985         set clock     
;     986         PLL_DIV=100
;     987         clock inputfrom CLKI,Fmclk=4M*PLL_DIV/4=100M                    
;     988         ********************************/
;     989         byte[1]= 0x40;    
	LDI  R30,LOW(64)
	STD  Y+7,R30
;     990         byte[2]= 0x63;             //PLLCTRL
	LDI  R30,LOW(99)
	STD  Y+8,R30
;     991         byte[3]= 0x04;             //SYNTCTRL
	LDI  R30,LOW(4)
	STD  Y+9,R30
;     992         i2c_tran(pointer,4); 
	ST   -Y,R17
	ST   -Y,R16
	ST   -Y,R30
	CALL _i2c_tran
;     993                                            
;     994         
;     995                   
;     996         byte[1]=0x02;                 //ACR
	LDI  R30,LOW(2)
	STD  Y+7,R30
;     997         byte[2]=0x20; 
	LDI  R30,LOW(32)
	STD  Y+8,R30
;     998         i2c_tran(pointer,3);         
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(3)
	ST   -Y,R30
	CALL _i2c_tran
;     999         
;    1000         /*****************************
;    1001         set symbol rate   
;    1002         //SFRH,SFRM,SFRL = 27.5/100*2e20 =0x46666   27.49996
;    1003         *****************************/               
;    1004         ksy_rate =(sym_rate*1048576/100000);        
	__GETD2S 14
	__GETD1N 0x49800000
	CALL __MULF12
	MOVW R26,R30
	MOVW R24,R22
	__GETD1N 0x47C35000
	CALL __DIVF21
	MOVW R26,R28
	ADIW R26,2
	CALL __CFD1
	CALL __PUTDP1
;    1005         byte[1]=0x28;    
	LDI  R30,LOW(40)
	STD  Y+7,R30
;    1006 
;    1007         byte[2]=(ksy_rate >> 12)& 0xFF;
	__GETD2S 2
	LDI  R30,LOW(12)
	CALL __ASRD12
	__ANDD1N 0xFF
	STD  Y+8,R30
;    1008         byte[3]=(ksy_rate >> 4)& 0xFF;
	LDI  R30,LOW(4)
	CALL __ASRD12
	__ANDD1N 0xFF
	STD  Y+9,R30
;    1009         byte[4]=(ksy_rate << 4)& 0xFF;
	LDI  R30,LOW(4)
	CALL __LSLD12
	__ANDD1N 0xFF
	STD  Y+10,R30
;    1010         
;    1011         printf("symbol %f, 0x%x 0x%x 0x%x\n",sym_rate,byte[2],byte[3],byte[4] );
	__POINTW1FN _0,512
	ST   -Y,R31
	ST   -Y,R30
	__GETD1S 16
	CALL __PUTPARD1
	LDD  R30,Y+14
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	LDD  R30,Y+19
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	LDD  R30,Y+24
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	LDI  R24,16
	CALL _printf
	ADIW R28,18
;    1012         byte[5]=0;     //CFRM  ÔØ²¨ÆµÂÊ
	LDI  R30,LOW(0)
	STD  Y+11,R30
;    1013         byte[6]=0;     //CFRL
	STD  Y+12,R30
;    1014         i2c_tran(pointer,7); 
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(7)
	ST   -Y,R30
	CALL _i2c_tran
;    1015         printf("SetSymbolRate Done\n");
	__POINTW1FN _0,539
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _printf
	ADIW R28,2
;    1016 }  
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,18
	RET
;    1017 
;    1018 
;    1019 
;    1020 /***************************************************************
;    1021 7395³õÊ¼»¯
;    1022 master clockÉèÖÃÎª100M                           
;    1023 ²âÊÔÊ¹ÓÃAsia6  12395MHz frequency  27500K symbol rate
;    1024 12395-10750=1645=fvco=32*51+13
;    1025 11880-10750=1030
;    1026 ****************************************************************/
;    1027 unsigned char tuner(unsigned long F,float S)
;    1028 {
_tuner:
;    1029 
;    1030         char i;                   
;    1031         TunerRst();
	ST   -Y,R16
;	F -> Y+5
;	S -> Y+1
;	i -> R16
	CALL _TunerRst
;    1032         delay_ms(50);        
	LDI  R30,LOW(50)
	LDI  R31,HIGH(50)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;    1033         
;    1034         
;    1035         TFC(F);                                           
	__GETD1S 5
	CALL __PUTPARD1
	CALL _TFC
;    1036         STV0288Init();            
	CALL _STV0288Init
;    1037         SetSymbolRate(S);              
	__GETD1S 1
	CALL __PUTPARD1
	CALL _SetSymbolRate
;    1038         
;    1039         i = 0;
	LDI  R16,LOW(0)
;    1040         while(i<4)
_0x66:
	CPI  R16,4
	BRSH _0x68
;    1041         {
;    1042             i++;
	SUBI R16,-1
;    1043             delay_us(900);
	__DELAY_USW 3600
;    1044             if(locked())
	RCALL _locked
	CPI  R30,0
	BREQ _0x69
;    1045             {
;    1046                printf("locked\n");
	__POINTW1FN _0,559
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _printf
	ADIW R28,2
;    1047                return 1;
	LDI  R30,LOW(1)
	RJMP _0x106
;    1048             }
;    1049         }  
_0x69:
	RJMP _0x66
_0x68:
;    1050         printf("not locked\n");
	__POINTW1FN _0,567
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _printf
	ADIW R28,2
;    1051         return 0;                                 
	LDI  R30,LOW(0)
_0x106:
	LDD  R16,Y+0
	ADIW R28,9
	RET
;    1052         
;    1053 }
;    1054                       
;    1055 /*
;    1056 read lock register  
;    1057 and save to pointer p 
;    1058 */            
;    1059 void getstus(char *p)
;    1060   {
_getstus:
;    1061         char data[3];
;    1062         char *pdata;        
;    1063         char i,j;
;    1064         i = 1;
	SBIW R28,3
	CALL __SAVELOCR4
;	*p -> Y+7
;	data -> Y+4
;	*pdata -> R16,R17
;	i -> R18
;	j -> R19
	LDI  R18,LOW(1)
;    1065         j = 0;
	LDI  R19,LOW(0)
;    1066         do
_0x6B:
;    1067           {        
;    1068                  pdata = &data[0];        
	MOVW R30,R28
	ADIW R30,4
	__PUTW1R 16,17
;    1069                  data[0]= 0xD0;
	LDI  R30,LOW(208)
	STD  Y+4,R30
;    1070                  data[1]= 0x24;                             
	LDI  R30,LOW(36)
	STD  Y+5,R30
;    1071                  if (i2c_tran(pdata,2))
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(2)
	ST   -Y,R30
	CALL _i2c_tran
	CPI  R30,0
	BREQ _0x6D
;    1072                    {             
;    1073                       if(i2c_rd(data[0],pdata,2))   
	LDD  R30,Y+4
	ST   -Y,R30
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(2)
	ST   -Y,R30
	CALL _i2c_rd
	CPI  R30,0
	BREQ _0x6E
;    1074                       { 
;    1075                                p[j] = data[0];  
	MOV  R30,R19
	LDD  R26,Y+7
	LDD  R27,Y+7+1
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	LDD  R26,Y+4
	STD  Z+0,R26
;    1076                                //printf("R 24-0x%x    ",data[0]);
;    1077                                j = 1;
	LDI  R19,LOW(1)
;    1078                           
;    1079                                 i=0;
	LDI  R18,LOW(0)
;    1080                                
;    1081                       }
;    1082                    }                       
_0x6E:
;    1083             }  
_0x6D:
;    1084        while(i) ;
	CPI  R18,0
	BRNE _0x6B
;    1085          
;    1086        i=1; 
	LDI  R18,LOW(1)
;    1087        do
_0x70:
;    1088           {         
;    1089                  pdata = &data[0];        
	MOVW R30,R28
	ADIW R30,4
	__PUTW1R 16,17
;    1090                  data[0]= 0xD0;
	LDI  R30,LOW(208)
	STD  Y+4,R30
;    1091                  data[1]= 0x1E;                     
	LDI  R30,LOW(30)
	STD  Y+5,R30
;    1092                  if (i2c_tran(pdata,2))
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(2)
	ST   -Y,R30
	CALL _i2c_tran
	CPI  R30,0
	BREQ _0x72
;    1093                    {  
;    1094                          if(i2c_rd(data[0],pdata,2))   
	LDD  R30,Y+4
	ST   -Y,R30
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(2)
	ST   -Y,R30
	CALL _i2c_rd
	CPI  R30,0
	BREQ _0x73
;    1095                          {       
;    1096                               p[j] = data[0];
	MOV  R30,R19
	LDD  R26,Y+7
	LDD  R27,Y+7+1
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	LDD  R26,Y+4
	STD  Z+0,R26
;    1097                               //printf("R 1E-0x%x\n",data[0]);                                          
;    1098                               i=0; 
	LDI  R18,LOW(0)
;    1099                                 
;    1100                          }
;    1101                    }                  
_0x73:
;    1102           } 
_0x72:
;    1103        while(i) ; 
	CPI  R18,0
	BRNE _0x70
;    1104   
;    1105   } 
	CALL __LOADLOCR4
	ADIW R28,9
	RET
;    1106    
;    1107 
;    1108 char locked(void)   
;    1109 { 
_locked:
;    1110     char t[2];
;    1111     getstus(t); 
	SBIW R28,2
;	t -> Y+0
	MOVW R30,R28
	ST   -Y,R31
	ST   -Y,R30
	CALL _getstus
;    1112 
;    1113 
;    1114     if(((t[0] & 0x80) == 0x80) && ((t[1] & 0x80) == 0x80))
	LD   R30,Y
	ANDI R30,LOW(0x80)
	CPI  R30,LOW(0x80)
	BRNE _0x75
	LDD  R30,Y+1
	ANDI R30,LOW(0x80)
	CPI  R30,LOW(0x80)
	BREQ _0x76
_0x75:
	RJMP _0x74
_0x76:
;    1115     { 
;    1116         LED2_ON;
	CBI  0x12,6
;    1117         return 1;             
	LDI  R30,LOW(1)
	RJMP _0x105
;    1118     }
;    1119     else   
_0x74:
;    1120     {
;    1121        STV0288Init();          
	CALL _STV0288Init
;    1122        LED2_OFF;
	SBI  0x12,6
;    1123        return 0;         
	LDI  R30,LOW(0)
;    1124     }
;    1125 
;    1126  }
_0x105:
	ADIW R28,2
	RET
;    1127  
;    1128 unsigned char Get0288Register(unsigned char addr)
;    1129 {
_Get0288Register:
;    1130     char data[3];
;    1131     char *pdata; 
;    1132     pdata = &data[0]; 
	SBIW R28,3
	ST   -Y,R17
	ST   -Y,R16
;	addr -> Y+5
;	data -> Y+2
;	*pdata -> R16,R17
	MOVW R30,R28
	ADIW R30,2
	__PUTW1R 16,17
;    1133     data[0]= 0xD0;
	LDI  R30,LOW(208)
	STD  Y+2,R30
;    1134     data[1]= addr;
	LDD  R30,Y+5
	STD  Y+3,R30
;    1135     if (i2c_tran(pdata,2))
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(2)
	ST   -Y,R30
	CALL _i2c_tran
	CPI  R30,0
	BREQ _0x78
;    1136       {   
;    1137        if(i2c_rd(data[0],pdata,1))   
	LDD  R30,Y+2
	ST   -Y,R30
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(1)
	ST   -Y,R30
	CALL _i2c_rd
	CPI  R30,0
	BREQ _0x79
;    1138           {   
;    1139            return data[0];
	LDD  R30,Y+2
;    1140           }
;    1141       }       
_0x79:
;    1142 }
_0x78:
_0x104:
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,6
	RET
;    1143   
;    1144 unsigned int GetAGC()
;    1145 {               
_GetAGC:
;    1146     unsigned int AGC2;   
;    1147     char data[2];
;    1148     char *pdata; 
;    1149     pdata = &data[0]; 
	SBIW R28,2
	CALL __SAVELOCR4
;	AGC2 -> R16,R17
;	data -> Y+4
;	*pdata -> R18,R19
	MOVW R30,R28
	ADIW R30,4
	__PUTW1R 18,19
;    1150     data[0]= 0xD0;
	LDI  R30,LOW(208)
	STD  Y+4,R30
;    1151     data[1]= 0x20;
	LDI  R30,LOW(32)
	STD  Y+5,R30
;    1152     if (i2c_tran(pdata,2))
	ST   -Y,R19
	ST   -Y,R18
	LDI  R30,LOW(2)
	ST   -Y,R30
	CALL _i2c_tran
	CPI  R30,0
	BREQ _0x7A
;    1153       {   
;    1154        if(i2c_rd(data[0],pdata,2))   
	LDD  R30,Y+4
	ST   -Y,R30
	ST   -Y,R19
	ST   -Y,R18
	LDI  R30,LOW(2)
	ST   -Y,R30
	CALL _i2c_rd
	CPI  R30,0
	BREQ _0x7B
;    1155           {   
;    1156            AGC2 = data[0]*256 + data[1];
	LDD  R26,Y+4
	LDI  R27,0
	LDI  R30,LOW(256)
	LDI  R31,HIGH(256)
	CALL __MULW12U
	MOVW R26,R30
	LDD  R30,Y+5
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	__PUTW1R 16,17
;    1157            return AGC2;
	__GETW1R 16,17
;    1158           }
;    1159       }       
_0x7B:
;    1160 }
_0x7A:
_0x103:
	CALL __LOADLOCR4
	ADIW R28,6
	RET
;    1161 
;    1162   
;    1163 unsigned char Set0288Register(unsigned char addr,unsigned char dat,)
;    1164 {
_Set0288Register:
;    1165     char data[3];
;    1166     char *pdata; 
;    1167     pdata = &data[0]; 
	SBIW R28,3
	ST   -Y,R17
	ST   -Y,R16
;	addr -> Y+6
;	dat -> Y+5
;	data -> Y+2
;	*pdata -> R16,R17
	MOVW R30,R28
	ADIW R30,2
	__PUTW1R 16,17
;    1168     data[0]= 0xD0;
	LDI  R30,LOW(208)
	STD  Y+2,R30
;    1169     data[1]= addr; 
	LDD  R30,Y+6
	STD  Y+3,R30
;    1170     data[2]= dat;       
	LDD  R30,Y+5
	STD  Y+4,R30
;    1171     i2c_tran(pdata,3);
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(3)
	ST   -Y,R30
	CALL _i2c_tran
;    1172     
;    1173     
;    1174     if (i2c_tran(pdata,2))
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(2)
	ST   -Y,R30
	CALL _i2c_tran
	CPI  R30,0
	BREQ _0x7C
;    1175       {   
;    1176        if(i2c_rd(data[0],pdata,1))   
	LDD  R30,Y+2
	ST   -Y,R30
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(1)
	ST   -Y,R30
	CALL _i2c_rd
	CPI  R30,0
	BREQ _0x7D
;    1177           {   
;    1178            return data[0];
	LDD  R30,Y+2
;    1179           }
;    1180       }       
_0x7D:
;    1181 }
_0x7C:
_0x102:
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,7
	RET
;    1182   
;    1183   
;    1184   
;    1185 unsigned char pll_lk(void)
;    1186   {
_pll_lk:
;    1187       unsigned char byte[1] = {0xc0},i = 0; 
;    1188       
;    1189       EnableTunerOperation();
	SBIW R28,1
	LDI  R24,1
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	LDI  R30,LOW(_0x7E*2)
	LDI  R31,HIGH(_0x7E*2)
	CALL __INITLOCB
	ST   -Y,R16
;	byte -> Y+1
;	i -> R16
	LDI  R16,0
	CALL _EnableTunerOperation
;    1190       do 
_0x80:
;    1191       {
;    1192           i2c_rd(byte[0],byte,1);
	LDD  R30,Y+1
	ST   -Y,R30
	MOVW R30,R28
	ADIW R30,2
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	CALL _i2c_rd
;    1193           i++;
	SUBI R16,-1
;    1194           if((byte[0] & 0x40) != 0)
	LDD  R30,Y+1
	ANDI R30,LOW(0x40)
	BREQ _0x82
;    1195           {
;    1196               //printf("pll locked:0x%x\n",byte[0]);
;    1197               DisableTunerOperation();
	CALL _DisableTunerOperation
;    1198               return 1;
	LDI  R30,LOW(1)
	RJMP _0x101
;    1199           }
;    1200           else
_0x82:
;    1201           {   
;    1202              printf("pll no locked:0x%x\n",byte[0]);
	__POINTW1FN _0,579
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+3
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	LDI  R24,4
	CALL _printf
	ADIW R28,6
;    1203           }
;    1204       }while(i < 3);
	CPI  R16,3
	BRLO _0x80
;    1205       DisableTunerOperation();
	CALL _DisableTunerOperation
;    1206       return 0;
	LDI  R30,LOW(0)
_0x101:
	LDD  R16,Y+0
	ADIW R28,2
	RET
;    1207 }                            
;    1208 
;    1209 char Track()
;    1210 {          
_Track:
;    1211    unsigned int AGC,omgaX,omgaY;   
;    1212    
;    1213    while(!Rx0())  
	CALL __SAVELOCR6
;	AGC -> R16,R17
;	omgaX -> R18,R19
;	omgaY -> R20,R21
_0x84:
	CALL _Rx0
	CPI  R30,0
	BRNE _0x86
;    1214       {
;    1215          while(!(TIFR & 0x01))       //wait TC0    125Hz
_0x87:
	IN   R30,0x36
	ANDI R30,LOW(0x1)
	BREQ _0x87
;    1216                 ;
;    1217          TIFR = TIFR | 0x01;         //clear TOV0
	IN   R30,0x36
	ORI  R30,1
	OUT  0x36,R30
;    1218          TCNT0=0x82;                 //init timer from 130
	LDI  R30,LOW(130)
	OUT  0x32,R30
;    1219          
;    1220          AGC = GetAGC();          //read agc number
	CALL _GetAGC
	__PUTW1R 16,17
;    1221          omgaX = ANLG_A;          //read X grro
	LDI  R30,LOW(5)
	ST   -Y,R30
	CALL _read_adc
	__PUTW1R 18,19
;    1222          omgaY = ANLG_B;          //read Y gyro
	LDI  R30,LOW(6)
	ST   -Y,R30
	CALL _read_adc
	__PUTW1R 20,21
;    1223          printf("%u %u %u %d\n",omgaX,omgaY,AGC,locked());
	__POINTW1FN _0,599
	ST   -Y,R31
	ST   -Y,R30
	__GETW1R 18,19
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	__GETW1R 20,21
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	__GETW1R 16,17
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	CALL _locked
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	LDI  R24,16
	CALL _printf
	ADIW R28,18
;    1224          //printf("%u %u \n",x,y);
;    1225       }       
	RJMP _0x84
_0x86:
;    1226   return  ;
	CALL __LOADLOCR6
	ADIW R28,6
	RET
;    1227 }
;    1228 
;    1229 
;    1230         

_labs:
    ld    r30,y+
    ld    r31,y+
    ld    r22,y+
    ld    r23,y+
    sbiw  r30,0
    sbci  r22,0
    sbci  r23,0
    brpl  __labs0
    com   r30
    com   r31
    com   r22
    com   r23
    clr   r0
    adiw  r30,1
    adc   r22,r0
    adc   r23,r0
__labs0:
    ret
_putchar:
     sbis usr,udre
     rjmp _putchar
     ld   r30,y
     out  udr,r30
	ADIW R28,1
	RET
__put_G7:
	put:
	LD   R26,Y
	LDD  R27,Y+1
	CALL __GETW1P
	SBIW R30,0
	BREQ _0x8A
	CALL __GETW1P
	ADIW R30,1
	ST   X+,R30
	ST   X,R31
	SBIW R30,1
	LDD  R26,Y+2
	STD  Z+0,R26
	RJMP _0x8B
_0x8A:
	LDD  R30,Y+2
	ST   -Y,R30
	CALL _putchar
_0x8B:
	ADIW R28,3
	RET
__print_sign_G7:
    ;flags&=~F_SIGNED
    andi r17,~4
    ;_put(s,ptr_ps)
    ldd  r30,y+17
    st   -y,r30
    ldd  r30,y+19
    ldd  r31,y+20
    st   -y,r31
    st   -y,r30
    rcall put
    ;if (width) --width
    cpi  r20,0
    breq width0
    dec  r20
width0:
	RET
__print_G7:
	SBIW R28,12
	CALL __SAVELOCR6
	LDI  R16,0
_0x8C:
	LDD  R30,Y+22
	LDD  R31,Y+22+1
	ADIW R30,1
	STD  Y+22,R30
	STD  Y+22+1,R31
	SBIW R30,1
	LPM  R30,Z
	MOV  R19,R30
	CPI  R30,0
	BRNE PC+3
	JMP _0x8E
	MOV  R30,R16
	CPI  R30,0
	BRNE _0x92
	CPI  R19,37
	BRNE _0x93
	LDI  R16,LOW(1)
	RJMP _0x94
_0x93:
	ST   -Y,R19
	LDD  R30,Y+19
	LDD  R31,Y+19+1
	ST   -Y,R31
	ST   -Y,R30
	CALL __put_G7
_0x94:
	RJMP _0x91
_0x92:
	CPI  R30,LOW(0x1)
	BRNE _0x95
	CPI  R19,37
	BRNE _0x96
	ST   -Y,R19
	LDD  R30,Y+19
	LDD  R31,Y+19+1
	ST   -Y,R31
	ST   -Y,R30
	CALL __put_G7
	LDI  R16,LOW(0)
	RJMP _0x91
_0x96:
	LDI  R16,LOW(2)
	LDI  R30,LOW(0)
	STD  Y+17,R30
	LDI  R17,LOW(0)
	CPI  R19,45
	BRNE _0x97
	LDI  R17,LOW(1)
	RJMP _0x91
_0x97:
	CPI  R19,43
	BRNE _0x98
	LDI  R30,LOW(43)
	STD  Y+17,R30
	RJMP _0x91
_0x98:
	CPI  R19,32
	BRNE _0x99
	LDI  R30,LOW(32)
	STD  Y+17,R30
	RJMP _0x91
_0x99:
	RJMP _0x9A
_0x95:
	CPI  R30,LOW(0x2)
	BRNE _0x9B
_0x9A:
	LDI  R20,LOW(0)
	LDI  R16,LOW(3)
	CPI  R19,48
	BRNE _0x9C
	ORI  R17,LOW(128)
	RJMP _0x91
_0x9C:
	RJMP _0x9D
_0x9B:
	CPI  R30,LOW(0x3)
	BRNE _0x9E
_0x9D:
	CPI  R19,48
	BRLO _0xA0
	CPI  R19,58
	BRLO _0xA1
_0xA0:
	RJMP _0x9F
_0xA1:
	MOV  R26,R20
	LDI  R30,LOW(10)
	MUL  R30,R26
	MOV  R30,R0
	MOV  R20,R30
	MOV  R30,R19
	SUBI R30,LOW(48)
	ADD  R20,R30
	RJMP _0x91
_0x9F:
	LDI  R21,LOW(0)
	CPI  R19,46
	BRNE _0xA2
	LDI  R16,LOW(4)
	RJMP _0x91
_0xA2:
	RJMP _0xA3
_0x9E:
	CPI  R30,LOW(0x4)
	BRNE _0xA5
	CPI  R19,48
	BRLO _0xA7
	CPI  R19,58
	BRLO _0xA8
_0xA7:
	RJMP _0xA6
_0xA8:
	MOV  R26,R21
	LDI  R30,LOW(10)
	MUL  R30,R26
	MOV  R30,R0
	MOV  R21,R30
	MOV  R30,R19
	SUBI R30,LOW(48)
	ADD  R21,R30
	RJMP _0x91
_0xA6:
_0xA3:
	CPI  R19,108
	BRNE _0xA9
	ORI  R17,LOW(2)
	LDI  R16,LOW(5)
	RJMP _0x91
_0xA9:
	RJMP _0xAA
_0xA5:
	CPI  R30,LOW(0x5)
	BREQ PC+3
	JMP _0x91
_0xAA:
	MOV  R30,R19
	CPI  R30,LOW(0x63)
	BRNE _0xAF
	LDD  R26,Y+20
	LDD  R27,Y+20+1
	SBIW R26,4
	STD  Y+20,R26
	STD  Y+20+1,R27
	ADIW R26,4
	LD   R30,X
	ST   -Y,R30
	LDD  R30,Y+19
	LDD  R31,Y+19+1
	ST   -Y,R31
	ST   -Y,R30
	CALL __put_G7
	RJMP _0xB0
_0xAF:
	CPI  R30,LOW(0x73)
	BRNE _0xB2
	LDD  R26,Y+20
	LDD  R27,Y+20+1
	SBIW R26,4
	STD  Y+20,R26
	STD  Y+20+1,R27
	ADIW R26,4
	CALL __GETW1P
	STD  Y+6,R30
	STD  Y+6+1,R31
	ST   -Y,R31
	ST   -Y,R30
	CALL _strlen
	MOV  R16,R30
	RJMP _0xB3
_0xB2:
	CPI  R30,LOW(0x70)
	BRNE _0xB5
	LDD  R26,Y+20
	LDD  R27,Y+20+1
	SBIW R26,4
	STD  Y+20,R26
	STD  Y+20+1,R27
	ADIW R26,4
	CALL __GETW1P
	STD  Y+6,R30
	STD  Y+6+1,R31
	ST   -Y,R31
	ST   -Y,R30
	CALL _strlenf
	MOV  R16,R30
	ORI  R17,LOW(8)
_0xB3:
	ANDI R17,LOW(127)
	CPI  R21,0
	BREQ _0xB7
	CP   R21,R16
	BRLO _0xB8
_0xB7:
	RJMP _0xB6
_0xB8:
	MOV  R16,R21
_0xB6:
	LDI  R21,LOW(0)
	LDI  R30,LOW(0)
	STD  Y+16,R30
	LDI  R18,LOW(0)
	RJMP _0xB9
_0xB5:
	CPI  R30,LOW(0x64)
	BREQ _0xBC
	CPI  R30,LOW(0x69)
	BRNE _0xBD
_0xBC:
	ORI  R17,LOW(4)
	RJMP _0xBE
_0xBD:
	CPI  R30,LOW(0x75)
	BRNE _0xBF
_0xBE:
	LDI  R30,LOW(10)
	STD  Y+16,R30
	SBRS R17,1
	RJMP _0xC0
	__GETD1N 0x3B9ACA00
	__PUTD1S 8
	LDI  R16,LOW(10)
	RJMP _0xC1
_0xC0:
	__GETD1N 0x2710
	__PUTD1S 8
	LDI  R16,LOW(5)
	RJMP _0xC1
_0xBF:
	CPI  R30,LOW(0x58)
	BRNE _0xC3
	ORI  R17,LOW(8)
	RJMP _0xC4
_0xC3:
	CPI  R30,LOW(0x78)
	BREQ PC+3
	JMP _0x100
_0xC4:
	LDI  R30,LOW(16)
	STD  Y+16,R30
	SBRS R17,1
	RJMP _0xC6
	__GETD1N 0x10000000
	__PUTD1S 8
	LDI  R16,LOW(8)
	RJMP _0xC1
_0xC6:
	__GETD1N 0x1000
	__PUTD1S 8
	LDI  R16,LOW(4)
_0xC1:
	CPI  R21,0
	BREQ _0xC7
	ANDI R17,LOW(127)
	RJMP _0xC8
_0xC7:
	LDI  R21,LOW(1)
_0xC8:
	SBRS R17,1
	RJMP _0xC9
	LDD  R26,Y+20
	LDD  R27,Y+20+1
	SBIW R26,4
	STD  Y+20,R26
	STD  Y+20+1,R27
	ADIW R26,4
	CALL __GETD1P
	__PUTD1S 12
	RJMP _0xCA
_0xC9:
	SBRS R17,2
	RJMP _0xCB
	LDD  R26,Y+20
	LDD  R27,Y+20+1
	SBIW R26,4
	STD  Y+20,R26
	STD  Y+20+1,R27
	ADIW R26,4
	CALL __GETW1P
	CALL __CWD1
	RJMP _0x10D
_0xCB:
	LDD  R26,Y+20
	LDD  R27,Y+20+1
	SBIW R26,4
	STD  Y+20,R26
	STD  Y+20+1,R27
	ADIW R26,4
	CALL __GETW1P
	CLR  R22
	CLR  R23
_0x10D:
	__PUTD1S 12
_0xCA:
	SBRS R17,2
	RJMP _0xCD
	__GETD2S 12
	CALL __CPD20
	BRGE _0xCE
	__GETD1S 12
	CALL __ANEGD1
	__PUTD1S 12
	LDI  R30,LOW(45)
	STD  Y+17,R30
_0xCE:
	LDD  R30,Y+17
	CPI  R30,0
	BREQ _0xCF
	SUBI R16,-LOW(1)
	SUBI R21,-LOW(1)
	RJMP _0xD0
_0xCF:
	ANDI R17,LOW(251)
_0xD0:
_0xCD:
	MOV  R18,R21
_0xB9:
	SBRC R17,0
	RJMP _0xD1
_0xD2:
	CP   R16,R20
	BRSH _0xD5
	CP   R18,R20
	BRLO _0xD6
_0xD5:
	RJMP _0xD4
_0xD6:
	SBRS R17,7
	RJMP _0xD7
	SBRS R17,2
	RJMP _0xD8
	ANDI R17,LOW(251)
	LDD  R19,Y+17
	SUBI R16,LOW(1)
	RJMP _0xD9
_0xD8:
	LDI  R19,LOW(48)
_0xD9:
	RJMP _0xDA
_0xD7:
	LDI  R19,LOW(32)
_0xDA:
	ST   -Y,R19
	LDD  R30,Y+19
	LDD  R31,Y+19+1
	ST   -Y,R31
	ST   -Y,R30
	CALL __put_G7
	SUBI R20,LOW(1)
	RJMP _0xD2
_0xD4:
_0xD1:
_0xDB:
	CP   R16,R21
	BRSH _0xDD
	ORI  R17,LOW(16)
	SBRS R17,2
	RJMP _0xDE
	CALL __print_sign_G7
	SUBI R16,LOW(1)
	SUBI R21,LOW(1)
_0xDE:
	LDI  R30,LOW(48)
	ST   -Y,R30
	LDD  R30,Y+19
	LDD  R31,Y+19+1
	ST   -Y,R31
	ST   -Y,R30
	CALL __put_G7
	CPI  R20,0
	BREQ _0xDF
	SUBI R20,LOW(1)
_0xDF:
	SUBI R21,LOW(1)
	RJMP _0xDB
_0xDD:
	MOV  R18,R16
	LDD  R30,Y+16
	CPI  R30,0
	BRNE _0xE0
_0xE1:
	CPI  R18,0
	BREQ _0xE3
	SBRS R17,3
	RJMP _0xE4
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,1
	STD  Y+6,R30
	STD  Y+6+1,R31
	SBIW R30,1
	LPM  R30,Z
	RJMP _0x10E
_0xE4:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LD   R30,X+
	STD  Y+6,R26
	STD  Y+6+1,R27
_0x10E:
	ST   -Y,R30
	LDD  R30,Y+19
	LDD  R31,Y+19+1
	ST   -Y,R31
	ST   -Y,R30
	CALL __put_G7
	CPI  R20,0
	BREQ _0xE6
	SUBI R20,LOW(1)
_0xE6:
	SUBI R18,LOW(1)
	RJMP _0xE1
_0xE3:
	RJMP _0xE7
_0xE0:
_0xE9:
	__GETD1S 8
	__GETD2S 12
	CALL __DIVD21U
	MOV  R19,R30
	LDI  R30,LOW(9)
	CP   R30,R19
	BRSH _0xEB
	SBRS R17,3
	RJMP _0xEC
	SUBI R19,-LOW(55)
	RJMP _0xED
_0xEC:
	SUBI R19,-LOW(87)
_0xED:
	RJMP _0xEE
_0xEB:
	SUBI R19,-LOW(48)
_0xEE:
	SBRC R17,4
	RJMP _0xF0
	LDI  R30,LOW(48)
	CP   R30,R19
	BRLO _0xF2
	__GETD2S 8
	__CPD2N 0x1
	BRNE _0xF1
_0xF2:
	RJMP _0xF4
_0xF1:
	CP   R21,R18
	BRLO _0xF5
	LDI  R19,LOW(48)
	RJMP _0xF4
_0xF5:
	CP   R20,R18
	BRLO _0xF7
	SBRS R17,0
	RJMP _0xF8
_0xF7:
	RJMP _0xF6
_0xF8:
	LDI  R19,LOW(32)
	SBRS R17,7
	RJMP _0xF9
	LDI  R19,LOW(48)
_0xF4:
	ORI  R17,LOW(16)
	SBRS R17,2
	RJMP _0xFA
	CALL __print_sign_G7
_0xFA:
_0xF9:
_0xF0:
	ST   -Y,R19
	LDD  R30,Y+19
	LDD  R31,Y+19+1
	ST   -Y,R31
	ST   -Y,R30
	CALL __put_G7
	CPI  R20,0
	BREQ _0xFB
	SUBI R20,LOW(1)
_0xFB:
_0xF6:
	SUBI R18,LOW(1)
	__GETD1S 8
	__GETD2S 12
	CALL __MODD21U
	__PUTD1S 12
	LDD  R30,Y+16
	__GETD2S 8
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __DIVD21U
	__PUTD1S 8
	CALL __CPD10
	BREQ _0xEA
	RJMP _0xE9
_0xEA:
_0xE7:
	SBRS R17,0
	RJMP _0xFC
_0xFD:
	CPI  R20,0
	BREQ _0xFF
	SUBI R20,LOW(1)
	LDI  R30,LOW(32)
	ST   -Y,R30
	LDD  R30,Y+19
	LDD  R31,Y+19+1
	ST   -Y,R31
	ST   -Y,R30
	CALL __put_G7
	RJMP _0xFD
_0xFF:
_0xFC:
_0x100:
_0xB0:
	LDI  R16,LOW(0)
_0x91:
	RJMP _0x8C
_0x8E:
	CALL __LOADLOCR6
	ADIW R28,24
	RET
_printf:
	PUSH R15
	MOV  R15,R24
	SBIW R28,2
	ST   -Y,R17
	ST   -Y,R16
	MOVW R26,R28
	CALL __ADDW2R15
	__PUTW2R 16,17
	LDI  R30,0
	STD  Y+2,R30
	STD  Y+2+1,R30
	MOVW R26,R28
	ADIW R26,4
	CALL __ADDW2R15
	CALL __GETW1P
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R17
	ST   -Y,R16
	MOVW R30,R28
	ADIW R30,6
	ST   -Y,R31
	ST   -Y,R30
	RCALL __print_G7
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,4
	POP  R15
	RET

_strlen:
	ld   r26,y+
	ld   r27,y+
	clr  r30
	clr  r31
__strlen0:
	ld   r22,x+
	tst  r22
	breq __strlen1
	adiw r30,1
	rjmp __strlen0
__strlen1:
	ret

_strlenf:
	clr  r26
	clr  r27
	ld   r30,y+
	ld   r31,y+
__strlenf0:
	lpm  r0,z+
	tst  r0
	breq __strlenf1
	adiw r26,1
	rjmp __strlenf0
__strlenf1:
	movw r30,r26
	ret

_delay_ms:
	ld   r30,y+
	ld   r31,y+
	adiw r30,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0xFA0
	wdr
	sbiw r30,1
	brne __delay_ms0
__delay_ms1:
	ret

__ADDW2R15:
	CLR  R0
	ADD  R26,R15
	ADC  R27,R0
	RET

__ADDD21:
	ADD  R26,R30
	ADC  R27,R31
	ADC  R24,R22
	ADC  R25,R23
	RET

__SUBD12:
	SUB  R30,R26
	SBC  R31,R27
	SBC  R22,R24
	SBC  R23,R25
	RET

__ANEGD1:
	COM  R30
	COM  R31
	COM  R22
	COM  R23
	SUBI R30,-1
	SBCI R31,-1
	SBCI R22,-1
	SBCI R23,-1
	RET

__LSLW12:
	TST  R30
	MOV  R0,R30
	MOVW R30,R26
	BREQ __LSLW12R
__LSLW12L:
	LSL  R30
	ROL  R31
	DEC  R0
	BRNE __LSLW12L
__LSLW12R:
	RET

__LSLD12:
	TST  R30
	MOV  R0,R30
	MOVW R30,R26
	MOVW R22,R24
	BREQ __LSLD12R
__LSLD12L:
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R23
	DEC  R0
	BRNE __LSLD12L
__LSLD12R:
	RET

__ASRD12:
	TST  R30
	MOV  R0,R30
	MOVW R30,R26
	MOVW R22,R24
	BREQ __ASRD12R
__ASRD12L:
	ASR  R23
	ROR  R22
	ROR  R31
	ROR  R30
	DEC  R0
	BRNE __ASRD12L
__ASRD12R:
	RET

__LSLW4:
	LSL  R30
	ROL  R31
__LSLW3:
	LSL  R30
	ROL  R31
__LSLW2:
	LSL  R30
	ROL  R31
	LSL  R30
	ROL  R31
	RET

__LSRW3:
	LSR  R31
	ROR  R30
__LSRW2:
	LSR  R31
	ROR  R30
	LSR  R31
	ROR  R30
	RET

__CWD1:
	MOV  R22,R31
	ADD  R22,R22
	SBC  R22,R22
	MOV  R23,R22
	RET

__MULW12U:
	MUL  R31,R26
	MOV  R31,R0
	MUL  R30,R27
	ADD  R31,R0
	MUL  R30,R26
	MOV  R30,R0
	ADD  R31,R1
	RET

__MULD12U:
	MUL  R23,R26
	MOV  R23,R0
	MUL  R22,R27
	ADD  R23,R0
	MUL  R31,R24
	ADD  R23,R0
	MUL  R30,R25
	ADD  R23,R0
	MUL  R22,R26
	MOV  R22,R0
	ADD  R23,R1
	MUL  R31,R27
	ADD  R22,R0
	ADC  R23,R1
	MUL  R30,R24
	ADD  R22,R0
	ADC  R23,R1
	CLR  R24
	MUL  R31,R26
	MOV  R31,R0
	ADD  R22,R1
	ADC  R23,R24
	MUL  R30,R27
	ADD  R31,R0
	ADC  R22,R1
	ADC  R23,R24
	MUL  R30,R26
	MOV  R30,R0
	ADD  R31,R1
	ADC  R22,R24
	ADC  R23,R24
	RET

__DIVD21U:
	PUSH R19
	PUSH R20
	PUSH R21
	CLR  R0
	CLR  R1
	CLR  R19
	CLR  R20
	LDI  R21,32
__DIVD21U1:
	LSL  R26
	ROL  R27
	ROL  R24
	ROL  R25
	ROL  R0
	ROL  R1
	ROL  R19
	ROL  R20
	SUB  R0,R30
	SBC  R1,R31
	SBC  R19,R22
	SBC  R20,R23
	BRCC __DIVD21U2
	ADD  R0,R30
	ADC  R1,R31
	ADC  R19,R22
	ADC  R20,R23
	RJMP __DIVD21U3
__DIVD21U2:
	SBR  R26,1
__DIVD21U3:
	DEC  R21
	BRNE __DIVD21U1
	MOVW R30,R26
	MOVW R22,R24
	MOVW R26,R0
	MOV  R24,R19
	MOV  R25,R20
	POP  R21
	POP  R20
	POP  R19
	RET

__DIVD21:
	RCALL __CHKSIGND
	RCALL __DIVD21U
	BRTC __DIVD211
	RCALL __ANEGD1
__DIVD211:
	RET

__MODD21U:
	RCALL __DIVD21U
	MOVW R30,R26
	MOVW R22,R24
	RET

__CHKSIGND:
	CLT
	SBRS R23,7
	RJMP __CHKSD1
	RCALL __ANEGD1
	SET
__CHKSD1:
	SBRS R25,7
	RJMP __CHKSD2
	CLR  R0
	COM  R26
	COM  R27
	COM  R24
	COM  R25
	ADIW R26,1
	ADC  R24,R0
	ADC  R25,R0
	BLD  R0,0
	INC  R0
	BST  R0,0
__CHKSD2:
	RET

__GETW1P:
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	RET

__GETD1P:
	LD   R30,X+
	LD   R31,X+
	LD   R22,X+
	LD   R23,X
	SBIW R26,3
	RET

__PUTDP1:
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	RET

__GETD1PF:
	LPM  R0,Z+
	LPM  R1,Z+
	LPM  R22,Z+
	LPM  R23,Z
	MOVW R30,R0
	RET

__PUTPARD1:
	ST   -Y,R23
	ST   -Y,R22
	ST   -Y,R31
	ST   -Y,R30
	RET

__SWAPD12:
	MOV  R1,R24
	MOV  R24,R22
	MOV  R22,R1
	MOV  R1,R25
	MOV  R25,R23
	MOV  R23,R1

__SWAPW12:
	MOV  R1,R27
	MOV  R27,R31
	MOV  R31,R1

__SWAPB12:
	MOV  R1,R26
	MOV  R26,R30
	MOV  R30,R1
	RET

__REPACK:
	LDI  R21,0x80
	EOR  R21,R23
	BRNE __REPACK0
	PUSH R21
	RJMP __ZERORES
__REPACK0:
	CPI  R21,0xFF
	BREQ __REPACK1
	LSL  R22
	LSL  R0
	ROR  R21
	ROR  R22
	MOV  R23,R21
	RET
__REPACK1:
	PUSH R21
	TST  R0
	BRMI __REPACK2
	RJMP __MAXRES
__REPACK2:
	RJMP __MINRES

__UNPACK:
	LDI  R21,0x80
	MOV  R1,R25
	AND  R1,R21
	LSL  R24
	ROL  R25
	EOR  R25,R21
	LSL  R21
	ROR  R24

__UNPACK1:
	LDI  R21,0x80
	MOV  R0,R23
	AND  R0,R21
	LSL  R22
	ROL  R23
	EOR  R23,R21
	LSL  R21
	ROR  R22
	RET

__CFD1:
	PUSH R21
	RCALL __UNPACK1
	CPI  R23,0x80
	BRLO __CFD10
	CPI  R23,0xFF
	BRCC __CFD10
	RJMP __ZERORES
__CFD10:
	LDI  R21,22
	SUB  R21,R23
	BRPL __CFD11
	NEG  R21
	CPI  R21,8
	BRLO __CFD17
	SER  R30
	SER  R31
	SER  R22
	LDI  R23,0x7F
	RJMP __CFD15
__CFD17:
	CLR  R23
	TST  R21
	BREQ __CFD15
__CFD18:
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R23
	DEC  R21
	BRNE __CFD18
	RJMP __CFD15
__CFD11:
	CLR  R23
__CFD12:
	CPI  R21,8
	BRLO __CFD13
	MOV  R30,R31
	MOV  R31,R22
	MOV  R22,R23
	SUBI R21,8
	RJMP __CFD12
__CFD13:
	TST  R21
	BREQ __CFD15
__CFD14:
	LSR  R23
	ROR  R22
	ROR  R31
	ROR  R30
	DEC  R21
	BRNE __CFD14
__CFD15:
	TST  R0
	BRPL __CFD16
	RCALL __ANEGD1
__CFD16:
	POP  R21
	RET

__CDF1U:
	SET
	RJMP __CDF1U0
__CDF1:
	CLT
__CDF1U0:
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	BREQ __CDF10
	CLR  R0
	BRTS __CDF11
	TST  R23
	BRPL __CDF11
	COM  R0
	RCALL __ANEGD1
__CDF11:
	MOV  R1,R23
	LDI  R23,30
	TST  R1
__CDF12:
	BRMI __CDF13
	DEC  R23
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R1
	RJMP __CDF12
__CDF13:
	MOV  R30,R31
	MOV  R31,R22
	MOV  R22,R1
	PUSH R21
	RCALL __REPACK
	POP  R21
__CDF10:
	RET

__MINRES:
	SER  R30
	SER  R31
	LDI  R22,0x7F
	SER  R23
	POP  R21
	RET

__ZERORES:
	CLR  R30
	CLR  R31
	CLR  R22
	CLR  R23
	POP  R21
	RET

__MAXRES:
	SER  R30
	SER  R31
	LDI  R22,0x7F
	LDI  R23,0x7F
	POP  R21
	RET

__MULF12:
	PUSH R21
	RCALL __UNPACK
	CPI  R23,0x80
	BREQ __ZERORES
	CPI  R25,0x80
	BREQ __ZERORES
	EOR  R0,R1
	SEC
	ADC  R23,R25
	BRVC __MULF124
	BRLT __ZERORES
__MULF125:
	TST  R0
	BRMI __MINRES
	RJMP __MAXRES
__MULF124:
	PUSH R19
	PUSH R20
	CLR  R1
	CLR  R19
	CLR  R20
	CLR  R21
	LDI  R25,24
__MULF120:
	LSL  R19
	ROL  R20
	ROL  R21
	ROL  R30
	ROL  R31
	ROL  R22
	BRCC __MULF121
	ADD  R19,R26
	ADC  R20,R27
	ADC  R21,R24
	ADC  R30,R1
	ADC  R31,R1
	ADC  R22,R1
__MULF121:
	DEC  R25
	BRNE __MULF120
	POP  R20
	POP  R19
	TST  R22
	BRMI __MULF122
	LSL  R21
	ROL  R30
	ROL  R31
	ROL  R22
	RJMP __MULF123
__MULF122:
	INC  R23
	BRVS __MULF125
__MULF123:
	RCALL __REPACK
	POP  R21
	RET

__DIVF21:
	PUSH R21
	RCALL __UNPACK
	CPI  R23,0x80
	BRNE __DIVF210
	TST  R1
__DIVF211:
	BRPL __MAXRES
	RJMP __MINRES
__DIVF210:
	CPI  R25,0x80
	BRNE __DIVF218
__DIVF217:
	RJMP __ZERORES
__DIVF218:
	EOR  R0,R1
	SEC
	SBC  R25,R23
	BRVC __DIVF216
	BRLT __DIVF217
	TST  R0
	RJMP __DIVF211
__DIVF216:
	MOV  R23,R25
	LSR  R22
	ROR  R31
	ROR  R30
	LSR  R24
	ROR  R27
	ROR  R26
	PUSH R20
	CLR  R1
	CLR  R20
	CLR  R21
	LDI  R25,24
__DIVF212:
	CP   R26,R30
	CPC  R27,R31
	CPC  R24,R22
	BRLO __DIVF213
	SUB  R26,R30
	SBC  R27,R31
	SBC  R24,R22
	SEC
	RJMP __DIVF214
__DIVF213:
	CLC
__DIVF214:
	ROL  R1
	ROL  R20
	ROL  R21
	ROL  R26
	ROL  R27
	ROL  R24
	DEC  R25
	BRNE __DIVF212
	MOV  R30,R1
	MOV  R31,R20
	MOV  R22,R21
	LSR  R26
	ADC  R30,R25
	ADC  R31,R25
	ADC  R22,R25
	POP  R20
	TST  R22
	BRMI __DIVF215
	LSL  R30
	ROL  R31
	ROL  R22
	DEC  R23
	BRVS __DIVF217
__DIVF215:
	RCALL __REPACK
	POP  R21
	RET

__CPD10:
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	RET

__CPD20:
	SBIW R26,0
	SBCI R24,0
	SBCI R25,0
	RET

__CPD21:
	CP   R26,R30
	CPC  R27,R31
	CPC  R24,R22
	CPC  R25,R23
	RET

__SAVELOCR6:
	ST   -Y,R21
__SAVELOCR5:
	ST   -Y,R20
__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR6:
	LDD  R21,Y+5
__LOADLOCR5:
	LDD  R20,Y+4
__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

__INITLOCB:
__INITLOCW:
	ADD R26,R28
	ADC R27,R29
__INITLOC0:
	LPM  R0,Z+
	ST   X+,R0
	DEC  R24
	BRNE __INITLOC0
	RET

;END OF CODE MARKER
__END_OF_CODE:
