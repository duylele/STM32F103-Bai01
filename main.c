
#include <stdint.h>

/* =========================
   RCC
   ========================= */

#define RCC_BASE        0x40021000UL
#define RCC_APB2ENR     (*(volatile uint32_t *)(RCC_BASE + 0x18))


/* =========================
   GPIOC
   ========================= */

#define GPIOC_BASE      0x40011000UL

#define GPIOC_CRH       (*(volatile uint32_t *)(GPIOC_BASE + 0x04))
#define GPIOC_ODR       (*(volatile uint32_t *)(GPIOC_BASE + 0x0C))


/* =========================
   SysTick
   ========================= */
#define SYST_CSR        (*(volatile uint32_t *)0xE000E010UL)
#define SYST_RVR        (*(volatile uint32_t *)0xE000E014UL)
#define SYST_CVR        (*(volatile uint32_t *)0xE000E018UL)


/* =========================
   THAM SO NHAP NHAY
   ========================= */

#define BLINK_DELAY_MS  1000

volatile uint32_t ms_tick = 0;


/* =========================
   SysTick Interrupt
   ========================= */

void SysTick_Handler(void)
{
    ms_tick++;
}


/* =========================
   Delay
   ========================= */

void delay_ms(uint32_t ms)
{
    uint32_t start = ms_tick;

    while ((ms_tick - start) < ms)
    {
        /* Cho */
    }
}


/* =========================
   GPIOC INIT
   ========================= */

void GPIOC_Init(void)
{
    /*
     * Bat clock GPIOC
     * APB2ENR bit 4 = IOPCEN
     */
    RCC_APB2ENR |= (1 << 4);


    /*
     * PC13 nam trong GPIOC_CRH
     *
     * MODE13 = 10
     * CNF13  = 00
     *
     * Output 2 MHz
     * Push-pull
     */

    GPIOC_CRH &= ~(0xFUL << 20);
    GPIOC_CRH |=  (0x2UL << 20);


    /*
     * Blue Pill:
     * PC13 = 1 -> LED tat
     */
    GPIOC_ODR |= (1 << 13);
}


/* =========================
   SysTick INIT
   ========================= */

void SysTick_Init(void)
{
    /*
     * HSI = 8 MHz
     *
     * 8,000,000 / 1000 = 8000
     *
     * 8000 clock = 1 ms
     */

    SYST_RVR = 8000 - 1;

    SYST_CVR = 0;


    /*
     * CLKSOURCE = 1
     * TICKINT   = 1
     * ENABLE    = 1
     */

    SYST_CSR = (1 << 2) |
               (1 << 1) |
               (1 << 0);
}


/* =========================
   MAIN
   ========================= */

int main(void)
{
    GPIOC_Init();

    SysTick_Init();

    while (1)
    {
        delay_ms(BLINK_DELAY_MS);

        /*
         * Dao trang thai PC13
         */
        GPIOC_ODR ^= (1 << 13);
    }

    return 0;
}
