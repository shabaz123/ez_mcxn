
#include "board.h"
#include "clock_config.h"
#include "peripherals.h"

void BOARD_InitHardware(void)
{
    BOARD_InitPins();
    BOARD_InitBootClocks();
    BOARD_InitPeripherals();
}
