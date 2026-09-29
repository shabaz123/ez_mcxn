/*********************************************
 * double_blinky
 * rev 1 - shabaz - sep 2026
 * This project alternately blinks the two
 * LEDs on the EZ_MXCN board
 *********************************************/

#include "board.h"

int main(void)
{
    BOARD_InitHardware();

    LED1_ON();
    LED2_OFF();

    while (1)
    {
        LED1_TOGGLE();
        LED2_TOGGLE();
        for (volatile uint32_t i = 0; i < 5000000U; i++)
        {
            __NOP();
        }
    }
}
