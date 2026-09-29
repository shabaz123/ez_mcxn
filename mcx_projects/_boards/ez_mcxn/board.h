#ifndef _BOARD_H_
#define _BOARD_H_

#include "fsl_gpio.h"
#include "pin_mux.h"


/*******************************************************************************
 * Definitions
 ******************************************************************************/

#define BOARD_NAME "EZ-MCXN"

/* LEDs - active high */
#define BOARD_LED1_GPIO      BOARD_INITPINS_LED1_PIN_GPIO
#define BOARD_LED1_GPIO_PIN  BOARD_INITPINS_LED1_PIN_GPIO_PIN

#define BOARD_LED2_GPIO      BOARD_INITPINS_LED2_PIN_GPIO
#define BOARD_LED2_GPIO_PIN  BOARD_INITPINS_LED2_PIN_GPIO_PIN

#define LOGIC_LED_ON   1U
#define LOGIC_LED_OFF  0U

#define LED1_ON() \
    GPIO_PinWrite(BOARD_LED1_GPIO, BOARD_LED1_GPIO_PIN, LOGIC_LED_ON)

#define LED1_OFF() \
    GPIO_PinWrite(BOARD_LED1_GPIO, BOARD_LED1_GPIO_PIN, LOGIC_LED_OFF)

#define LED1_TOGGLE() \
    GPIO_PortToggle(BOARD_LED1_GPIO, 1U << BOARD_LED1_GPIO_PIN)

#define LED2_ON() \
    GPIO_PinWrite(BOARD_LED2_GPIO, BOARD_LED2_GPIO_PIN, LOGIC_LED_ON)

#define LED2_OFF() \
    GPIO_PinWrite(BOARD_LED2_GPIO, BOARD_LED2_GPIO_PIN, LOGIC_LED_OFF)

#define LED2_TOGGLE() \
    GPIO_PortToggle(BOARD_LED2_GPIO, 1U << BOARD_LED2_GPIO_PIN)

/*******************************************************************************
 * API
 ******************************************************************************/

#if defined(__cplusplus)
extern "C" {
#endif

void BOARD_InitHardware(void);

#if defined(__cplusplus)
}
#endif

#endif /* _BOARD_H_ */
