/*******************************************************************************
*
* COPYRIGHT(c) 2020, China Mobile IOT
*
* Redistribution and use in source and binary forms, with or without modification,
* are permitted provided that the following conditions are met:
*	1. Redistributions of source code must retain the above copyright notice,
*	   this list of conditions and the following disclaimer.
*	2. Redistributions in binary form must reproduce the above copyright notice,
*	   this list of conditions and the following disclaimer in the documentation
*	   and/or other materials provided with the distribution.
*	3. Neither the name of China Mobile IOT nor the names of its contributors
*	   may be used to endorse or promote products derived from this software
*	   without specific prior written permission.
*
* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
* AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
* IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
* DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
* FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
* DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
* SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
* CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
* OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
* OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*
*******************************************************************************/

/**
 * @file main.c
 * @author CMIOT Firmware Team
 * @version v1.0.0
 *
 * @copyright Copyright (c) 2020, CMIOT. All rights reserved.
 */
#include "main.h"
#include "bsp.h"

/** @addtogroup CM32M4xxR_StdPeriph_Examples
 * @{
 */

/** @addtogroup TIM_6Steps
 * @{
 */

TIM_TimeBaseInitType TIM_TimeBaseStructure;
TIM_OCInitType TIM_OCInitStructure;
TIM_BDTRInitType TIM_BDTRInitStructure;
uint16_t CCR1_Val = 2048;
uint16_t CCR2_Val = 1024;
uint16_t CCR3_Val = 512;

void RCC_Configuration(void);
void GPIO_Configuration(void);
void SysTick_Configuration(void);
void ECLIC_Configuration(void);

/**
 * @brief   Main function
 */
extern double pow (double, double);
int main(void)
{
    /* System Clocks Configuration */
    RCC_Configuration();

    /* ECLIC Configuration */
    ECLIC_Configuration();

    /* GPIO Configuration */
    GPIO_Configuration();

    /* SysTick Configuration */
    SysTick_Configuration();

    /*-----------------------------------------------------------------------------
    The cm32m4xxr TIM1 peripheral offers the possibility to program in advance the
    configuration for the next TIM1 outputs behavior (step) and change the configuration
    of all the channels at the same time. This operation is possible when the COM
    (commutation) event is used.
    The COM event can be generated by software by setting the COM bit in the TIM1_EGR
    register or by hardware (on TRC rising edge).
    In this example, a software COM event is generated each 100 ms: using the Systick
    interrupt.
    The TIM1 is configured in Timing Mode, each time a COM event occurs,
    a new TIM1 configuration will be set in advance.
    The following Table describes the TIM1 Channels states:
                -----------------------------------------------
               | Step1 | Step2 | Step3 | Step4 | Step5 | Step6 |
    ----------------------------------------------------------
    |Channel1  |   1   |   0   |   0   |   0   |   0   |   1   |
    ----------------------------------------------------------
    |Channel1N |   0   |   0   |   1   |   1   |   0   |   0   |
    ----------------------------------------------------------
    |Channel2  |   0   |   0   |   0   |   1   |   1   |   0   |
    ----------------------------------------------------------
    |Channel2N |   1   |   1   |   0   |   0   |   0   |   0   |
    ----------------------------------------------------------
    |Channel3  |   0   |   1   |   1   |   0   |   0   |   0   |
    ----------------------------------------------------------
    |Channel3N |   0   |   0   |   0   |   0   |   1   |   1   |
    ----------------------------------------------------------
    -----------------------------------------------------------------------------*/

    /* Time Base configuration */
    TIM_TimeBaseStructure.Prescaler = 0;
    TIM_TimeBaseStructure.CntMode   = TIM_CNT_MODE_UP;
    TIM_TimeBaseStructure.Period    = 4095;
    TIM_TimeBaseStructure.ClkDiv    = 0;
    TIM_TimeBaseStructure.RepetCnt  = 0;

    TIM_InitTimeBase(TIM1, &TIM_TimeBaseStructure);

    /* Channel 1, 2, 3 and 4 Configuration in PWM mode */
    TIM_OCInitStructure.OcMode       = TIM_OCMODE_TIMING;
    TIM_OCInitStructure.OutputState  = TIM_OUTPUT_STATE_ENABLE;
    TIM_OCInitStructure.OutputNState = TIM_OUTPUT_NSTATE_ENABLE;
    TIM_OCInitStructure.Pulse        = CCR1_Val;
    TIM_OCInitStructure.OcPolarity   = TIM_OC_POLARITY_HIGH;
    TIM_OCInitStructure.OcNPolarity  = TIM_OCN_POLARITY_HIGH;
    TIM_OCInitStructure.OcIdleState  = TIM_OC_IDLE_STATE_RESET;
    TIM_OCInitStructure.OcNIdleState = TIM_OCN_IDLE_STATE_SET;

    TIM_InitOc1(TIM1, &TIM_OCInitStructure);

    TIM_OCInitStructure.Pulse = CCR2_Val;
    TIM_InitOc2(TIM1, &TIM_OCInitStructure);

    TIM_OCInitStructure.Pulse = CCR3_Val;
    TIM_InitOc3(TIM1, &TIM_OCInitStructure);

    /* Automatic Output enable, Break, dead time and lock configuration */
    TIM_BDTRInitStructure.OssrState       = TIM_OSSR_STATE_ENABLE;
    TIM_BDTRInitStructure.OssiState       = TIM_OSSI_STATE_ENABLE;
    TIM_BDTRInitStructure.LockLevel       = TIM_LOCK_LEVEL_OFF;
    TIM_BDTRInitStructure.DeadTime        = 1;
    TIM_BDTRInitStructure.Break           = TIM_BREAK_IN_ENABLE; // TIM_BREAK_IN_DISABLE;
    TIM_BDTRInitStructure.BreakPolarity   = TIM_BREAK_POLARITY_HIGH;
    TIM_BDTRInitStructure.AutomaticOutput = TIM_AUTO_OUTPUT_ENABLE;
    TIM_BDTRInitStructure.IomBreakEn	  = true; /* TIM1_BKIN as BRK */

    TIM_ConfigBkdt(TIM1, &TIM_BDTRInitStructure);

    TIM_EnableCapCmpPreloadControl(TIM1, ENABLE);

    TIM_ConfigInt(TIM1, TIM_INT_COM, ENABLE);

    /* Enable global interrupt */
    __enable_irq();

    /* TIM1 counter enable */
    TIM_Enable(TIM1, ENABLE);

    /* Main Output Enable */
    TIM_EnableCtrlPwmOutputs(TIM1, ENABLE);

    while (1)
    {
    }
}

