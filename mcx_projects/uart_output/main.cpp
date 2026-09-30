/*********************************************
 * uart output
 * rev 1 - shabaz - sep 2026
 * This project transmits text out of the
 * UART
 *********************************************/

#include "board.h"
#include "peripherals.h"
#include <stdio.h>
#include <stdint.h>

extern "C" int _write(int handle, char *buffer, int size)
{
    (void)handle;

    LPUART_WriteBlocking(
        LP_FLEXCOMM4_PERIPHERAL,
        reinterpret_cast<const uint8_t *>(buffer),
        static_cast<size_t>(size)
    );

    return size;
}

void
delay_ms(uint16_t n) {
    for (volatile uint16_t j=0; j<n; j++) {
        for (volatile uint32_t i=0; i<50000U; i++) {
            __NOP();
        }
    }
}

int main(void)
{
    uint16_t count = 0;
    BOARD_InitHardware();

    LED1_ON();
    LED2_OFF();

    while (1)
    {
        printf("count = %d\r\n", count);
        count ++;
        LED1_TOGGLE();
        LED2_TOGGLE();
        delay_ms(500);
    }
}
