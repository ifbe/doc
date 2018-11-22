#include "stc12c5a60s2.h"

typedef unsigned char BYTE;
typedef unsigned int WORD;

#define FOSC 11059200L      //System frequency
#define BAUD 9600           //UART baudrate

/*Define UART parity mode*/
#define NONE_PARITY     0   //None parity
#define ODD_PARITY      1   //Odd parity
#define EVEN_PARITY     2   //Even parity
#define MARK_PARITY     3   //Mark parity
#define SPACE_PARITY    4   //Space parity

#define PARITYBIT EVEN_PARITY   //Testing even parity

sbit bit9 = P2^2;           //P2.2 show UART data bit9
bit busy;




void SendData(BYTE dat)
{
    while (busy);           //Wait for the completion of the previous data is sent
    ACC = dat;              //Calculate the even parity bit P (PSW.0)
    if (P)                  //Set the parity bit according to P
    {
#if (PARITYBIT == ODD_PARITY)
        TB8 = 0;            //Set parity bit to 0
#elif (PARITYBIT == EVEN_PARITY)
        TB8 = 1;            //Set parity bit to 1
#endif
    }
    else
    {
#if (PARITYBIT == ODD_PARITY)
        TB8 = 1;            //Set parity bit to 1
#elif (PARITYBIT == EVEN_PARITY)
        TB8 = 0;            //Set parity bit to 0
#endif
    }
    busy = 1;
    SBUF = ACC;             //Send data to UART buffer
}
void SendString(char *s)
{
    while (*s)              //Check the end of the string
    {
        SendData(*s++);     //Send current char and increment string ptr
    }
}




void delay()
{
    int i, j;

    for (i=0; i<1000; i++)
    for (j=0; j<1000; j++);
}
void main()
{
	int t;
	char str[16];

	PCON &= 0x7F;
	SCON = 0x50;
	AUXR |= 0x04;
	BRT = 0xFD;
	AUXR |= 0x01;
	AUXR |= 0x10;
    ES = 1;
    EA = 1;

	while(1)
	{
		str[0] = (t&7)+0x30;
		str[1] = 0;

		SendString("STC12C5A60S2    ");
		SendString(str);
		SendString("\r\n");

		delay();
		t++;
	}
}




void Uart_Isr() interrupt 4
{
    if (RI)
    {
        RI = 0;             //Clear receive interrupt flag
        P0 = SBUF;          //P0 show UART data
        bit9 = RB8;         //P2.2 show parity bit
    }
    if (TI)
    {
        TI = 0;             //Clear transmit interrupt flag
        busy = 0;           //Clear transmit busy flag
    }
}