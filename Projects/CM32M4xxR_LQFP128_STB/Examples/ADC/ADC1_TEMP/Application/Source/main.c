/*
  ******************************************************************************
  *
  * COPYRIGHT(c) 2020, China Mobile IOT
  *
  * Redistribution and use in source and binary forms, with or without modification,
  * are permitted provided that the following conditions are met:
  *   1. Redistributions of source code must retain the above copyright notice,
  *      this list of conditions and the following disclaimer.
  *   2. Redistributions in binary form must reproduce the above copyright notice,
  *      this list of conditions and the following disclaimer in the documentation
  *      and/or other materials provided with the distribution.
  *   3. Neither the name of China Mobile IOT nor the names of its contributors
  *      may be used to endorse or promote products derived from this software
  *      without specific prior written permission.
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
  ******************************************************************************
  */ 

/**
 * @file main.c
 * @author CMIOT
 * @version v1.0.2
 *
 * @COPYRIGHT(c) 2020, China Mobile IOT. All rights reserved.
 */
#include "main.h"
#include "log.h"

/** @addtogroup ADC_ADC1_TEMP
 * @{
 */

ADC_InitType ADC_InitStructure;
ADC_InitTypeEx ADC_InitStructureEx;
DMA_InitType DMA_InitStructure;
__IO uint16_t ADCConvertedValue;

void RCC_Configuration(void);

/*comment out DEF_NO_CAL if use calibration value in register*/
#define DEF_NO_CAL

/*comment out DEF_FLOAT if not use float with nano printf, and the temperature value will be a integer.*/
#define DEF_FLOAT

/*comment out cal_25_degree if use 105°C calibration value, otherwise use 25°C calibration value*/
//#define cal_25_degree


/*V25 is the voltage value at 25 degree Celsius by datasheet define*/
#define V25        1.32f
/*Tc1 is the temprature compensation value*/
#define Tc1        1.5f
/*Vc0 is the ADC compensation value*/
#define Vc0        0
/*Vref is the voltage value at 105 or 25 degree Celsius by factory default*/ 
uint16_t  Vref = 0;
#ifdef  cal_25_degree
uint16_t  Tref = 25;
#else
uint16_t  Tref = 105;
#endif


#ifdef  DEF_FLOAT   //float result
/*xx v per degree Celsius  by datasheet define*/
#define AVG_SLOPE  0.004f
__IO float TempValue;
/**
 * @brief  get float temperature result.
 */
float TempCal(uint16_t TempAdVal)
{
    float Temperate,tempValue;
    
    /* Get the temperature inside the chip */
#ifdef DEF_NO_CAL   //no calibration
    tempValue=TempAdVal*(3.3/4095);
    Temperate=(V25-tempValue)/AVG_SLOPE+25.0f;
#else   //use calibration
    Temperate=((Vref+Vc0-TempAdVal)*3.3/4095)/AVG_SLOPE+Tref-Tc1;
#endif
    
    return Temperate;
}

#else   //integer result
#define AVG_SLOPE  4
__IO int16_t TempValue;
/**
 * @brief  get integer temperature result.
 */
int16_t TempCal(uint16_t TempAdVal)
{
    int16_t Temperate,tempValue;
    
    /* Get the temperature inside the chip */
#ifdef DEF_NO_CAL   //no calibration
    tempValue=V25*1000 - TempAdVal*3.3*1000/4095;
    Temperate=tempValue/AVG_SLOPE+25;
#else   //use calibration
    Temperate=(int16_t)(((Vref+Vc0-TempAdVal)*3.3*1000/4095)/AVG_SLOPE+Tref-Tc1);
#endif
    
    return Temperate;
}
#endif   //integer result



/**
 * @brief   Main program
 */
