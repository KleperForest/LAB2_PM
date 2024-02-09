//*********************************************************************
// Universidad del Valle de Guatemala
// IE2023: Programación de Microcontroladores
// Autor: Alan Gomez
// Proyecto: Laboratorio 2.asm
// Descripción: Segundo Laboratorio de Programación de Microcontroladores. 
// Hardware: ATmega328p
// Created: 1/24/2024 5:38:40 PM
//*********************************************************************
// Encabezado
//*********************************************************************
.include "M328PDEF.inc"

.cseg; Comensamos con el segmento de Codigo. 
.org 0x00 ;Posicion 0
//*********************************************************************
// Stack Pointer
//*********************************************************************
LDI R16, LOW(RAMEND)// Ultima direccion de la memorio RAM 16bits
OUT SPL, R16 // Se colocara en el registro SPL
LDI R17, HIGH(RAMEND)// Seleccionamos la parte alta 
OUT SPH, R17 //Se colocara en el registro SPH
//*********************************************************************

//*********************************************************************
// Tabla de valores
//*********************************************************************
;TABLA7SEG: .DB 0x00,0xFC, 0x18, 0x6E, 0x3E, 0x9A, 0xB6;, 0xF6, 0x1C, 0xFE, 0x9E, 0xDE, 0xF2, 0xE4, 0x7A, 0xE6, 0xC6
TABLA7SEG: .DB 0x00,0xFC, 0x18, 0x6E, 0x3E, 0x9A, 0xB6, 0x1C, 0xFE, 0xF2, 0xE4, 0x7A, 0xE6
//*********************************************************************
//Configuracion MCU
//*********************************************************************
SETUP:

	; VELOCIDAD*****************************************************

	LDI R16, 0b1000_0000
	LDI R16, (1 << CLKPCE) 
	STS CLKPR, R16        // Habilitando el prescaler 

	LDI R16, 0b0000_0100
	STS CLKPR, R16   //Frecuencia 1MHz	 16/16 = 1
		
	;ENTRADAS Y SALIDAS*****************************************************

	LDI R16, 0xFF;Se configura PD2, PD3, PD4, PD5, PD6, y PD7 como 
	;Salidas
	OUT DDRD, R16

	LDI R16, 0b0000_0011; Se configuran PC0, PC1
	;Como entrada con pull up  
	OUT PORTC, R16

	;Apuntador Z***********************************
	 LDI ZL, LOW(TABLA7SEG << 1)
//*********************************************************************
//LOOP infinito
//*********************************************************************
LOOP:
	IN R16, PINC; Cargar a r16 los valores del purto C
	SBRS R16, PC0; Salta si el bit PC0 es 1
	RJMP INCREMET; Crecemos valor del Display
	
	IN R16, PINC;
	SBRS R16, PC1; Salta si el bit PC1 es 1
	RJMP DECREMET; Decrecemos valor del Display

	RJMP LOOP
//*********************************************************************
//Subutinas
//*********************************************************************
INCREMET:
	;Delay...................................................
	LDI R16, 255   //Cargar con un valor a R16
	delay:
		DEC R16 //Decrementa R16
		BRNE delay   //Si R16 no es igual a 0, tira al delay

	LDI R16, 255   //Cargar con un valor a R16
	delay2:
		DEC R16 //Decrementa R16
		BRNE delay2   //Si R16 no es igual a 0, tira al delay

	LDI R16, 255   //Cargar con un valor a R16
	delay3:
		DEC R16 //Decrementa R16
		BRNE delay3   //Si R16 no es igual a 0, tira al delay

	LDI R16, 255   //Cargar con un valor a R16
	delay4:
		DEC R16 //Decrementa R16
		BRNE delay4   //Si R16 no es igual a 0, tira al delay	
	;Delay...................................................

	ADIW Z,1// suma uno en z
	LPM R17,Z// indica a z
	OUT PORTD, R17// carga salida
	KL:// loop hasta que deje de presionar el boton
		IN R16, PINC
		SBRC R16, PC0
		RJMP LOOP

	RJMP KL

DECREMET:
	;Delay...................................................
	LDI R16, 255   //Cargar con un valor a R16
	delay5:
		DEC R16 //Decrementa R16
		BRNE delay5   //Si R16 no es igual a 0, tira al delay

	LDI R16, 255   //Cargar con un valor a R16
	delay6:
		DEC R16 //Decrementa R16
		BRNE delay6   //Si R16 no es igual a 0, tira al delay

	LDI R16, 255   //Cargar con un valor a R16
	delay7:
		DEC R16 //Decrementa R16
		BRNE delay7   //Si R16 no es igual a 0, tira al delay

	LDI R16, 255   //Cargar con un valor a R16
	delay8:
		DEC R16 //Decrementa R16
		BRNE delay8   //Si R16 no es igual a 0, tira al delay
	 ;Delay...................................................

	SBIW Z,1// resta uno en z
	LPM R18,Z// indica a z
	OUT PORTD, R18// carga saldia
	KL2:
		IN R16, PINC // loop hasta que deje de presionar boton
		SBRC R16, PC1
		RJMP LOOP

	
	

	


	