/**
 * @brief  Configures the different system clocks.
 */
void RCC_Configuration(void)
{
    /* TIM1, GPIOA, GPIOB, GPIOE and AFIO clocks enable */
    RCC_EnableAPB2PeriphClk(RCC_APB2_PERIPH_TIM1  | RCC_APB2_PERIPH_GPIOA | RCC_APB2_PERIPH_GPIOE |
    						RCC_APB2_PERIPH_GPIOB | RCC_APB2_PERIPH_AFIO, ENABLE);
}

/**
 * @brief  Configure the TIM1 Pins.
 */
void GPIO_Configuration(void)
{
    GPIO_InitType GPIO_InitStructure;

    /* GPIOA Configuration: Channel 1, 2 and 3 as alternate function push-pull */
    GPIO_InitStructure.Pin        = GPIO_PIN_8 | GPIO_PIN_9 | GPIO_PIN_10;
    GPIO_InitStructure.GPIO_Mode  = GPIO_Mode_AF_PP;
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_2MHz;
    GPIO_Init(GPIOA, &GPIO_InitStructure);

    /* GPIOB Configuration: Channel 1N, 2N and 3N as alternate function push-pull */
    GPIO_InitStructure.Pin = GPIO_PIN_13 | GPIO_PIN_14 | GPIO_PIN_15;
    GPIO_Init(GPIOB, &GPIO_InitStructure);

    /* GPIOB Configuration: BKIN pin */
    GPIO_InitStructure.Pin       = GPIO_PIN_12;
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN_FLOATING;
    GPIO_Init(GPIOB, &GPIO_InitStructure);
}

/**
 * @brief  Configures the SysTick.
 */
void SysTick_Configuration(void)
{
	/* Use core_aon_clk as systimer clock */
	SysTimer_SetControlValue(SysTimer_GetControlValue() | SysTimer_MTIMECTL_CLKSRC_Msk);

	/* Setup SysTick Timer for 100 msec interrupts */
	SysTick_Config((SystemCoreClock) / 10);
}

/**
 * @brief  Configures ECLIC.
 */
void ECLIC_Configuration(void)
{
    /* Enable the TIM1 Interrupt */
	ECLIC_SetLevelIRQ(TIM1_TRG_COM_IRQn, 0);
	ECLIC_SetPriorityIRQ(TIM1_TRG_COM_IRQn, 1);
	ECLIC_SetTrigIRQ(TIM1_TRG_COM_IRQn, ECLIC_LEVEL_TRIGGER);
	ECLIC_EnableIRQ(TIM1_TRG_COM_IRQn);
}

/**
 * @}
 */

/**
 * @}
 */