int main(void)
{
    /* System clocks configuration ---------------------------------------------*/
    RCC_Configuration();

    /* DMA1 channel1 configuration ----------------------------------------------*/
    DMA_DeInit(DMA1_CH1);
    DMA_InitStructure.PeriphAddr     = (uint32_t)&ADC1->DAT;
    DMA_InitStructure.MemAddr        = (uint32_t)&ADCConvertedValue;
    DMA_InitStructure.Direction      = DMA_DIR_PERIPH_SRC;
    DMA_InitStructure.BufSize        = 1;
    DMA_InitStructure.PeriphInc      = DMA_PERIPH_INC_DISABLE;
    DMA_InitStructure.DMA_MemoryInc  = DMA_MEM_INC_DISABLE;
    DMA_InitStructure.PeriphDataSize = DMA_PERIPH_DATA_SIZE_HALFWORD;
    DMA_InitStructure.MemDataSize    = DMA_MEMORY_DATA_SIZE_HALFWORD;
    DMA_InitStructure.CircularMode   = DMA_MODE_CIRCULAR;
    DMA_InitStructure.Priority       = DMA_PRIORITY_HIGH;
    DMA_InitStructure.Mem2Mem        = DMA_M2M_DISABLE;
    DMA_Init(DMA1_CH1, &DMA_InitStructure);
    /* Enable DMA1 channel1 */
    DMA_EnableChannel(DMA1_CH1, ENABLE);

    /* ADC1 configuration ------------------------------------------------------*/
    ADC_InitStructure.WorkMode       = ADC_WORKMODE_INDEPENDENT;
    ADC_InitStructure.MultiChEn      = ENABLE;
    ADC_InitStructure.ContinueConvEn = ENABLE;
    ADC_InitStructure.ExtTrigSelect  = ADC_EXT_TRIGCONV_NONE;
    ADC_InitStructure.DatAlign       = ADC_DAT_ALIGN_R;
    ADC_InitStructure.ChsNumber      = 1;
    ADC_Init(ADC1, &ADC_InitStructure);
		/* ADC1 temp sensor enable */
    ADC_EnableTempSensorVrefint(ENABLE);

    ADC_InitStructureEx.VbatMinitEn = ENABLE;
    ADC_InitStructureEx.DeepPowerModEn = DISABLE;
    ADC_InitStructureEx.JendcIntEn = DISABLE;
    ADC_InitStructureEx.EndcIntEn = DISABLE;
    ADC_InitStructureEx.ClkMode = ADC_CTRL3_CKMOD_AHB;
    ADC_InitStructureEx.CalAtuoLoadEn = DISABLE;
    ADC_InitStructureEx.DifModCal = false;
    ADC_InitStructureEx.ResBit = ADC_CTRL3_RES_12BIT;
    ADC_InitStructureEx.SampSecondStyle = false;
    ADC_InitEx(ADC1, &ADC_InitStructureEx);
    /* ADC1 regular configuration */
    ADC_ConfigRegularChannel(ADC1, ADC_CH_16, 1, ADC_SAMP_TIME_239CYCLES5);//ADC_CH_16：测温度，ADC_CH_18：测内部1.2V基准
    /* ADC1 temp sensor enable */
    ADC_EnableTempSensorVrefint(ENABLE);
    /* Enable ADC1 DMA */
    ADC_EnableDMA(ADC1, ENABLE);

    /* Enable ADC1 */
    ADC_Enable(ADC1, ENABLE);
    /*Check ADC Ready*/
    while(ADC_GetFlagStatusReady(ADC1,ADC_FLAG_RDY) == RESET)
        ;
    /* Start ADC1 calibration */
    ADC_StartCalibration(ADC1);
    /* Check the end of ADC1 calibration */
    while (ADC_GetCalibrationStatus(ADC1))
        ;

		/* ADC1 CAL AUTO LOAD enable */
    ADC_InitStructureEx.CalAtuoLoadEn = ENABLE;
    ADC_InitEx(ADC1, &ADC_InitStructureEx);

    /* Start ADC1 Software Conversion */
    ADC_EnableSoftwareStartConv(ADC1, ENABLE);

    /* Initialize the uart to output log information. */
    log_init();

#ifndef DEF_NO_CAL
#ifdef  cal_25_degree   //use V25 as reference
    Vref = *(__IO uint16_t*)((uint32_t)0x1FFFF7D0);
#else   //use V105 as reference
    Vref = *(__IO uint16_t*)((uint32_t)0x1FFFF7D4);
#endif
#endif   //DEF_NO_CAL

    while (1)
    {
        /* */
        TempValue = TempCal(ADCConvertedValue);
		#ifdef DEF_FLOAT
        printf("Temperature = %.3f\r\n",TempValue);
		#else
        printf("Temperature = %d\r\n",TempValue);
		#endif

        delay_ms(500);
    }
}

/**
 * @brief  Configures the different system clocks.
 */
void RCC_Configuration(void)
{
    /* Enable peripheral clocks ------------------------------------------------*/
    /* Enable DMA1 and DMA2 clocks */
    RCC_EnableAHBPeriphClk(RCC_AHB_PERIPH_DMA1 | RCC_AHB_PERIPH_DMA2, ENABLE);

    /* Enable GPIOC clocks */
    RCC_EnableAPB2PeriphClk(RCC_APB2_PERIPH_GPIOC, ENABLE);
    /* Enable ADC1 clocks */
    RCC_EnableAHBPeriphClk(RCC_AHB_PERIPH_ADC1,ENABLE);

    /* RCC_ADCHCLK_DIV16*/
    ADC_ConfigClk(ADC1,ADC_CTRL3_CKMOD_AHB,RCC_ADCHCLK_DIV16);
    RCC_ConfigAdc1mClk(RCC_ADC1MCLK_SRC_HSI, RCC_ADC1MCLK_DIV8);
}

/**
 * @}
 */

/**
 * @}
 */
