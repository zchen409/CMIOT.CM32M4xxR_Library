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
 * @file riscv_sin_cos_example_f32.c
 * @author CMIOT Firmware Team
 * @version v1.0.0
 *
 * @copyright Copyright (c) 2020, CMIOT. All rights reserved.
 */
/* ----------------------------------------------------------------------
* Copyright (C) 2010-2012 ARM Limited. All rights reserved.
* Copyright (c) 2019 Nuclei Limited. All rights reserved.
*
* $Date:         12. March 2014
* $Revision:     V1.4.3
*
* Project:       NMSIS DSP Library
* Title:         riscv_sin_cos_example_f32.c
*
* Description:   Example code demonstrating sin and cos calculation of input signal.
*
* Target Processor: RISC-V Cores
*
* Redistribution and use in source and binary forms, with or without
* modification, are permitted provided that the following conditions
* are met:
*   - Redistributions of source code must retain the above copyright
*     notice, this list of conditions and the following disclaimer.
*   - Redistributions in binary form must reproduce the above copyright
*     notice, this list of conditions and the following disclaimer in
*     the documentation and/or other materials provided with the
*     distribution.
*   - Neither the name of ARM LIMITED nor the names of its contributors
*     may be used to endorse or promote products derived from this
*     software without specific prior written permission.
*
* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
* "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
* LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
* FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
* COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
* INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
* BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
* LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
* CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
* LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
* ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
* POSSIBILITY OF SUCH DAMAGE.
* -------------------------------------------------------------------- */

/**
 * @ingroup groupExamples
 */

/**
 * @defgroup SinCosExample SineCosine Example
 *
 * \par Description:
 * \par
 * Demonstrates the Pythagorean trignometric identity with the use of Cosine, Sine, Vector
 * Multiplication, and Vector Addition functions.
 *
 * \par Algorithm:
 * \par
 * Mathematically, the Pythagorean trignometric identity is defined by the following equation:
 *  <pre>sin(x) * sin(x) + cos(x) * cos(x) = 1</pre>
 * where \c x is the angle in radians.
 *
 * \par Block Diagram:
 * \par
 * \image html sinCos.png
 *
 * \par Variables Description:
 * \par
 * \li \c testInput_f32 array of input angle in radians
 * \li \c testOutput stores sum of the squares of sine and cosine values of input angle
 *
 * \par NMSIS DSP Software Library Functions Used:
 * \par
 * - riscv_cos_f32()
 * - riscv_sin_f32()
 * - riscv_mult_f32()
 * - riscv_add_f32()
 *
 * <b> Refer  </b>
 * \link riscv_sin_cos_example_f32.c \endlink
 *
 */


/** \example riscv_sin_cos_example_f32.c
  */
#include "main.h"
#include "bsp.h"
#include <stdio.h>
#include <math.h>
#include "riscv_math.h"

/* ----------------------------------------------------------------------
* Defines each of the tests performed
* ------------------------------------------------------------------- */
#define MAX_BLOCKSIZE   32
#define DELTA           (0.0001f)


/* ----------------------------------------------------------------------
* Test input data for Floating point sin_cos example for 32-blockSize
* Generated by the MATLAB randn() function
* ------------------------------------------------------------------- */

const float32_t testInput_f32[MAX_BLOCKSIZE] =
{
  -1.244916875853235400,  -4.793533929171324800,   0.360705030233248850,   0.827929644170887320,  -3.299532218312426900,   3.427441903227623800,   3.422401784294607700,  -0.108308165334010680,
   0.941943896490312180,   0.502609575000365850,  -0.537345278736373500,   2.088817392965764500,  -1.693168684143455700,   6.283185307179590700,  -0.392545884746175080,   0.327893095115825040,
   3.070147440456292300,   0.170611405884662230,  -0.275275082396073010,  -2.395492805446796300,   0.847311163536506600,  -3.845517018083148800,   2.055818378415868300,   4.672594161978930800,
  -1.990923030266425800,   2.469305197656249500,   3.609002606064021000,  -4.586736582331667500,  -4.147080139136136300,   1.643756718868359500,  -1.150866392366494800,   1.985805026477433800


};

const float32_t testRefOutput_f32 = 1.000000000;

/* ----------------------------------------------------------------------
* Declare Global variables
* ------------------------------------------------------------------- */
uint32_t blockSize = 32;
float32_t  testOutput;
float32_t  cosOutput;
float32_t  sinOutput;
float32_t  cosSquareOutput;
float32_t  sinSquareOutput;

/* ----------------------------------------------------------------------
* Max magnitude FFT Bin test
* ------------------------------------------------------------------- */

riscv_status status;

int32_t main(void)
{
  log_init();
/*  Enable Vector  */
#if (defined (__RISCV_FEATURE_VECTOR) && (__RISCV_FEATURE_VECTOR == 1))
  __RV_CSR_SET(CSR_MSTATUS, 0x200);
#endif 

  float32_t diff;
  uint32_t i;

  for(i=0; i< blockSize; i++)
  {
    cosOutput = riscv_cos_f32(testInput_f32[i]);
    sinOutput = riscv_sin_f32(testInput_f32[i]);

    riscv_mult_f32(&cosOutput, &cosOutput, &cosSquareOutput, 1);
    riscv_mult_f32(&sinOutput, &sinOutput, &sinSquareOutput, 1);

    riscv_add_f32(&cosSquareOutput, &sinSquareOutput, &testOutput, 1);

    /* absolute value of difference between ref and test */
    diff = fabsf(testRefOutput_f32 - testOutput);

    /* Comparison of sin_cos value with reference */
    if (diff > DELTA)
    {
       printf("failed\n");
       return 1;
    }
    printf("passed\n");
    return 0;
  }
}

 /** \endlink */
