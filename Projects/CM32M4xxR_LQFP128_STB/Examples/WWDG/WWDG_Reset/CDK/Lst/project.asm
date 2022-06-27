
.//Obj/project.elf:     file format elf32-littleriscv


Disassembly of section .init:

08000000 <vector_base>:
 8000000:	1a40006f          	j	80001a4 <_start>
 8000004:	18ae                	slli	a7,a7,0x2b
 8000006:	0800                	addi	s0,sp,16
 8000008:	18ae                	slli	a7,a7,0x2b
 800000a:	0800                	addi	s0,sp,16
 800000c:	12b4                	addi	a3,sp,360
 800000e:	0800                	addi	s0,sp,16
 8000010:	18ae                	slli	a7,a7,0x2b
 8000012:	0800                	addi	s0,sp,16
 8000014:	18ae                	slli	a7,a7,0x2b
 8000016:	0800                	addi	s0,sp,16
 8000018:	18ae                	slli	a7,a7,0x2b
 800001a:	0800                	addi	s0,sp,16
 800001c:	12b6                	slli	t0,t0,0x2d
 800001e:	0800                	addi	s0,sp,16
 8000020:	18ae                	slli	a7,a7,0x2b
 8000022:	0800                	addi	s0,sp,16
 8000024:	18ae                	slli	a7,a7,0x2b
 8000026:	0800                	addi	s0,sp,16
 8000028:	18ae                	slli	a7,a7,0x2b
 800002a:	0800                	addi	s0,sp,16
 800002c:	18ae                	slli	a7,a7,0x2b
 800002e:	0800                	addi	s0,sp,16
 8000030:	18ae                	slli	a7,a7,0x2b
 8000032:	0800                	addi	s0,sp,16
 8000034:	18ae                	slli	a7,a7,0x2b
 8000036:	0800                	addi	s0,sp,16
 8000038:	18ae                	slli	a7,a7,0x2b
 800003a:	0800                	addi	s0,sp,16
 800003c:	18ae                	slli	a7,a7,0x2b
 800003e:	0800                	addi	s0,sp,16
 8000040:	18ae                	slli	a7,a7,0x2b
 8000042:	0800                	addi	s0,sp,16
 8000044:	18ae                	slli	a7,a7,0x2b
 8000046:	0800                	addi	s0,sp,16
 8000048:	18ae                	slli	a7,a7,0x2b
 800004a:	0800                	addi	s0,sp,16
	...
 80000f4:	18ae                	slli	a7,a7,0x2b
 80000f6:	0800                	addi	s0,sp,16
	...
 800010c:	18ae                	slli	a7,a7,0x2b
 800010e:	0800                	addi	s0,sp,16
 8000110:	18ae                	slli	a7,a7,0x2b
 8000112:	0800                	addi	s0,sp,16
	...
 8000140:	18ae                	slli	a7,a7,0x2b
 8000142:	0800                	addi	s0,sp,16
 8000144:	18ae                	slli	a7,a7,0x2b
 8000146:	0800                	addi	s0,sp,16
	...
 8000184:	18ae                	slli	a7,a7,0x2b
 8000186:	0800                	addi	s0,sp,16
	...

080001a4 <_start>:
 * Reset Handler called on controller reset
 */
_start:
    /* ===== Startup Stage 1 ===== */
    /* Disable Global Interrupt */
    csrc CSR_MSTATUS, MSTATUS_MIE
 80001a4:	30047073          	csrci	mstatus,8

	/* Transform logic address to actual address if necessary */
    la	 a0, _start
 80001a8:	00000517          	auipc	a0,0x0
 80001ac:	ffc50513          	addi	a0,a0,-4 # 80001a4 <_start>
    li   a1, 1
 80001b0:	4585                	li	a1,1
 	slli a1, a1, 29
 80001b2:	05f6                	slli	a1,a1,0x1d
    bleu a1, a0, _start_main
 80001b4:	00b57b63          	bgeu	a0,a1,80001ca <_start_main>
    srli a1, a1, 2
 80001b8:	8189                	srli	a1,a1,0x2
    bleu a1, a0, _start_main
 80001ba:	00b57863          	bgeu	a0,a1,80001ca <_start_main>
    la   a0, _start_main
 80001be:	00000517          	auipc	a0,0x0
 80001c2:	00c50513          	addi	a0,a0,12 # 80001ca <_start_main>
    add  a0, a0, a1
 80001c6:	952e                	add	a0,a0,a1
 	jr   a0
 80001c8:	8502                	jr	a0

080001ca <_start_main>:

_start_main:
    /* Initialize GP and Stack Pointer SP */
    .option push
    .option norelax
    la gp, __global_pointer$
 80001ca:	18000197          	auipc	gp,0x18000
 80001ce:	69618193          	addi	gp,gp,1686 # 20000860 <__global_pointer$>

    .option pop
    la sp, _sp
 80001d2:	18020117          	auipc	sp,0x18020
 80001d6:	e2e10113          	addi	sp,sp,-466 # 20020000 <_sp>
    /*
     * Set the the NMI base mnvec to share
     * with mtvec by setting CSR_MMISC_CTL
     * bit 9 NMI_CAUSE_FFF to 1
     */
    li t0, MMISC_CTL_NMI_CAUSE_FFF
 80001da:	20000293          	li	t0,512
    csrs CSR_MMISC_CTL, t0
 80001de:	7d02a073          	csrs	mmisc_ctl,t0

    /*
     * Intialize ECLIC vector interrupt
     * base address mtvt to vector_base
     */
    la t0, vector_base
 80001e2:	00000297          	auipc	t0,0x0
 80001e6:	e1e28293          	addi	t0,t0,-482 # 8000000 <vector_base>
    csrw CSR_MTVT, t0
 80001ea:	30729073          	csrw	mtvt,t0
     * Set ECLIC non-vector entry to be controlled
     * by mtvt2 CSR register.
     * Intialize ECLIC non-vector interrupt
     * base address mtvt2 to irq_entry.
     */
    la t0, irq_entry
 80001ee:	00001297          	auipc	t0,0x1
 80001f2:	64e28293          	addi	t0,t0,1614 # 800183c <irq_entry>
    csrw CSR_MTVT2, t0
 80001f6:	7ec29073          	csrw	mtvt2,t0
    csrs CSR_MTVT2, 0x1
 80001fa:	7ec0e073          	csrsi	mtvt2,1
    /*
     * Set Exception Entry MTVEC to exc_entry
     * Due to settings above, Exception and NMI
     * will share common entry.
     */
    la t0, exc_entry
 80001fe:	00001297          	auipc	t0,0x1
 8000202:	5c228293          	addi	t0,t0,1474 # 80017c0 <exc_entry>
    csrw CSR_MTVEC, t0
 8000206:	30529073          	csrw	mtvec,t0

    /* Set the interrupt processing mode to ECLIC mode */
    li t0, 0x3f
 800020a:	03f00293          	li	t0,63
    csrc CSR_MTVEC, t0
 800020e:	3052b073          	csrc	mtvec,t0
    csrs CSR_MTVEC, 0x3
 8000212:	3051e073          	csrsi	mtvec,3

    /* ===== Startup Stage 2 ===== */

#if defined(__riscv_flen) && __riscv_flen > 0
    /* Enable FPU */
    li t0, MSTATUS_FS
 8000216:	6299                	lui	t0,0x6
    csrs mstatus, t0
 8000218:	3002a073          	csrs	mstatus,t0
    csrw fcsr, x0
 800021c:	00301073          	fscsr	zero
#endif

    /* Enable mcycle and minstret counter */
    csrci CSR_MCOUNTINHIBIT, 0x5
 8000220:	3202f073          	csrci	mcountinhibit,5
     * Call vendor defined SystemInit to
     * initialize the micro-controller system.
     * In FlashXIP and ILM mode, call SystemInit before code loading
     */
#if defined(DOWNLOAD_MODE) && (DOWNLOAD_MODE != DOWNLOAD_MODE_FLASH)
    call SystemInit
 8000224:	1b6010ef          	jal	ra,80013da <SystemInit>
    /* ===== Startup Stage 3 ===== */
    /*
     * Load code section from FLASH to ILM
     * when code LMA is different with VMA
     */
    la a0, _ilm_lma
 8000228:	00000517          	auipc	a0,0x0
 800022c:	09850513          	addi	a0,a0,152 # 80002c0 <main>
    la a1, _ilm
 8000230:	00000597          	auipc	a1,0x0
 8000234:	09058593          	addi	a1,a1,144 # 80002c0 <main>
    /* If the ILM phy-address same as the logic-address, then quit */
    beq a0, a1, 2f
 8000238:	02b50063          	beq	a0,a1,8000258 <_start_main+0x8e>
    la a2, _eilm
 800023c:	00003617          	auipc	a2,0x3
 8000240:	1ac60613          	addi	a2,a2,428 # 80033e8 <__frame_dummy_init_array_entry>
    bgeu a1, a2, 2f
 8000244:	00c5fa63          	bgeu	a1,a2,8000258 <_start_main+0x8e>

1:
    /* Load code section if necessary */
    lw t0, (a0)
 8000248:	00052283          	lw	t0,0(a0)
    sw t0, (a1)
 800024c:	0055a023          	sw	t0,0(a1)
    addi a0, a0, 4
 8000250:	0511                	addi	a0,a0,4
    addi a1, a1, 4
 8000252:	0591                	addi	a1,a1,4
    bltu a1, a2, 1b
 8000254:	fec5eae3          	bltu	a1,a2,8000248 <_start_main+0x7e>
2:
    /* Load data section */
    la a0, _data_lma
 8000258:	00003517          	auipc	a0,0x3
 800025c:	19850513          	addi	a0,a0,408 # 80033f0 <_data_lma>
    la a1, _data
 8000260:	18000597          	auipc	a1,0x18000
 8000264:	da058593          	addi	a1,a1,-608 # 20000000 <impure_data>
    la a2, _edata
 8000268:	18000617          	auipc	a2,0x18000
 800026c:	e0460613          	addi	a2,a2,-508 # 2000006c <TimingDelay>
    bgeu a1, a2, 2f
 8000270:	00c5fa63          	bgeu	a1,a2,8000284 <_start_main+0xba>
1:
    lw t0, (a0)
 8000274:	00052283          	lw	t0,0(a0)
    sw t0, (a1)
 8000278:	0055a023          	sw	t0,0(a1)
    addi a0, a0, 4
 800027c:	0511                	addi	a0,a0,4
    addi a1, a1, 4
 800027e:	0591                	addi	a1,a1,4
    bltu a1, a2, 1b
 8000280:	fec5eae3          	bltu	a1,a2,8000274 <_start_main+0xaa>
2:
    /* Clear bss section */
    la a0, __bss_start
 8000284:	18000517          	auipc	a0,0x18000
 8000288:	de850513          	addi	a0,a0,-536 # 2000006c <TimingDelay>
    la a1, _end
 800028c:	90018593          	addi	a1,gp,-1792 # 20000160 <_end>
    bgeu a0, a1, 2f
 8000290:	00b57763          	bgeu	a0,a1,800029e <_start_main+0xd4>
1:
    sw zero, (a0)
 8000294:	00052023          	sw	zero,0(a0)
    addi a0, a0, 4
 8000298:	0511                	addi	a0,a0,4
    bltu a0, a1, 1b
 800029a:	feb56de3          	bltu	a0,a1,8000294 <_start_main+0xca>
#if defined(DOWNLOAD_MODE) && (DOWNLOAD_MODE == DOWNLOAD_MODE_FLASH)
    call SystemInit
#endif

    /* Call global constructors */
    la a0, __libc_fini_array
 800029e:	00001517          	auipc	a0,0x1
 80002a2:	61e50513          	addi	a0,a0,1566 # 80018bc <__libc_fini_array>
    call atexit
 80002a6:	60c010ef          	jal	ra,80018b2 <atexit>
    /* Call C/C++ constructor start up code */
    call __libc_init_array
 80002aa:	648010ef          	jal	ra,80018f2 <__libc_init_array>

    /* do pre-init steps before main */
    call _premain_init
 80002ae:	322010ef          	jal	ra,80015d0 <_premain_init>
    /* ===== Call Main Function  ===== */
    /* argc = argv = 0 */
    li a0, 0
 80002b2:	4501                	li	a0,0
    li a1, 0
 80002b4:	4581                	li	a1,0
    call main
 80002b6:	2029                	jal	80002c0 <main>
    /* do post-main steps after main */
    call _postmain_fini
 80002b8:	360010ef          	jal	ra,8001618 <_postmain_fini>

1:
    j 1b
 80002bc:	a001                	j	80002bc <_start_main+0xf2>

Disassembly of section .text:

080002c0 <main>:

/**
 * @brief  Main function.
 */
int main(void)
{
 80002c0:	1101                	addi	sp,sp,-32
 80002c2:	ce06                	sw	ra,28(sp)
 80002c4:	cc22                	sw	s0,24(sp)
 80002c6:	ca26                	sw	s1,20(sp)
 80002c8:	c84a                	sw	s2,16(sp)
         file (startup_cm32m4xxr.s) before to branch to application main.
         To reconfigure the default setting of SystemInit() function, refer to
         system_cm32m4xxr.c file
       */

    log_init();
 80002ca:	44c010ef          	jal	ra,8001716 <log_init>
    log_info("--- WWDG demo reset ---\n");
 80002ce:	00003517          	auipc	a0,0x3
 80002d2:	eda50513          	addi	a0,a0,-294 # 80031a8 <s_ApbAhbPresTable+0x298>

    LedInit(LED1_PORT, LED1_PIN);
 80002d6:	40011437          	lui	s0,0x40011
    log_info("--- WWDG demo reset ---\n");
 80002da:	037010ef          	jal	ra,8001b10 <puts>
    LedInit(LED1_PORT, LED1_PIN);
 80002de:	c0040513          	addi	a0,s0,-1024 # 40010c00 <_sp+0x1fff0c00>
 80002e2:	4585                	li	a1,1
 80002e4:	33a010ef          	jal	ra,800161e <LedInit>
    LedInit(LED2_PORT, LED2_PIN);
 80002e8:	c0040513          	addi	a0,s0,-1024
 80002ec:	4589                	li	a1,2
 80002ee:	330010ef          	jal	ra,800161e <LedInit>
    LedOff(LED1_PORT, LED1_PIN);
 80002f2:	c0040513          	addi	a0,s0,-1024
 80002f6:	4585                	li	a1,1
 80002f8:	3f2010ef          	jal	ra,80016ea <LedOff>
    LedOff(LED2_PORT, LED2_PIN);
 80002fc:	4589                	li	a1,2
 80002fe:	c0040513          	addi	a0,s0,-1024
 8000302:	3e8010ef          	jal	ra,80016ea <LedOff>
 * \remarks
 *          Can only be executed in Privileged modes.
 */
__STATIC_FORCEINLINE void __enable_irq(void)
{
    __RV_CSR_SET(CSR_MSTATUS, MSTATUS_MIE);
 8000306:	30046073          	csrsi	mstatus,8
 * \remarks
 * - \ref SysTimer_SetControlValue
 */
__STATIC_FORCEINLINE uint32_t SysTimer_GetControlValue(void)
{
    return (SysTimer->MTIMECTL & SysTimer_MTIMECTL_Msk);
 800030a:	e0021737          	lui	a4,0xe0021
 800030e:	ff872783          	lw	a5,-8(a4) # e0020ff8 <_sp+0xc0000ff8>

    /* Use core_aon_clk as systimer clock */
    SysTimer_SetControlValue(SysTimer_GetControlValue() | SysTimer_MTIMECTL_CLKSRC_Msk);

    /* Check if the system has resumed from WWDG reset */
    if (RCC_GetFlagStatus(RCC_FLAG_WWDGRST) != RESET)
 8000312:	07e00513          	li	a0,126
    SysTimer_SetControlValue(SysTimer_GetControlValue() | SysTimer_MTIMECTL_CLKSRC_Msk);
 8000316:	0047e793          	ori	a5,a5,4
    SysTimer->MTIMECTL = (mctl & SysTimer_MTIMECTL_Msk);
 800031a:	fef72c23          	sw	a5,-8(a4)
    if (RCC_GetFlagStatus(RCC_FLAG_WWDGRST) != RESET)
 800031e:	261000ef          	jal	ra,8000d7e <RCC_GetFlagStatus>
    {
        /* WWDGRST flag set */
        /* Turn on LED1 */
        LedOn(LED1_PORT, LED1_PIN);
 8000322:	4585                	li	a1,1
    if (RCC_GetFlagStatus(RCC_FLAG_WWDGRST) != RESET)
 8000324:	10050963          	beqz	a0,8000436 <main+0x176>
        LedOn(LED1_PORT, LED1_PIN);
 8000328:	c0040513          	addi	a0,s0,-1024
 800032c:	3b8010ef          	jal	ra,80016e4 <LedOn>

        log_info("reset by WWDG\n");
 8000330:	00003517          	auipc	a0,0x3
 8000334:	e9050513          	addi	a0,a0,-368 # 80031c0 <s_ApbAhbPresTable+0x2b0>
 8000338:	7d8010ef          	jal	ra,8001b10 <puts>

        /* Clear reset flags */
        RCC_ClrFlag();
 800033c:	2fd000ef          	jal	ra,8000e38 <RCC_ClrFlag>
    high = (value >> 32) & 0xFFFFFFFF;
 8000340:	c002                	sw	zero,0(sp)
    low = value & 0xFFFFFFFF;
 8000342:	c202                	sw	zero,4(sp)
    *(volatile uint32_t *)((uint32_t)(&SysTimer->MTIMER) + 0) = 0;	//prevent carry
 8000344:	e00207b7          	lui	a5,0xe0020
        /* Turn off LED1 */
        LedOff(LED1_PORT, LED1_PIN);
    }

    /* Setup SysTick Timer for 1 msec interrupts  */
    if (SysTick_Config(SystemCoreClock / 1000))
 8000348:	18000717          	auipc	a4,0x18000
 800034c:	d1872703          	lw	a4,-744(a4) # 20000060 <SystemCoreClock>
 8000350:	0007a023          	sw	zero,0(a5) # e0020000 <_sp+0xc0000000>
	*(volatile uint32_t *)((uint32_t)(&SysTimer->MTIMER) + 4) = high;
 8000354:	4682                	lw	a3,0(sp)
 8000356:	c3d4                	sw	a3,4(a5)
	*(volatile uint32_t *)((uint32_t)(&SysTimer->MTIMER) + 0) = low;
 8000358:	4692                	lw	a3,4(sp)
 800035a:	c394                	sw	a3,0(a5)
 800035c:	106256b7          	lui	a3,0x10625
 8000360:	dd368693          	addi	a3,a3,-557 # 10624dd3 <__ILM_RAM_BASE+0x624dd3>
 8000364:	02d73733          	mulhu	a4,a4,a3
	high = (value >> 32) & 0xFFFFFFFF;
 8000368:	c402                	sw	zero,8(sp)
 800036a:	8319                	srli	a4,a4,0x6
	low = value & 0xFFFFFFFF;
 800036c:	c63a                	sw	a4,12(sp)
	*(volatile uint32_t *)((uint32_t)(&SysTimer->MTIMERCMP) + 4) = 0xFFFFFFFF;		// No smaller than old value
 800036e:	577d                	li	a4,-1
 8000370:	c7d8                	sw	a4,12(a5)
	*(volatile uint32_t *)((uint32_t)(&SysTimer->MTIMERCMP) + 0) = low;				// New value
 8000372:	46b2                	lw	a3,12(sp)
 * \sa
 * - \ref ECLIC_GetShvIRQ
 */
__STATIC_FORCEINLINE void __ECLIC_SetShvIRQ(IRQn_Type IRQn, uint32_t shv)
{
    ECLIC->CTRL[IRQn].INTATTR &= ~CLIC_INTATTR_SHV_Msk;
 8000374:	e0011737          	lui	a4,0xe0011
 8000378:	c794                	sw	a3,8(a5)
	*(volatile uint32_t *)((uint32_t)(&SysTimer->MTIMERCMP) + 4) = high;		    // New value
 800037a:	46a2                	lw	a3,8(sp)
 800037c:	c7d4                	sw	a3,12(a5)
 800037e:	01e74783          	lbu	a5,30(a4) # e001101e <_sp+0xbfff101e>
 8000382:	0fe7f793          	andi	a5,a5,254
 8000386:	00f70f23          	sb	a5,30(a4)
    ECLIC->CTRL[IRQn].INTATTR |= (uint8_t)(shv<<CLIC_INTATTR_SHV_Pos);
 800038a:	01e74783          	lbu	a5,30(a4)
 800038e:	0ff7f793          	zext.b	a5,a5
 8000392:	00f70f23          	sb	a5,30(a4)
    return ((uint32_t)((ECLIC->CFG & CLIC_CLICCFG_NLBIT_Msk) >> CLIC_CLICCFG_NLBIT_Pos));
 8000396:	e00107b7          	lui	a5,0xe0010
 800039a:	0007c783          	lbu	a5,0(a5) # e0010000 <_sp+0xbfff0000>
 800039e:	8385                	srli	a5,a5,0x1
 80003a0:	8bbd                	andi	a5,a5,15
__STATIC_FORCEINLINE void __ECLIC_SetLevelIRQ(IRQn_Type IRQn, uint8_t lvl_abs)
{
    uint8_t nlbits = __ECLIC_GetCfgNlbits();
    uint8_t intctlbits = (uint8_t)__ECLIC_INTCTLBITS;

    if (nlbits == 0) {
 80003a2:	c78d                	beqz	a5,80003cc <main+0x10c>
    uint8_t nlbits = __ECLIC_GetCfgNlbits();
 80003a4:	0ff7f793          	zext.b	a5,a5
    }

    if (nlbits > intctlbits) {
        nlbits = intctlbits;
    }
    uint8_t maxlvl = ((1 << nlbits) - 1);
 80003a8:	4691                	li	a3,4
 80003aa:	873e                	mv	a4,a5
 80003ac:	08f6e363          	bltu	a3,a5,8000432 <main+0x172>
    return (ECLIC->CTRL[IRQn].INTCTRL);
 80003b0:	e00116b7          	lui	a3,0xe0011
 80003b4:	01f6c783          	lbu	a5,31(a3) # e001101f <_sp+0xbfff101f>
    if (lvl_abs > maxlvl) {
        lvl_abs = maxlvl;
    }
    uint8_t lvl = lvl_abs << (ECLIC_MAX_NLBITS - nlbits);
    uint8_t cur_ctrl = __ECLIC_GetCtrlIRQ(IRQn);
    cur_ctrl = cur_ctrl << nlbits;
 80003b8:	00e797b3          	sll	a5,a5,a4
    cur_ctrl = cur_ctrl >> nlbits;
 80003bc:	0ff7f793          	zext.b	a5,a5
 80003c0:	40e7d7b3          	sra	a5,a5,a4
 80003c4:	0ff7f793          	zext.b	a5,a5
    ECLIC->CTRL[IRQn].INTCTRL = intctrl;
 80003c8:	00f68fa3          	sb	a5,31(a3)
    ECLIC->CTRL[IRQn].INTIE |= CLIC_INTIE_IE_Msk;
 80003cc:	e0011737          	lui	a4,0xe0011
 80003d0:	01d74783          	lbu	a5,29(a4) # e001101d <_sp+0xbfff101d>
            ;
    }

    /* WWDG configuration */
    /* Enable WWDG clock */
    RCC_EnableAPB1PeriphClk(RCC_APB1_PERIPH_WWDG, ENABLE);
 80003d4:	6505                	lui	a0,0x1
 80003d6:	0ff7f793          	zext.b	a5,a5
 80003da:	0017e793          	ori	a5,a5,1
 80003de:	4585                	li	a1,1
 80003e0:	00f70ea3          	sb	a5,29(a4)
 80003e4:	80050513          	addi	a0,a0,-2048 # 800 <__STACK_SIZE-0x1800>
 80003e8:	117000ef          	jal	ra,8000cfe <RCC_EnableAPB1PeriphClk>

    /* WWDG clock counter = (PCLK1(36MHz) / 4096) / 8 = 1,098 Hz (0.9102 ms)  */
    WWDG_SetPrescalerDiv(WWDG_PRESCALER_DIV8);
 80003ec:	18000513          	li	a0,384
 80003f0:	587000ef          	jal	ra,8001176 <WWDG_SetPrescalerDiv>

    /* Set Window value to 80; WWDG counter should be refreshed only when the counter
      is below 80 (and greater than 64) otherwise a reset will be generated */
    WWDG_SetWValue(80);
 80003f4:	05000513          	li	a0,80
 80003f8:	5bd000ef          	jal	ra,80011b4 <WWDG_SetWValue>

    /*
      Enable WWDG and set counter value to 127, WWDG timeout = 0.9102 ms * 64 = 58.2528 ms
      In this case the refresh window is: 0.9102 ms * (127 - 80) = 42.7794 ms < refresh window < 0.9102 ms * 64 = 58.2528ms
    */
    WWDG_Enable(127);
 80003fc:	07f00513          	li	a0,127

    while (1)
    {
        /* Toggle LED2 */
        LedBlink(LED2_PORT, LED2_PIN);
 8000400:	400114b7          	lui	s1,0x40011
    WWDG_Enable(127);
 8000404:	643000ef          	jal	ra,8001246 <WWDG_Enable>
 8000408:	18000417          	auipc	s0,0x18000
 800040c:	c6440413          	addi	s0,s0,-924 # 2000006c <TimingDelay>
        LedBlink(LED2_PORT, LED2_PIN);
 8000410:	c0048493          	addi	s1,s1,-1024 # 40010c00 <_sp+0x1fff0c00>
 8000414:	03200913          	li	s2,50
 8000418:	4589                	li	a1,2
 800041a:	8526                	mv	a0,s1
 800041c:	2d4010ef          	jal	ra,80016f0 <LedBlink>
    TimingDelay = nTime;
 8000420:	01242023          	sw	s2,0(s0)
    while (TimingDelay != 0)
 8000424:	401c                	lw	a5,0(s0)
 8000426:	fffd                	bnez	a5,8000424 <main+0x164>

        Delay(50);

        /* Update WWDG counter */
        WWDG_SetCnt(127);
 8000428:	07f00513          	li	a0,127
 800042c:	5cd000ef          	jal	ra,80011f8 <WWDG_SetCnt>
        LedBlink(LED2_PORT, LED2_PIN);
 8000430:	b7e5                	j	8000418 <main+0x158>
    uint8_t maxlvl = ((1 << nlbits) - 1);
 8000432:	4711                	li	a4,4
 8000434:	bfb5                	j	80003b0 <main+0xf0>
        LedOff(LED1_PORT, LED1_PIN);
 8000436:	c0040513          	addi	a0,s0,-1024
 800043a:	2b0010ef          	jal	ra,80016ea <LedOff>
 800043e:	b709                	j	8000340 <main+0x80>

08000440 <__do_global_dtors_aux>:
 8000440:	1141                	addi	sp,sp,-16
 8000442:	c422                	sw	s0,8(sp)
 8000444:	18000417          	auipc	s0,0x18000
 8000448:	c4040413          	addi	s0,s0,-960 # 20000084 <completed.1>
 800044c:	00044783          	lbu	a5,0(s0)
 8000450:	c606                	sw	ra,12(sp)
 8000452:	ef99                	bnez	a5,8000470 <__do_global_dtors_aux+0x30>
 8000454:	00000793          	li	a5,0
 8000458:	cb89                	beqz	a5,800046a <__do_global_dtors_aux+0x2a>
 800045a:	18000517          	auipc	a0,0x18000
 800045e:	c1250513          	addi	a0,a0,-1006 # 2000006c <TimingDelay>
 8000462:	00000097          	auipc	ra,0x0
 8000466:	000000e7          	jalr	zero # 0 <__STACK_SIZE-0x2000>
 800046a:	4785                	li	a5,1
 800046c:	00f40023          	sb	a5,0(s0)
 8000470:	40b2                	lw	ra,12(sp)
 8000472:	4422                	lw	s0,8(sp)
 8000474:	0141                	addi	sp,sp,16
 8000476:	8082                	ret

08000478 <frame_dummy>:
 8000478:	00000793          	li	a5,0
 800047c:	cf89                	beqz	a5,8000496 <frame_dummy+0x1e>
 800047e:	18000597          	auipc	a1,0x18000
 8000482:	c0a58593          	addi	a1,a1,-1014 # 20000088 <object.0>
 8000486:	18000517          	auipc	a0,0x18000
 800048a:	be650513          	addi	a0,a0,-1050 # 2000006c <TimingDelay>
 800048e:	00000317          	auipc	t1,0x0
 8000492:	00000067          	jr	zero # 0 <__STACK_SIZE-0x2000>
 8000496:	8082                	ret

08000498 <ConfigPinRemap.part.0>:
  if(BitSeg == 0)
  {
	  return;
  }

  regnum = (BitSeg & REGNUM_MASK)>>10;
 8000498:	40a55713          	srai	a4,a0,0xa
  pos = (BitSeg & POS_MASK)>>5;
 800049c:	40555613          	srai	a2,a0,0x5
  bitwidth = (BitSeg & BITWIDTH_MASK)>>3;
 80004a0:	40355793          	srai	a5,a0,0x3
  regnum = (BitSeg & REGNUM_MASK)>>10;
 80004a4:	01f77813          	andi	a6,a4,31
  val = BitSeg & VAL_MASK;

  /* Check RmpPin relate AFIO RMP_CFG */
  switch(regnum)
 80004a8:	468d                	li	a3,3
  pos = (BitSeg & POS_MASK)>>5;
 80004aa:	8a7d                	andi	a2,a2,31
  bitwidth = (BitSeg & BITWIDTH_MASK)>>3;
 80004ac:	8b8d                	andi	a5,a5,3
  switch(regnum)
 80004ae:	0cd80763          	beq	a6,a3,800057c <ConfigPinRemap.part.0+0xe4>
 80004b2:	01c77693          	andi	a3,a4,28
 80004b6:	e29d                	bnez	a3,80004dc <ConfigPinRemap.part.0+0x44>
 80004b8:	0a080a63          	beqz	a6,800056c <ConfigPinRemap.part.0+0xd4>
 80004bc:	4689                	li	a3,2
 80004be:	0cd81d63          	bne	a6,a3,8000598 <ConfigPinRemap.part.0+0x100>
  	  case 0:
  		  tmpregister = AFIO->RMP_CFG;
  		  tmpregister |= ~DBGAFR_SWJCFG_MASK;  /* SW_JTAG_CFG is write only, the read value is undefined. write 7 has no effect on the original value */
  		  break;
	  case 2:
		  tmpregister = AFIO->RMP_CFG3;
 80004c2:	400106b7          	lui	a3,0x40010
 80004c6:	5294                	lw	a3,32(a3)
	  default:
		  return;
  }

  /* find the bit field and clear it */
  switch(bitwidth)
 80004c8:	4889                	li	a7,2
 80004ca:	03178263          	beq	a5,a7,80004ee <ConfigPinRemap.part.0+0x56>
 80004ce:	488d                	li	a7,3
 80004d0:	07178063          	beq	a5,a7,8000530 <ConfigPinRemap.part.0+0x98>
 80004d4:	4885                	li	a7,1
 80004d6:	01178d63          	beq	a5,a7,80004f0 <ConfigPinRemap.part.0+0x58>
		  break;
	  case 4:
		  AFIO->RMP_CFG5 = tmpregister;
		  break;
  }
}
 80004da:	8082                	ret
  switch(regnum)
 80004dc:	4691                	li	a3,4
 80004de:	04d81863          	bne	a6,a3,800052e <ConfigPinRemap.part.0+0x96>
		  tmpregister = AFIO->RMP_CFG5;
 80004e2:	400106b7          	lui	a3,0x40010
 80004e6:	5694                	lw	a3,40(a3)
  switch(bitwidth)
 80004e8:	4889                	li	a7,2
 80004ea:	ff1792e3          	bne	a5,a7,80004ce <ConfigPinRemap.part.0+0x36>
  		  tmp = ((uint32_t)0x03) << pos;
 80004ee:	478d                	li	a5,3
 80004f0:	00c797b3          	sll	a5,a5,a2
  		  tmpregister &= ~tmp;
 80004f4:	fff7c793          	not	a5,a5
 80004f8:	8ff5                	and	a5,a5,a3
  if (Cmd != DISABLE)
 80004fa:	c589                	beqz	a1,8000504 <ConfigPinRemap.part.0+0x6c>
  val = BitSeg & VAL_MASK;
 80004fc:	891d                	andi	a0,a0,7
	  tmpregister |= (val << pos);
 80004fe:	00c51533          	sll	a0,a0,a2
 8000502:	8fc9                	or	a5,a5,a0
  switch(regnum)
 8000504:	468d                	li	a3,3
 8000506:	08d80063          	beq	a6,a3,8000586 <ConfigPinRemap.part.0+0xee>
 800050a:	8b71                	andi	a4,a4,28
 800050c:	eb11                	bnez	a4,8000520 <ConfigPinRemap.part.0+0x88>
 800050e:	08080063          	beqz	a6,800058e <ConfigPinRemap.part.0+0xf6>
 8000512:	4709                	li	a4,2
 8000514:	08e81163          	bne	a6,a4,8000596 <ConfigPinRemap.part.0+0xfe>
		  AFIO->RMP_CFG3 = tmpregister;
 8000518:	40010737          	lui	a4,0x40010
 800051c:	d31c                	sw	a5,32(a4)
		  break;
 800051e:	8082                	ret
  switch(regnum)
 8000520:	4711                	li	a4,4
 8000522:	06e81163          	bne	a6,a4,8000584 <ConfigPinRemap.part.0+0xec>
		  AFIO->RMP_CFG5 = tmpregister;
 8000526:	40010737          	lui	a4,0x40010
 800052a:	d71c                	sw	a5,40(a4)
}
 800052c:	8082                	ret
 800052e:	8082                	ret
  		  tmp = ((uint32_t)0x07) << pos;
 8000530:	479d                	li	a5,7
  		  if((BitSeg == GPIO_RMP_SW_JTAG_NO_NJTRST) || (BitSeg == GPIO_RMP_SW_JTAG_SW_ENABLE) || (BitSeg == GPIO_RMP_SW_JTAG_DISABLE))
 8000532:	ce750893          	addi	a7,a0,-793
  		  tmp = ((uint32_t)0x07) << pos;
 8000536:	00c797b3          	sll	a5,a5,a2
  		  if((BitSeg == GPIO_RMP_SW_JTAG_NO_NJTRST) || (BitSeg == GPIO_RMP_SW_JTAG_SW_ENABLE) || (BitSeg == GPIO_RMP_SW_JTAG_DISABLE))
 800053a:	08c2                	slli	a7,a7,0x10
  		  tmpregister &= ~tmp;
 800053c:	fff7c793          	not	a5,a5
  		  if((BitSeg == GPIO_RMP_SW_JTAG_NO_NJTRST) || (BitSeg == GPIO_RMP_SW_JTAG_SW_ENABLE) || (BitSeg == GPIO_RMP_SW_JTAG_DISABLE))
 8000540:	0108d893          	srli	a7,a7,0x10
 8000544:	4305                	li	t1,1
  		  tmpregister &= ~tmp;
 8000546:	8ff5                	and	a5,a5,a3
  		  if((BitSeg == GPIO_RMP_SW_JTAG_NO_NJTRST) || (BitSeg == GPIO_RMP_SW_JTAG_SW_ENABLE) || (BitSeg == GPIO_RMP_SW_JTAG_DISABLE))
 8000548:	01137663          	bgeu	t1,a7,8000554 <ConfigPinRemap.part.0+0xbc>
 800054c:	31c00693          	li	a3,796
 8000550:	fad515e3          	bne	a0,a3,80004fa <ConfigPinRemap.part.0+0x62>
  			  AFIO->RMP_CFG &= DBGAFR_SWJCFG_MASK;
 8000554:	40010337          	lui	t1,0x40010
 8000558:	00432683          	lw	a3,4(t1) # 40010004 <_sp+0x1fff0004>
 800055c:	f90008b7          	lui	a7,0xf9000
 8000560:	18fd                	addi	a7,a7,-1
 8000562:	0116f6b3          	and	a3,a3,a7
 8000566:	00d32223          	sw	a3,4(t1)
 800056a:	bf41                	j	80004fa <ConfigPinRemap.part.0+0x62>
  		  tmpregister = AFIO->RMP_CFG;
 800056c:	400106b7          	lui	a3,0x40010
 8000570:	42d4                	lw	a3,4(a3)
  		  tmpregister |= ~DBGAFR_SWJCFG_MASK;  /* SW_JTAG_CFG is write only, the read value is undefined. write 7 has no effect on the original value */
 8000572:	070008b7          	lui	a7,0x7000
 8000576:	0116e6b3          	or	a3,a3,a7
  		  break;
 800057a:	b7b9                	j	80004c8 <ConfigPinRemap.part.0+0x30>
		  tmpregister = AFIO->RMP_CFG4;
 800057c:	400106b7          	lui	a3,0x40010
 8000580:	52d4                	lw	a3,36(a3)
		  break;
 8000582:	b799                	j	80004c8 <ConfigPinRemap.part.0+0x30>
 8000584:	8082                	ret
		  AFIO->RMP_CFG4 = tmpregister;
 8000586:	40010737          	lui	a4,0x40010
 800058a:	d35c                	sw	a5,36(a4)
		  break;
 800058c:	8082                	ret
  		  AFIO->RMP_CFG = tmpregister;
 800058e:	40010737          	lui	a4,0x40010
 8000592:	c35c                	sw	a5,4(a4)
  		  break;
 8000594:	8082                	ret
 8000596:	8082                	ret
 8000598:	8082                	ret

0800059a <GPIO_Init>:
 * @param GPIOx where x can be (A..G) to select the GPIO peripheral.
 * @param GPIO_InitStruct pointer to a GPIO_InitType structure that
 *         contains the configuration information for the specified GPIO peripheral.
 */
void GPIO_Init(GPIO_Module* GPIOx, GPIO_InitType* GPIO_InitStruct)
{
 800059a:	1141                	addi	sp,sp,-16
	uint32_t pos			= 0x00;
    uint32_t tmpregister	= 0x00;
	uint32_t pinmask		= 0x00;
	
    /* Check the parameters */
    assert_param(IS_GPIO_ALL_PERIPH(GPIOx));
 800059c:	400117b7          	lui	a5,0x40011
{
 80005a0:	c422                	sw	s0,8(sp)
 80005a2:	c226                	sw	s1,4(sp)
 80005a4:	c606                	sw	ra,12(sp)
 80005a6:	c04a                	sw	s2,0(sp)
    assert_param(IS_GPIO_ALL_PERIPH(GPIOx));
 80005a8:	80078713          	addi	a4,a5,-2048 # 40010800 <_sp+0x1fff0800>
{
 80005ac:	842a                	mv	s0,a0
 80005ae:	84ae                	mv	s1,a1
    assert_param(IS_GPIO_ALL_PERIPH(GPIOx));
 80005b0:	04e50463          	beq	a0,a4,80005f8 <GPIO_Init+0x5e>
 80005b4:	c0078713          	addi	a4,a5,-1024
 80005b8:	04e50063          	beq	a0,a4,80005f8 <GPIO_Init+0x5e>
 80005bc:	02f50e63          	beq	a0,a5,80005f8 <GPIO_Init+0x5e>
 80005c0:	40078793          	addi	a5,a5,1024
 80005c4:	02f50a63          	beq	a0,a5,80005f8 <GPIO_Init+0x5e>
 80005c8:	400127b7          	lui	a5,0x40012
 80005cc:	80078713          	addi	a4,a5,-2048 # 40011800 <_sp+0x1fff1800>
 80005d0:	02e50463          	beq	a0,a4,80005f8 <GPIO_Init+0x5e>
 80005d4:	c0078713          	addi	a4,a5,-1024
 80005d8:	02e50063          	beq	a0,a4,80005f8 <GPIO_Init+0x5e>
 80005dc:	00f50e63          	beq	a0,a5,80005f8 <GPIO_Init+0x5e>
 80005e0:	0f700613          	li	a2,247
 80005e4:	00002597          	auipc	a1,0x2
 80005e8:	6ec58593          	addi	a1,a1,1772 # 8002cd0 <_write+0x12>
 80005ec:	00002517          	auipc	a0,0x2
 80005f0:	73450513          	addi	a0,a0,1844 # 8002d20 <_write+0x62>
 80005f4:	4a9000ef          	jal	ra,800129c <assert_failed>
    assert_param(IS_GPIO_MODE(GPIO_InitStruct->GPIO_Mode));
 80005f8:	0084a903          	lw	s2,8(s1)
 80005fc:	ffb97793          	andi	a5,s2,-5
 8000600:	14078463          	beqz	a5,8000748 <GPIO_Init+0x1ae>
 8000604:	fd890793          	addi	a5,s2,-40
 8000608:	fdf7f793          	andi	a5,a5,-33
 800060c:	12078e63          	beqz	a5,8000748 <GPIO_Init+0x1ae>
 8000610:	ff397793          	andi	a5,s2,-13
 8000614:	4741                	li	a4,16
 8000616:	14e78363          	beq	a5,a4,800075c <GPIO_Init+0x1c2>
 800061a:	0f800613          	li	a2,248
 800061e:	00002597          	auipc	a1,0x2
 8000622:	6b258593          	addi	a1,a1,1714 # 8002cd0 <_write+0x12>
 8000626:	00002517          	auipc	a0,0x2
 800062a:	71650513          	addi	a0,a0,1814 # 8002d3c <_write+0x7e>
 800062e:	46f000ef          	jal	ra,800129c <assert_failed>
    assert_param(IS_GPIO_PIN(GPIO_InitStruct->Pin));
 8000632:	0004d783          	lhu	a5,0(s1)
 8000636:	ef89                	bnez	a5,8000650 <GPIO_Init+0xb6>
 8000638:	0f900613          	li	a2,249
 800063c:	00002597          	auipc	a1,0x2
 8000640:	69458593          	addi	a1,a1,1684 # 8002cd0 <_write+0x12>
 8000644:	00002517          	auipc	a0,0x2
 8000648:	72450513          	addi	a0,a0,1828 # 8002d68 <_write+0xaa>
 800064c:	451000ef          	jal	ra,800129c <assert_failed>

    /*---------------------------- GPIO Mode Configuration -----------------------*/
    currentmode = ((uint32_t) GPIO_InitStruct->GPIO_Mode) & ((uint32_t) 0x0F);
 8000650:	0084a903          	lw	s2,8(s1)
    if ((((uint32_t) GPIO_InitStruct->GPIO_Mode) & ((uint32_t) 0x10)) != 0x00) /* Output mode */
 8000654:	01097793          	andi	a5,s2,16
    currentmode = ((uint32_t) GPIO_InitStruct->GPIO_Mode) & ((uint32_t) 0x0F);
 8000658:	00f97913          	andi	s2,s2,15
    if ((((uint32_t) GPIO_InitStruct->GPIO_Mode) & ((uint32_t) 0x10)) != 0x00) /* Output mode */
 800065c:	10078763          	beqz	a5,800076a <GPIO_Init+0x1d0>
    {
        /* Check the parameters */
        assert_param(IS_GPIO_SPEED(GPIO_InitStruct->GPIO_Speed));
 8000660:	40dc                	lw	a5,4(s1)
 8000662:	470d                	li	a4,3
 8000664:	00f77f63          	bgeu	a4,a5,8000682 <GPIO_Init+0xe8>
 8000668:	10000613          	li	a2,256
 800066c:	00002597          	auipc	a1,0x2
 8000670:	66458593          	addi	a1,a1,1636 # 8002cd0 <_write+0x12>
 8000674:	00002517          	auipc	a0,0x2
 8000678:	71850513          	addi	a0,a0,1816 # 8002d8c <_write+0xce>
 800067c:	421000ef          	jal	ra,800129c <assert_failed>
		
        /* Output mode */
        currentmode |= ((uint32_t) GPIO_InitStruct->GPIO_Speed);
 8000680:	40dc                	lw	a5,4(s1)
    }
	
    /*---------------------------- GPIO PL_CFG Configuration ------------------------*/
    /* Configure the eight low port pins */
    if (((uint32_t)GPIO_InitStruct->Pin & ((uint32_t)0x00FF)) != 0x00)
 8000682:	0004d683          	lhu	a3,0(s1)
        currentmode |= ((uint32_t) GPIO_InitStruct->GPIO_Speed);
 8000686:	00f96933          	or	s2,s2,a5
    if (((uint32_t)GPIO_InitStruct->Pin & ((uint32_t)0x00FF)) != 0x00)
 800068a:	0ff6f793          	zext.b	a5,a3
 800068e:	cba9                	beqz	a5,80006e0 <GPIO_Init+0x146>
    {
        tmpregister = GPIOx->PL_CFG;
 8000690:	400c                	lw	a1,0(s0)
        for (pinpos = 0x00; pinpos < 0x08; pinpos++)
 8000692:	4781                	li	a5,0
        {
			/* Pin logic position to pin bit-mask position */
            pos = ((uint32_t) 0x01) << pinpos;
 8000694:	4885                	li	a7,1
            {
				/* Calculate the corresponding low control register bits position */
                pos = pinpos << 2;
				
                /* Clear the corresponding low control register bits */
                pinmask = ((uint32_t) 0x0F) << pos;
 8000696:	4ebd                	li	t4,15
				
                /* Write the mode configuration in the corresponding bits */
                tmpregister |= (currentmode << pos);
				
                /* Reset the corresponding POD bit */
                if (GPIO_InitStruct->GPIO_Mode == GPIO_Mode_IPD)
 8000698:	02800e13          	li	t3,40
                    GPIOx->PBC = (((uint32_t) 0x01) << pinpos); /* Input Pull-Down Mode */
                }
                else
                {
                    /* Set the corresponding POD bit */
                    if (GPIO_InitStruct->GPIO_Mode == GPIO_Mode_IPU)
 800069c:	04800f13          	li	t5,72
        for (pinpos = 0x00; pinpos < 0x08; pinpos++)
 80006a0:	4821                	li	a6,8
 80006a2:	a021                	j	80006aa <GPIO_Init+0x110>
 80006a4:	0785                	addi	a5,a5,1
 80006a6:	03078c63          	beq	a5,a6,80006de <GPIO_Init+0x144>
            pos = ((uint32_t) 0x01) << pinpos;
 80006aa:	00f89733          	sll	a4,a7,a5
            currentpin = (GPIO_InitStruct->Pin) & pos;
 80006ae:	00e6f633          	and	a2,a3,a4
            if (currentpin == pos)
 80006b2:	fec719e3          	bne	a4,a2,80006a4 <GPIO_Init+0x10a>
                    if (GPIO_InitStruct->GPIO_Mode == GPIO_Mode_IPU)
 80006b6:	00279613          	slli	a2,a5,0x2
                pinmask = ((uint32_t) 0x0F) << pos;
 80006ba:	00ce9533          	sll	a0,t4,a2
                tmpregister &= ~pinmask;
 80006be:	fff54513          	not	a0,a0
                if (GPIO_InitStruct->GPIO_Mode == GPIO_Mode_IPD)
 80006c2:	0084a303          	lw	t1,8(s1)
                tmpregister &= ~pinmask;
 80006c6:	8de9                	and	a1,a1,a0
                tmpregister |= (currentmode << pos);
 80006c8:	00c91633          	sll	a2,s2,a2
 80006cc:	8dd1                	or	a1,a1,a2
                if (GPIO_InitStruct->GPIO_Mode == GPIO_Mode_IPD)
 80006ce:	09c30563          	beq	t1,t3,8000758 <GPIO_Init+0x1be>
                    if (GPIO_InitStruct->GPIO_Mode == GPIO_Mode_IPU)
 80006d2:	fde319e3          	bne	t1,t5,80006a4 <GPIO_Init+0x10a>
                    {
                        GPIOx->PBSC = (((uint32_t) 0x01) << pinpos); /* Input Pull-Up Mode */
 80006d6:	c818                	sw	a4,16(s0)
        for (pinpos = 0x00; pinpos < 0x08; pinpos++)
 80006d8:	0785                	addi	a5,a5,1
 80006da:	fd0798e3          	bne	a5,a6,80006aa <GPIO_Init+0x110>
                    }
                }
            }
        }

        GPIOx->PL_CFG = tmpregister;
 80006de:	c00c                	sw	a1,0(s0)
    }
    /*---------------------------- GPIO PH_CFG Configuration ------------------------*/
    /* Configure the eight high port pins */
    if (GPIO_InitStruct->Pin > 0x00FF)
 80006e0:	0ff00793          	li	a5,255
 80006e4:	04d7fc63          	bgeu	a5,a3,800073c <GPIO_Init+0x1a2>
    {
        tmpregister = GPIOx->PH_CFG;
 80006e8:	404c                	lw	a1,4(s0)
        for (pinpos = 0x00; pinpos < 0x08; pinpos++)
 80006ea:	4701                	li	a4,0
        {
            pos = (((uint32_t) 0x01) << (pinpos + 0x08));
 80006ec:	4885                	li	a7,1
            if (currentpin == pos)
            {
                pos = pinpos << 2;
				
                /* Clear the corresponding high control register bits */
                pinmask = ((uint32_t) 0x0F) << pos;
 80006ee:	4ebd                	li	t4,15
				
                /* Write the mode configuration in the corresponding bits */
                tmpregister |= (currentmode << pos);
				
                /* Reset the corresponding POD bit */
                if (GPIO_InitStruct->GPIO_Mode == GPIO_Mode_IPD)
 80006f0:	02800e13          	li	t3,40
                {
                    GPIOx->PBC = (((uint32_t) 0x01) << (pinpos + 0x08));
                }
                /* Set the corresponding POD bit */
                if (GPIO_InitStruct->GPIO_Mode == GPIO_Mode_IPU)
 80006f4:	04800f13          	li	t5,72
        for (pinpos = 0x00; pinpos < 0x08; pinpos++)
 80006f8:	4821                	li	a6,8
 80006fa:	a021                	j	8000702 <GPIO_Init+0x168>
 80006fc:	0705                	addi	a4,a4,1
 80006fe:	03070e63          	beq	a4,a6,800073a <GPIO_Init+0x1a0>
            pos = (((uint32_t) 0x01) << (pinpos + 0x08));
 8000702:	00870793          	addi	a5,a4,8 # 40010008 <_sp+0x1fff0008>
 8000706:	00f897b3          	sll	a5,a7,a5
            currentpin = ((GPIO_InitStruct->Pin) & pos);
 800070a:	00f6f633          	and	a2,a3,a5
            if (currentpin == pos)
 800070e:	fec797e3          	bne	a5,a2,80006fc <GPIO_Init+0x162>
                if (GPIO_InitStruct->GPIO_Mode == GPIO_Mode_IPU)
 8000712:	00271613          	slli	a2,a4,0x2
                pinmask = ((uint32_t) 0x0F) << pos;
 8000716:	00ce9533          	sll	a0,t4,a2
                tmpregister &= ~pinmask;
 800071a:	fff54513          	not	a0,a0
                if (GPIO_InitStruct->GPIO_Mode == GPIO_Mode_IPD)
 800071e:	0084a303          	lw	t1,8(s1)
                tmpregister &= ~pinmask;
 8000722:	8de9                	and	a1,a1,a0
                tmpregister |= (currentmode << pos);
 8000724:	00c91633          	sll	a2,s2,a2
 8000728:	8dd1                	or	a1,a1,a2
                if (GPIO_InitStruct->GPIO_Mode == GPIO_Mode_IPD)
 800072a:	03c30563          	beq	t1,t3,8000754 <GPIO_Init+0x1ba>
                if (GPIO_InitStruct->GPIO_Mode == GPIO_Mode_IPU)
 800072e:	fde317e3          	bne	t1,t5,80006fc <GPIO_Init+0x162>
                {
                    GPIOx->PBSC = (((uint32_t) 0x01) << (pinpos + 0x08));
 8000732:	c81c                	sw	a5,16(s0)
        for (pinpos = 0x00; pinpos < 0x08; pinpos++)
 8000734:	0705                	addi	a4,a4,1
 8000736:	fd0716e3          	bne	a4,a6,8000702 <GPIO_Init+0x168>
                }
            }
        }

        GPIOx->PH_CFG = tmpregister;
 800073a:	c04c                	sw	a1,4(s0)
    }
}
 800073c:	40b2                	lw	ra,12(sp)
 800073e:	4422                	lw	s0,8(sp)
 8000740:	4492                	lw	s1,4(sp)
 8000742:	4902                	lw	s2,0(sp)
 8000744:	0141                	addi	sp,sp,16
 8000746:	8082                	ret
    assert_param(IS_GPIO_PIN(GPIO_InitStruct->Pin));
 8000748:	0004d683          	lhu	a3,0(s1)
    currentmode = ((uint32_t) GPIO_InitStruct->GPIO_Mode) & ((uint32_t) 0x0F);
 800074c:	00f97913          	andi	s2,s2,15
    assert_param(IS_GPIO_PIN(GPIO_InitStruct->Pin));
 8000750:	fe8d                	bnez	a3,800068a <GPIO_Init+0xf0>
 8000752:	b5dd                	j	8000638 <GPIO_Init+0x9e>
                    GPIOx->PBC = (((uint32_t) 0x01) << (pinpos + 0x08));
 8000754:	c85c                	sw	a5,20(s0)
                if (GPIO_InitStruct->GPIO_Mode == GPIO_Mode_IPU)
 8000756:	b75d                	j	80006fc <GPIO_Init+0x162>
                    GPIOx->PBC = (((uint32_t) 0x01) << pinpos); /* Input Pull-Down Mode */
 8000758:	c858                	sw	a4,20(s0)
 800075a:	b7a9                	j	80006a4 <GPIO_Init+0x10a>
    assert_param(IS_GPIO_PIN(GPIO_InitStruct->Pin));
 800075c:	0004d783          	lhu	a5,0(s1)
    currentmode = ((uint32_t) GPIO_InitStruct->GPIO_Mode) & ((uint32_t) 0x0F);
 8000760:	00f97913          	andi	s2,s2,15
    assert_param(IS_GPIO_PIN(GPIO_InitStruct->Pin));
 8000764:	ee079ee3          	bnez	a5,8000660 <GPIO_Init+0xc6>
 8000768:	bdc1                	j	8000638 <GPIO_Init+0x9e>
    if (((uint32_t)GPIO_InitStruct->Pin & ((uint32_t)0x00FF)) != 0x00)
 800076a:	0004d683          	lhu	a3,0(s1)
 800076e:	bf31                	j	800068a <GPIO_Init+0xf0>

08000770 <GPIO_ReadOutputData>:
 * @brief  Reads the specified GPIO output data port.
 * @param  GPIOx where x can be (A..G) to select the GPIO peripheral.
 * @return GPIO output data port value.
 */
uint16_t GPIO_ReadOutputData(GPIO_Module* GPIOx)
{
 8000770:	1141                	addi	sp,sp,-16
    /* Check the parameters */
    assert_param(IS_GPIO_ALL_PERIPH(GPIOx));
 8000772:	400117b7          	lui	a5,0x40011
{
 8000776:	c422                	sw	s0,8(sp)
 8000778:	c606                	sw	ra,12(sp)
    assert_param(IS_GPIO_ALL_PERIPH(GPIOx));
 800077a:	80078713          	addi	a4,a5,-2048 # 40010800 <_sp+0x1fff0800>
{
 800077e:	842a                	mv	s0,a0
    assert_param(IS_GPIO_ALL_PERIPH(GPIOx));
 8000780:	04e50463          	beq	a0,a4,80007c8 <GPIO_ReadOutputData+0x58>
 8000784:	c0078713          	addi	a4,a5,-1024
 8000788:	04e50063          	beq	a0,a4,80007c8 <GPIO_ReadOutputData+0x58>
 800078c:	02f50e63          	beq	a0,a5,80007c8 <GPIO_ReadOutputData+0x58>
 8000790:	40078793          	addi	a5,a5,1024
 8000794:	02f50a63          	beq	a0,a5,80007c8 <GPIO_ReadOutputData+0x58>
 8000798:	400127b7          	lui	a5,0x40012
 800079c:	80078713          	addi	a4,a5,-2048 # 40011800 <_sp+0x1fff1800>
 80007a0:	02e50463          	beq	a0,a4,80007c8 <GPIO_ReadOutputData+0x58>
 80007a4:	c0078713          	addi	a4,a5,-1024
 80007a8:	02e50063          	beq	a0,a4,80007c8 <GPIO_ReadOutputData+0x58>
 80007ac:	00f50e63          	beq	a0,a5,80007c8 <GPIO_ReadOutputData+0x58>
 80007b0:	1af00613          	li	a2,431
 80007b4:	00002597          	auipc	a1,0x2
 80007b8:	51c58593          	addi	a1,a1,1308 # 8002cd0 <_write+0x12>
 80007bc:	00002517          	auipc	a0,0x2
 80007c0:	56450513          	addi	a0,a0,1380 # 8002d20 <_write+0x62>
 80007c4:	2d9000ef          	jal	ra,800129c <assert_failed>

    return ((uint16_t) GPIOx->POD);
 80007c8:	4448                	lw	a0,12(s0)
}
 80007ca:	40b2                	lw	ra,12(sp)
 80007cc:	4422                	lw	s0,8(sp)
 80007ce:	0542                	slli	a0,a0,0x10
 80007d0:	8141                	srli	a0,a0,0x10
 80007d2:	0141                	addi	sp,sp,16
 80007d4:	8082                	ret

080007d6 <GPIO_WriteBit>:
 *   This parameter can be one of the Bit_OperateType enum values:
 *     @arg Bit_RESET to clear the port pin
 *     @arg Bit_SET to set the port pin
 */
void GPIO_WriteBit(GPIO_Module* GPIOx, uint16_t Pin, Bit_OperateType BitCmd)
{
 80007d6:	1141                	addi	sp,sp,-16
    /* Check the parameters */
    assert_param(IS_GPIO_ALL_PERIPH(GPIOx));
 80007d8:	400117b7          	lui	a5,0x40011
{
 80007dc:	c422                	sw	s0,8(sp)
 80007de:	c226                	sw	s1,4(sp)
 80007e0:	c04a                	sw	s2,0(sp)
 80007e2:	c606                	sw	ra,12(sp)
    assert_param(IS_GPIO_ALL_PERIPH(GPIOx));
 80007e4:	80078713          	addi	a4,a5,-2048 # 40010800 <_sp+0x1fff0800>
{
 80007e8:	842a                	mv	s0,a0
 80007ea:	84ae                	mv	s1,a1
 80007ec:	8932                	mv	s2,a2
    assert_param(IS_GPIO_ALL_PERIPH(GPIOx));
 80007ee:	04e50463          	beq	a0,a4,8000836 <GPIO_WriteBit+0x60>
 80007f2:	c0078713          	addi	a4,a5,-1024
 80007f6:	04e50063          	beq	a0,a4,8000836 <GPIO_WriteBit+0x60>
 80007fa:	02f50e63          	beq	a0,a5,8000836 <GPIO_WriteBit+0x60>
 80007fe:	40078793          	addi	a5,a5,1024
 8000802:	02f50a63          	beq	a0,a5,8000836 <GPIO_WriteBit+0x60>
 8000806:	400127b7          	lui	a5,0x40012
 800080a:	80078713          	addi	a4,a5,-2048 # 40011800 <_sp+0x1fff1800>
 800080e:	02e50463          	beq	a0,a4,8000836 <GPIO_WriteBit+0x60>
 8000812:	c0078713          	addi	a4,a5,-1024
 8000816:	02e50063          	beq	a0,a4,8000836 <GPIO_WriteBit+0x60>
 800081a:	00f50e63          	beq	a0,a5,8000836 <GPIO_WriteBit+0x60>
 800081e:	1ef00613          	li	a2,495
 8000822:	00002597          	auipc	a1,0x2
 8000826:	4ae58593          	addi	a1,a1,1198 # 8002cd0 <_write+0x12>
 800082a:	00002517          	auipc	a0,0x2
 800082e:	4f650513          	addi	a0,a0,1270 # 8002d20 <_write+0x62>
 8000832:	26b000ef          	jal	ra,800129c <assert_failed>
    assert_param(IS_GET_GPIO_PIN(Pin));
 8000836:	fff48793          	addi	a5,s1,-1
 800083a:	07c2                	slli	a5,a5,0x10
 800083c:	83c1                	srli	a5,a5,0x10
 800083e:	4705                	li	a4,1
 8000840:	06f77f63          	bgeu	a4,a5,80008be <GPIO_WriteBit+0xe8>
 8000844:	ffc48793          	addi	a5,s1,-4
 8000848:	9bed                	andi	a5,a5,-5
 800084a:	07c2                	slli	a5,a5,0x10
 800084c:	83c1                	srli	a5,a5,0x10
 800084e:	cba5                	beqz	a5,80008be <GPIO_WriteBit+0xe8>
 8000850:	ff048793          	addi	a5,s1,-16
 8000854:	9bbd                	andi	a5,a5,-17
 8000856:	07c2                	slli	a5,a5,0x10
 8000858:	83c1                	srli	a5,a5,0x10
 800085a:	c3b5                	beqz	a5,80008be <GPIO_WriteBit+0xe8>
 800085c:	fc048793          	addi	a5,s1,-64
 8000860:	fbf7f793          	andi	a5,a5,-65
 8000864:	07c2                	slli	a5,a5,0x10
 8000866:	83c1                	srli	a5,a5,0x10
 8000868:	cbb9                	beqz	a5,80008be <GPIO_WriteBit+0xe8>
 800086a:	f0048793          	addi	a5,s1,-256
 800086e:	eff7f793          	andi	a5,a5,-257
 8000872:	07c2                	slli	a5,a5,0x10
 8000874:	83c1                	srli	a5,a5,0x10
 8000876:	c7a1                	beqz	a5,80008be <GPIO_WriteBit+0xe8>
 8000878:	c0048793          	addi	a5,s1,-1024
 800087c:	bff7f793          	andi	a5,a5,-1025
 8000880:	07c2                	slli	a5,a5,0x10
 8000882:	83c1                	srli	a5,a5,0x10
 8000884:	cf8d                	beqz	a5,80008be <GPIO_WriteBit+0xe8>
 8000886:	77fd                	lui	a5,0xfffff
 8000888:	777d                	lui	a4,0xfffff
 800088a:	97a6                	add	a5,a5,s1
 800088c:	177d                	addi	a4,a4,-1
 800088e:	8ff9                	and	a5,a5,a4
 8000890:	07c2                	slli	a5,a5,0x10
 8000892:	83c1                	srli	a5,a5,0x10
 8000894:	c78d                	beqz	a5,80008be <GPIO_WriteBit+0xe8>
 8000896:	77f1                	lui	a5,0xffffc
 8000898:	7771                	lui	a4,0xffffc
 800089a:	97a6                	add	a5,a5,s1
 800089c:	177d                	addi	a4,a4,-1
 800089e:	8ff9                	and	a5,a5,a4
 80008a0:	07c2                	slli	a5,a5,0x10
 80008a2:	83c1                	srli	a5,a5,0x10
 80008a4:	cf89                	beqz	a5,80008be <GPIO_WriteBit+0xe8>
 80008a6:	1f000613          	li	a2,496
 80008aa:	00002597          	auipc	a1,0x2
 80008ae:	42658593          	addi	a1,a1,1062 # 8002cd0 <_write+0x12>
 80008b2:	00002517          	auipc	a0,0x2
 80008b6:	50650513          	addi	a0,a0,1286 # 8002db8 <_write+0xfa>
 80008ba:	1e3000ef          	jal	ra,800129c <assert_failed>
    assert_param(IS_GPIO_BIT_OPERATE(BitCmd));
 80008be:	4785                	li	a5,1
 80008c0:	0127eb63          	bltu	a5,s2,80008d6 <GPIO_WriteBit+0x100>

    if (BitCmd != Bit_RESET)
 80008c4:	02091563          	bnez	s2,80008ee <GPIO_WriteBit+0x118>
    {
        GPIOx->PBSC = Pin;
    }
    else
    {
        GPIOx->PBC = Pin;
 80008c8:	c844                	sw	s1,20(s0)
    }
}
 80008ca:	40b2                	lw	ra,12(sp)
 80008cc:	4422                	lw	s0,8(sp)
 80008ce:	4492                	lw	s1,4(sp)
 80008d0:	4902                	lw	s2,0(sp)
 80008d2:	0141                	addi	sp,sp,16
 80008d4:	8082                	ret
    assert_param(IS_GPIO_BIT_OPERATE(BitCmd));
 80008d6:	1f100613          	li	a2,497
 80008da:	00002597          	auipc	a1,0x2
 80008de:	3f658593          	addi	a1,a1,1014 # 8002cd0 <_write+0x12>
 80008e2:	00002517          	auipc	a0,0x2
 80008e6:	4ee50513          	addi	a0,a0,1262 # 8002dd0 <_write+0x112>
 80008ea:	1b3000ef          	jal	ra,800129c <assert_failed>
        GPIOx->PBSC = Pin;
 80008ee:	c804                	sw	s1,16(s0)
}
 80008f0:	40b2                	lw	ra,12(sp)
 80008f2:	4422                	lw	s0,8(sp)
 80008f4:	4492                	lw	s1,4(sp)
 80008f6:	4902                	lw	s2,0(sp)
 80008f8:	0141                	addi	sp,sp,16
 80008fa:	8082                	ret

080008fc <GPIO_Write>:
 * @brief Writes data to the specified GPIO data port.
 * @param GPIOx where x can be (A..G) to select the GPIO peripheral.
 * @param PortVal specifies the value to be written to the port output data register.
 */
void GPIO_Write(GPIO_Module* GPIOx, uint16_t PortVal)
{
 80008fc:	1141                	addi	sp,sp,-16
    /* Check the parameters */
    assert_param(IS_GPIO_ALL_PERIPH(GPIOx));
 80008fe:	400117b7          	lui	a5,0x40011
{
 8000902:	c422                	sw	s0,8(sp)
 8000904:	c226                	sw	s1,4(sp)
 8000906:	c606                	sw	ra,12(sp)
    assert_param(IS_GPIO_ALL_PERIPH(GPIOx));
 8000908:	80078713          	addi	a4,a5,-2048 # 40010800 <_sp+0x1fff0800>
{
 800090c:	842a                	mv	s0,a0
 800090e:	84ae                	mv	s1,a1
    assert_param(IS_GPIO_ALL_PERIPH(GPIOx));
 8000910:	04e50463          	beq	a0,a4,8000958 <GPIO_Write+0x5c>
 8000914:	c0078713          	addi	a4,a5,-1024
 8000918:	04e50063          	beq	a0,a4,8000958 <GPIO_Write+0x5c>
 800091c:	02f50e63          	beq	a0,a5,8000958 <GPIO_Write+0x5c>
 8000920:	40078793          	addi	a5,a5,1024
 8000924:	02f50a63          	beq	a0,a5,8000958 <GPIO_Write+0x5c>
 8000928:	400127b7          	lui	a5,0x40012
 800092c:	80078713          	addi	a4,a5,-2048 # 40011800 <_sp+0x1fff1800>
 8000930:	02e50463          	beq	a0,a4,8000958 <GPIO_Write+0x5c>
 8000934:	c0078713          	addi	a4,a5,-1024
 8000938:	02e50063          	beq	a0,a4,8000958 <GPIO_Write+0x5c>
 800093c:	00f50e63          	beq	a0,a5,8000958 <GPIO_Write+0x5c>
 8000940:	20500613          	li	a2,517
 8000944:	00002597          	auipc	a1,0x2
 8000948:	38c58593          	addi	a1,a1,908 # 8002cd0 <_write+0x12>
 800094c:	00002517          	auipc	a0,0x2
 8000950:	3d450513          	addi	a0,a0,980 # 8002d20 <_write+0x62>
 8000954:	149000ef          	jal	ra,800129c <assert_failed>

    GPIOx->POD = PortVal;
 8000958:	c444                	sw	s1,12(s0)
}
 800095a:	40b2                	lw	ra,12(sp)
 800095c:	4422                	lw	s0,8(sp)
 800095e:	4492                	lw	s1,4(sp)
 8000960:	0141                	addi	sp,sp,16
 8000962:	8082                	ret

08000964 <GPIO_ConfigPinRemap>:
 *     @arg GPIO_RMP_RST_EN_ECLAMP1 ECLAMP1 Reset Alternate Function mapping
 * @param Cmd new state of the port pin remapping.
 *   This parameter can be: ENABLE or DISABLE.
 */
void GPIO_ConfigPinRemap(uint32_t RmpPin, FunctionalState Cmd)
{
 8000964:	1101                	addi	sp,sp,-32
 8000966:	cc22                	sw	s0,24(sp)
 8000968:	ca26                	sw	s1,20(sp)
 800096a:	c84a                	sw	s2,16(sp)
 800096c:	ce06                	sw	ra,28(sp)

	/* Check the parameters */
	assert_param(IS_GPIO_REMAP(RmpPin));
	assert_param(IS_FUNCTIONAL_STATE(Cmd));

	bitsegL = RmpPin & LSB_MASK;
 800096e:	01051913          	slli	s2,a0,0x10
{
 8000972:	c64e                	sw	s3,12(sp)
	assert_param(IS_GPIO_REMAP(RmpPin));
 8000974:	f9f57793          	andi	a5,a0,-97
 8000978:	4725                	li	a4,9
{
 800097a:	842a                	mv	s0,a0
 800097c:	84ae                	mv	s1,a1
	bitsegL = RmpPin & LSB_MASK;
 800097e:	01095913          	srli	s2,s2,0x10
	assert_param(IS_GPIO_REMAP(RmpPin));
 8000982:	18e78f63          	beq	a5,a4,8000b20 <GPIO_ConfigPinRemap+0x1bc>
 8000986:	fbd57713          	andi	a4,a0,-67
 800098a:	09100613          	li	a2,145
 800098e:	ffd57593          	andi	a1,a0,-3
 8000992:	18c70763          	beq	a4,a2,8000b20 <GPIO_ConfigPinRemap+0x1bc>
 8000996:	fdf57693          	andi	a3,a0,-33
 800099a:	eef50613          	addi	a2,a0,-273
 800099e:	4509                	li	a0,2
 80009a0:	18c57063          	bgeu	a0,a2,8000b20 <GPIO_ConfigPinRemap+0x1bc>
 80009a4:	eae40613          	addi	a2,s0,-338
 80009a8:	4805                	li	a6,1
 80009aa:	16c87b63          	bgeu	a6,a2,8000b20 <GPIO_ConfigPinRemap+0x1bc>
 80009ae:	e7740613          	addi	a2,s0,-393
 80009b2:	eff67613          	andi	a2,a2,-257
 80009b6:	16060563          	beqz	a2,8000b20 <GPIO_ConfigPinRemap+0x1bc>
 80009ba:	e4f40613          	addi	a2,s0,-433
 80009be:	16c57163          	bgeu	a0,a2,8000b20 <GPIO_ConfigPinRemap+0x1bc>
 80009c2:	1e900613          	li	a2,489
 80009c6:	14c40d63          	beq	s0,a2,8000b20 <GPIO_ConfigPinRemap+0x1bc>
 80009ca:	20900613          	li	a2,521
 80009ce:	14c78963          	beq	a5,a2,8000b20 <GPIO_ConfigPinRemap+0x1bc>
 80009d2:	ce740613          	addi	a2,s0,-793
 80009d6:	14c87563          	bgeu	a6,a2,8000b20 <GPIO_ConfigPinRemap+0x1bc>
 80009da:	31c00613          	li	a2,796
 80009de:	14c40163          	beq	s0,a2,8000b20 <GPIO_ConfigPinRemap+0x1bc>
 80009e2:	6805                	lui	a6,0x1
 80009e4:	83180613          	addi	a2,a6,-1999 # 831 <__STACK_SIZE-0x17cf>
 80009e8:	12c58c63          	beq	a1,a2,8000b20 <GPIO_ConfigPinRemap+0x1bc>
 80009ec:	767d                	lui	a2,0xfffff
 80009ee:	76e60513          	addi	a0,a2,1902 # fffff76e <_sp+0xdffdf76e>
 80009f2:	9522                	add	a0,a0,s0
 80009f4:	f7e57513          	andi	a0,a0,-130
 80009f8:	12050463          	beqz	a0,8000b20 <GPIO_ConfigPinRemap+0x1bc>
 80009fc:	72f60513          	addi	a0,a2,1839
 8000a00:	952e                	add	a0,a0,a1
 8000a02:	f7f57513          	andi	a0,a0,-129
 8000a06:	10050d63          	beqz	a0,8000b20 <GPIO_ConfigPinRemap+0x1bc>
 8000a0a:	99180813          	addi	a6,a6,-1647
 8000a0e:	11058963          	beq	a1,a6,8000b20 <GPIO_ConfigPinRemap+0x1bc>
 8000a12:	62f60513          	addi	a0,a2,1583
 8000a16:	9522                	add	a0,a0,s0
 8000a18:	4889                	li	a7,2
 8000a1a:	10a8f363          	bgeu	a7,a0,8000b20 <GPIO_ConfigPinRemap+0x1bc>
 8000a1e:	0a480537          	lui	a0,0xa480
 8000a22:	0525                	addi	a0,a0,9
 8000a24:	14a40863          	beq	s0,a0,8000b74 <GPIO_ConfigPinRemap+0x210>
 8000a28:	f5b70537          	lui	a0,0xf5b70
 8000a2c:	1561                	addi	a0,a0,-8
 8000a2e:	9522                	add	a0,a0,s0
 8000a30:	4805                	li	a6,1
 8000a32:	14a87163          	bgeu	a6,a0,8000b74 <GPIO_ConfigPinRemap+0x210>
 8000a36:	0a680537          	lui	a0,0xa680
 8000a3a:	06950513          	addi	a0,a0,105 # a680069 <_data_lma+0x267cc79>
 8000a3e:	12a40b63          	beq	s0,a0,8000b74 <GPIO_ConfigPinRemap+0x210>
 8000a42:	f5970537          	lui	a0,0xf5970
 8000a46:	f9850513          	addi	a0,a0,-104 # f596ff98 <_sp+0xd594ff98>
 8000a4a:	9522                	add	a0,a0,s0
 8000a4c:	12a87463          	bgeu	a6,a0,8000b74 <GPIO_ConfigPinRemap+0x210>
 8000a50:	fbf47813          	andi	a6,s0,-65
 8000a54:	56f60613          	addi	a2,a2,1391
 8000a58:	9642                	add	a2,a2,a6
 8000a5a:	0cc8f363          	bgeu	a7,a2,8000b20 <GPIO_ConfigPinRemap+0x1bc>
 8000a5e:	757d                	lui	a0,0xfffff
 8000a60:	4ee50613          	addi	a2,a0,1262 # fffff4ee <_sp+0xdffdf4ee>
 8000a64:	9622                	add	a2,a2,s0
 8000a66:	4885                	li	a7,1
 8000a68:	0ac8fc63          	bgeu	a7,a2,8000b20 <GPIO_ConfigPinRemap+0x1bc>
 8000a6c:	6605                	lui	a2,0x1
 8000a6e:	f7d47893          	andi	a7,s0,-131
 8000a72:	b5160313          	addi	t1,a2,-1199 # b51 <__STACK_SIZE-0x14af>
 8000a76:	0a688563          	beq	a7,t1,8000b20 <GPIO_ConfigPinRemap+0x1bc>
 8000a7a:	3ef50893          	addi	a7,a0,1007
 8000a7e:	98c2                	add	a7,a7,a6
 8000a80:	4309                	li	t1,2
 8000a82:	09137f63          	bgeu	t1,a7,8000b20 <GPIO_ConfigPinRemap+0x1bc>
 8000a86:	c9160893          	addi	a7,a2,-879
 8000a8a:	09170b63          	beq	a4,a7,8000b20 <GPIO_ConfigPinRemap+0x1bc>
 8000a8e:	2ef50713          	addi	a4,a0,751
 8000a92:	9722                	add	a4,a4,s0
 8000a94:	08e37663          	bgeu	t1,a4,8000b20 <GPIO_ConfigPinRemap+0x1bc>
 8000a98:	d5160713          	addi	a4,a2,-687
 8000a9c:	08e58263          	beq	a1,a4,8000b20 <GPIO_ConfigPinRemap+0x1bc>
 8000aa0:	d8960713          	addi	a4,a2,-631
 8000aa4:	06e80e63          	beq	a6,a4,8000b20 <GPIO_ConfigPinRemap+0x1bc>
 8000aa8:	de960713          	addi	a4,a2,-535
 8000aac:	06e40a63          	beq	s0,a4,8000b20 <GPIO_ConfigPinRemap+0x1bc>
 8000ab0:	e0960613          	addi	a2,a2,-503
 8000ab4:	06c78663          	beq	a5,a2,8000b20 <GPIO_ConfigPinRemap+0x1bc>
 8000ab8:	13750713          	addi	a4,a0,311
 8000abc:	9736                	add	a4,a4,a3
 8000abe:	fbf77713          	andi	a4,a4,-65
 8000ac2:	cf39                	beqz	a4,8000b20 <GPIO_ConfigPinRemap+0x1bc>
 8000ac4:	0d200713          	li	a4,210
 8000ac8:	04e40c63          	beq	s0,a4,8000b20 <GPIO_ConfigPinRemap+0x1bc>
 8000acc:	6705                	lui	a4,0x1
 8000ace:	28970693          	addi	a3,a4,649 # 1289 <__STACK_SIZE-0xd77>
 8000ad2:	04d78763          	beq	a5,a3,8000b20 <GPIO_ConfigPinRemap+0x1bc>
 8000ad6:	20970693          	addi	a3,a4,521
 8000ada:	04d78363          	beq	a5,a3,8000b20 <GPIO_ConfigPinRemap+0x1bc>
 8000ade:	18970693          	addi	a3,a4,393
 8000ae2:	02d78f63          	beq	a5,a3,8000b20 <GPIO_ConfigPinRemap+0x1bc>
 8000ae6:	10970693          	addi	a3,a4,265
 8000aea:	02d78b63          	beq	a5,a3,8000b20 <GPIO_ConfigPinRemap+0x1bc>
 8000aee:	08970693          	addi	a3,a4,137
 8000af2:	02d78763          	beq	a5,a3,8000b20 <GPIO_ConfigPinRemap+0x1bc>
 8000af6:	0725                	addi	a4,a4,9
 8000af8:	02e78463          	beq	a5,a4,8000b20 <GPIO_ConfigPinRemap+0x1bc>
 8000afc:	2ce00613          	li	a2,718
 8000b00:	00002597          	auipc	a1,0x2
 8000b04:	1d058593          	addi	a1,a1,464 # 8002cd0 <_write+0x12>
 8000b08:	00002517          	auipc	a0,0x2
 8000b0c:	30050513          	addi	a0,a0,768 # 8002e08 <_write+0x14a>
 8000b10:	78c000ef          	jal	ra,800129c <assert_failed>
	assert_param(IS_FUNCTIONAL_STATE(Cmd));
 8000b14:	4785                	li	a5,1
 8000b16:	01045993          	srli	s3,s0,0x10
 8000b1a:	0297f463          	bgeu	a5,s1,8000b42 <GPIO_ConfigPinRemap+0x1de>
 8000b1e:	a031                	j	8000b2a <GPIO_ConfigPinRemap+0x1c6>
 8000b20:	4785                	li	a5,1
 8000b22:	01045993          	srli	s3,s0,0x10
 8000b26:	0297f563          	bgeu	a5,s1,8000b50 <GPIO_ConfigPinRemap+0x1ec>
 8000b2a:	2cf00613          	li	a2,719
 8000b2e:	00002597          	auipc	a1,0x2
 8000b32:	1a258593          	addi	a1,a1,418 # 8002cd0 <_write+0x12>
 8000b36:	00002517          	auipc	a0,0x2
 8000b3a:	2b650513          	addi	a0,a0,694 # 8002dec <_write+0x12e>
 8000b3e:	75e000ef          	jal	ra,800129c <assert_failed>
	bitsegH = RmpPin >> 16;
 8000b42:	01099513          	slli	a0,s3,0x10
 8000b46:	8141                	srli	a0,a0,0x10
  if(BitSeg == 0)
 8000b48:	00098463          	beqz	s3,8000b50 <GPIO_ConfigPinRemap+0x1ec>
 8000b4c:	85a6                	mv	a1,s1
 8000b4e:	32a9                	jal	8000498 <ConfigPinRemap.part.0>
 8000b50:	00090b63          	beqz	s2,8000b66 <GPIO_ConfigPinRemap+0x202>

	ConfigPinRemap(bitsegH, Cmd);
	ConfigPinRemap(bitsegL, Cmd);
}
 8000b54:	4462                	lw	s0,24(sp)
 8000b56:	40f2                	lw	ra,28(sp)
 8000b58:	49b2                	lw	s3,12(sp)
 8000b5a:	85a6                	mv	a1,s1
 8000b5c:	854a                	mv	a0,s2
 8000b5e:	44d2                	lw	s1,20(sp)
 8000b60:	4942                	lw	s2,16(sp)
 8000b62:	6105                	addi	sp,sp,32
 8000b64:	ba15                	j	8000498 <ConfigPinRemap.part.0>
 8000b66:	40f2                	lw	ra,28(sp)
 8000b68:	4462                	lw	s0,24(sp)
 8000b6a:	44d2                	lw	s1,20(sp)
 8000b6c:	4942                	lw	s2,16(sp)
 8000b6e:	49b2                	lw	s3,12(sp)
 8000b70:	6105                	addi	sp,sp,32
 8000b72:	8082                	ret
	bitsegH = RmpPin >> 16;
 8000b74:	01045993          	srli	s3,s0,0x10
	assert_param(IS_FUNCTIONAL_STATE(Cmd));
 8000b78:	4785                	li	a5,1
	bitsegH = RmpPin >> 16;
 8000b7a:	854e                	mv	a0,s3
	assert_param(IS_FUNCTIONAL_STATE(Cmd));
 8000b7c:	fc97f8e3          	bgeu	a5,s1,8000b4c <GPIO_ConfigPinRemap+0x1e8>
 8000b80:	b76d                	j	8000b2a <GPIO_ConfigPinRemap+0x1c6>

08000b82 <RCC_GetClocksFreqValue>:
	uint32_t pllmull	= 0;
	uint32_t pllsource	= 0;
	uint32_t presc		= 0;

    /* Get PLL clock source and multiplication factor ----------------------*/
    pllmull   = RCC->CFG & RCC_CFG_PLLMULFCT_Msk;
 8000b82:	40021737          	lui	a4,0x40021
 8000b86:	435c                	lw	a5,4(a4)
    pllsource = RCC->CFG & RCC_CFG_PLLSRC_Msk;

    if ((pllmull & RCC_CFG_PLLMULFCT_4) == 0)
 8000b88:	08000637          	lui	a2,0x8000
    pllsource = RCC->CFG & RCC_CFG_PLLSRC_Msk;
 8000b8c:	4354                	lw	a3,4(a4)
    {
        pllmull = (pllmull >> 18) + 2; /* PLLMUL[4] = 0 */
 8000b8e:	0127d713          	srli	a4,a5,0x12
 8000b92:	20f77713          	andi	a4,a4,527
    if ((pllmull & RCC_CFG_PLLMULFCT_4) == 0)
 8000b96:	8ff1                	and	a5,a5,a2
    pllsource = RCC->CFG & RCC_CFG_PLLSRC_Msk;
 8000b98:	6641                	lui	a2,0x10
 8000b9a:	8ef1                	and	a3,a3,a2
    }
    else
    {
        pllmull = ((pllmull >> 18) - 512 + 16) + 1; /* PLLMUL[4] = 1 */
 8000b9c:	e1170593          	addi	a1,a4,-495 # 40020e11 <_sp+0x20000e11>
    if ((pllmull & RCC_CFG_PLLMULFCT_4) == 0)
 8000ba0:	e399                	bnez	a5,8000ba6 <RCC_GetClocksFreqValue+0x24>
        pllmull = (pllmull >> 18) + 2; /* PLLMUL[4] = 0 */
 8000ba2:	00270593          	addi	a1,a4,2
    }

    if (pllsource == 0x00)
 8000ba6:	ca81                	beqz	a3,8000bb6 <RCC_GetClocksFreqValue+0x34>
        pllclk = (HSI_VALUE >> 1) * pllmull;
    }
    else
    {
        /* HSE selected as PLL clock entry */
        if ((RCC->CFG & RCC_CFG_PLLHSEPRES_Msk) != (uint32_t)RESET)
 8000ba8:	400217b7          	lui	a5,0x40021
 8000bac:	43dc                	lw	a5,4(a5)
 8000bae:	00020737          	lui	a4,0x20
 8000bb2:	8ff9                	and	a5,a5,a4
 8000bb4:	c7cd                	beqz	a5,8000c5e <RCC_GetClocksFreqValue+0xdc>
        { 
			/* HSE oscillator clock divided by 2 */
            pllclk = (HSE_VALUE >> 1) * pllmull;
 8000bb6:	003d17b7          	lui	a5,0x3d1
 8000bba:	90078793          	addi	a5,a5,-1792 # 3d0900 <__FLASH_SIZE+0x350900>
 8000bbe:	02f585b3          	mul	a1,a1,a5
            pllclk = HSE_VALUE * pllmull;
        }
    }

    /* Get SYSCLK source -------------------------------------------------------*/
    tmp = RCC->CFG & RCC_CFG_SCLKSTS_Msk;
 8000bc2:	400217b7          	lui	a5,0x40021
 8000bc6:	43dc                	lw	a5,4(a5)

    switch (tmp)
 8000bc8:	4721                	li	a4,8
    tmp = RCC->CFG & RCC_CFG_SCLKSTS_Msk;
 8000bca:	8bb1                	andi	a5,a5,12
    switch (tmp)
 8000bcc:	0ae78663          	beq	a5,a4,8000c78 <RCC_GetClocksFreqValue+0xf6>
    {
    case 0x00: /* HSI used as system clock */
        RCC_Clocks->SysclkFreq = HSI_VALUE;
 8000bd0:	007a17b7          	lui	a5,0x7a1
 8000bd4:	20078793          	addi	a5,a5,512 # 7a1200 <__FLASH_SIZE+0x721200>
 8000bd8:	c11c                	sw	a5,0(a0)
        break;
    }

    /* Compute HCLK, PCLK1, PCLK2 and ADCCLK clocks frequencies ----------------*/
    /* Get HCLK prescaler */
    tmp   = RCC->CFG & RCC_CFG_AHBPRES_Msk;
 8000bda:	400216b7          	lui	a3,0x40021
 8000bde:	42d8                	lw	a4,4(a3)
    tmp   = tmp >> 4;
    presc = s_ApbAhbPresTable[tmp];
 8000be0:	00002617          	auipc	a2,0x2
 8000be4:	33060613          	addi	a2,a2,816 # 8002f10 <s_ApbAhbPresTable>
    tmp   = tmp >> 4;
 8000be8:	8311                	srli	a4,a4,0x4
 8000bea:	8b3d                	andi	a4,a4,15
    presc = s_ApbAhbPresTable[tmp];
 8000bec:	9732                	add	a4,a4,a2
 8000bee:	00074703          	lbu	a4,0(a4) # 20000 <__ILM_RAM_SIZE>
    /* Get ADCPLLCLK prescaler */
    tmp   = RCC->CFG2 & RCC_CFG2_ADCPLLPRES_Msk;
    tmp   = tmp >> 4;
    if ((tmp & 0x10) == 0x10)	//check BIT5, 0XXXX means ADC PLL is closed
    {
		RCC_Clocks->AdcPllClkFreq = 0;
 8000bf2:	4801                	li	a6,0
    RCC_Clocks->HclkFreq = RCC_Clocks->SysclkFreq >> presc;
 8000bf4:	00e7d7b3          	srl	a5,a5,a4
 8000bf8:	c15c                	sw	a5,4(a0)
    tmp   = RCC->CFG & RCC_CFG_APB1PRES_Msk;
 8000bfa:	42d8                	lw	a4,4(a3)
    tmp   = tmp >> 8;
 8000bfc:	8321                	srli	a4,a4,0x8
 8000bfe:	8b1d                	andi	a4,a4,7
    presc = s_ApbAhbPresTable[tmp];
 8000c00:	9732                	add	a4,a4,a2
 8000c02:	00074703          	lbu	a4,0(a4)
    RCC_Clocks->Pclk1Freq = RCC_Clocks->HclkFreq >> presc;
 8000c06:	00e7d733          	srl	a4,a5,a4
 8000c0a:	c518                	sw	a4,8(a0)
    tmp   = RCC->CFG & RCC_CFG_APB2PRES_Msk;
 8000c0c:	42d8                	lw	a4,4(a3)
    tmp   = tmp >> 11;
 8000c0e:	832d                	srli	a4,a4,0xb
 8000c10:	8b1d                	andi	a4,a4,7
    presc = s_ApbAhbPresTable[tmp];
 8000c12:	963a                	add	a2,a2,a4
 8000c14:	00064703          	lbu	a4,0(a2)
    RCC_Clocks->Pclk2Freq = RCC_Clocks->HclkFreq >> presc;
 8000c18:	00e7d733          	srl	a4,a5,a4
 8000c1c:	c558                	sw	a4,12(a0)
    tmp   = RCC->CFG2 & RCC_CFG2_ADCHPRES_Msk;
 8000c1e:	56d8                	lw	a4,44(a3)
 8000c20:	00f77613          	andi	a2,a4,15
    presc = s_AdcHclkPresTable[tmp];
 8000c24:	00002717          	auipc	a4,0x2
 8000c28:	2bc70713          	addi	a4,a4,700 # 8002ee0 <s_AdcHclkPresTable>
 8000c2c:	9732                	add	a4,a4,a2
 8000c2e:	00074703          	lbu	a4,0(a4)
    RCC_Clocks->AdcHclkFreq = RCC_Clocks->HclkFreq / presc;
 8000c32:	02e7d7b3          	divu	a5,a5,a4
 8000c36:	c95c                	sw	a5,20(a0)
    tmp   = RCC->CFG2 & RCC_CFG2_ADCPLLPRES_Msk;
 8000c38:	56dc                	lw	a5,44(a3)
    tmp   = tmp >> 4;
 8000c3a:	8391                	srli	a5,a5,0x4
    if ((tmp & 0x10) == 0x10)	//check BIT5, 0XXXX means ADC PLL is closed
 8000c3c:	0107f713          	andi	a4,a5,16
 8000c40:	ef01                	bnez	a4,8000c58 <RCC_GetClocksFreqValue+0xd6>
    }
    else
    {
		presc = s_AdcPllClkPresTable[(tmp & 0xF)]; // ignore BIT5
 8000c42:	8bbd                	andi	a5,a5,15
 8000c44:	0786                	slli	a5,a5,0x1
 8000c46:	00002717          	auipc	a4,0x2
 8000c4a:	2aa70713          	addi	a4,a4,682 # 8002ef0 <s_AdcPllClkPresTable>
 8000c4e:	97ba                	add	a5,a5,a4
 8000c50:	0007d803          	lhu	a6,0(a5)
		
		/* ADCPLLCLK clock frequency */
		RCC_Clocks->AdcPllClkFreq = pllclk / presc;
 8000c54:	0305d833          	divu	a6,a1,a6
 8000c58:	01052823          	sw	a6,16(a0)
    }
}
 8000c5c:	8082                	ret
            pllclk = HSE_VALUE * pllmull;
 8000c5e:	007a17b7          	lui	a5,0x7a1
 8000c62:	20078793          	addi	a5,a5,512 # 7a1200 <__FLASH_SIZE+0x721200>
 8000c66:	02f585b3          	mul	a1,a1,a5
    tmp = RCC->CFG & RCC_CFG_SCLKSTS_Msk;
 8000c6a:	400217b7          	lui	a5,0x40021
 8000c6e:	43dc                	lw	a5,4(a5)
    switch (tmp)
 8000c70:	4721                	li	a4,8
    tmp = RCC->CFG & RCC_CFG_SCLKSTS_Msk;
 8000c72:	8bb1                	andi	a5,a5,12
    switch (tmp)
 8000c74:	f4e79ee3          	bne	a5,a4,8000bd0 <RCC_GetClocksFreqValue+0x4e>
        RCC_Clocks->SysclkFreq = pllclk;
 8000c78:	c10c                	sw	a1,0(a0)
        break;
 8000c7a:	87ae                	mv	a5,a1
 8000c7c:	bfb9                	j	8000bda <RCC_GetClocksFreqValue+0x58>

08000c7e <RCC_EnableAPB2PeriphClk>:
 *   This parameter can be: ENABLE or DISABLE.
 */
void RCC_EnableAPB2PeriphClk(uint32_t RCC_APB2Periph, FunctionalState Cmd)
{
    /* Check the parameters */
    assert_param(IS_RCC_APB2_PERIPH(RCC_APB2Periph));
 8000c7e:	ffe187b7          	lui	a5,0xffe18
{
 8000c82:	1141                	addi	sp,sp,-16
    assert_param(IS_RCC_APB2_PERIPH(RCC_APB2Periph));
 8000c84:	60278793          	addi	a5,a5,1538 # ffe18602 <_sp+0xdfdf8602>
{
 8000c88:	c422                	sw	s0,8(sp)
 8000c8a:	c226                	sw	s1,4(sp)
 8000c8c:	c606                	sw	ra,12(sp)
    assert_param(IS_RCC_APB2_PERIPH(RCC_APB2Periph));
 8000c8e:	8fe9                	and	a5,a5,a0
{
 8000c90:	842a                	mv	s0,a0
 8000c92:	84ae                	mv	s1,a1
    assert_param(IS_RCC_APB2_PERIPH(RCC_APB2Periph));
 8000c94:	e395                	bnez	a5,8000cb8 <RCC_EnableAPB2PeriphClk+0x3a>
 8000c96:	c10d                	beqz	a0,8000cb8 <RCC_EnableAPB2PeriphClk+0x3a>
    assert_param(IS_FUNCTIONAL_STATE(Cmd));
 8000c98:	4785                	li	a5,1
 8000c9a:	0297ed63          	bltu	a5,s1,8000cd4 <RCC_EnableAPB2PeriphClk+0x56>
	
    if (Cmd != DISABLE)
 8000c9e:	e4b1                	bnez	s1,8000cea <RCC_EnableAPB2PeriphClk+0x6c>
    {
        RCC->APB2PCLKEN |= RCC_APB2Periph;
    }
    else
    {
        RCC->APB2PCLKEN &= ~RCC_APB2Periph;
 8000ca0:	400217b7          	lui	a5,0x40021
 8000ca4:	4f88                	lw	a0,24(a5)
 8000ca6:	fff44413          	not	s0,s0
 8000caa:	8c69                	and	s0,s0,a0
    }
}
 8000cac:	40b2                	lw	ra,12(sp)
        RCC->APB2PCLKEN &= ~RCC_APB2Periph;
 8000cae:	cf80                	sw	s0,24(a5)
}
 8000cb0:	4422                	lw	s0,8(sp)
 8000cb2:	4492                	lw	s1,4(sp)
 8000cb4:	0141                	addi	sp,sp,16
 8000cb6:	8082                	ret
    assert_param(IS_RCC_APB2_PERIPH(RCC_APB2Periph));
 8000cb8:	3c200613          	li	a2,962
 8000cbc:	00002597          	auipc	a1,0x2
 8000cc0:	16458593          	addi	a1,a1,356 # 8002e20 <_write+0x162>
 8000cc4:	00002517          	auipc	a0,0x2
 8000cc8:	1bc50513          	addi	a0,a0,444 # 8002e80 <_write+0x1c2>
 8000ccc:	2bc1                	jal	800129c <assert_failed>
    assert_param(IS_FUNCTIONAL_STATE(Cmd));
 8000cce:	4785                	li	a5,1
 8000cd0:	fc97f7e3          	bgeu	a5,s1,8000c9e <RCC_EnableAPB2PeriphClk+0x20>
 8000cd4:	3c300613          	li	a2,963
 8000cd8:	00002597          	auipc	a1,0x2
 8000cdc:	14858593          	addi	a1,a1,328 # 8002e20 <_write+0x162>
 8000ce0:	00002517          	auipc	a0,0x2
 8000ce4:	10c50513          	addi	a0,a0,268 # 8002dec <_write+0x12e>
 8000ce8:	2b55                	jal	800129c <assert_failed>
        RCC->APB2PCLKEN |= RCC_APB2Periph;
 8000cea:	400217b7          	lui	a5,0x40021
 8000cee:	4f88                	lw	a0,24(a5)
}
 8000cf0:	40b2                	lw	ra,12(sp)
        RCC->APB2PCLKEN |= RCC_APB2Periph;
 8000cf2:	8c49                	or	s0,s0,a0
 8000cf4:	cf80                	sw	s0,24(a5)
}
 8000cf6:	4422                	lw	s0,8(sp)
 8000cf8:	4492                	lw	s1,4(sp)
 8000cfa:	0141                	addi	sp,sp,16
 8000cfc:	8082                	ret

08000cfe <RCC_EnableAPB1PeriphClk>:
 *   This parameter can be: ENABLE or DISABLE.
 */
void RCC_EnableAPB1PeriphClk(uint32_t RCC_APB1Periph, FunctionalState Cmd)
{
    /* Check the parameters */
    assert_param(IS_RCC_APB1_PERIPH(RCC_APB1Periph));
 8000cfe:	410137b7          	lui	a5,0x41013
{
 8000d02:	1141                	addi	sp,sp,-16
    assert_param(IS_RCC_APB1_PERIPH(RCC_APB1Periph));
 8000d04:	30078793          	addi	a5,a5,768 # 41013300 <_sp+0x20ff3300>
{
 8000d08:	c422                	sw	s0,8(sp)
 8000d0a:	c226                	sw	s1,4(sp)
 8000d0c:	c606                	sw	ra,12(sp)
    assert_param(IS_RCC_APB1_PERIPH(RCC_APB1Periph));
 8000d0e:	8fe9                	and	a5,a5,a0
{
 8000d10:	842a                	mv	s0,a0
 8000d12:	84ae                	mv	s1,a1
    assert_param(IS_RCC_APB1_PERIPH(RCC_APB1Periph));
 8000d14:	e395                	bnez	a5,8000d38 <RCC_EnableAPB1PeriphClk+0x3a>
 8000d16:	c10d                	beqz	a0,8000d38 <RCC_EnableAPB1PeriphClk+0x3a>
    assert_param(IS_FUNCTIONAL_STATE(Cmd));
 8000d18:	4785                	li	a5,1
 8000d1a:	0297ed63          	bltu	a5,s1,8000d54 <RCC_EnableAPB1PeriphClk+0x56>
	
    if (Cmd != DISABLE)
 8000d1e:	e4b1                	bnez	s1,8000d6a <RCC_EnableAPB1PeriphClk+0x6c>
    {
        RCC->APB1PCLKEN |= RCC_APB1Periph;
    }
    else
    {
        RCC->APB1PCLKEN &= ~RCC_APB1Periph;
 8000d20:	400217b7          	lui	a5,0x40021
 8000d24:	4fc8                	lw	a0,28(a5)
 8000d26:	fff44413          	not	s0,s0
 8000d2a:	8c69                	and	s0,s0,a0
    }
}
 8000d2c:	40b2                	lw	ra,12(sp)
        RCC->APB1PCLKEN &= ~RCC_APB1Periph;
 8000d2e:	cfc0                	sw	s0,28(a5)
}
 8000d30:	4422                	lw	s0,8(sp)
 8000d32:	4492                	lw	s1,4(sp)
 8000d34:	0141                	addi	sp,sp,16
 8000d36:	8082                	ret
    assert_param(IS_RCC_APB1_PERIPH(RCC_APB1Periph));
 8000d38:	3e200613          	li	a2,994
 8000d3c:	00002597          	auipc	a1,0x2
 8000d40:	0e458593          	addi	a1,a1,228 # 8002e20 <_write+0x162>
 8000d44:	00002517          	auipc	a0,0x2
 8000d48:	16050513          	addi	a0,a0,352 # 8002ea4 <_write+0x1e6>
 8000d4c:	2b81                	jal	800129c <assert_failed>
    assert_param(IS_FUNCTIONAL_STATE(Cmd));
 8000d4e:	4785                	li	a5,1
 8000d50:	fc97f7e3          	bgeu	a5,s1,8000d1e <RCC_EnableAPB1PeriphClk+0x20>
 8000d54:	3e300613          	li	a2,995
 8000d58:	00002597          	auipc	a1,0x2
 8000d5c:	0c858593          	addi	a1,a1,200 # 8002e20 <_write+0x162>
 8000d60:	00002517          	auipc	a0,0x2
 8000d64:	08c50513          	addi	a0,a0,140 # 8002dec <_write+0x12e>
 8000d68:	2b15                	jal	800129c <assert_failed>
        RCC->APB1PCLKEN |= RCC_APB1Periph;
 8000d6a:	400217b7          	lui	a5,0x40021
 8000d6e:	4fc8                	lw	a0,28(a5)
}
 8000d70:	40b2                	lw	ra,12(sp)
        RCC->APB1PCLKEN |= RCC_APB1Periph;
 8000d72:	8c49                	or	s0,s0,a0
 8000d74:	cfc0                	sw	s0,28(a5)
}
 8000d76:	4422                	lw	s0,8(sp)
 8000d78:	4492                	lw	s1,4(sp)
 8000d7a:	0141                	addi	sp,sp,16
 8000d7c:	8082                	ret

08000d7e <RCC_GetFlagStatus>:
 *     @arg RCC_FLAG_LPWRRST Low Power reset
 *
 * @retval The new state of RCC_FLAG (SET or RESET).
 */
FlagStatus RCC_GetFlagStatus(uint8_t RCC_FLAG)
{
 8000d7e:	1141                	addi	sp,sp,-16
 8000d80:	c422                	sw	s0,8(sp)
 8000d82:	c606                	sw	ra,12(sp)
    uint32_t tmp         = 0;
    uint32_t statusreg   = 0;
    FlagStatus bitstatus = RESET;
	
    /* Check the parameters */
    assert_param(IS_RCC_FLAG(RCC_FLAG));
 8000d84:	0ef57713          	andi	a4,a0,239
 8000d88:	02100793          	li	a5,33
{
 8000d8c:	842a                	mv	s0,a0
    assert_param(IS_RCC_FLAG(RCC_FLAG));
 8000d8e:	04f70263          	beq	a4,a5,8000dd2 <RCC_GetFlagStatus+0x54>
 8000d92:	03900793          	li	a5,57
 8000d96:	02f50e63          	beq	a0,a5,8000dd2 <RCC_GetFlagStatus+0x54>
 8000d9a:	04100793          	li	a5,65
 8000d9e:	06f50763          	beq	a0,a5,8000e0c <RCC_GetFlagStatus+0x8e>
 8000da2:	f9f50793          	addi	a5,a0,-97
 8000da6:	0ff7f793          	zext.b	a5,a5
 8000daa:	4779                	li	a4,30
 8000dac:	02f76d63          	bltu	a4,a5,8000de6 <RCC_GetFlagStatus+0x68>
 8000db0:	7f5c0737          	lui	a4,0x7f5c0
 8000db4:	0705                	addi	a4,a4,1
 8000db6:	00f757b3          	srl	a5,a4,a5
 8000dba:	8b85                	andi	a5,a5,1
 8000dbc:	c3b5                	beqz	a5,8000e20 <RCC_GetFlagStatus+0xa2>
    {
        statusreg = RCC->BDCTRL;
    }
    else /* The flag to check is in CTRLSTS register */
    {
        statusreg = RCC->CTRLSTS;
 8000dbe:	400217b7          	lui	a5,0x40021
 8000dc2:	53c8                	lw	a0,36(a5)
        bitstatus = RESET;
    }

    /* Return the flag status */
    return bitstatus;
}
 8000dc4:	40b2                	lw	ra,12(sp)
    if ((statusreg & (((uint32_t) 1) << tmp)) != (uint32_t)RESET)
 8000dc6:	00855533          	srl	a0,a0,s0
}
 8000dca:	4422                	lw	s0,8(sp)
    if ((statusreg & (((uint32_t) 1) << tmp)) != (uint32_t)RESET)
 8000dcc:	8905                	andi	a0,a0,1
}
 8000dce:	0141                	addi	sp,sp,16
 8000dd0:	8082                	ret
        statusreg = RCC->CTRL;
 8000dd2:	400217b7          	lui	a5,0x40021
 8000dd6:	4388                	lw	a0,0(a5)
}
 8000dd8:	40b2                	lw	ra,12(sp)
    if ((statusreg & (((uint32_t) 1) << tmp)) != (uint32_t)RESET)
 8000dda:	00855533          	srl	a0,a0,s0
}
 8000dde:	4422                	lw	s0,8(sp)
    if ((statusreg & (((uint32_t) 1) << tmp)) != (uint32_t)RESET)
 8000de0:	8905                	andi	a0,a0,1
}
 8000de2:	0141                	addi	sp,sp,16
 8000de4:	8082                	ret
    assert_param(IS_RCC_FLAG(RCC_FLAG));
 8000de6:	4db00613          	li	a2,1243
 8000dea:	00002597          	auipc	a1,0x2
 8000dee:	03658593          	addi	a1,a1,54 # 8002e20 <_write+0x162>
 8000df2:	00002517          	auipc	a0,0x2
 8000df6:	0d650513          	addi	a0,a0,214 # 8002ec8 <_write+0x20a>
 8000dfa:	214d                	jal	800129c <assert_failed>
    tmp = RCC_FLAG >> 5;
 8000dfc:	00545793          	srli	a5,s0,0x5
    if (tmp == 1) /* The flag to check is in CTRL register */
 8000e00:	4705                	li	a4,1
 8000e02:	fce788e3          	beq	a5,a4,8000dd2 <RCC_GetFlagStatus+0x54>
    else if (tmp == 2) /* The flag to check is in BDCTRL register */
 8000e06:	4709                	li	a4,2
 8000e08:	fae79be3          	bne	a5,a4,8000dbe <RCC_GetFlagStatus+0x40>
        statusreg = RCC->BDCTRL;
 8000e0c:	400217b7          	lui	a5,0x40021
 8000e10:	5388                	lw	a0,32(a5)
}
 8000e12:	40b2                	lw	ra,12(sp)
    if ((statusreg & (((uint32_t) 1) << tmp)) != (uint32_t)RESET)
 8000e14:	00855533          	srl	a0,a0,s0
}
 8000e18:	4422                	lw	s0,8(sp)
    if ((statusreg & (((uint32_t) 1) << tmp)) != (uint32_t)RESET)
 8000e1a:	8905                	andi	a0,a0,1
}
 8000e1c:	0141                	addi	sp,sp,16
 8000e1e:	8082                	ret
    assert_param(IS_RCC_FLAG(RCC_FLAG));
 8000e20:	4db00613          	li	a2,1243
 8000e24:	00002597          	auipc	a1,0x2
 8000e28:	ffc58593          	addi	a1,a1,-4 # 8002e20 <_write+0x162>
 8000e2c:	00002517          	auipc	a0,0x2
 8000e30:	09c50513          	addi	a0,a0,156 # 8002ec8 <_write+0x20a>
 8000e34:	21a5                	jal	800129c <assert_failed>
    if (tmp == 1) /* The flag to check is in CTRL register */
 8000e36:	b761                	j	8000dbe <RCC_GetFlagStatus+0x40>

08000e38 <RCC_ClrFlag>:
 *   RCC_FLAG_IWDGRST, RCC_FLAG_WWDGRST, RCC_FLAG_LPWRRST
 */
void RCC_ClrFlag(void)
{
    /* Set RMRSTF bit to clear the reset flags */
    RCC->CTRLSTS |= RCC_CTRLSTS_RMRSTF;
 8000e38:	400217b7          	lui	a5,0x40021
 8000e3c:	53d8                	lw	a4,36(a5)
 8000e3e:	010006b7          	lui	a3,0x1000
 8000e42:	8f55                	or	a4,a4,a3
 8000e44:	d3d8                	sw	a4,36(a5)
	
    /* RMRSTF bit should be reset */
    RCC->CTRLSTS &= (~RCC_CTRLSTS_RMRSTF);
 8000e46:	53d8                	lw	a4,36(a5)
 8000e48:	ff0006b7          	lui	a3,0xff000
 8000e4c:	16fd                	addi	a3,a3,-1
 8000e4e:	8f75                	and	a4,a4,a3
 8000e50:	d3d8                	sw	a4,36(a5)
}
 8000e52:	8082                	ret

08000e54 <USART_Init>:
 * @param	USART_InitStruct pointer to a USART_InitType structure
 *         that contains the configuration information for the specified USART
 *         peripheral.
 */
void USART_Init(USART_Module* USARTx, USART_InitType* USART_InitStruct)
{
 8000e54:	7179                	addi	sp,sp,-48
    uint32_t fractionaldivider	= 0x00;
    uint32_t usartxbase        	= 0;
    RCC_ClocksType RCC_ClocksStatus;

    /* Check the parameters */
    assert_param(IS_USART_ALL_PERIPH(USARTx));
 8000e56:	400147b7          	lui	a5,0x40014
{
 8000e5a:	d422                	sw	s0,40(sp)
 8000e5c:	d226                	sw	s1,36(sp)
 8000e5e:	d606                	sw	ra,44(sp)
    assert_param(IS_USART_ALL_PERIPH(USARTx));
 8000e60:	80078793          	addi	a5,a5,-2048 # 40013800 <_sp+0x1fff3800>
{
 8000e64:	842a                	mv	s0,a0
 8000e66:	84ae                	mv	s1,a1
    assert_param(IS_USART_ALL_PERIPH(USARTx));
 8000e68:	04f50763          	beq	a0,a5,8000eb6 <USART_Init+0x62>
 8000e6c:	400047b7          	lui	a5,0x40004
 8000e70:	40078793          	addi	a5,a5,1024 # 40004400 <_sp+0x1ffe4400>
 8000e74:	04f50163          	beq	a0,a5,8000eb6 <USART_Init+0x62>
 8000e78:	400057b7          	lui	a5,0x40005
 8000e7c:	80078713          	addi	a4,a5,-2048 # 40004800 <_sp+0x1ffe4800>
 8000e80:	02e50b63          	beq	a0,a4,8000eb6 <USART_Init+0x62>
 8000e84:	c0078713          	addi	a4,a5,-1024
 8000e88:	02e50763          	beq	a0,a4,8000eb6 <USART_Init+0x62>
 8000e8c:	02f50563          	beq	a0,a5,8000eb6 <USART_Init+0x62>
 8000e90:	400157b7          	lui	a5,0x40015
 8000e94:	02f50163          	beq	a0,a5,8000eb6 <USART_Init+0x62>
 8000e98:	40078793          	addi	a5,a5,1024 # 40015400 <_sp+0x1fff5400>
 8000e9c:	00f50d63          	beq	a0,a5,8000eb6 <USART_Init+0x62>
 8000ea0:	08b00613          	li	a2,139
 8000ea4:	00002597          	auipc	a1,0x2
 8000ea8:	07c58593          	addi	a1,a1,124 # 8002f20 <s_ApbAhbPresTable+0x10>
 8000eac:	00002517          	auipc	a0,0x2
 8000eb0:	0c450513          	addi	a0,a0,196 # 8002f70 <s_ApbAhbPresTable+0x60>
 8000eb4:	26e5                	jal	800129c <assert_failed>
    assert_param(IS_USART_BAUDRATE(USART_InitStruct->BaudRate));
 8000eb6:	4098                	lw	a4,0(s1)
 8000eb8:	0044b7b7          	lui	a5,0x44b
 8000ebc:	177d                	addi	a4,a4,-1
 8000ebe:	a1f78793          	addi	a5,a5,-1505 # 44aa1f <__FLASH_SIZE+0x3caa1f>
 8000ec2:	1ce7e763          	bltu	a5,a4,8001090 <USART_Init+0x23c>
    assert_param(IS_USART_WORD_LENGTH(USART_InitStruct->WordLength));
 8000ec6:	0044d703          	lhu	a4,4(s1)
 8000eca:	77fd                	lui	a5,0xfffff
 8000ecc:	17fd                	addi	a5,a5,-1
 8000ece:	8ff9                	and	a5,a5,a4
 8000ed0:	cf81                	beqz	a5,8000ee8 <USART_Init+0x94>
 8000ed2:	08d00613          	li	a2,141
 8000ed6:	00002597          	auipc	a1,0x2
 8000eda:	04a58593          	addi	a1,a1,74 # 8002f20 <s_ApbAhbPresTable+0x10>
 8000ede:	00002517          	auipc	a0,0x2
 8000ee2:	0de50513          	addi	a0,a0,222 # 8002fbc <s_ApbAhbPresTable+0xac>
 8000ee6:	2e5d                	jal	800129c <assert_failed>
    assert_param(IS_USART_STOPBITS(USART_InitStruct->StopBits));
 8000ee8:	0064d703          	lhu	a4,6(s1)
 8000eec:	77f5                	lui	a5,0xffffd
 8000eee:	17fd                	addi	a5,a5,-1
 8000ef0:	8ff9                	and	a5,a5,a4
 8000ef2:	cf81                	beqz	a5,8000f0a <USART_Init+0xb6>
 8000ef4:	08e00613          	li	a2,142
 8000ef8:	00002597          	auipc	a1,0x2
 8000efc:	02858593          	addi	a1,a1,40 # 8002f20 <s_ApbAhbPresTable+0x10>
 8000f00:	00002517          	auipc	a0,0x2
 8000f04:	0f050513          	addi	a0,a0,240 # 8002ff0 <s_ApbAhbPresTable+0xe0>
 8000f08:	2e51                	jal	800129c <assert_failed>
    assert_param(IS_USART_PARITY(USART_InitStruct->Parity));
 8000f0a:	0084d783          	lhu	a5,8(s1)
 8000f0e:	bff7f713          	andi	a4,a5,-1025
 8000f12:	c709                	beqz	a4,8000f1c <USART_Init+0xc8>
 8000f14:	60000713          	li	a4,1536
 8000f18:	18e79863          	bne	a5,a4,80010a8 <USART_Init+0x254>
    assert_param(IS_USART_MODE(USART_InitStruct->Mode));
 8000f1c:	00a4d783          	lhu	a5,10(s1)
 8000f20:	ff37f713          	andi	a4,a5,-13
 8000f24:	0e071c63          	bnez	a4,800101c <USART_Init+0x1c8>
 8000f28:	0e078a63          	beqz	a5,800101c <USART_Init+0x1c8>
    assert_param(IS_USART_HARDWARE_FLOW_CONTROL(USART_InitStruct->HardwareFlowControl));
 8000f2c:	00c4d783          	lhu	a5,12(s1)
 8000f30:	86be                	mv	a3,a5
 8000f32:	cbad                	beqz	a5,8000fa4 <USART_Init+0x150>
 8000f34:	dff7f713          	andi	a4,a5,-513
 8000f38:	10000693          	li	a3,256
 8000f3c:	02d70563          	beq	a4,a3,8000f66 <USART_Init+0x112>
 8000f40:	20000713          	li	a4,512
 8000f44:	02e78163          	beq	a5,a4,8000f66 <USART_Init+0x112>
 8000f48:	09100613          	li	a2,145
 8000f4c:	00002597          	auipc	a1,0x2
 8000f50:	fd458593          	addi	a1,a1,-44 # 8002f20 <s_ApbAhbPresTable+0x10>
 8000f54:	00002517          	auipc	a0,0x2
 8000f58:	12050513          	addi	a0,a0,288 # 8003074 <s_ApbAhbPresTable+0x164>
 8000f5c:	2681                	jal	800129c <assert_failed>

    /* The hardware flow control is available only for USART1, USART2 and USART3 */
    if (USART_InitStruct->HardwareFlowControl != USART_HFCTRL_NONE)
 8000f5e:	00c4d783          	lhu	a5,12(s1)
 8000f62:	86be                	mv	a3,a5
 8000f64:	c3a1                	beqz	a5,8000fa4 <USART_Init+0x150>
    {
        assert_param(IS_USART_123_PERIPH(USARTx));
 8000f66:	40014737          	lui	a4,0x40014
 8000f6a:	80070713          	addi	a4,a4,-2048 # 40013800 <_sp+0x1fff3800>
 8000f6e:	10e40f63          	beq	s0,a4,800108c <USART_Init+0x238>
 8000f72:	40004737          	lui	a4,0x40004
 8000f76:	40070713          	addi	a4,a4,1024 # 40004400 <_sp+0x1ffe4400>
 8000f7a:	10e40963          	beq	s0,a4,800108c <USART_Init+0x238>
 8000f7e:	40005737          	lui	a4,0x40005
 8000f82:	80070713          	addi	a4,a4,-2048 # 40004800 <_sp+0x1ffe4800>
 8000f86:	10e40363          	beq	s0,a4,800108c <USART_Init+0x238>
 8000f8a:	09600613          	li	a2,150
 8000f8e:	00002597          	auipc	a1,0x2
 8000f92:	f9258593          	addi	a1,a1,-110 # 8002f20 <s_ApbAhbPresTable+0x10>
 8000f96:	00002517          	auipc	a0,0x2
 8000f9a:	12650513          	addi	a0,a0,294 # 80030bc <s_ApbAhbPresTable+0x1ac>
 8000f9e:	2cfd                	jal	800129c <assert_failed>
    /* Clear CTSE and RTSE bits */
    tmpregister &= CTRL3_CLR_MASK;

    /* Configure the USART HFC -------------------------------------------------*/
    /* Set CTSE and RTSE bits according to HardwareFlowControl value */
    tmpregister |= USART_InitStruct->HardwareFlowControl;
 8000fa0:	00c4d683          	lhu	a3,12(s1)
    tmpregister = USARTx->CTRL2;
 8000fa4:	01045783          	lhu	a5,16(s0)
 8000fa8:	7775                	lui	a4,0xffffd
 8000faa:	07c2                	slli	a5,a5,0x10
 8000fac:	0064d603          	lhu	a2,6(s1)
 8000fb0:	177d                	addi	a4,a4,-1
 8000fb2:	83c1                	srli	a5,a5,0x10
    tmpregister |= (uint32_t)USART_InitStruct->StopBits;
 8000fb4:	8ff9                	and	a5,a5,a4
 8000fb6:	8fd1                	or	a5,a5,a2
    USARTx->CTRL2 = (uint16_t)tmpregister;
 8000fb8:	00f41823          	sh	a5,16(s0)
    tmpregister |= (uint32_t)USART_InitStruct->WordLength | USART_InitStruct->Parity | USART_InitStruct->Mode;
 8000fbc:	0084d583          	lhu	a1,8(s1)
 8000fc0:	0044d783          	lhu	a5,4(s1)
    tmpregister = USARTx->CTRL1;
 8000fc4:	00c45703          	lhu	a4,12(s0)
    tmpregister |= (uint32_t)USART_InitStruct->WordLength | USART_InitStruct->Parity | USART_InitStruct->Mode;
 8000fc8:	00a4d603          	lhu	a2,10(s1)
 8000fcc:	8fcd                	or	a5,a5,a1
 8000fce:	8fd1                	or	a5,a5,a2
    tmpregister = USARTx->CTRL1;
 8000fd0:	0742                	slli	a4,a4,0x10
 8000fd2:	767d                	lui	a2,0xfffff
 8000fd4:	9f360613          	addi	a2,a2,-1549 # ffffe9f3 <_sp+0xdffde9f3>
 8000fd8:	8341                	srli	a4,a4,0x10
    tmpregister |= (uint32_t)USART_InitStruct->WordLength | USART_InitStruct->Parity | USART_InitStruct->Mode;
 8000fda:	8f71                	and	a4,a4,a2
 8000fdc:	8fd9                	or	a5,a5,a4
 8000fde:	07c2                	slli	a5,a5,0x10
 8000fe0:	83c1                	srli	a5,a5,0x10
    USARTx->CTRL1 = (uint16_t)tmpregister;
 8000fe2:	00f41623          	sh	a5,12(s0)
    tmpregister = USARTx->CTRL3;
 8000fe6:	01445783          	lhu	a5,20(s0)
    /* Write to USART CTRL3 */
    USARTx->CTRL3 = (uint16_t)tmpregister;

    /*---------------------------- USART PBC Configuration -----------------------*/
    /* Configure the USART Baud Rate -------------------------------------------*/
    RCC_GetClocksFreqValue(&RCC_ClocksStatus);
 8000fea:	0028                	addi	a0,sp,8
    tmpregister = USARTx->CTRL3;
 8000fec:	07c2                	slli	a5,a5,0x10
 8000fee:	83c1                	srli	a5,a5,0x10
    tmpregister |= USART_InitStruct->HardwareFlowControl;
 8000ff0:	cff7f793          	andi	a5,a5,-769
 8000ff4:	8fd5                	or	a5,a5,a3
    USARTx->CTRL3 = (uint16_t)tmpregister;
 8000ff6:	00f41a23          	sh	a5,20(s0)
    RCC_GetClocksFreqValue(&RCC_ClocksStatus);
 8000ffa:	3661                	jal	8000b82 <RCC_GetClocksFreqValue>
    if ((usartxbase == USART1_BASE) || (usartxbase == UART6_BASE) || (usartxbase == UART7_BASE))
 8000ffc:	400147b7          	lui	a5,0x40014
 8001000:	80078793          	addi	a5,a5,-2048 # 40013800 <_sp+0x1fff3800>
 8001004:	02f40863          	beq	s0,a5,8001034 <USART_Init+0x1e0>
 8001008:	400157b7          	lui	a5,0x40015
 800100c:	02f40463          	beq	s0,a5,8001034 <USART_Init+0x1e0>
 8001010:	40078793          	addi	a5,a5,1024 # 40015400 <_sp+0x1fff5400>
 8001014:	02f40063          	beq	s0,a5,8001034 <USART_Init+0x1e0>
    {
        apbclock = RCC_ClocksStatus.Pclk2Freq;
    }
    else
    {
        apbclock = RCC_ClocksStatus.Pclk1Freq;
 8001018:	4742                	lw	a4,16(sp)
 800101a:	a831                	j	8001036 <USART_Init+0x1e2>
    assert_param(IS_USART_MODE(USART_InitStruct->Mode));
 800101c:	09000613          	li	a2,144
 8001020:	00002597          	auipc	a1,0x2
 8001024:	f0058593          	addi	a1,a1,-256 # 8002f20 <s_ApbAhbPresTable+0x10>
 8001028:	00002517          	auipc	a0,0x2
 800102c:	02450513          	addi	a0,a0,36 # 800304c <s_ApbAhbPresTable+0x13c>
 8001030:	24b5                	jal	800129c <assert_failed>
 8001032:	bded                	j	8000f2c <USART_Init+0xd8>
        apbclock = RCC_ClocksStatus.Pclk2Freq;
 8001034:	4752                	lw	a4,20(sp)
    }

    /* Determine the integer part */
    integerdivider = ((25 * apbclock) / (4 * (USART_InitStruct->BaudRate))); /* Multiply by 100 to take 2 decimal places */
 8001036:	409c                	lw	a5,0(s1)
 8001038:	46e5                	li	a3,25
 800103a:	02d70733          	mul	a4,a4,a3
 800103e:	078a                	slli	a5,a5,0x2
 8001040:	02f75733          	divu	a4,a4,a5
    tmpregister = (integerdivider / 100) << 4;
 8001044:	51eb87b7          	lui	a5,0x51eb8
 8001048:	51f78613          	addi	a2,a5,1311 # 51eb851f <_sp+0x31e9851f>

    /* Determine the fractional part */
    fractionaldivider = ((((integerdivider - (100 * (tmpregister >> 4))) * 16) + 50) / 100); /* Rounding decimals by adding 0.5 */
 800104c:	06400793          	li	a5,100

    /*Determine whether the fractional part needs to carried*/
    if((fractionaldivider >> 4) == 1){
 8001050:	4585                	li	a1,1
    tmpregister = (integerdivider / 100) << 4;
 8001052:	02c736b3          	mulhu	a3,a4,a2
 8001056:	8295                	srli	a3,a3,0x5
    fractionaldivider = ((((integerdivider - (100 * (tmpregister >> 4))) * 16) + 50) / 100); /* Rounding decimals by adding 0.5 */
 8001058:	c6f6977f          	msubr32	a4,a3,a5
 800105c:	00471793          	slli	a5,a4,0x4
 8001060:	03278793          	addi	a5,a5,50
 8001064:	02c7b7b3          	mulhu	a5,a5,a2
    if((fractionaldivider >> 4) == 1){
 8001068:	0097d713          	srli	a4,a5,0x9
    fractionaldivider = ((((integerdivider - (100 * (tmpregister >> 4))) * 16) + 50) / 100); /* Rounding decimals by adding 0.5 */
 800106c:	8395                	srli	a5,a5,0x5
    if((fractionaldivider >> 4) == 1){
 800106e:	00b71363          	bne	a4,a1,8001074 <USART_Init+0x220>
        tmpregister = ((integerdivider / 100) + 1) << 4;
 8001072:	0685                	addi	a3,a3,1
 8001074:	0692                	slli	a3,a3,0x4
    }
    
    /* Implement the fractional part in the register */
    tmpregister |= fractionaldivider & ((uint8_t)0x0F);
 8001076:	8bbd                	andi	a5,a5,15
 8001078:	8fd5                	or	a5,a5,a3

    /* Write to USART PBC */
    USARTx->BRCF = (uint16_t)tmpregister;
 800107a:	07c2                	slli	a5,a5,0x10
 800107c:	83c1                	srli	a5,a5,0x10
}
 800107e:	50b2                	lw	ra,44(sp)
    USARTx->BRCF = (uint16_t)tmpregister;
 8001080:	00f41423          	sh	a5,8(s0)
}
 8001084:	5422                	lw	s0,40(sp)
 8001086:	5492                	lw	s1,36(sp)
 8001088:	6145                	addi	sp,sp,48
 800108a:	8082                	ret
    tmpregister |= USART_InitStruct->HardwareFlowControl;
 800108c:	86be                	mv	a3,a5
 800108e:	bf19                	j	8000fa4 <USART_Init+0x150>
    assert_param(IS_USART_BAUDRATE(USART_InitStruct->BaudRate));
 8001090:	08c00613          	li	a2,140
 8001094:	00002597          	auipc	a1,0x2
 8001098:	e8c58593          	addi	a1,a1,-372 # 8002f20 <s_ApbAhbPresTable+0x10>
 800109c:	00002517          	auipc	a0,0x2
 80010a0:	ef050513          	addi	a0,a0,-272 # 8002f8c <s_ApbAhbPresTable+0x7c>
 80010a4:	2ae5                	jal	800129c <assert_failed>
 80010a6:	b505                	j	8000ec6 <USART_Init+0x72>
    assert_param(IS_USART_PARITY(USART_InitStruct->Parity));
 80010a8:	08f00613          	li	a2,143
 80010ac:	00002597          	auipc	a1,0x2
 80010b0:	e7458593          	addi	a1,a1,-396 # 8002f20 <s_ApbAhbPresTable+0x10>
 80010b4:	00002517          	auipc	a0,0x2
 80010b8:	f6c50513          	addi	a0,a0,-148 # 8003020 <s_ApbAhbPresTable+0x110>
 80010bc:	22c5                	jal	800129c <assert_failed>
 80010be:	bdb9                	j	8000f1c <USART_Init+0xc8>

080010c0 <USART_Enable>:
 *         USART1, USART2, USART3, UART4, UART5, UART6 or UART7.
 * @param	Cmd new state of the USARTx peripheral.
 *         This parameter can be: ENABLE or DISABLE.
 */
void USART_Enable(USART_Module* USARTx, FunctionalState Cmd)
{
 80010c0:	1141                	addi	sp,sp,-16
    /* Check the parameters */
    assert_param(IS_USART_ALL_PERIPH(USARTx));
 80010c2:	400147b7          	lui	a5,0x40014
{
 80010c6:	c422                	sw	s0,8(sp)
 80010c8:	c226                	sw	s1,4(sp)
 80010ca:	c606                	sw	ra,12(sp)
    assert_param(IS_USART_ALL_PERIPH(USARTx));
 80010cc:	80078793          	addi	a5,a5,-2048 # 40013800 <_sp+0x1fff3800>
{
 80010d0:	842a                	mv	s0,a0
 80010d2:	84ae                	mv	s1,a1
    assert_param(IS_USART_ALL_PERIPH(USARTx));
 80010d4:	04f50763          	beq	a0,a5,8001122 <USART_Enable+0x62>
 80010d8:	400047b7          	lui	a5,0x40004
 80010dc:	40078793          	addi	a5,a5,1024 # 40004400 <_sp+0x1ffe4400>
 80010e0:	04f50163          	beq	a0,a5,8001122 <USART_Enable+0x62>
 80010e4:	400057b7          	lui	a5,0x40005
 80010e8:	80078713          	addi	a4,a5,-2048 # 40004800 <_sp+0x1ffe4800>
 80010ec:	02e50b63          	beq	a0,a4,8001122 <USART_Enable+0x62>
 80010f0:	c0078713          	addi	a4,a5,-1024
 80010f4:	02e50763          	beq	a0,a4,8001122 <USART_Enable+0x62>
 80010f8:	02f50563          	beq	a0,a5,8001122 <USART_Enable+0x62>
 80010fc:	400157b7          	lui	a5,0x40015
 8001100:	02f50163          	beq	a0,a5,8001122 <USART_Enable+0x62>
 8001104:	40078793          	addi	a5,a5,1024 # 40015400 <_sp+0x1fff5400>
 8001108:	00f50d63          	beq	a0,a5,8001122 <USART_Enable+0x62>
 800110c:	13200613          	li	a2,306
 8001110:	00002597          	auipc	a1,0x2
 8001114:	e1058593          	addi	a1,a1,-496 # 8002f20 <s_ApbAhbPresTable+0x10>
 8001118:	00002517          	auipc	a0,0x2
 800111c:	e5850513          	addi	a0,a0,-424 # 8002f70 <s_ApbAhbPresTable+0x60>
 8001120:	2ab5                	jal	800129c <assert_failed>
    assert_param(IS_FUNCTIONAL_STATE(Cmd));
 8001122:	4785                	li	a5,1
 8001124:	0297e163          	bltu	a5,s1,8001146 <USART_Enable+0x86>

    if (Cmd != DISABLE)
 8001128:	e895                	bnez	s1,800115c <USART_Enable+0x9c>
        USARTx->CTRL1 |= (uint16_t)USART_CTRL1_UEN;
    }
    else
    {
        /* Disable the selected USART by clearing the UE bit in the CTRL1 register */
        USARTx->CTRL1 &= (uint16_t)~USART_CTRL1_UEN;
 800112a:	00c45783          	lhu	a5,12(s0)
 800112e:	7779                	lui	a4,0xffffe
 8001130:	07c2                	slli	a5,a5,0x10
 8001132:	83c1                	srli	a5,a5,0x10
 8001134:	177d                	addi	a4,a4,-1
 8001136:	8ff9                	and	a5,a5,a4
    }
}
 8001138:	40b2                	lw	ra,12(sp)
        USARTx->CTRL1 &= (uint16_t)~USART_CTRL1_UEN;
 800113a:	00f41623          	sh	a5,12(s0)
}
 800113e:	4422                	lw	s0,8(sp)
 8001140:	4492                	lw	s1,4(sp)
 8001142:	0141                	addi	sp,sp,16
 8001144:	8082                	ret
    assert_param(IS_FUNCTIONAL_STATE(Cmd));
 8001146:	13300613          	li	a2,307
 800114a:	00002597          	auipc	a1,0x2
 800114e:	dd658593          	addi	a1,a1,-554 # 8002f20 <s_ApbAhbPresTable+0x10>
 8001152:	00002517          	auipc	a0,0x2
 8001156:	c9a50513          	addi	a0,a0,-870 # 8002dec <_write+0x12e>
 800115a:	2289                	jal	800129c <assert_failed>
        USARTx->CTRL1 |= (uint16_t)USART_CTRL1_UEN;
 800115c:	00c45783          	lhu	a5,12(s0)
 8001160:	6709                	lui	a4,0x2
 8001162:	07c2                	slli	a5,a5,0x10
 8001164:	83c1                	srli	a5,a5,0x10
 8001166:	8fd9                	or	a5,a5,a4
}
 8001168:	40b2                	lw	ra,12(sp)
        USARTx->CTRL1 |= (uint16_t)USART_CTRL1_UEN;
 800116a:	00f41623          	sh	a5,12(s0)
}
 800116e:	4422                	lw	s0,8(sp)
 8001170:	4492                	lw	s1,4(sp)
 8001172:	0141                	addi	sp,sp,16
 8001174:	8082                	ret

08001176 <WWDG_SetPrescalerDiv>:
 *     @arg WWDG_PRESCALER_DIV2 WWDG counter clock = (PCLK1/4096)/2
 *     @arg WWDG_PRESCALER_DIV4 WWDG counter clock = (PCLK1/4096)/4
 *     @arg WWDG_PRESCALER_DIV8 WWDG counter clock = (PCLK1/4096)/8
 */
void WWDG_SetPrescalerDiv(uint32_t WWDG_Prescaler)
{
 8001176:	1141                	addi	sp,sp,-16
 8001178:	c422                	sw	s0,8(sp)
 800117a:	c606                	sw	ra,12(sp)
    uint32_t tmpregister = 0;
	
    /* Check the parameters */
    assert_param(IS_WWDG_PRESCALER_DIV(WWDG_Prescaler));
 800117c:	e7f57793          	andi	a5,a0,-385
{
 8001180:	842a                	mv	s0,a0
    assert_param(IS_WWDG_PRESCALER_DIV(WWDG_Prescaler));
 8001182:	cf81                	beqz	a5,800119a <WWDG_SetPrescalerDiv+0x24>
 8001184:	05c00613          	li	a2,92
 8001188:	00002597          	auipc	a1,0x2
 800118c:	f5058593          	addi	a1,a1,-176 # 80030d8 <s_ApbAhbPresTable+0x1c8>
 8001190:	00002517          	auipc	a0,0x2
 8001194:	f9850513          	addi	a0,a0,-104 # 8003128 <s_ApbAhbPresTable+0x218>
 8001198:	2211                	jal	800129c <assert_failed>
	
	tmpregister = WWDG->CFG;
 800119a:	400037b7          	lui	a5,0x40003
 800119e:	c047a503          	lw	a0,-1020(a5) # 40002c04 <_sp+0x1ffe2c04>
    /* Set WDGTB[1:0] bits according to WWDG_Prescaler value */
    tmpregister |= WWDG_Prescaler;
	
    /* Store the new value */
    WWDG->CFG = tmpregister;
}
 80011a2:	40b2                	lw	ra,12(sp)
    tmpregister &= (~WWDG_CFG_TIMERB);
 80011a4:	e7f57513          	andi	a0,a0,-385
    tmpregister |= WWDG_Prescaler;
 80011a8:	8c49                	or	s0,s0,a0
    WWDG->CFG = tmpregister;
 80011aa:	c087a223          	sw	s0,-1020(a5)
}
 80011ae:	4422                	lw	s0,8(sp)
 80011b0:	0141                	addi	sp,sp,16
 80011b2:	8082                	ret

080011b4 <WWDG_SetWValue>:
 * @brief  Sets the WWDG window value.
 * @param WindowValue specifies the window value to be compared to the downcounter.
 *   This parameter value must be lower than 0x80.
 */
void WWDG_SetWValue(uint8_t WindowValue)
{
 80011b4:	1141                	addi	sp,sp,-16
    uint32_t tmpregister = 0;

    /* Check the parameters */
    assert_param(IS_WWDG_VALUE(WindowValue));
 80011b6:	01851793          	slli	a5,a0,0x18
{
 80011ba:	c422                	sw	s0,8(sp)
 80011bc:	c606                	sw	ra,12(sp)
    assert_param(IS_WWDG_VALUE(WindowValue));
 80011be:	87e1                	srai	a5,a5,0x18
{
 80011c0:	842a                	mv	s0,a0
    assert_param(IS_WWDG_VALUE(WindowValue));
 80011c2:	0007cf63          	bltz	a5,80011e0 <WWDG_SetWValue+0x2c>
	
	tmpregister = WWDG->CFG;
 80011c6:	400037b7          	lui	a5,0x40003
 80011ca:	c047a503          	lw	a0,-1020(a5) # 40002c04 <_sp+0x1ffe2c04>
    /* Set W[6:0] bits according to WindowValue value */
    tmpregister |= (uint32_t)WindowValue;

    /* Store the new value */
    WWDG->CFG = tmpregister;
}
 80011ce:	40b2                	lw	ra,12(sp)
    tmpregister &= (~WWDG_CFG_W);
 80011d0:	f8057513          	andi	a0,a0,-128
    tmpregister |= (uint32_t)WindowValue;
 80011d4:	8c49                	or	s0,s0,a0
    WWDG->CFG = tmpregister;
 80011d6:	c087a223          	sw	s0,-1020(a5)
}
 80011da:	4422                	lw	s0,8(sp)
 80011dc:	0141                	addi	sp,sp,16
 80011de:	8082                	ret
    assert_param(IS_WWDG_VALUE(WindowValue));
 80011e0:	07400613          	li	a2,116
 80011e4:	00002597          	auipc	a1,0x2
 80011e8:	ef458593          	addi	a1,a1,-268 # 80030d8 <s_ApbAhbPresTable+0x1c8>
 80011ec:	00002517          	auipc	a0,0x2
 80011f0:	f6450513          	addi	a0,a0,-156 # 8003150 <s_ApbAhbPresTable+0x240>
 80011f4:	2065                	jal	800129c <assert_failed>
 80011f6:	bfc1                	j	80011c6 <WWDG_SetWValue+0x12>

080011f8 <WWDG_SetCnt>:
 * @brief  Sets the WWDG counter value.
 * @param Counter specifies the watchdog counter value.
 *   This parameter must be a number between 0x40 and 0x7F.
 */
void WWDG_SetCnt(uint8_t Counter)
{
 80011f8:	1141                	addi	sp,sp,-16
    /* Check the parameters */
    assert_param(IS_WWDG_CNT(Counter));
 80011fa:	fc050793          	addi	a5,a0,-64
{
 80011fe:	c422                	sw	s0,8(sp)
 8001200:	c606                	sw	ra,12(sp)
    assert_param(IS_WWDG_CNT(Counter));
 8001202:	0ff7f793          	zext.b	a5,a5
 8001206:	03f00713          	li	a4,63
{
 800120a:	842a                	mv	s0,a0
    assert_param(IS_WWDG_CNT(Counter));
 800120c:	00f76a63          	bltu	a4,a5,8001220 <WWDG_SetCnt+0x28>
	
    /* Write to T[6:0] bits to configure the counter value. Actually no need to do
       a read-modify-write, because writing a 0 to ACTB bit does nothing */
    WWDG->CTRL = Counter;
 8001210:	400037b7          	lui	a5,0x40003
}
 8001214:	40b2                	lw	ra,12(sp)
    WWDG->CTRL = Counter;
 8001216:	c087a023          	sw	s0,-1024(a5) # 40002c00 <_sp+0x1ffe2c00>
}
 800121a:	4422                	lw	s0,8(sp)
 800121c:	0141                	addi	sp,sp,16
 800121e:	8082                	ret
    assert_param(IS_WWDG_CNT(Counter));
 8001220:	09200613          	li	a2,146
 8001224:	00002597          	auipc	a1,0x2
 8001228:	eb458593          	addi	a1,a1,-332 # 80030d8 <s_ApbAhbPresTable+0x1c8>
 800122c:	00002517          	auipc	a0,0x2
 8001230:	f4050513          	addi	a0,a0,-192 # 800316c <s_ApbAhbPresTable+0x25c>
 8001234:	20a5                	jal	800129c <assert_failed>
    WWDG->CTRL = Counter;
 8001236:	400037b7          	lui	a5,0x40003
}
 800123a:	40b2                	lw	ra,12(sp)
    WWDG->CTRL = Counter;
 800123c:	c087a023          	sw	s0,-1024(a5) # 40002c00 <_sp+0x1ffe2c00>
}
 8001240:	4422                	lw	s0,8(sp)
 8001242:	0141                	addi	sp,sp,16
 8001244:	8082                	ret

08001246 <WWDG_Enable>:
 * @brief  Enables WWDG and load the counter value.
 * @param Counter specifies the watchdog counter value.
 *   This parameter must be a number between 0x40 and 0x7F.
 */
void WWDG_Enable(uint8_t Counter)
{
 8001246:	1141                	addi	sp,sp,-16
    /* Check the parameters */
    assert_param(IS_WWDG_CNT(Counter));
 8001248:	fc050793          	addi	a5,a0,-64
{
 800124c:	c422                	sw	s0,8(sp)
 800124e:	c606                	sw	ra,12(sp)
    assert_param(IS_WWDG_CNT(Counter));
 8001250:	0ff7f793          	zext.b	a5,a5
 8001254:	03f00713          	li	a4,63
{
 8001258:	842a                	mv	s0,a0
    assert_param(IS_WWDG_CNT(Counter));
 800125a:	00f76c63          	bltu	a4,a5,8001272 <WWDG_Enable+0x2c>
	
    WWDG->CTRL = CTRL_ACTB_SET | Counter;
 800125e:	08046413          	ori	s0,s0,128
 8001262:	400037b7          	lui	a5,0x40003
}
 8001266:	40b2                	lw	ra,12(sp)
    WWDG->CTRL = CTRL_ACTB_SET | Counter;
 8001268:	c087a023          	sw	s0,-1024(a5) # 40002c00 <_sp+0x1ffe2c00>
}
 800126c:	4422                	lw	s0,8(sp)
 800126e:	0141                	addi	sp,sp,16
 8001270:	8082                	ret
    assert_param(IS_WWDG_CNT(Counter));
 8001272:	0a100613          	li	a2,161
 8001276:	00002597          	auipc	a1,0x2
 800127a:	e6258593          	addi	a1,a1,-414 # 80030d8 <s_ApbAhbPresTable+0x1c8>
 800127e:	00002517          	auipc	a0,0x2
 8001282:	eee50513          	addi	a0,a0,-274 # 800316c <s_ApbAhbPresTable+0x25c>
 8001286:	2819                	jal	800129c <assert_failed>
    WWDG->CTRL = CTRL_ACTB_SET | Counter;
 8001288:	08046413          	ori	s0,s0,128
 800128c:	400037b7          	lui	a5,0x40003
}
 8001290:	40b2                	lw	ra,12(sp)
    WWDG->CTRL = CTRL_ACTB_SET | Counter;
 8001292:	c087a023          	sw	s0,-1024(a5) # 40002c00 <_sp+0x1ffe2c00>
}
 8001296:	4422                	lw	s0,8(sp)
 8001298:	0141                	addi	sp,sp,16
 800129a:	8082                	ret

0800129c <assert_failed>:
 * @param  expr: The expression of parameter check.
 *         file: source file name of the expression.
 *         line: source line number of the expression.
 */
__WEAK void assert_failed(const uint8_t* expr, const uint8_t* file, uint32_t line)
{
 800129c:	1141                	addi	sp,sp,-16
 800129e:	86b2                	mv	a3,a2
	printf("assertion failed: `%s` at %s:%d\r\n", expr, file, line);
 80012a0:	862e                	mv	a2,a1
 80012a2:	85aa                	mv	a1,a0
 80012a4:	00002517          	auipc	a0,0x2
 80012a8:	ee050513          	addi	a0,a0,-288 # 8003184 <s_ApbAhbPresTable+0x274>
{
 80012ac:	c606                	sw	ra,12(sp)
	printf("assertion failed: `%s` at %s:%d\r\n", expr, file, line);
 80012ae:	74a000ef          	jal	ra,80019f8 <iprintf>
	while(1)
 80012b2:	a001                	j	80012b2 <assert_failed+0x16>

080012b4 <eclic_msip_handler>:
 * @brief  This function handles software interrupt request.
 */
void eclic_msip_handler(void)
{

}
 80012b4:	8082                	ret

080012b6 <eclic_mtip_handler>:
/**
 * @brief  This function handles TIMER interrupt request.
 */
void eclic_mtip_handler(void)
{
    TimingDelay--;
 80012b6:	17fff697          	auipc	a3,0x17fff
 80012ba:	db668693          	addi	a3,a3,-586 # 2000006c <TimingDelay>
 80012be:	429c                	lw	a5,0(a3)
    high0 = *(volatile uint32_t *)((uint32_t)(&SysTimer->MTIMER) + 4);
 80012c0:	e0020737          	lui	a4,0xe0020
 80012c4:	17fd                	addi	a5,a5,-1
 80012c6:	c29c                	sw	a5,0(a3)
 80012c8:	435c                	lw	a5,4(a4)
{
 80012ca:	7179                	addi	sp,sp,-48
 80012cc:	d23e                	sw	a5,36(sp)
    low = *(volatile uint32_t *)((uint32_t)(&SysTimer->MTIMER));
 80012ce:	431c                	lw	a5,0(a4)

	SysTick_Reload(SystemCoreClock / 1000);
 80012d0:	106256b7          	lui	a3,0x10625
 80012d4:	d43e                	sw	a5,40(sp)
    high = *(volatile uint32_t *)((uint32_t)(&SysTimer->MTIMER) + 4);
 80012d6:	435c                	lw	a5,4(a4)
 80012d8:	dd368693          	addi	a3,a3,-557 # 10624dd3 <__ILM_RAM_BASE+0x624dd3>
 80012dc:	d63e                	sw	a5,44(sp)
    if (high0 != high) {
 80012de:	5592                	lw	a1,36(sp)
 80012e0:	17fff797          	auipc	a5,0x17fff
 80012e4:	d807a783          	lw	a5,-640(a5) # 20000060 <SystemCoreClock>
 80012e8:	5632                	lw	a2,44(sp)
 80012ea:	02d7b7b3          	mulhu	a5,a5,a3
 80012ee:	8399                	srli	a5,a5,0x6
 80012f0:	00c58463          	beq	a1,a2,80012f8 <eclic_mtip_handler+0x42>
        low = *(volatile uint32_t *)((uint32_t)(&SysTimer->MTIMER));
 80012f4:	4318                	lw	a4,0(a4)
 80012f6:	d43a                	sw	a4,40(sp)
    full = (((uint64_t)high) << 32) | low;
 80012f8:	56b2                	lw	a3,44(sp)
 80012fa:	55a2                	lw	a1,40(sp)
 * - \ref SysTimer_SetLoadValue
 */
__STATIC_FORCEINLINE uint32_t SysTick_Reload(uint64_t ticks)
{
    uint64_t cur_ticks = SysTimer_GetLoadValue();
    uint64_t reload_ticks = ticks + cur_ticks;
 80012fc:	00b78633          	add	a2,a5,a1
 8001300:	00f63733          	sltu	a4,a2,a5
 8001304:	9736                	add	a4,a4,a3

    if (__USUALLY(reload_ticks > cur_ticks)) {
 8001306:	00e6fe63          	bgeu	a3,a4,8001322 <eclic_mtip_handler+0x6c>
	high = (value >> 32) & 0xFFFFFFFF;
 800130a:	ce3a                	sw	a4,28(sp)
	low = value & 0xFFFFFFFF;
 800130c:	d032                	sw	a2,32(sp)
	*(volatile uint32_t *)((uint32_t)(&SysTimer->MTIMERCMP) + 4) = 0xFFFFFFFF;		// No smaller than old value
 800130e:	e00207b7          	lui	a5,0xe0020
 8001312:	577d                	li	a4,-1
 8001314:	c7d8                	sw	a4,12(a5)
	*(volatile uint32_t *)((uint32_t)(&SysTimer->MTIMERCMP) + 0) = low;				// New value
 8001316:	5702                	lw	a4,32(sp)
 8001318:	c798                	sw	a4,8(a5)
	*(volatile uint32_t *)((uint32_t)(&SysTimer->MTIMERCMP) + 4) = high;		    // New value
 800131a:	4772                	lw	a4,28(sp)
 800131c:	c7d8                	sw	a4,12(a5)
}
 800131e:	6145                	addi	sp,sp,48
 8001320:	8082                	ret
    if (__USUALLY(reload_ticks > cur_ticks)) {
 8001322:	00d71463          	bne	a4,a3,800132a <eclic_mtip_handler+0x74>
 8001326:	fec5e2e3          	bltu	a1,a2,800130a <eclic_mtip_handler+0x54>
    high = (value >> 32) & 0xFFFFFFFF;
 800132a:	c602                	sw	zero,12(sp)
    low = value & 0xFFFFFFFF;
 800132c:	c802                	sw	zero,16(sp)
    *(volatile uint32_t *)((uint32_t)(&SysTimer->MTIMER) + 0) = 0;	//prevent carry
 800132e:	e0020737          	lui	a4,0xe0020
 8001332:	00072023          	sw	zero,0(a4) # e0020000 <_sp+0xc0000000>
	*(volatile uint32_t *)((uint32_t)(&SysTimer->MTIMER) + 4) = high;
 8001336:	46b2                	lw	a3,12(sp)
 8001338:	c354                	sw	a3,4(a4)
	*(volatile uint32_t *)((uint32_t)(&SysTimer->MTIMER) + 0) = low;
 800133a:	46c2                	lw	a3,16(sp)
 800133c:	c314                	sw	a3,0(a4)
	high = (value >> 32) & 0xFFFFFFFF;
 800133e:	ca02                	sw	zero,20(sp)
	low = value & 0xFFFFFFFF;
 8001340:	cc3e                	sw	a5,24(sp)
	*(volatile uint32_t *)((uint32_t)(&SysTimer->MTIMERCMP) + 4) = 0xFFFFFFFF;		// No smaller than old value
 8001342:	57fd                	li	a5,-1
 8001344:	c75c                	sw	a5,12(a4)
	*(volatile uint32_t *)((uint32_t)(&SysTimer->MTIMERCMP) + 0) = low;				// New value
 8001346:	47e2                	lw	a5,24(sp)
 8001348:	c71c                	sw	a5,8(a4)
	*(volatile uint32_t *)((uint32_t)(&SysTimer->MTIMERCMP) + 4) = high;		    // New value
 800134a:	47d2                	lw	a5,20(sp)
 800134c:	c75c                	sw	a5,12(a4)
 800134e:	6145                	addi	sp,sp,48
 8001350:	8082                	ret

08001352 <SystemCoreClockUpdate>:
    uint32_t tmp		= 0;
	uint32_t pllmull	= 0;
	uint32_t pllsource	= 0;

	/* Get SYSCLK source */
    tmp = RCC->CFG & RCC_CFG_SCLKSTS;
 8001352:	400216b7          	lui	a3,0x40021
 8001356:	42d8                	lw	a4,4(a3)

    switch (tmp)
 8001358:	007a17b7          	lui	a5,0x7a1
    tmp = RCC->CFG & RCC_CFG_SCLKSTS;
 800135c:	8b31                	andi	a4,a4,12
    switch (tmp)
 800135e:	4621                	li	a2,8
 8001360:	20078793          	addi	a5,a5,512 # 7a1200 <__FLASH_SIZE+0x721200>
 8001364:	02c70563          	beq	a4,a2,800138e <SystemCoreClockUpdate+0x3c>
        break;
    }

    /* Compute HCLK clock frequency */
    /* Get HCLK prescaler */
    tmp = AHBPrescTable[((RCC->CFG & RCC_CFG_AHBPRES) >> 4)];
 8001368:	40021737          	lui	a4,0x40021
 800136c:	4358                	lw	a4,4(a4)
 800136e:	00002697          	auipc	a3,0x2
 8001372:	f5668693          	addi	a3,a3,-170 # 80032c4 <AHBPrescTable>
 8001376:	8311                	srli	a4,a4,0x4
 8001378:	8b3d                	andi	a4,a4,15
 800137a:	9736                	add	a4,a4,a3
 800137c:	00074703          	lbu	a4,0(a4) # 40021000 <_sp+0x20001000>
	
    /* HCLK clock frequency */
    SystemCoreClock >>= tmp;
 8001380:	00e7d7b3          	srl	a5,a5,a4
 8001384:	17fff717          	auipc	a4,0x17fff
 8001388:	ccf72e23          	sw	a5,-804(a4) # 20000060 <SystemCoreClock>
}
 800138c:	8082                	ret
        pllmull   = RCC->CFG & RCC_CFG_PLLMULFCT;
 800138e:	42dc                	lw	a5,4(a3)
        if ((pllmull & RCC_CFG_PLLMULFCT_4) == 0){
 8001390:	08000737          	lui	a4,0x8000
        pllsource = RCC->CFG & RCC_CFG_PLLSRC;
 8001394:	42d0                	lw	a2,4(a3)
            pllmull = (pllmull >> 18) + 2; /* PLLMUL[4] = 0 */
 8001396:	0127d693          	srli	a3,a5,0x12
 800139a:	20f6f693          	andi	a3,a3,527
        if ((pllmull & RCC_CFG_PLLMULFCT_4) == 0){
 800139e:	8f7d                	and	a4,a4,a5
        pllsource = RCC->CFG & RCC_CFG_PLLSRC;
 80013a0:	67c1                	lui	a5,0x10
 80013a2:	8e7d                	and	a2,a2,a5
            pllmull = ((pllmull >> 18) - 512 + 16) + 1; /* PLLMUL[4] = 1 */
 80013a4:	e1168793          	addi	a5,a3,-495
        if ((pllmull & RCC_CFG_PLLMULFCT_4) == 0){
 80013a8:	e319                	bnez	a4,80013ae <SystemCoreClockUpdate+0x5c>
            pllmull = (pllmull >> 18) + 2; /* PLLMUL[4] = 0 */
 80013aa:	00268793          	addi	a5,a3,2
        if (pllsource == 0x00){
 80013ae:	ce19                	beqz	a2,80013cc <SystemCoreClockUpdate+0x7a>
            if ((RCC->CFG & RCC_CFG_PLLHSEPRES) != (uint32_t)RESET){
 80013b0:	40021737          	lui	a4,0x40021
 80013b4:	4358                	lw	a4,4(a4)
 80013b6:	000206b7          	lui	a3,0x20
 80013ba:	8f75                	and	a4,a4,a3
 80013bc:	eb01                	bnez	a4,80013cc <SystemCoreClockUpdate+0x7a>
                SystemCoreClock = HSE_VALUE * pllmull;
 80013be:	007a1737          	lui	a4,0x7a1
 80013c2:	20070713          	addi	a4,a4,512 # 7a1200 <__FLASH_SIZE+0x721200>
 80013c6:	02e787b3          	mul	a5,a5,a4
 80013ca:	bf79                	j	8001368 <SystemCoreClockUpdate+0x16>
                SystemCoreClock = (HSE_VALUE >> 1) * pllmull;
 80013cc:	003d1737          	lui	a4,0x3d1
 80013d0:	90070713          	addi	a4,a4,-1792 # 3d0900 <__FLASH_SIZE+0x350900>
 80013d4:	02e787b3          	mul	a5,a5,a4
 80013d8:	bf41                	j	8001368 <SystemCoreClockUpdate+0x16>

080013da <SystemInit>:
    /* FPU is enabled during startup */
#endif

    /* Reset the RCC clock configuration to the default reset state(for debug purpose) */
    /* Set HSIEN bit */
    RCC->CTRL |= (uint32_t)0x00000001;
 80013da:	400217b7          	lui	a5,0x40021
 80013de:	4398                	lw	a4,0(a5)

    /* Reset SW, HPRE, PPRE1, PPRE2, ADCPRE and MCO bits */
    RCC->CFG &= (uint32_t)0xF8FFC000;
 80013e0:	f8ffc6b7          	lui	a3,0xf8ffc
    RCC->CTRL |= (uint32_t)0x00000001;
 80013e4:	00176713          	ori	a4,a4,1
 80013e8:	c398                	sw	a4,0(a5)
    RCC->CFG &= (uint32_t)0xF8FFC000;
 80013ea:	43d8                	lw	a4,4(a5)
    RCC->CTRL |= ((uint32_t) RCC_CTRL_HSEEN);
 80013ec:	6641                	lui	a2,0x10
    RCC->CFG &= (uint32_t)0xF8FFC000;
 80013ee:	8f75                	and	a4,a4,a3
 80013f0:	c3d8                	sw	a4,4(a5)

    /* Reset HSEON, CLKSSEN and PLLEN bits */
    RCC->CTRL &= (uint32_t)0xFEF6FFFF;
 80013f2:	4398                	lw	a4,0(a5)
 80013f4:	fef706b7          	lui	a3,0xfef70
 80013f8:	16fd                	addi	a3,a3,-1
 80013fa:	8f75                	and	a4,a4,a3
 80013fc:	c398                	sw	a4,0(a5)

    /* Reset HSEBYP bit */
    RCC->CTRL &= (uint32_t)0xFFFBFFFF;
 80013fe:	4398                	lw	a4,0(a5)
 8001400:	fffc06b7          	lui	a3,0xfffc0
 8001404:	16fd                	addi	a3,a3,-1
 8001406:	8f75                	and	a4,a4,a3
 8001408:	c398                	sw	a4,0(a5)

    /* Reset PLLSRC, PLLXTPRE, PLLMUL and USBPRES/OTGFSPRE bits */
    RCC->CFG &= (uint32_t)0xF700FFFF;
 800140a:	43d8                	lw	a4,4(a5)
 800140c:	f70106b7          	lui	a3,0xf7010
 8001410:	16fd                	addi	a3,a3,-1
 8001412:	8f75                	and	a4,a4,a3
 8001414:	c3d8                	sw	a4,4(a5)

    /* Reset CFG2 register */
    RCC->CFG2 = 0x00000000;
 8001416:	0207a623          	sw	zero,44(a5) # 4002102c <_sp+0x2000102c>

    /* Reset CFG3 register */
    RCC->CFG3 = 0x00000000;
 800141a:	0207a823          	sw	zero,48(a5)

    /* Disable all interrupts and clear pending bits  */
    RCC->CLKINT = 0x009F0000;
 800141e:	009f0737          	lui	a4,0x9f0
 8001422:	c798                	sw	a4,8(a5)

    /* Enable ex mode */
    RCC->APB1PCLKEN |= RCC_APB1PCLKEN_PWREN;
 8001424:	4fd8                	lw	a4,28(a5)
 8001426:	100006b7          	lui	a3,0x10000
 800142a:	8f55                	or	a4,a4,a3
 800142c:	cfd8                	sw	a4,28(a5)
    PWR->CTRL3 |= 0x00000001;
 800142e:	400076b7          	lui	a3,0x40007
 8001432:	46d8                	lw	a4,12(a3)
 8001434:	00176713          	ori	a4,a4,1
 8001438:	c6d8                	sw	a4,12(a3)
    RCC->APB1PCLKEN &= (uint32_t)(~RCC_APB1PCLKEN_PWREN);
 800143a:	4fd8                	lw	a4,28(a5)
 800143c:	f00006b7          	lui	a3,0xf0000
 8001440:	16fd                	addi	a3,a3,-1
 8001442:	8f75                	and	a4,a4,a3
 8001444:	cfd8                	sw	a4,28(a5)

    /* Enable ICACHE and Prefetch Buffer */
    FLASH->AC |= (uint32_t)(FLASH_AC_ICAHEN | FLASH_AC_PRFTBFE);
 8001446:	400226b7          	lui	a3,0x40022
 800144a:	4298                	lw	a4,0(a3)
 800144c:	09076713          	ori	a4,a4,144
 8001450:	c298                	sw	a4,0(a3)
    RCC->CTRL |= ((uint32_t) RCC_CTRL_HSEEN);
 8001452:	4394                	lw	a3,0(a5)
 8001454:	50000713          	li	a4,1280
 8001458:	8ed1                	or	a3,a3,a2
 800145a:	c394                	sw	a3,0(a5)
        HSEStatus = RCC->CTRL & RCC_CTRL_HSERDF;
 800145c:	40021637          	lui	a2,0x40021
 8001460:	000206b7          	lui	a3,0x20
 8001464:	a011                	j	8001468 <SystemInit+0x8e>
    } while ((HSEStatus == 0) && (StartUpCounter != HSE_STARTUP_TIMEOUT));
 8001466:	c709                	beqz	a4,8001470 <SystemInit+0x96>
        HSEStatus = RCC->CTRL & RCC_CTRL_HSERDF;
 8001468:	421c                	lw	a5,0(a2)
    } while ((HSEStatus == 0) && (StartUpCounter != HSE_STARTUP_TIMEOUT));
 800146a:	177d                	addi	a4,a4,-1
        HSEStatus = RCC->CTRL & RCC_CTRL_HSERDF;
 800146c:	8ff5                	and	a5,a5,a3
    } while ((HSEStatus == 0) && (StartUpCounter != HSE_STARTUP_TIMEOUT));
 800146e:	dfe5                	beqz	a5,8001466 <SystemInit+0x8c>
    HSEStatus = ((RCC->CTRL & RCC_CTRL_HSERDF) != RESET);
 8001470:	400217b7          	lui	a5,0x40021
 8001474:	4398                	lw	a4,0(a5)
 8001476:	000206b7          	lui	a3,0x20
 800147a:	8f75                	and	a4,a4,a3
    if (!HSEStatus){
 800147c:	c349                	beqz	a4,80014fe <SystemInit+0x124>
    FLASH->AC &= (uint32_t)((uint32_t)~FLASH_AC_LATENCY);
 800147e:	40022737          	lui	a4,0x40022
 8001482:	4314                	lw	a3,0(a4)
    RCC->CFG &= (uint32_t)((uint32_t) ~(RCC_CFG_PLLSRC | RCC_CFG_PLLHSEPRES | RCC_CFG_PLLMULFCT));
 8001484:	f7c10637          	lui	a2,0xf7c10
    FLASH->AC &= (uint32_t)((uint32_t)~FLASH_AC_LATENCY);
 8001488:	9ae1                	andi	a3,a3,-8
 800148a:	c314                	sw	a3,0(a4)
    FLASH->AC |= (uint32_t)((SYSTEM_CORE_CLOCK - 1) / 32000000);
 800148c:	4314                	lw	a3,0(a4)
    RCC->CFG &= (uint32_t)((uint32_t) ~(RCC_CFG_PLLSRC | RCC_CFG_PLLHSEPRES | RCC_CFG_PLLMULFCT));
 800148e:	167d                	addi	a2,a2,-1
    FLASH->AC |= (uint32_t)((SYSTEM_CORE_CLOCK - 1) / 32000000);
 8001490:	0046e693          	ori	a3,a3,4
 8001494:	c314                	sw	a3,0(a4)
    RCC->CFG |= (uint32_t)RCC_CFG_AHBPRES_DIV1;
 8001496:	43d8                	lw	a4,4(a5)
        RCC->CFG |= (uint32_t)RCC_CFG_APB2PRES_DIV2;
 8001498:	6689                	lui	a3,0x2
    RCC->CFG |= (uint32_t)RCC_CFG_AHBPRES_DIV1;
 800149a:	c3d8                	sw	a4,4(a5)
        RCC->CFG |= (uint32_t)RCC_CFG_APB2PRES_DIV2;
 800149c:	43d8                	lw	a4,4(a5)
    rcc_cfgr |= ((PLL_MUL - 17) << 18) | (1 << 27);
 800149e:	080505b7          	lui	a1,0x8050
        RCC->CFG |= (uint32_t)RCC_CFG_APB2PRES_DIV2;
 80014a2:	8f55                	or	a4,a4,a3
 80014a4:	c3d8                	sw	a4,4(a5)
        RCC->CFG |= (uint32_t)RCC_CFG_APB1PRES_DIV4;
 80014a6:	43d8                	lw	a4,4(a5)
 80014a8:	50076713          	ori	a4,a4,1280
 80014ac:	c3d8                	sw	a4,4(a5)
    RCC->CFG &= (uint32_t)((uint32_t) ~(RCC_CFG_PLLSRC | RCC_CFG_PLLHSEPRES | RCC_CFG_PLLMULFCT));
 80014ae:	43d4                	lw	a3,4(a5)
    while ((RCC->CTRL & RCC_CTRL_PLLRDF) == 0){
 80014b0:	40021737          	lui	a4,0x40021
    RCC->CFG &= (uint32_t)((uint32_t) ~(RCC_CFG_PLLSRC | RCC_CFG_PLLHSEPRES | RCC_CFG_PLLMULFCT));
 80014b4:	8ef1                	and	a3,a3,a2
 80014b6:	c3d4                	sw	a3,4(a5)
    rcc_cfgr = RCC->CFG;
 80014b8:	43d0                	lw	a2,4(a5)
    while ((RCC->CTRL & RCC_CTRL_PLLRDF) == 0){
 80014ba:	020006b7          	lui	a3,0x2000
    rcc_cfgr |= ((PLL_MUL - 17) << 18) | (1 << 27);
 80014be:	8e4d                	or	a2,a2,a1
    RCC->CFG = rcc_cfgr;
 80014c0:	c3d0                	sw	a2,4(a5)
    RCC->CTRL |= RCC_CTRL_PLLEN;
 80014c2:	4390                	lw	a2,0(a5)
 80014c4:	010005b7          	lui	a1,0x1000
 80014c8:	8e4d                	or	a2,a2,a1
 80014ca:	c390                	sw	a2,0(a5)
    while ((RCC->CTRL & RCC_CTRL_PLLRDF) == 0){
 80014cc:	431c                	lw	a5,0(a4)
 80014ce:	8ff5                	and	a5,a5,a3
 80014d0:	dff5                	beqz	a5,80014cc <SystemInit+0xf2>
    RCC->CFG &= (uint32_t)((uint32_t) ~(RCC_CFG_SCLKSW));
 80014d2:	435c                	lw	a5,4(a4)
    while ((RCC->CFG & (uint32_t)RCC_CFG_SCLKSTS) != (uint32_t)0x08){
 80014d4:	40021637          	lui	a2,0x40021
    RCC->CFG &= (uint32_t)((uint32_t) ~(RCC_CFG_SCLKSW));
 80014d8:	9bf1                	andi	a5,a5,-4
 80014da:	c35c                	sw	a5,4(a4)
    RCC->CFG |= (uint32_t)RCC_CFG_SCLKSW_PLL;
 80014dc:	435c                	lw	a5,4(a4)
    while ((RCC->CFG & (uint32_t)RCC_CFG_SCLKSTS) != (uint32_t)0x08){
 80014de:	46a1                	li	a3,8
    RCC->CFG |= (uint32_t)RCC_CFG_SCLKSW_PLL;
 80014e0:	0027e793          	ori	a5,a5,2
 80014e4:	c35c                	sw	a5,4(a4)
    while ((RCC->CFG & (uint32_t)RCC_CFG_SCLKSTS) != (uint32_t)0x08){
 80014e6:	425c                	lw	a5,4(a2)
 80014e8:	8bb1                	andi	a5,a5,12
 80014ea:	fed79ee3          	bne	a5,a3,80014e6 <SystemInit+0x10c>
    return (SysTimer->MTIMECTL & SysTimer_MTIMECTL_Msk);
 80014ee:	e0021737          	lui	a4,0xe0021
 80014f2:	ff872783          	lw	a5,-8(a4) # e0020ff8 <_sp+0xc0000ff8>
    SysTimer_SetControlValue(SystimerCtrl | SysTimer_MTIMECTL_CLKSRC_Msk);
 80014f6:	0047e793          	ori	a5,a5,4
    SysTimer->MTIMECTL = (mctl & SysTimer_MTIMECTL_Msk);
 80014fa:	fef72c23          	sw	a5,-8(a4)
#endif /* DATA_IN_ExtSRAM */

    /* Configure the System clock frequency, HCLK, PCLK2 and PCLK1 prescalers */
    /* Configure the Flash Latency cycles and enable prefetch buffer */
    SystemClockInit();
}
 80014fe:	8082                	ret

08001500 <Exception_DumpFrame>:
 * \brief      Dump Exception Frame
 * \details
 * This function provided feature to dump exception frame stored in stack.
 */
void Exception_DumpFrame(unsigned long sp)
{
 8001500:	85aa                	mv	a1,a0
    EXC_Frame_Type *exc_frame = (EXC_Frame_Type *)sp;

#ifndef __riscv_32e
    printf("ra: 0x%x, tp: 0x%x, t0: 0x%x, t1: 0x%x, t2: 0x%x, t3: 0x%x, t4: 0x%x, t5: 0x%x, t6: 0x%x\n" \
 8001502:	5948                	lw	a0,52(a0)
{
 8001504:	715d                	addi	sp,sp,-80
    printf("ra: 0x%x, tp: 0x%x, t0: 0x%x, t1: 0x%x, t2: 0x%x, t3: 0x%x, t4: 0x%x, t5: 0x%x, t6: 0x%x\n" \
 8001506:	0445a883          	lw	a7,68(a1) # 1000044 <__FLASH_SIZE+0xf80044>
 800150a:	0405a803          	lw	a6,64(a1)
 800150e:	499c                	lw	a5,16(a1)
 8001510:	45d8                	lw	a4,12(a1)
 8001512:	4594                	lw	a3,8(a1)
 8001514:	41d0                	lw	a2,4(a1)
 8001516:	d82a                	sw	a0,48(sp)
 8001518:	5988                	lw	a0,48(a1)
{
 800151a:	c686                	sw	ra,76(sp)
    printf("ra: 0x%x, tp: 0x%x, t0: 0x%x, t1: 0x%x, t2: 0x%x, t3: 0x%x, t4: 0x%x, t5: 0x%x, t6: 0x%x\n" \
 800151c:	d62a                	sw	a0,44(sp)
 800151e:	55c8                	lw	a0,44(a1)
 8001520:	d42a                	sw	a0,40(sp)
 8001522:	5dc8                	lw	a0,60(a1)
 8001524:	d22a                	sw	a0,36(sp)
 8001526:	5d88                	lw	a0,56(a1)
 8001528:	d02a                	sw	a0,32(sp)
 800152a:	5588                	lw	a0,40(a1)
 800152c:	ce2a                	sw	a0,28(sp)
 800152e:	51c8                	lw	a0,36(a1)
 8001530:	cc2a                	sw	a0,24(sp)
 8001532:	0205a303          	lw	t1,32(a1)
 8001536:	00002517          	auipc	a0,0x2
 800153a:	c9a50513          	addi	a0,a0,-870 # 80031d0 <s_ApbAhbPresTable+0x2c0>
 800153e:	ca1a                	sw	t1,20(sp)
 8001540:	01c5a303          	lw	t1,28(a1)
 8001544:	c81a                	sw	t1,16(sp)
 8001546:	0185a303          	lw	t1,24(a1)
 800154a:	c61a                	sw	t1,12(sp)
 800154c:	0145a303          	lw	t1,20(a1)
 8001550:	c41a                	sw	t1,8(sp)
 8001552:	04c5a303          	lw	t1,76(a1)
 8001556:	c21a                	sw	t1,4(sp)
 8001558:	0485a303          	lw	t1,72(a1)
 800155c:	c01a                	sw	t1,0(sp)
 800155e:	418c                	lw	a1,0(a1)
 8001560:	2961                	jal	80019f8 <iprintf>
           "a0: 0x%x, a1: 0x%x, a2: 0x%x, a3: 0x%x, a4: 0x%x, a5: 0x%x\n" \
           "mcause: 0x%x, mepc: 0x%x, msubm: 0x%x\n", exc_frame->ra, exc_frame->tp, exc_frame->t0, \
           exc_frame->t1, exc_frame->t2, exc_frame->a0, exc_frame->a1, exc_frame->a2, exc_frame->a3, \
           exc_frame->a4, exc_frame->a5, exc_frame->mcause, exc_frame->mepc, exc_frame->msubm);
#endif
}
 8001562:	40b6                	lw	ra,76(sp)
 8001564:	6161                	addi	sp,sp,80
 8001566:	8082                	ret

08001568 <system_default_exception_handler>:
{
 8001568:	1141                	addi	sp,sp,-16
 800156a:	c422                	sw	s0,8(sp)
 800156c:	c606                	sw	ra,12(sp)
 800156e:	842e                	mv	s0,a1
    printf("MDCAUSE: 0x%lx\r\n", __RV_CSR_READ(CSR_MDCAUSE));
 8001570:	7c9025f3          	csrr	a1,mdcause
 8001574:	00002517          	auipc	a0,0x2
 8001578:	d2c50513          	addi	a0,a0,-724 # 80032a0 <s_ApbAhbPresTable+0x390>
 800157c:	29b5                	jal	80019f8 <iprintf>
    printf("MTVAL : 0x%lx\r\n", __RV_CSR_READ(CSR_MBADADDR));
 800157e:	343025f3          	csrr	a1,mtval
 8001582:	00002517          	auipc	a0,0x2
 8001586:	d3250513          	addi	a0,a0,-718 # 80032b4 <s_ApbAhbPresTable+0x3a4>
 800158a:	21bd                	jal	80019f8 <iprintf>
    Exception_DumpFrame(sp);
 800158c:	8522                	mv	a0,s0
 800158e:	3f8d                	jal	8001500 <Exception_DumpFrame>
    while(1);
 8001590:	a001                	j	8001590 <system_default_exception_handler+0x28>

08001592 <core_exception_handler>:
 * - For the core_exception_handler template, we provided exception register function \ref Exception_Register_EXCn
 *   which can help developer to register your exception handler for specific exception number.
 */
uint32_t core_exception_handler(unsigned long mcause, unsigned long sp)
{
    uint32_t EXCn = (uint32_t)(mcause & 0X00000fff);
 8001592:	6785                	lui	a5,0x1
 8001594:	17fd                	addi	a5,a5,-1
 8001596:	00f57733          	and	a4,a0,a5
    EXC_HANDLER exc_handler;

    if ((EXCn < MAX_SYSTEM_EXCEPTION_NUM) && (EXCn >= 0)) {
 800159a:	46ad                	li	a3,11
 800159c:	00e6ef63          	bltu	a3,a4,80015ba <core_exception_handler+0x28>
        exc_handler = (EXC_HANDLER)SystemExceptionHandlers[EXCn];
 80015a0:	070a                	slli	a4,a4,0x2
 80015a2:	84018793          	addi	a5,gp,-1984 # 200000a0 <SystemExceptionHandlers>
 80015a6:	973e                	add	a4,a4,a5
 80015a8:	4314                	lw	a3,0(a4)
        exc_handler = (EXC_HANDLER)SystemExceptionHandlers[MAX_SYSTEM_EXCEPTION_NUM];
    } else {
        exc_handler = (EXC_HANDLER)system_default_exception_handler;
    }

    if (exc_handler != NULL) {
 80015aa:	c28d                	beqz	a3,80015cc <core_exception_handler+0x3a>
{
 80015ac:	1141                	addi	sp,sp,-16
 80015ae:	c606                	sw	ra,12(sp)
        exc_handler(mcause, sp);
 80015b0:	9682                	jalr	a3
    }
	
	return 0;
}
 80015b2:	40b2                	lw	ra,12(sp)
 80015b4:	4501                	li	a0,0
 80015b6:	0141                	addi	sp,sp,16
 80015b8:	8082                	ret
        exc_handler = (EXC_HANDLER)system_default_exception_handler;
 80015ba:	00000697          	auipc	a3,0x0
 80015be:	fae68693          	addi	a3,a3,-82 # 8001568 <system_default_exception_handler>
    } else if (EXCn == NMI_EXCn) {
 80015c2:	fef715e3          	bne	a4,a5,80015ac <core_exception_handler+0x1a>
        exc_handler = (EXC_HANDLER)SystemExceptionHandlers[MAX_SYSTEM_EXCEPTION_NUM];
 80015c6:	8701a683          	lw	a3,-1936(gp) # 200000d0 <SystemExceptionHandlers+0x30>
    if (exc_handler != NULL) {
 80015ca:	f2ed                	bnez	a3,80015ac <core_exception_handler+0x1a>
}
 80015cc:	4501                	li	a0,0
 80015ce:	8082                	ret

080015d0 <_premain_init>:
 * For RISC-V gnu toolchain, _init function might not be called
 * by __libc_init_array function, so we defined a new function
 * to do initialization
 */
void _premain_init(void)
{
 80015d0:	1141                	addi	sp,sp,-16
 80015d2:	c606                	sw	ra,12(sp)
#endif
#if defined(__DCACHE_PRESENT) && __DCACHE_PRESENT == 1
    EnableDCache();
#endif
	
	SystemCoreClockUpdate(); /* Get SystemCoreClock value */
 80015d4:	3bbd                	jal	8001352 <SystemCoreClockUpdate>
        SystemExceptionHandlers[i] = (unsigned long)system_default_exception_handler;
 80015d6:	00000697          	auipc	a3,0x0
 80015da:	f9268693          	addi	a3,a3,-110 # 8001568 <system_default_exception_handler>
 80015de:	84018793          	addi	a5,gp,-1984 # 200000a0 <SystemExceptionHandlers>
 80015e2:	87418713          	addi	a4,gp,-1932 # 200000d4 <_global_atexit0>
 80015e6:	c394                	sw	a3,0(a5)
    for (int i = 0; i < MAX_SYSTEM_EXCEPTION_NUM + 1; i++) {
 80015e8:	0791                	addi	a5,a5,4
 80015ea:	fee79ee3          	bne	a5,a4,80015e6 <_premain_init+0x16>
    ECLIC->MTH = mth;
 80015ee:	e00107b7          	lui	a5,0xe0010
 80015f2:	000785a3          	sb	zero,11(a5) # e001000b <_sp+0xbfff000b>
    ECLIC->CFG &= ~CLIC_CLICCFG_NLBIT_Msk;
 80015f6:	0007c703          	lbu	a4,0(a5)
 80015fa:	0e177713          	andi	a4,a4,225
 80015fe:	00e78023          	sb	a4,0(a5)
    ECLIC->CFG |= (uint8_t)((nlbits <<CLIC_CLICCFG_NLBIT_Pos) & CLIC_CLICCFG_NLBIT_Msk);
 8001602:	0007c703          	lbu	a4,0(a5)
 8001606:	0ff77713          	zext.b	a4,a4
 800160a:	00876713          	ori	a4,a4,8
 800160e:	00e78023          	sb	a4,0(a5)
	
    /* Initialize exception default handlers */
    Exception_Init();
    /* ECLIC initialization, mainly MTH and NLBIT settings */
    ECLIC_Init();
}
 8001612:	40b2                	lw	ra,12(sp)
 8001614:	0141                	addi	sp,sp,16
 8001616:	8082                	ret

08001618 <_postmain_fini>:
 * to do initialization
 */
void _postmain_fini(int status)
{
    /* TODO: Add your own finishing code here, called after main */
}
 8001618:	8082                	ret

0800161a <_init>:
 * Please use \ref _premain_init function now
 */
void _init(void)
{
    /* Don't put any code here, please use _premain_init now */
}
 800161a:	8082                	ret

0800161c <_fini>:
 800161c:	8082                	ret

0800161e <LedInit>:
 * @brief Configures LED GPIO.
 * @param GPIOx x can be A to G to select the GPIO port.
 * @param Pin This parameter can be GPIO_PIN_0 ~ GPIO_PIN_15.
 */
void LedInit(GPIO_Module* GPIOx, uint16_t Pin)
{
 800161e:	1101                	addi	sp,sp,-32
    GPIO_InitType GPIO_InitStructure;

    /* Check the parameters */
    assert_param(IS_GPIO_ALL_PERIPH(GPIOx));
 8001620:	400117b7          	lui	a5,0x40011
{
 8001624:	cc22                	sw	s0,24(sp)
 8001626:	ca26                	sw	s1,20(sp)
 8001628:	ce06                	sw	ra,28(sp)
    assert_param(IS_GPIO_ALL_PERIPH(GPIOx));
 800162a:	80078713          	addi	a4,a5,-2048 # 40010800 <_sp+0x1fff0800>
{
 800162e:	842a                	mv	s0,a0
 8001630:	84ae                	mv	s1,a1
    assert_param(IS_GPIO_ALL_PERIPH(GPIOx));
 8001632:	06e50d63          	beq	a0,a4,80016ac <LedInit+0x8e>
 8001636:	c0078713          	addi	a4,a5,-1024
 800163a:	04e50063          	beq	a0,a4,800167a <LedInit+0x5c>
 800163e:	06f50c63          	beq	a0,a5,80016b6 <LedInit+0x98>
 8001642:	40078793          	addi	a5,a5,1024
 8001646:	06f50d63          	beq	a0,a5,80016c0 <LedInit+0xa2>
 800164a:	400127b7          	lui	a5,0x40012
 800164e:	80078713          	addi	a4,a5,-2048 # 40011800 <_sp+0x1fff1800>
 8001652:	04e50763          	beq	a0,a4,80016a0 <LedInit+0x82>
 8001656:	c0078713          	addi	a4,a5,-1024
 800165a:	06e50963          	beq	a0,a4,80016cc <LedInit+0xae>
 800165e:	06f50d63          	beq	a0,a5,80016d8 <LedInit+0xba>
 8001662:	03100613          	li	a2,49
 8001666:	00002597          	auipc	a1,0x2
 800166a:	c6e58593          	addi	a1,a1,-914 # 80032d4 <AHBPrescTable+0x10>
 800166e:	00001517          	auipc	a0,0x1
 8001672:	6b250513          	addi	a0,a0,1714 # 8002d20 <_write+0x62>
 8001676:	311d                	jal	800129c <assert_failed>
    {
        RCC_EnableAPB2PeriphClk(RCC_APB2_PERIPH_GPIOF, ENABLE);
    }
    else
    {
        if (GPIOx == GPIOG)
 8001678:	a029                	j	8001682 <LedInit+0x64>
        RCC_EnableAPB2PeriphClk(RCC_APB2_PERIPH_GPIOB, ENABLE);
 800167a:	4585                	li	a1,1
 800167c:	4521                	li	a0,8
 800167e:	e00ff0ef          	jal	ra,8000c7e <RCC_EnableAPB2PeriphClk>

    /* Configure the GPIO pin */
    if (Pin <= GPIO_PIN_ALL)
    {
        GPIO_InitStructure.Pin        = Pin;
        GPIO_InitStructure.GPIO_Mode  = GPIO_Mode_Out_PP;
 8001682:	47c1                	li	a5,16
 8001684:	c63e                	sw	a5,12(sp)
        GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
        GPIO_Init(GPIOx, &GPIO_InitStructure);
 8001686:	004c                	addi	a1,sp,4
 8001688:	8522                	mv	a0,s0
        GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
 800168a:	478d                	li	a5,3
        GPIO_InitStructure.Pin        = Pin;
 800168c:	00911223          	sh	s1,4(sp)
        GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
 8001690:	c43e                	sw	a5,8(sp)
        GPIO_Init(GPIOx, &GPIO_InitStructure);
 8001692:	f09fe0ef          	jal	ra,800059a <GPIO_Init>
    }
}
 8001696:	40f2                	lw	ra,28(sp)
 8001698:	4462                	lw	s0,24(sp)
 800169a:	44d2                	lw	s1,20(sp)
 800169c:	6105                	addi	sp,sp,32
 800169e:	8082                	ret
        RCC_EnableAPB2PeriphClk(RCC_APB2_PERIPH_GPIOE, ENABLE);
 80016a0:	4585                	li	a1,1
 80016a2:	04000513          	li	a0,64
 80016a6:	dd8ff0ef          	jal	ra,8000c7e <RCC_EnableAPB2PeriphClk>
 80016aa:	bfe1                	j	8001682 <LedInit+0x64>
        RCC_EnableAPB2PeriphClk(RCC_APB2_PERIPH_GPIOA, ENABLE);
 80016ac:	4585                	li	a1,1
 80016ae:	4511                	li	a0,4
 80016b0:	dceff0ef          	jal	ra,8000c7e <RCC_EnableAPB2PeriphClk>
 80016b4:	b7f9                	j	8001682 <LedInit+0x64>
        RCC_EnableAPB2PeriphClk(RCC_APB2_PERIPH_GPIOC, ENABLE);
 80016b6:	4585                	li	a1,1
 80016b8:	4541                	li	a0,16
 80016ba:	dc4ff0ef          	jal	ra,8000c7e <RCC_EnableAPB2PeriphClk>
 80016be:	b7d1                	j	8001682 <LedInit+0x64>
        RCC_EnableAPB2PeriphClk(RCC_APB2_PERIPH_GPIOD, ENABLE);
 80016c0:	4585                	li	a1,1
 80016c2:	02000513          	li	a0,32
 80016c6:	db8ff0ef          	jal	ra,8000c7e <RCC_EnableAPB2PeriphClk>
 80016ca:	bf65                	j	8001682 <LedInit+0x64>
        RCC_EnableAPB2PeriphClk(RCC_APB2_PERIPH_GPIOF, ENABLE);
 80016cc:	4585                	li	a1,1
 80016ce:	08000513          	li	a0,128
 80016d2:	dacff0ef          	jal	ra,8000c7e <RCC_EnableAPB2PeriphClk>
 80016d6:	b775                	j	8001682 <LedInit+0x64>
            RCC_EnableAPB2PeriphClk(RCC_APB2_PERIPH_GPIOG, ENABLE);
 80016d8:	4585                	li	a1,1
 80016da:	10000513          	li	a0,256
 80016de:	da0ff0ef          	jal	ra,8000c7e <RCC_EnableAPB2PeriphClk>
 80016e2:	b745                	j	8001682 <LedInit+0x64>

080016e4 <LedOn>:
 * @param GPIOx x can be A to G to select the GPIO port.
 * @param Pin This parameter can be GPIO_PIN_0 ~ GPIO_PIN_15.
 */
void LedOn(GPIO_Module* GPIOx, uint16_t Pin)
{
	GPIO_WriteBit(GPIOx, Pin, Bit_SET);
 80016e4:	4605                	li	a2,1
 80016e6:	8f0ff06f          	j	80007d6 <GPIO_WriteBit>

080016ea <LedOff>:
 * @param GPIOx x can be A to G to select the GPIO port.
 * @param Pin This parameter can be GPIO_PIN_0 ~ GPIO_PIN_15.
 */
void LedOff(GPIO_Module* GPIOx, uint16_t Pin)
{
	GPIO_WriteBit(GPIOx, Pin, Bit_RESET);
 80016ea:	4601                	li	a2,0
 80016ec:	8eaff06f          	j	80007d6 <GPIO_WriteBit>

080016f0 <LedBlink>:
 * @brief Toggles the selected Led.
 * @param GPIOx x can be A to G to select the GPIO port.
 * @param Pin This parameter can be GPIO_PIN_0 ~ GPIO_PIN_15.
 */
void LedBlink(GPIO_Module* GPIOx, uint16_t Pin)
{
 80016f0:	1141                	addi	sp,sp,-16
 80016f2:	c422                	sw	s0,8(sp)
 80016f4:	c226                	sw	s1,4(sp)
 80016f6:	c606                	sw	ra,12(sp)
 80016f8:	842a                	mv	s0,a0
 80016fa:	84ae                	mv	s1,a1
	GPIO_Write(GPIOx,GPIO_ReadOutputData(GPIOx)^Pin);
 80016fc:	874ff0ef          	jal	ra,8000770 <GPIO_ReadOutputData>
 8001700:	009545b3          	xor	a1,a0,s1
 8001704:	8522                	mv	a0,s0
}
 8001706:	4422                	lw	s0,8(sp)
 8001708:	40b2                	lw	ra,12(sp)
 800170a:	4492                	lw	s1,4(sp)
	GPIO_Write(GPIOx,GPIO_ReadOutputData(GPIOx)^Pin);
 800170c:	05c2                	slli	a1,a1,0x10
 800170e:	81c1                	srli	a1,a1,0x10
}
 8001710:	0141                	addi	sp,sp,16
	GPIO_Write(GPIOx,GPIO_ReadOutputData(GPIOx)^Pin);
 8001712:	9eaff06f          	j	80008fc <GPIO_Write>

08001716 <log_init>:

/**
 * @brief  Initialize the uart to output log information.
 */
void log_init(void)
{
 8001716:	7179                	addi	sp,sp,-48
    GPIO_InitType GPIO_InitStructure;
    USART_InitType USART_InitStructure;

    RCC_EnableAPB2PeriphClk(RCC_APB2_PERIPH_AFIO | LOG_PERIPH_GPIO, ENABLE);
 8001718:	4585                	li	a1,1
 800171a:	04100513          	li	a0,65
{
 800171e:	d606                	sw	ra,44(sp)
 8001720:	d422                	sw	s0,40(sp)
    RCC_EnableAPB2PeriphClk(RCC_APB2_PERIPH_AFIO | LOG_PERIPH_GPIO, ENABLE);
 8001722:	d5cff0ef          	jal	ra,8000c7e <RCC_EnableAPB2PeriphClk>
    LOG_CLK_FUNC(LOG_PERIPH, ENABLE);
 8001726:	4585                	li	a1,1
 8001728:	00100537          	lui	a0,0x100
 800172c:	dd2ff0ef          	jal	ra,8000cfe <RCC_EnableAPB1PeriphClk>

    GPIO_ConfigPinRemap(LOG_REMAP, ENABLE);
 8001730:	6505                	lui	a0,0x1
 8001732:	4585                	li	a1,1
 8001734:	ad250513          	addi	a0,a0,-1326 # ad2 <__STACK_SIZE-0x152e>
 8001738:	a2cff0ef          	jal	ra,8000964 <GPIO_ConfigPinRemap>

    GPIO_InitStructure.Pin        = LOG_TX_PIN;
 800173c:	10000793          	li	a5,256
    GPIO_InitStructure.GPIO_Mode  = GPIO_Mode_AF_PP;
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
    GPIO_Init(LOG_GPIO, &GPIO_InitStructure);
 8001740:	40012437          	lui	s0,0x40012
    GPIO_InitStructure.Pin        = LOG_TX_PIN;
 8001744:	00f11223          	sh	a5,4(sp)
    GPIO_InitStructure.GPIO_Mode  = GPIO_Mode_AF_PP;
 8001748:	47e1                	li	a5,24
    GPIO_Init(LOG_GPIO, &GPIO_InitStructure);
 800174a:	004c                	addi	a1,sp,4
 800174c:	80040513          	addi	a0,s0,-2048 # 40011800 <_sp+0x1fff1800>
    GPIO_InitStructure.GPIO_Mode  = GPIO_Mode_AF_PP;
 8001750:	c63e                	sw	a5,12(sp)
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
 8001752:	478d                	li	a5,3
 8001754:	c43e                	sw	a5,8(sp)
    GPIO_Init(LOG_GPIO, &GPIO_InitStructure);
 8001756:	e45fe0ef          	jal	ra,800059a <GPIO_Init>

    GPIO_InitStructure.Pin       = LOG_RX_PIN;
 800175a:	20000793          	li	a5,512
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN_FLOATING;
    GPIO_Init(LOG_GPIO, &GPIO_InitStructure);
 800175e:	004c                	addi	a1,sp,4
 8001760:	80040513          	addi	a0,s0,-2048
    GPIO_InitStructure.Pin       = LOG_RX_PIN;
 8001764:	00f11223          	sh	a5,4(sp)
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN_FLOATING;
 8001768:	4791                	li	a5,4
 800176a:	c63e                	sw	a5,12(sp)
    GPIO_Init(LOG_GPIO, &GPIO_InitStructure);
 800176c:	e2ffe0ef          	jal	ra,800059a <GPIO_Init>

    USART_InitStructure.BaudRate            = 115200;
 8001770:	67f1                	lui	a5,0x1c
 8001772:	20078793          	addi	a5,a5,512 # 1c200 <__STACK_SIZE+0x1a200>
    USART_InitStructure.Parity              = USART_PE_NO;
    USART_InitStructure.HardwareFlowControl = USART_HFCTRL_NONE;
    USART_InitStructure.Mode                = USART_MODE_TX | USART_MODE_RX;

    /* Init uart */
    USART_Init(LOG_USARTx, &USART_InitStructure);
 8001776:	080c                	addi	a1,sp,16
    USART_InitStructure.BaudRate            = 115200;
 8001778:	c83e                	sw	a5,16(sp)
    USART_Init(LOG_USARTx, &USART_InitStructure);
 800177a:	40005537          	lui	a0,0x40005
    USART_InitStructure.Parity              = USART_PE_NO;
 800177e:	000c07b7          	lui	a5,0xc0
 8001782:	cc3e                	sw	a5,24(sp)
    USART_InitStructure.WordLength          = USART_WL_8B;
 8001784:	ca02                	sw	zero,20(sp)
    USART_InitStructure.HardwareFlowControl = USART_HFCTRL_NONE;
 8001786:	00011e23          	sh	zero,28(sp)
    USART_Init(LOG_USARTx, &USART_InitStructure);
 800178a:	ecaff0ef          	jal	ra,8000e54 <USART_Init>

    /* Enable uart */
    USART_Enable(LOG_USARTx, ENABLE);
 800178e:	4585                	li	a1,1
 8001790:	40005537          	lui	a0,0x40005
 8001794:	92dff0ef          	jal	ra,80010c0 <USART_Enable>
}
 8001798:	50b2                	lw	ra,44(sp)
 800179a:	5422                	lw	s0,40(sp)
 800179c:	6145                	addi	sp,sp,48
 800179e:	8082                	ret
	...

080017c0 <exc_entry>:
.align 6
.global exc_entry
.weak exc_entry
exc_entry:
    /* Save the caller saving registers (context) */
    SAVE_CONTEXT
 80017c0:	715d                	addi	sp,sp,-80
 80017c2:	c006                	sw	ra,0(sp)
 80017c4:	c212                	sw	tp,4(sp)
 80017c6:	c416                	sw	t0,8(sp)
 80017c8:	c61a                	sw	t1,12(sp)
 80017ca:	c81e                	sw	t2,16(sp)
 80017cc:	ca2a                	sw	a0,20(sp)
 80017ce:	cc2e                	sw	a1,24(sp)
 80017d0:	ce32                	sw	a2,28(sp)
 80017d2:	d036                	sw	a3,32(sp)
 80017d4:	d23a                	sw	a4,36(sp)
 80017d6:	d43e                	sw	a5,40(sp)
 80017d8:	dc42                	sw	a6,56(sp)
 80017da:	de46                	sw	a7,60(sp)
 80017dc:	c0f2                	sw	t3,64(sp)
 80017de:	c2f6                	sw	t4,68(sp)
 80017e0:	c4fa                	sw	t5,72(sp)
 80017e2:	c6fe                	sw	t6,76(sp)
    /* Save the necessary CSR registers */
    SAVE_CSR_CONTEXT
 80017e4:	7ee5d073          	csrwi	pushmcause,11
 80017e8:	7ef65073          	csrwi	pushmepc,12
 80017ec:	7eb6d073          	csrwi	pushmsubm,13
    /*
     * Set the exception handler function arguments
     * argument 1: mcause value
     * argument 2: current stack point(SP) value
     */
    csrr a0, mcause
 80017f0:	34202573          	csrr	a0,mcause
    mv a1, sp
 80017f4:	858a                	mv	a1,sp
    /*
     * Call the exception handler function
     * By default, the function template is provided in
     * system_Device.c, you can adjust it as you want
     */
    call core_exception_handler
 80017f6:	3b71                	jal	8001592 <core_exception_handler>

    /* Restore the necessary CSR registers */
    RESTORE_CSR_CONTEXT
 80017f8:	52d2                	lw	t0,52(sp)
 80017fa:	7c429073          	csrw	msubm,t0
 80017fe:	52c2                	lw	t0,48(sp)
 8001800:	34129073          	csrw	mepc,t0
 8001804:	52b2                	lw	t0,44(sp)
 8001806:	34229073          	csrw	mcause,t0
    /* Restore the caller saving registers (context) */
    RESTORE_CONTEXT
 800180a:	4082                	lw	ra,0(sp)
 800180c:	4212                	lw	tp,4(sp)
 800180e:	42a2                	lw	t0,8(sp)
 8001810:	4332                	lw	t1,12(sp)
 8001812:	43c2                	lw	t2,16(sp)
 8001814:	4552                	lw	a0,20(sp)
 8001816:	45e2                	lw	a1,24(sp)
 8001818:	4672                	lw	a2,28(sp)
 800181a:	5682                	lw	a3,32(sp)
 800181c:	5712                	lw	a4,36(sp)
 800181e:	57a2                	lw	a5,40(sp)
 8001820:	5862                	lw	a6,56(sp)
 8001822:	58f2                	lw	a7,60(sp)
 8001824:	4e06                	lw	t3,64(sp)
 8001826:	4e96                	lw	t4,68(sp)
 8001828:	4f26                	lw	t5,72(sp)
 800182a:	4fb6                	lw	t6,76(sp)
 800182c:	6161                	addi	sp,sp,80

    /* Return to regular code */
    mret
 800182e:	30200073          	mret
	...

0800183c <irq_entry>:
.global irq_entry
.weak irq_entry
/* This label will be set to MTVT2 register */
irq_entry:
    /* Save the caller saving registers (context) */
    SAVE_CONTEXT
 800183c:	715d                	addi	sp,sp,-80
 800183e:	c006                	sw	ra,0(sp)
 8001840:	c212                	sw	tp,4(sp)
 8001842:	c416                	sw	t0,8(sp)
 8001844:	c61a                	sw	t1,12(sp)
 8001846:	c81e                	sw	t2,16(sp)
 8001848:	ca2a                	sw	a0,20(sp)
 800184a:	cc2e                	sw	a1,24(sp)
 800184c:	ce32                	sw	a2,28(sp)
 800184e:	d036                	sw	a3,32(sp)
 8001850:	d23a                	sw	a4,36(sp)
 8001852:	d43e                	sw	a5,40(sp)
 8001854:	dc42                	sw	a6,56(sp)
 8001856:	de46                	sw	a7,60(sp)
 8001858:	c0f2                	sw	t3,64(sp)
 800185a:	c2f6                	sw	t4,68(sp)
 800185c:	c4fa                	sw	t5,72(sp)
 800185e:	c6fe                	sw	t6,76(sp)
    /* Save the necessary CSR registers */
    SAVE_CSR_CONTEXT
 8001860:	7ee5d073          	csrwi	pushmcause,11
 8001864:	7ef65073          	csrwi	pushmepc,12
 8001868:	7eb6d073          	csrwi	pushmsubm,13
    /* This special CSR read/write operation, which is actually
     * claim the CLIC to find its pending highest ID, if the ID
     * is not 0, then automatically enable the mstatus.MIE, and
     * jump to its vector-entry-label, and update the link register
     */
    csrrw ra, CSR_JALMNXTI, ra
 800186c:	7ed090f3          	csrrw	ra,jalmnxti,ra

    /* Critical section with interrupts disabled */
    DISABLE_MIE
 8001870:	30047073          	csrci	mstatus,8

    /* Restore the necessary CSR registers */
    RESTORE_CSR_CONTEXT
 8001874:	52d2                	lw	t0,52(sp)
 8001876:	7c429073          	csrw	msubm,t0
 800187a:	52c2                	lw	t0,48(sp)
 800187c:	34129073          	csrw	mepc,t0
 8001880:	52b2                	lw	t0,44(sp)
 8001882:	34229073          	csrw	mcause,t0
    /* Restore the caller saving registers (context) */
    RESTORE_CONTEXT
 8001886:	4082                	lw	ra,0(sp)
 8001888:	4212                	lw	tp,4(sp)
 800188a:	42a2                	lw	t0,8(sp)
 800188c:	4332                	lw	t1,12(sp)
 800188e:	43c2                	lw	t2,16(sp)
 8001890:	4552                	lw	a0,20(sp)
 8001892:	45e2                	lw	a1,24(sp)
 8001894:	4672                	lw	a2,28(sp)
 8001896:	5682                	lw	a3,32(sp)
 8001898:	5712                	lw	a4,36(sp)
 800189a:	57a2                	lw	a5,40(sp)
 800189c:	5862                	lw	a6,56(sp)
 800189e:	58f2                	lw	a7,60(sp)
 80018a0:	4e06                	lw	t3,64(sp)
 80018a2:	4e96                	lw	t4,68(sp)
 80018a4:	4f26                	lw	t5,72(sp)
 80018a6:	4fb6                	lw	t6,76(sp)
 80018a8:	6161                	addi	sp,sp,80

    /* Return to regular code */
    mret
 80018aa:	30200073          	mret

080018ae <default_intexc_handler>:
.global default_intexc_handler
.weak default_intexc_handler
Undef_Handler:
default_intexc_handler:
1:
	j 1b
 80018ae:	a001                	j	80018ae <default_intexc_handler>
	...

080018b2 <atexit>:
 80018b2:	85aa                	mv	a1,a0
 80018b4:	4681                	li	a3,0
 80018b6:	4601                	li	a2,0
 80018b8:	4501                	li	a0,0
 80018ba:	a135                	j	8001ce6 <__register_exitproc>

080018bc <__libc_fini_array>:
 80018bc:	1141                	addi	sp,sp,-16
 80018be:	c422                	sw	s0,8(sp)
 80018c0:	c226                	sw	s1,4(sp)
 80018c2:	00002417          	auipc	s0,0x2
 80018c6:	b2e40413          	addi	s0,s0,-1234 # 80033f0 <_data_lma>
 80018ca:	00002497          	auipc	s1,0x2
 80018ce:	b2248493          	addi	s1,s1,-1246 # 80033ec <__do_global_dtors_aux_fini_array_entry>
 80018d2:	8c05                	sub	s0,s0,s1
 80018d4:	c606                	sw	ra,12(sp)
 80018d6:	8409                	srai	s0,s0,0x2
 80018d8:	e411                	bnez	s0,80018e4 <__libc_fini_array+0x28>
 80018da:	40b2                	lw	ra,12(sp)
 80018dc:	4422                	lw	s0,8(sp)
 80018de:	4492                	lw	s1,4(sp)
 80018e0:	0141                	addi	sp,sp,16
 80018e2:	8082                	ret
 80018e4:	147d                	addi	s0,s0,-1
 80018e6:	00241793          	slli	a5,s0,0x2
 80018ea:	97a6                	add	a5,a5,s1
 80018ec:	439c                	lw	a5,0(a5)
 80018ee:	9782                	jalr	a5
 80018f0:	b7e5                	j	80018d8 <__libc_fini_array+0x1c>

080018f2 <__libc_init_array>:
 80018f2:	1141                	addi	sp,sp,-16
 80018f4:	c422                	sw	s0,8(sp)
 80018f6:	c226                	sw	s1,4(sp)
 80018f8:	00002417          	auipc	s0,0x2
 80018fc:	af040413          	addi	s0,s0,-1296 # 80033e8 <__frame_dummy_init_array_entry>
 8001900:	00002497          	auipc	s1,0x2
 8001904:	ae848493          	addi	s1,s1,-1304 # 80033e8 <__frame_dummy_init_array_entry>
 8001908:	8c81                	sub	s1,s1,s0
 800190a:	c04a                	sw	s2,0(sp)
 800190c:	c606                	sw	ra,12(sp)
 800190e:	8489                	srai	s1,s1,0x2
 8001910:	4901                	li	s2,0
 8001912:	02991563          	bne	s2,s1,800193c <__libc_init_array+0x4a>
 8001916:	00002417          	auipc	s0,0x2
 800191a:	ad240413          	addi	s0,s0,-1326 # 80033e8 <__frame_dummy_init_array_entry>
 800191e:	00002497          	auipc	s1,0x2
 8001922:	ace48493          	addi	s1,s1,-1330 # 80033ec <__do_global_dtors_aux_fini_array_entry>
 8001926:	8c81                	sub	s1,s1,s0
 8001928:	8489                	srai	s1,s1,0x2
 800192a:	4901                	li	s2,0
 800192c:	00991d63          	bne	s2,s1,8001946 <__libc_init_array+0x54>
 8001930:	40b2                	lw	ra,12(sp)
 8001932:	4422                	lw	s0,8(sp)
 8001934:	4492                	lw	s1,4(sp)
 8001936:	4902                	lw	s2,0(sp)
 8001938:	0141                	addi	sp,sp,16
 800193a:	8082                	ret
 800193c:	401c                	lw	a5,0(s0)
 800193e:	0905                	addi	s2,s2,1
 8001940:	0411                	addi	s0,s0,4
 8001942:	9782                	jalr	a5
 8001944:	b7f9                	j	8001912 <__libc_init_array+0x20>
 8001946:	401c                	lw	a5,0(s0)
 8001948:	0905                	addi	s2,s2,1
 800194a:	0411                	addi	s0,s0,4
 800194c:	9782                	jalr	a5
 800194e:	bff9                	j	800192c <__libc_init_array+0x3a>

08001950 <memset>:
 8001950:	433d                	li	t1,15
 8001952:	872a                	mv	a4,a0
 8001954:	02c37363          	bgeu	t1,a2,800197a <memset+0x2a>
 8001958:	00f77793          	andi	a5,a4,15
 800195c:	efbd                	bnez	a5,80019da <memset+0x8a>
 800195e:	e5ad                	bnez	a1,80019c8 <memset+0x78>
 8001960:	ff067693          	andi	a3,a2,-16
 8001964:	8a3d                	andi	a2,a2,15
 8001966:	96ba                	add	a3,a3,a4
 8001968:	c30c                	sw	a1,0(a4)
 800196a:	c34c                	sw	a1,4(a4)
 800196c:	c70c                	sw	a1,8(a4)
 800196e:	c74c                	sw	a1,12(a4)
 8001970:	0741                	addi	a4,a4,16
 8001972:	fed76be3          	bltu	a4,a3,8001968 <memset+0x18>
 8001976:	e211                	bnez	a2,800197a <memset+0x2a>
 8001978:	8082                	ret
 800197a:	40c306b3          	sub	a3,t1,a2
 800197e:	068a                	slli	a3,a3,0x2
 8001980:	00000297          	auipc	t0,0x0
 8001984:	9696                	add	a3,a3,t0
 8001986:	00a68067          	jr	10(a3)
 800198a:	00b70723          	sb	a1,14(a4)
 800198e:	00b706a3          	sb	a1,13(a4)
 8001992:	00b70623          	sb	a1,12(a4)
 8001996:	00b705a3          	sb	a1,11(a4)
 800199a:	00b70523          	sb	a1,10(a4)
 800199e:	00b704a3          	sb	a1,9(a4)
 80019a2:	00b70423          	sb	a1,8(a4)
 80019a6:	00b703a3          	sb	a1,7(a4)
 80019aa:	00b70323          	sb	a1,6(a4)
 80019ae:	00b702a3          	sb	a1,5(a4)
 80019b2:	00b70223          	sb	a1,4(a4)
 80019b6:	00b701a3          	sb	a1,3(a4)
 80019ba:	00b70123          	sb	a1,2(a4)
 80019be:	00b700a3          	sb	a1,1(a4)
 80019c2:	00b70023          	sb	a1,0(a4)
 80019c6:	8082                	ret
 80019c8:	0ff5f593          	zext.b	a1,a1
 80019cc:	00859693          	slli	a3,a1,0x8
 80019d0:	8dd5                	or	a1,a1,a3
 80019d2:	01059693          	slli	a3,a1,0x10
 80019d6:	8dd5                	or	a1,a1,a3
 80019d8:	b761                	j	8001960 <memset+0x10>
 80019da:	00279693          	slli	a3,a5,0x2
 80019de:	00000297          	auipc	t0,0x0
 80019e2:	9696                	add	a3,a3,t0
 80019e4:	8286                	mv	t0,ra
 80019e6:	fa8680e7          	jalr	-88(a3)
 80019ea:	8096                	mv	ra,t0
 80019ec:	17c1                	addi	a5,a5,-16
 80019ee:	8f1d                	sub	a4,a4,a5
 80019f0:	963e                	add	a2,a2,a5
 80019f2:	f8c374e3          	bgeu	t1,a2,800197a <memset+0x2a>
 80019f6:	b7a5                	j	800195e <memset+0xe>

080019f8 <iprintf>:
 80019f8:	715d                	addi	sp,sp,-80
 80019fa:	d422                	sw	s0,40(sp)
 80019fc:	d606                	sw	ra,44(sp)
 80019fe:	842a                	mv	s0,a0
 8001a00:	da2e                	sw	a1,52(sp)
 8001a02:	dc32                	sw	a2,56(sp)
 8001a04:	de36                	sw	a3,60(sp)
 8001a06:	c0ba                	sw	a4,64(sp)
 8001a08:	c2be                	sw	a5,68(sp)
 8001a0a:	c4c2                	sw	a6,72(sp)
 8001a0c:	c6c6                	sw	a7,76(sp)
 8001a0e:	17ffe517          	auipc	a0,0x17ffe
 8001a12:	65652503          	lw	a0,1622(a0) # 20000064 <_impure_ptr>
 8001a16:	c511                	beqz	a0,8001a22 <iprintf+0x2a>
 8001a18:	4d1c                	lw	a5,24(a0)
 8001a1a:	e781                	bnez	a5,8001a22 <iprintf+0x2a>
 8001a1c:	c62a                	sw	a0,12(sp)
 8001a1e:	2355                	jal	8001fc2 <__sinit>
 8001a20:	4532                	lw	a0,12(sp)
 8001a22:	450c                	lw	a1,8(a0)
 8001a24:	1854                	addi	a3,sp,52
 8001a26:	8622                	mv	a2,s0
 8001a28:	ce36                	sw	a3,28(sp)
 8001a2a:	1ed000ef          	jal	ra,8002416 <_vfiprintf_r>
 8001a2e:	50b2                	lw	ra,44(sp)
 8001a30:	5422                	lw	s0,40(sp)
 8001a32:	6161                	addi	sp,sp,80
 8001a34:	8082                	ret

08001a36 <_puts_r>:
 8001a36:	1101                	addi	sp,sp,-32
 8001a38:	ca26                	sw	s1,20(sp)
 8001a3a:	c84a                	sw	s2,16(sp)
 8001a3c:	ce06                	sw	ra,28(sp)
 8001a3e:	cc22                	sw	s0,24(sp)
 8001a40:	c64e                	sw	s3,12(sp)
 8001a42:	c452                	sw	s4,8(sp)
 8001a44:	84aa                	mv	s1,a0
 8001a46:	892e                	mv	s2,a1
 8001a48:	c501                	beqz	a0,8001a50 <_puts_r+0x1a>
 8001a4a:	4d1c                	lw	a5,24(a0)
 8001a4c:	e391                	bnez	a5,8001a50 <_puts_r+0x1a>
 8001a4e:	2b95                	jal	8001fc2 <__sinit>
 8001a50:	4c9c                	lw	a5,24(s1)
 8001a52:	4480                	lw	s0,8(s1)
 8001a54:	e399                	bnez	a5,8001a5a <_puts_r+0x24>
 8001a56:	8526                	mv	a0,s1
 8001a58:	23ad                	jal	8001fc2 <__sinit>
 8001a5a:	00002797          	auipc	a5,0x2
 8001a5e:	8ba78793          	addi	a5,a5,-1862 # 8003314 <__sf_fake_stdin>
 8001a62:	02f41c63          	bne	s0,a5,8001a9a <_puts_r+0x64>
 8001a66:	40c0                	lw	s0,4(s1)
 8001a68:	00c45783          	lhu	a5,12(s0)
 8001a6c:	8ba1                	andi	a5,a5,8
 8001a6e:	c7b1                	beqz	a5,8001aba <_puts_r+0x84>
 8001a70:	481c                	lw	a5,16(s0)
 8001a72:	c7a1                	beqz	a5,8001aba <_puts_r+0x84>
 8001a74:	59fd                	li	s3,-1
 8001a76:	4a29                	li	s4,10
 8001a78:	441c                	lw	a5,8(s0)
 8001a7a:	00094583          	lbu	a1,0(s2)
 8001a7e:	17fd                	addi	a5,a5,-1
 8001a80:	e9b1                	bnez	a1,8001ad4 <_puts_r+0x9e>
 8001a82:	c41c                	sw	a5,8(s0)
 8001a84:	0607de63          	bgez	a5,8001b00 <_puts_r+0xca>
 8001a88:	8622                	mv	a2,s0
 8001a8a:	45a9                	li	a1,10
 8001a8c:	8526                	mv	a0,s1
 8001a8e:	2079                	jal	8001b1c <__swbuf_r>
 8001a90:	57fd                	li	a5,-1
 8001a92:	02f50863          	beq	a0,a5,8001ac2 <_puts_r+0x8c>
 8001a96:	4529                	li	a0,10
 8001a98:	a035                	j	8001ac4 <_puts_r+0x8e>
 8001a9a:	00002797          	auipc	a5,0x2
 8001a9e:	89a78793          	addi	a5,a5,-1894 # 8003334 <__sf_fake_stdout>
 8001aa2:	00f41463          	bne	s0,a5,8001aaa <_puts_r+0x74>
 8001aa6:	4480                	lw	s0,8(s1)
 8001aa8:	b7c1                	j	8001a68 <_puts_r+0x32>
 8001aaa:	00002797          	auipc	a5,0x2
 8001aae:	84a78793          	addi	a5,a5,-1974 # 80032f4 <__sf_fake_stderr>
 8001ab2:	faf41be3          	bne	s0,a5,8001a68 <_puts_r+0x32>
 8001ab6:	44c0                	lw	s0,12(s1)
 8001ab8:	bf45                	j	8001a68 <_puts_r+0x32>
 8001aba:	85a2                	mv	a1,s0
 8001abc:	8526                	mv	a0,s1
 8001abe:	2a39                	jal	8001bdc <__swsetup_r>
 8001ac0:	d955                	beqz	a0,8001a74 <_puts_r+0x3e>
 8001ac2:	557d                	li	a0,-1
 8001ac4:	40f2                	lw	ra,28(sp)
 8001ac6:	4462                	lw	s0,24(sp)
 8001ac8:	44d2                	lw	s1,20(sp)
 8001aca:	4942                	lw	s2,16(sp)
 8001acc:	49b2                	lw	s3,12(sp)
 8001ace:	4a22                	lw	s4,8(sp)
 8001ad0:	6105                	addi	sp,sp,32
 8001ad2:	8082                	ret
 8001ad4:	c41c                	sw	a5,8(s0)
 8001ad6:	0905                	addi	s2,s2,1
 8001ad8:	0007d763          	bgez	a5,8001ae6 <_puts_r+0xb0>
 8001adc:	4c18                	lw	a4,24(s0)
 8001ade:	00e7cb63          	blt	a5,a4,8001af4 <_puts_r+0xbe>
 8001ae2:	01458963          	beq	a1,s4,8001af4 <_puts_r+0xbe>
 8001ae6:	401c                	lw	a5,0(s0)
 8001ae8:	00178713          	addi	a4,a5,1
 8001aec:	c018                	sw	a4,0(s0)
 8001aee:	00b78023          	sb	a1,0(a5)
 8001af2:	b759                	j	8001a78 <_puts_r+0x42>
 8001af4:	8622                	mv	a2,s0
 8001af6:	8526                	mv	a0,s1
 8001af8:	2015                	jal	8001b1c <__swbuf_r>
 8001afa:	f7351fe3          	bne	a0,s3,8001a78 <_puts_r+0x42>
 8001afe:	b7d1                	j	8001ac2 <_puts_r+0x8c>
 8001b00:	401c                	lw	a5,0(s0)
 8001b02:	00178713          	addi	a4,a5,1
 8001b06:	c018                	sw	a4,0(s0)
 8001b08:	4729                	li	a4,10
 8001b0a:	00e78023          	sb	a4,0(a5)
 8001b0e:	b761                	j	8001a96 <_puts_r+0x60>

08001b10 <puts>:
 8001b10:	85aa                	mv	a1,a0
 8001b12:	17ffe517          	auipc	a0,0x17ffe
 8001b16:	55252503          	lw	a0,1362(a0) # 20000064 <_impure_ptr>
 8001b1a:	bf31                	j	8001a36 <_puts_r>

08001b1c <__swbuf_r>:
 8001b1c:	1101                	addi	sp,sp,-32
 8001b1e:	cc22                	sw	s0,24(sp)
 8001b20:	ca26                	sw	s1,20(sp)
 8001b22:	c84a                	sw	s2,16(sp)
 8001b24:	ce06                	sw	ra,28(sp)
 8001b26:	c64e                	sw	s3,12(sp)
 8001b28:	84aa                	mv	s1,a0
 8001b2a:	892e                	mv	s2,a1
 8001b2c:	8432                	mv	s0,a2
 8001b2e:	c501                	beqz	a0,8001b36 <__swbuf_r+0x1a>
 8001b30:	4d1c                	lw	a5,24(a0)
 8001b32:	e391                	bnez	a5,8001b36 <__swbuf_r+0x1a>
 8001b34:	2179                	jal	8001fc2 <__sinit>
 8001b36:	00001797          	auipc	a5,0x1
 8001b3a:	7de78793          	addi	a5,a5,2014 # 8003314 <__sf_fake_stdin>
 8001b3e:	06f41963          	bne	s0,a5,8001bb0 <__swbuf_r+0x94>
 8001b42:	40c0                	lw	s0,4(s1)
 8001b44:	4c1c                	lw	a5,24(s0)
 8001b46:	c41c                	sw	a5,8(s0)
 8001b48:	00c45783          	lhu	a5,12(s0)
 8001b4c:	8ba1                	andi	a5,a5,8
 8001b4e:	c3c9                	beqz	a5,8001bd0 <__swbuf_r+0xb4>
 8001b50:	481c                	lw	a5,16(s0)
 8001b52:	cfbd                	beqz	a5,8001bd0 <__swbuf_r+0xb4>
 8001b54:	481c                	lw	a5,16(s0)
 8001b56:	4008                	lw	a0,0(s0)
 8001b58:	0ff97993          	zext.b	s3,s2
 8001b5c:	0ff97913          	zext.b	s2,s2
 8001b60:	8d1d                	sub	a0,a0,a5
 8001b62:	485c                	lw	a5,20(s0)
 8001b64:	00f54663          	blt	a0,a5,8001b70 <__swbuf_r+0x54>
 8001b68:	85a2                	mv	a1,s0
 8001b6a:	8526                	mv	a0,s1
 8001b6c:	2e25                	jal	8001ea4 <_fflush_r>
 8001b6e:	e52d                	bnez	a0,8001bd8 <__swbuf_r+0xbc>
 8001b70:	441c                	lw	a5,8(s0)
 8001b72:	0505                	addi	a0,a0,1
 8001b74:	17fd                	addi	a5,a5,-1
 8001b76:	c41c                	sw	a5,8(s0)
 8001b78:	401c                	lw	a5,0(s0)
 8001b7a:	00178713          	addi	a4,a5,1
 8001b7e:	c018                	sw	a4,0(s0)
 8001b80:	01378023          	sb	s3,0(a5)
 8001b84:	485c                	lw	a5,20(s0)
 8001b86:	00a78963          	beq	a5,a0,8001b98 <__swbuf_r+0x7c>
 8001b8a:	00c45783          	lhu	a5,12(s0)
 8001b8e:	8b85                	andi	a5,a5,1
 8001b90:	cb81                	beqz	a5,8001ba0 <__swbuf_r+0x84>
 8001b92:	47a9                	li	a5,10
 8001b94:	00f91663          	bne	s2,a5,8001ba0 <__swbuf_r+0x84>
 8001b98:	85a2                	mv	a1,s0
 8001b9a:	8526                	mv	a0,s1
 8001b9c:	2621                	jal	8001ea4 <_fflush_r>
 8001b9e:	ed0d                	bnez	a0,8001bd8 <__swbuf_r+0xbc>
 8001ba0:	40f2                	lw	ra,28(sp)
 8001ba2:	4462                	lw	s0,24(sp)
 8001ba4:	44d2                	lw	s1,20(sp)
 8001ba6:	49b2                	lw	s3,12(sp)
 8001ba8:	854a                	mv	a0,s2
 8001baa:	4942                	lw	s2,16(sp)
 8001bac:	6105                	addi	sp,sp,32
 8001bae:	8082                	ret
 8001bb0:	00001797          	auipc	a5,0x1
 8001bb4:	78478793          	addi	a5,a5,1924 # 8003334 <__sf_fake_stdout>
 8001bb8:	00f41463          	bne	s0,a5,8001bc0 <__swbuf_r+0xa4>
 8001bbc:	4480                	lw	s0,8(s1)
 8001bbe:	b759                	j	8001b44 <__swbuf_r+0x28>
 8001bc0:	00001797          	auipc	a5,0x1
 8001bc4:	73478793          	addi	a5,a5,1844 # 80032f4 <__sf_fake_stderr>
 8001bc8:	f6f41ee3          	bne	s0,a5,8001b44 <__swbuf_r+0x28>
 8001bcc:	44c0                	lw	s0,12(s1)
 8001bce:	bf9d                	j	8001b44 <__swbuf_r+0x28>
 8001bd0:	85a2                	mv	a1,s0
 8001bd2:	8526                	mv	a0,s1
 8001bd4:	2021                	jal	8001bdc <__swsetup_r>
 8001bd6:	dd3d                	beqz	a0,8001b54 <__swbuf_r+0x38>
 8001bd8:	597d                	li	s2,-1
 8001bda:	b7d9                	j	8001ba0 <__swbuf_r+0x84>

08001bdc <__swsetup_r>:
 8001bdc:	1141                	addi	sp,sp,-16
 8001bde:	c422                	sw	s0,8(sp)
 8001be0:	c226                	sw	s1,4(sp)
 8001be2:	c04a                	sw	s2,0(sp)
 8001be4:	c606                	sw	ra,12(sp)
 8001be6:	17ffe497          	auipc	s1,0x17ffe
 8001bea:	47e4a483          	lw	s1,1150(s1) # 20000064 <_impure_ptr>
 8001bee:	892a                	mv	s2,a0
 8001bf0:	842e                	mv	s0,a1
 8001bf2:	c489                	beqz	s1,8001bfc <__swsetup_r+0x20>
 8001bf4:	4c9c                	lw	a5,24(s1)
 8001bf6:	e399                	bnez	a5,8001bfc <__swsetup_r+0x20>
 8001bf8:	8526                	mv	a0,s1
 8001bfa:	26e1                	jal	8001fc2 <__sinit>
 8001bfc:	00001797          	auipc	a5,0x1
 8001c00:	71878793          	addi	a5,a5,1816 # 8003314 <__sf_fake_stdin>
 8001c04:	02f41763          	bne	s0,a5,8001c32 <__swsetup_r+0x56>
 8001c08:	40c0                	lw	s0,4(s1)
 8001c0a:	00c41783          	lh	a5,12(s0)
 8001c0e:	01079713          	slli	a4,a5,0x10
 8001c12:	0087f693          	andi	a3,a5,8
 8001c16:	8341                	srli	a4,a4,0x10
 8001c18:	eaad                	bnez	a3,8001c8a <__swsetup_r+0xae>
 8001c1a:	01077693          	andi	a3,a4,16
 8001c1e:	ea95                	bnez	a3,8001c52 <__swsetup_r+0x76>
 8001c20:	4725                	li	a4,9
 8001c22:	00e92023          	sw	a4,0(s2)
 8001c26:	0407e793          	ori	a5,a5,64
 8001c2a:	00f41623          	sh	a5,12(s0)
 8001c2e:	557d                	li	a0,-1
 8001c30:	a871                	j	8001ccc <__swsetup_r+0xf0>
 8001c32:	00001797          	auipc	a5,0x1
 8001c36:	70278793          	addi	a5,a5,1794 # 8003334 <__sf_fake_stdout>
 8001c3a:	00f41463          	bne	s0,a5,8001c42 <__swsetup_r+0x66>
 8001c3e:	4480                	lw	s0,8(s1)
 8001c40:	b7e9                	j	8001c0a <__swsetup_r+0x2e>
 8001c42:	00001797          	auipc	a5,0x1
 8001c46:	6b278793          	addi	a5,a5,1714 # 80032f4 <__sf_fake_stderr>
 8001c4a:	fcf410e3          	bne	s0,a5,8001c0a <__swsetup_r+0x2e>
 8001c4e:	44c0                	lw	s0,12(s1)
 8001c50:	bf6d                	j	8001c0a <__swsetup_r+0x2e>
 8001c52:	8b11                	andi	a4,a4,4
 8001c54:	c70d                	beqz	a4,8001c7e <__swsetup_r+0xa2>
 8001c56:	584c                	lw	a1,52(s0)
 8001c58:	c989                	beqz	a1,8001c6a <__swsetup_r+0x8e>
 8001c5a:	04440793          	addi	a5,s0,68
 8001c5e:	00f58463          	beq	a1,a5,8001c66 <__swsetup_r+0x8a>
 8001c62:	854a                	mv	a0,s2
 8001c64:	23c9                	jal	8002226 <_free_r>
 8001c66:	02042a23          	sw	zero,52(s0)
 8001c6a:	00c45783          	lhu	a5,12(s0)
 8001c6e:	00042223          	sw	zero,4(s0)
 8001c72:	fdb7f793          	andi	a5,a5,-37
 8001c76:	00f41623          	sh	a5,12(s0)
 8001c7a:	481c                	lw	a5,16(s0)
 8001c7c:	c01c                	sw	a5,0(s0)
 8001c7e:	00c45783          	lhu	a5,12(s0)
 8001c82:	0087e793          	ori	a5,a5,8
 8001c86:	00f41623          	sh	a5,12(s0)
 8001c8a:	481c                	lw	a5,16(s0)
 8001c8c:	ef81                	bnez	a5,8001ca4 <__swsetup_r+0xc8>
 8001c8e:	00c45783          	lhu	a5,12(s0)
 8001c92:	20000713          	li	a4,512
 8001c96:	2807f793          	andi	a5,a5,640
 8001c9a:	00e78563          	beq	a5,a4,8001ca4 <__swsetup_r+0xc8>
 8001c9e:	85a2                	mv	a1,s0
 8001ca0:	854a                	mv	a0,s2
 8001ca2:	21dd                	jal	8002188 <__smakebuf_r>
 8001ca4:	00c41783          	lh	a5,12(s0)
 8001ca8:	01079713          	slli	a4,a5,0x10
 8001cac:	0017f693          	andi	a3,a5,1
 8001cb0:	8341                	srli	a4,a4,0x10
 8001cb2:	c29d                	beqz	a3,8001cd8 <__swsetup_r+0xfc>
 8001cb4:	4854                	lw	a3,20(s0)
 8001cb6:	00042423          	sw	zero,8(s0)
 8001cba:	40d006b3          	neg	a3,a3
 8001cbe:	cc14                	sw	a3,24(s0)
 8001cc0:	4814                	lw	a3,16(s0)
 8001cc2:	4501                	li	a0,0
 8001cc4:	e681                	bnez	a3,8001ccc <__swsetup_r+0xf0>
 8001cc6:	08077713          	andi	a4,a4,128
 8001cca:	ff31                	bnez	a4,8001c26 <__swsetup_r+0x4a>
 8001ccc:	40b2                	lw	ra,12(sp)
 8001cce:	4422                	lw	s0,8(sp)
 8001cd0:	4492                	lw	s1,4(sp)
 8001cd2:	4902                	lw	s2,0(sp)
 8001cd4:	0141                	addi	sp,sp,16
 8001cd6:	8082                	ret
 8001cd8:	00277693          	andi	a3,a4,2
 8001cdc:	4601                	li	a2,0
 8001cde:	e291                	bnez	a3,8001ce2 <__swsetup_r+0x106>
 8001ce0:	4850                	lw	a2,20(s0)
 8001ce2:	c410                	sw	a2,8(s0)
 8001ce4:	bff1                	j	8001cc0 <__swsetup_r+0xe4>

08001ce6 <__register_exitproc>:
 8001ce6:	88aa                	mv	a7,a0
 8001ce8:	17ffe517          	auipc	a0,0x17ffe
 8001cec:	38850513          	addi	a0,a0,904 # 20000070 <_global_atexit>
 8001cf0:	411c                	lw	a5,0(a0)
 8001cf2:	ef81                	bnez	a5,8001d0a <__register_exitproc+0x24>
 8001cf4:	87418713          	addi	a4,gp,-1932 # 200000d4 <_global_atexit0>
 8001cf8:	c118                	sw	a4,0(a0)
 8001cfa:	00000513          	li	a0,0
 8001cfe:	87ba                	mv	a5,a4
 8001d00:	c509                	beqz	a0,8001d0a <__register_exitproc+0x24>
 8001d02:	411c                	lw	a5,0(a0)
 8001d04:	08f72423          	sw	a5,136(a4)
 8001d08:	87ba                	mv	a5,a4
 8001d0a:	43d8                	lw	a4,4(a5)
 8001d0c:	487d                	li	a6,31
 8001d0e:	557d                	li	a0,-1
 8001d10:	04e84663          	blt	a6,a4,8001d5c <__register_exitproc+0x76>
 8001d14:	02088d63          	beqz	a7,8001d4e <__register_exitproc+0x68>
 8001d18:	0887a803          	lw	a6,136(a5)
 8001d1c:	04080063          	beqz	a6,8001d5c <__register_exitproc+0x76>
 8001d20:	00271513          	slli	a0,a4,0x2
 8001d24:	9542                	add	a0,a0,a6
 8001d26:	c110                	sw	a2,0(a0)
 8001d28:	10082303          	lw	t1,256(a6)
 8001d2c:	4605                	li	a2,1
 8001d2e:	00e61633          	sll	a2,a2,a4
 8001d32:	00c36333          	or	t1,t1,a2
 8001d36:	10682023          	sw	t1,256(a6)
 8001d3a:	08d52023          	sw	a3,128(a0)
 8001d3e:	4689                	li	a3,2
 8001d40:	00d89763          	bne	a7,a3,8001d4e <__register_exitproc+0x68>
 8001d44:	10482683          	lw	a3,260(a6)
 8001d48:	8e55                	or	a2,a2,a3
 8001d4a:	10c82223          	sw	a2,260(a6)
 8001d4e:	00170693          	addi	a3,a4,1
 8001d52:	070a                	slli	a4,a4,0x2
 8001d54:	c3d4                	sw	a3,4(a5)
 8001d56:	97ba                	add	a5,a5,a4
 8001d58:	c78c                	sw	a1,8(a5)
 8001d5a:	4501                	li	a0,0
 8001d5c:	8082                	ret

08001d5e <__sflush_r>:
 8001d5e:	00c5d783          	lhu	a5,12(a1)
 8001d62:	1101                	addi	sp,sp,-32
 8001d64:	cc22                	sw	s0,24(sp)
 8001d66:	ca26                	sw	s1,20(sp)
 8001d68:	ce06                	sw	ra,28(sp)
 8001d6a:	c84a                	sw	s2,16(sp)
 8001d6c:	c64e                	sw	s3,12(sp)
 8001d6e:	0087f713          	andi	a4,a5,8
 8001d72:	84aa                	mv	s1,a0
 8001d74:	842e                	mv	s0,a1
 8001d76:	e375                	bnez	a4,8001e5a <__sflush_r+0xfc>
 8001d78:	41d8                	lw	a4,4(a1)
 8001d7a:	00e04763          	bgtz	a4,8001d88 <__sflush_r+0x2a>
 8001d7e:	41b8                	lw	a4,64(a1)
 8001d80:	00e04463          	bgtz	a4,8001d88 <__sflush_r+0x2a>
 8001d84:	4501                	li	a0,0
 8001d86:	a875                	j	8001e42 <__sflush_r+0xe4>
 8001d88:	5458                	lw	a4,44(s0)
 8001d8a:	df6d                	beqz	a4,8001d84 <__sflush_r+0x26>
 8001d8c:	6685                	lui	a3,0x1
 8001d8e:	0004a903          	lw	s2,0(s1)
 8001d92:	8ff5                	and	a5,a5,a3
 8001d94:	0004a023          	sw	zero,0(s1)
 8001d98:	cfa5                	beqz	a5,8001e10 <__sflush_r+0xb2>
 8001d9a:	4868                	lw	a0,84(s0)
 8001d9c:	00c45783          	lhu	a5,12(s0)
 8001da0:	8b91                	andi	a5,a5,4
 8001da2:	c799                	beqz	a5,8001db0 <__sflush_r+0x52>
 8001da4:	405c                	lw	a5,4(s0)
 8001da6:	8d1d                	sub	a0,a0,a5
 8001da8:	585c                	lw	a5,52(s0)
 8001daa:	c399                	beqz	a5,8001db0 <__sflush_r+0x52>
 8001dac:	403c                	lw	a5,64(s0)
 8001dae:	8d1d                	sub	a0,a0,a5
 8001db0:	545c                	lw	a5,44(s0)
 8001db2:	500c                	lw	a1,32(s0)
 8001db4:	862a                	mv	a2,a0
 8001db6:	4681                	li	a3,0
 8001db8:	8526                	mv	a0,s1
 8001dba:	9782                	jalr	a5
 8001dbc:	57fd                	li	a5,-1
 8001dbe:	00c45703          	lhu	a4,12(s0)
 8001dc2:	00f51d63          	bne	a0,a5,8001ddc <__sflush_r+0x7e>
 8001dc6:	4094                	lw	a3,0(s1)
 8001dc8:	47f5                	li	a5,29
 8001dca:	08d7e363          	bltu	a5,a3,8001e50 <__sflush_r+0xf2>
 8001dce:	204007b7          	lui	a5,0x20400
 8001dd2:	0785                	addi	a5,a5,1
 8001dd4:	00d7d7b3          	srl	a5,a5,a3
 8001dd8:	8b85                	andi	a5,a5,1
 8001dda:	cbbd                	beqz	a5,8001e50 <__sflush_r+0xf2>
 8001ddc:	481c                	lw	a5,16(s0)
 8001dde:	00042223          	sw	zero,4(s0)
 8001de2:	c01c                	sw	a5,0(s0)
 8001de4:	6785                	lui	a5,0x1
 8001de6:	8f7d                	and	a4,a4,a5
 8001de8:	c719                	beqz	a4,8001df6 <__sflush_r+0x98>
 8001dea:	57fd                	li	a5,-1
 8001dec:	00f51463          	bne	a0,a5,8001df4 <__sflush_r+0x96>
 8001df0:	409c                	lw	a5,0(s1)
 8001df2:	e391                	bnez	a5,8001df6 <__sflush_r+0x98>
 8001df4:	c868                	sw	a0,84(s0)
 8001df6:	584c                	lw	a1,52(s0)
 8001df8:	0124a023          	sw	s2,0(s1)
 8001dfc:	d5c1                	beqz	a1,8001d84 <__sflush_r+0x26>
 8001dfe:	04440793          	addi	a5,s0,68
 8001e02:	00f58463          	beq	a1,a5,8001e0a <__sflush_r+0xac>
 8001e06:	8526                	mv	a0,s1
 8001e08:	2939                	jal	8002226 <_free_r>
 8001e0a:	02042a23          	sw	zero,52(s0)
 8001e0e:	bf9d                	j	8001d84 <__sflush_r+0x26>
 8001e10:	500c                	lw	a1,32(s0)
 8001e12:	4685                	li	a3,1
 8001e14:	4601                	li	a2,0
 8001e16:	8526                	mv	a0,s1
 8001e18:	9702                	jalr	a4
 8001e1a:	57fd                	li	a5,-1
 8001e1c:	f8f510e3          	bne	a0,a5,8001d9c <__sflush_r+0x3e>
 8001e20:	409c                	lw	a5,0(s1)
 8001e22:	dfad                	beqz	a5,8001d9c <__sflush_r+0x3e>
 8001e24:	4775                	li	a4,29
 8001e26:	00e78563          	beq	a5,a4,8001e30 <__sflush_r+0xd2>
 8001e2a:	4759                	li	a4,22
 8001e2c:	00e79563          	bne	a5,a4,8001e36 <__sflush_r+0xd8>
 8001e30:	0124a023          	sw	s2,0(s1)
 8001e34:	bf81                	j	8001d84 <__sflush_r+0x26>
 8001e36:	00c45783          	lhu	a5,12(s0)
 8001e3a:	0407e793          	ori	a5,a5,64
 8001e3e:	00f41623          	sh	a5,12(s0)
 8001e42:	40f2                	lw	ra,28(sp)
 8001e44:	4462                	lw	s0,24(sp)
 8001e46:	44d2                	lw	s1,20(sp)
 8001e48:	4942                	lw	s2,16(sp)
 8001e4a:	49b2                	lw	s3,12(sp)
 8001e4c:	6105                	addi	sp,sp,32
 8001e4e:	8082                	ret
 8001e50:	04076713          	ori	a4,a4,64
 8001e54:	00e41623          	sh	a4,12(s0)
 8001e58:	b7ed                	j	8001e42 <__sflush_r+0xe4>
 8001e5a:	0105a983          	lw	s3,16(a1)
 8001e5e:	f20983e3          	beqz	s3,8001d84 <__sflush_r+0x26>
 8001e62:	0005a903          	lw	s2,0(a1)
 8001e66:	8b8d                	andi	a5,a5,3
 8001e68:	0135a023          	sw	s3,0(a1)
 8001e6c:	41390933          	sub	s2,s2,s3
 8001e70:	4701                	li	a4,0
 8001e72:	e391                	bnez	a5,8001e76 <__sflush_r+0x118>
 8001e74:	49d8                	lw	a4,20(a1)
 8001e76:	c418                	sw	a4,8(s0)
 8001e78:	f12056e3          	blez	s2,8001d84 <__sflush_r+0x26>
 8001e7c:	541c                	lw	a5,40(s0)
 8001e7e:	500c                	lw	a1,32(s0)
 8001e80:	86ca                	mv	a3,s2
 8001e82:	864e                	mv	a2,s3
 8001e84:	8526                	mv	a0,s1
 8001e86:	9782                	jalr	a5
 8001e88:	00a04a63          	bgtz	a0,8001e9c <__sflush_r+0x13e>
 8001e8c:	00c45783          	lhu	a5,12(s0)
 8001e90:	557d                	li	a0,-1
 8001e92:	0407e793          	ori	a5,a5,64
 8001e96:	00f41623          	sh	a5,12(s0)
 8001e9a:	b765                	j	8001e42 <__sflush_r+0xe4>
 8001e9c:	99aa                	add	s3,s3,a0
 8001e9e:	40a90933          	sub	s2,s2,a0
 8001ea2:	bfd9                	j	8001e78 <__sflush_r+0x11a>

08001ea4 <_fflush_r>:
 8001ea4:	499c                	lw	a5,16(a1)
 8001ea6:	cfb9                	beqz	a5,8001f04 <_fflush_r+0x60>
 8001ea8:	1101                	addi	sp,sp,-32
 8001eaa:	cc22                	sw	s0,24(sp)
 8001eac:	ce06                	sw	ra,28(sp)
 8001eae:	842a                	mv	s0,a0
 8001eb0:	c511                	beqz	a0,8001ebc <_fflush_r+0x18>
 8001eb2:	4d1c                	lw	a5,24(a0)
 8001eb4:	e781                	bnez	a5,8001ebc <_fflush_r+0x18>
 8001eb6:	c62e                	sw	a1,12(sp)
 8001eb8:	2229                	jal	8001fc2 <__sinit>
 8001eba:	45b2                	lw	a1,12(sp)
 8001ebc:	00001797          	auipc	a5,0x1
 8001ec0:	45878793          	addi	a5,a5,1112 # 8003314 <__sf_fake_stdin>
 8001ec4:	00f59b63          	bne	a1,a5,8001eda <_fflush_r+0x36>
 8001ec8:	404c                	lw	a1,4(s0)
 8001eca:	00c59783          	lh	a5,12(a1)
 8001ece:	c795                	beqz	a5,8001efa <_fflush_r+0x56>
 8001ed0:	8522                	mv	a0,s0
 8001ed2:	4462                	lw	s0,24(sp)
 8001ed4:	40f2                	lw	ra,28(sp)
 8001ed6:	6105                	addi	sp,sp,32
 8001ed8:	b559                	j	8001d5e <__sflush_r>
 8001eda:	00001797          	auipc	a5,0x1
 8001ede:	45a78793          	addi	a5,a5,1114 # 8003334 <__sf_fake_stdout>
 8001ee2:	00f59463          	bne	a1,a5,8001eea <_fflush_r+0x46>
 8001ee6:	440c                	lw	a1,8(s0)
 8001ee8:	b7cd                	j	8001eca <_fflush_r+0x26>
 8001eea:	00001797          	auipc	a5,0x1
 8001eee:	40a78793          	addi	a5,a5,1034 # 80032f4 <__sf_fake_stderr>
 8001ef2:	fcf59ce3          	bne	a1,a5,8001eca <_fflush_r+0x26>
 8001ef6:	444c                	lw	a1,12(s0)
 8001ef8:	bfc9                	j	8001eca <_fflush_r+0x26>
 8001efa:	40f2                	lw	ra,28(sp)
 8001efc:	4462                	lw	s0,24(sp)
 8001efe:	4501                	li	a0,0
 8001f00:	6105                	addi	sp,sp,32
 8001f02:	8082                	ret
 8001f04:	4501                	li	a0,0
 8001f06:	8082                	ret

08001f08 <std>:
 8001f08:	1141                	addi	sp,sp,-16
 8001f0a:	c422                	sw	s0,8(sp)
 8001f0c:	c606                	sw	ra,12(sp)
 8001f0e:	842a                	mv	s0,a0
 8001f10:	00b51623          	sh	a1,12(a0)
 8001f14:	00c51723          	sh	a2,14(a0)
 8001f18:	00052023          	sw	zero,0(a0)
 8001f1c:	00052223          	sw	zero,4(a0)
 8001f20:	00052423          	sw	zero,8(a0)
 8001f24:	06052223          	sw	zero,100(a0)
 8001f28:	00052823          	sw	zero,16(a0)
 8001f2c:	00052a23          	sw	zero,20(a0)
 8001f30:	00052c23          	sw	zero,24(a0)
 8001f34:	4621                	li	a2,8
 8001f36:	4581                	li	a1,0
 8001f38:	05c50513          	addi	a0,a0,92
 8001f3c:	a15ff0ef          	jal	ra,8001950 <memset>
 8001f40:	00001797          	auipc	a5,0x1
 8001f44:	b1478793          	addi	a5,a5,-1260 # 8002a54 <__sread>
 8001f48:	d05c                	sw	a5,36(s0)
 8001f4a:	00001797          	auipc	a5,0x1
 8001f4e:	b3a78793          	addi	a5,a5,-1222 # 8002a84 <__swrite>
 8001f52:	d41c                	sw	a5,40(s0)
 8001f54:	00001797          	auipc	a5,0x1
 8001f58:	b7e78793          	addi	a5,a5,-1154 # 8002ad2 <__sseek>
 8001f5c:	d45c                	sw	a5,44(s0)
 8001f5e:	00001797          	auipc	a5,0x1
 8001f62:	baa78793          	addi	a5,a5,-1110 # 8002b08 <__sclose>
 8001f66:	40b2                	lw	ra,12(sp)
 8001f68:	d000                	sw	s0,32(s0)
 8001f6a:	d81c                	sw	a5,48(s0)
 8001f6c:	4422                	lw	s0,8(sp)
 8001f6e:	0141                	addi	sp,sp,16
 8001f70:	8082                	ret

08001f72 <_cleanup_r>:
 8001f72:	00000597          	auipc	a1,0x0
 8001f76:	f3258593          	addi	a1,a1,-206 # 8001ea4 <_fflush_r>
 8001f7a:	a2a1                	j	80020c2 <_fwalk_reent>

08001f7c <__sfmoreglue>:
 8001f7c:	1141                	addi	sp,sp,-16
 8001f7e:	c226                	sw	s1,4(sp)
 8001f80:	06800613          	li	a2,104
 8001f84:	fff58493          	addi	s1,a1,-1
 8001f88:	02c484b3          	mul	s1,s1,a2
 8001f8c:	c04a                	sw	s2,0(sp)
 8001f8e:	892e                	mv	s2,a1
 8001f90:	c422                	sw	s0,8(sp)
 8001f92:	c606                	sw	ra,12(sp)
 8001f94:	07448593          	addi	a1,s1,116
 8001f98:	2e15                	jal	80022cc <_malloc_r>
 8001f9a:	842a                	mv	s0,a0
 8001f9c:	cd01                	beqz	a0,8001fb4 <__sfmoreglue+0x38>
 8001f9e:	00052023          	sw	zero,0(a0)
 8001fa2:	01252223          	sw	s2,4(a0)
 8001fa6:	0531                	addi	a0,a0,12
 8001fa8:	c408                	sw	a0,8(s0)
 8001faa:	06848613          	addi	a2,s1,104
 8001fae:	4581                	li	a1,0
 8001fb0:	9a1ff0ef          	jal	ra,8001950 <memset>
 8001fb4:	40b2                	lw	ra,12(sp)
 8001fb6:	8522                	mv	a0,s0
 8001fb8:	4422                	lw	s0,8(sp)
 8001fba:	4492                	lw	s1,4(sp)
 8001fbc:	4902                	lw	s2,0(sp)
 8001fbe:	0141                	addi	sp,sp,16
 8001fc0:	8082                	ret

08001fc2 <__sinit>:
 8001fc2:	4d1c                	lw	a5,24(a0)
 8001fc4:	e3ad                	bnez	a5,8002026 <__sinit+0x64>
 8001fc6:	1141                	addi	sp,sp,-16
 8001fc8:	c422                	sw	s0,8(sp)
 8001fca:	c606                	sw	ra,12(sp)
 8001fcc:	00000797          	auipc	a5,0x0
 8001fd0:	fa678793          	addi	a5,a5,-90 # 8001f72 <_cleanup_r>
 8001fd4:	d51c                	sw	a5,40(a0)
 8001fd6:	04052423          	sw	zero,72(a0)
 8001fda:	04052623          	sw	zero,76(a0)
 8001fde:	04052823          	sw	zero,80(a0)
 8001fe2:	8081a783          	lw	a5,-2040(gp) # 20000068 <_global_impure_ptr>
 8001fe6:	842a                	mv	s0,a0
 8001fe8:	00f51463          	bne	a0,a5,8001ff0 <__sinit+0x2e>
 8001fec:	4785                	li	a5,1
 8001fee:	cd1c                	sw	a5,24(a0)
 8001ff0:	8522                	mv	a0,s0
 8001ff2:	281d                	jal	8002028 <__sfp>
 8001ff4:	c048                	sw	a0,4(s0)
 8001ff6:	8522                	mv	a0,s0
 8001ff8:	2805                	jal	8002028 <__sfp>
 8001ffa:	c408                	sw	a0,8(s0)
 8001ffc:	8522                	mv	a0,s0
 8001ffe:	202d                	jal	8002028 <__sfp>
 8002000:	c448                	sw	a0,12(s0)
 8002002:	4048                	lw	a0,4(s0)
 8002004:	4601                	li	a2,0
 8002006:	4591                	li	a1,4
 8002008:	3701                	jal	8001f08 <std>
 800200a:	4408                	lw	a0,8(s0)
 800200c:	4605                	li	a2,1
 800200e:	45a5                	li	a1,9
 8002010:	3de5                	jal	8001f08 <std>
 8002012:	4448                	lw	a0,12(s0)
 8002014:	4609                	li	a2,2
 8002016:	45c9                	li	a1,18
 8002018:	3dc5                	jal	8001f08 <std>
 800201a:	4785                	li	a5,1
 800201c:	40b2                	lw	ra,12(sp)
 800201e:	cc1c                	sw	a5,24(s0)
 8002020:	4422                	lw	s0,8(sp)
 8002022:	0141                	addi	sp,sp,16
 8002024:	8082                	ret
 8002026:	8082                	ret

08002028 <__sfp>:
 8002028:	1141                	addi	sp,sp,-16
 800202a:	c226                	sw	s1,4(sp)
 800202c:	8081a483          	lw	s1,-2040(gp) # 20000068 <_global_impure_ptr>
 8002030:	4c9c                	lw	a5,24(s1)
 8002032:	c04a                	sw	s2,0(sp)
 8002034:	c606                	sw	ra,12(sp)
 8002036:	c422                	sw	s0,8(sp)
 8002038:	892a                	mv	s2,a0
 800203a:	e399                	bnez	a5,8002040 <__sfp+0x18>
 800203c:	8526                	mv	a0,s1
 800203e:	3751                	jal	8001fc2 <__sinit>
 8002040:	04848493          	addi	s1,s1,72
 8002044:	4480                	lw	s0,8(s1)
 8002046:	40dc                	lw	a5,4(s1)
 8002048:	17fd                	addi	a5,a5,-1
 800204a:	0007d663          	bgez	a5,8002056 <__sfp+0x2e>
 800204e:	409c                	lw	a5,0(s1)
 8002050:	cfb9                	beqz	a5,80020ae <__sfp+0x86>
 8002052:	4084                	lw	s1,0(s1)
 8002054:	bfc5                	j	8002044 <__sfp+0x1c>
 8002056:	00c41703          	lh	a4,12(s0)
 800205a:	e739                	bnez	a4,80020a8 <__sfp+0x80>
 800205c:	77c1                	lui	a5,0xffff0
 800205e:	0785                	addi	a5,a5,1
 8002060:	06042223          	sw	zero,100(s0)
 8002064:	00042023          	sw	zero,0(s0)
 8002068:	00042223          	sw	zero,4(s0)
 800206c:	00042423          	sw	zero,8(s0)
 8002070:	c45c                	sw	a5,12(s0)
 8002072:	00042823          	sw	zero,16(s0)
 8002076:	00042a23          	sw	zero,20(s0)
 800207a:	00042c23          	sw	zero,24(s0)
 800207e:	4621                	li	a2,8
 8002080:	4581                	li	a1,0
 8002082:	05c40513          	addi	a0,s0,92
 8002086:	8cbff0ef          	jal	ra,8001950 <memset>
 800208a:	02042a23          	sw	zero,52(s0)
 800208e:	02042c23          	sw	zero,56(s0)
 8002092:	04042423          	sw	zero,72(s0)
 8002096:	04042623          	sw	zero,76(s0)
 800209a:	40b2                	lw	ra,12(sp)
 800209c:	8522                	mv	a0,s0
 800209e:	4422                	lw	s0,8(sp)
 80020a0:	4492                	lw	s1,4(sp)
 80020a2:	4902                	lw	s2,0(sp)
 80020a4:	0141                	addi	sp,sp,16
 80020a6:	8082                	ret
 80020a8:	06840413          	addi	s0,s0,104
 80020ac:	bf71                	j	8002048 <__sfp+0x20>
 80020ae:	4591                	li	a1,4
 80020b0:	854a                	mv	a0,s2
 80020b2:	35e9                	jal	8001f7c <__sfmoreglue>
 80020b4:	c088                	sw	a0,0(s1)
 80020b6:	842a                	mv	s0,a0
 80020b8:	fd49                	bnez	a0,8002052 <__sfp+0x2a>
 80020ba:	47b1                	li	a5,12
 80020bc:	00f92023          	sw	a5,0(s2)
 80020c0:	bfe9                	j	800209a <__sfp+0x72>

080020c2 <_fwalk_reent>:
 80020c2:	7179                	addi	sp,sp,-48
 80020c4:	d422                	sw	s0,40(sp)
 80020c6:	d04a                	sw	s2,32(sp)
 80020c8:	ce4e                	sw	s3,28(sp)
 80020ca:	cc52                	sw	s4,24(sp)
 80020cc:	c85a                	sw	s6,16(sp)
 80020ce:	c65e                	sw	s7,12(sp)
 80020d0:	d606                	sw	ra,44(sp)
 80020d2:	d226                	sw	s1,36(sp)
 80020d4:	ca56                	sw	s5,20(sp)
 80020d6:	892a                	mv	s2,a0
 80020d8:	8a2e                	mv	s4,a1
 80020da:	04850413          	addi	s0,a0,72
 80020de:	4981                	li	s3,0
 80020e0:	4b05                	li	s6,1
 80020e2:	5bfd                	li	s7,-1
 80020e4:	4404                	lw	s1,8(s0)
 80020e6:	00442a83          	lw	s5,4(s0)
 80020ea:	1afd                	addi	s5,s5,-1
 80020ec:	020ad063          	bgez	s5,800210c <_fwalk_reent+0x4a>
 80020f0:	4000                	lw	s0,0(s0)
 80020f2:	f86d                	bnez	s0,80020e4 <_fwalk_reent+0x22>
 80020f4:	50b2                	lw	ra,44(sp)
 80020f6:	5422                	lw	s0,40(sp)
 80020f8:	5492                	lw	s1,36(sp)
 80020fa:	5902                	lw	s2,32(sp)
 80020fc:	4a62                	lw	s4,24(sp)
 80020fe:	4ad2                	lw	s5,20(sp)
 8002100:	4b42                	lw	s6,16(sp)
 8002102:	4bb2                	lw	s7,12(sp)
 8002104:	854e                	mv	a0,s3
 8002106:	49f2                	lw	s3,28(sp)
 8002108:	6145                	addi	sp,sp,48
 800210a:	8082                	ret
 800210c:	00c4d783          	lhu	a5,12(s1)
 8002110:	00fb7b63          	bgeu	s6,a5,8002126 <_fwalk_reent+0x64>
 8002114:	00e49783          	lh	a5,14(s1)
 8002118:	01778763          	beq	a5,s7,8002126 <_fwalk_reent+0x64>
 800211c:	85a6                	mv	a1,s1
 800211e:	854a                	mv	a0,s2
 8002120:	9a02                	jalr	s4
 8002122:	00a9e9b3          	or	s3,s3,a0
 8002126:	06848493          	addi	s1,s1,104
 800212a:	b7c1                	j	80020ea <_fwalk_reent+0x28>

0800212c <__swhatbuf_r>:
 800212c:	7159                	addi	sp,sp,-112
 800212e:	d0ca                	sw	s2,96(sp)
 8002130:	892e                	mv	s2,a1
 8002132:	00e59583          	lh	a1,14(a1)
 8002136:	d4a2                	sw	s0,104(sp)
 8002138:	d2a6                	sw	s1,100(sp)
 800213a:	d686                	sw	ra,108(sp)
 800213c:	8432                	mv	s0,a2
 800213e:	84b6                	mv	s1,a3
 8002140:	0005dc63          	bgez	a1,8002158 <__swhatbuf_r+0x2c>
 8002144:	00c91783          	lh	a5,12(s2)
 8002148:	0004a023          	sw	zero,0(s1)
 800214c:	0807f793          	andi	a5,a5,128
 8002150:	e395                	bnez	a5,8002174 <__swhatbuf_r+0x48>
 8002152:	40000793          	li	a5,1024
 8002156:	a00d                	j	8002178 <__swhatbuf_r+0x4c>
 8002158:	0030                	addi	a2,sp,8
 800215a:	215000ef          	jal	ra,8002b6e <_fstat_r>
 800215e:	fe0543e3          	bltz	a0,8002144 <__swhatbuf_r+0x18>
 8002162:	4732                	lw	a4,12(sp)
 8002164:	67bd                	lui	a5,0xf
 8002166:	8ff9                	and	a5,a5,a4
 8002168:	7779                	lui	a4,0xffffe
 800216a:	97ba                	add	a5,a5,a4
 800216c:	0017b793          	seqz	a5,a5
 8002170:	c09c                	sw	a5,0(s1)
 8002172:	b7c5                	j	8002152 <__swhatbuf_r+0x26>
 8002174:	04000793          	li	a5,64
 8002178:	50b6                	lw	ra,108(sp)
 800217a:	c01c                	sw	a5,0(s0)
 800217c:	5426                	lw	s0,104(sp)
 800217e:	5496                	lw	s1,100(sp)
 8002180:	5906                	lw	s2,96(sp)
 8002182:	4501                	li	a0,0
 8002184:	6165                	addi	sp,sp,112
 8002186:	8082                	ret

08002188 <__smakebuf_r>:
 8002188:	00c5d783          	lhu	a5,12(a1)
 800218c:	1101                	addi	sp,sp,-32
 800218e:	cc22                	sw	s0,24(sp)
 8002190:	ce06                	sw	ra,28(sp)
 8002192:	ca26                	sw	s1,20(sp)
 8002194:	c84a                	sw	s2,16(sp)
 8002196:	8b89                	andi	a5,a5,2
 8002198:	842e                	mv	s0,a1
 800219a:	cf89                	beqz	a5,80021b4 <__smakebuf_r+0x2c>
 800219c:	04740793          	addi	a5,s0,71
 80021a0:	c01c                	sw	a5,0(s0)
 80021a2:	c81c                	sw	a5,16(s0)
 80021a4:	4785                	li	a5,1
 80021a6:	c85c                	sw	a5,20(s0)
 80021a8:	40f2                	lw	ra,28(sp)
 80021aa:	4462                	lw	s0,24(sp)
 80021ac:	44d2                	lw	s1,20(sp)
 80021ae:	4942                	lw	s2,16(sp)
 80021b0:	6105                	addi	sp,sp,32
 80021b2:	8082                	ret
 80021b4:	0074                	addi	a3,sp,12
 80021b6:	0030                	addi	a2,sp,8
 80021b8:	892a                	mv	s2,a0
 80021ba:	3f8d                	jal	800212c <__swhatbuf_r>
 80021bc:	45a2                	lw	a1,8(sp)
 80021be:	84aa                	mv	s1,a0
 80021c0:	854a                	mv	a0,s2
 80021c2:	2229                	jal	80022cc <_malloc_r>
 80021c4:	ed01                	bnez	a0,80021dc <__smakebuf_r+0x54>
 80021c6:	00c41783          	lh	a5,12(s0)
 80021ca:	2007f713          	andi	a4,a5,512
 80021ce:	ff69                	bnez	a4,80021a8 <__smakebuf_r+0x20>
 80021d0:	9bf1                	andi	a5,a5,-4
 80021d2:	0027e793          	ori	a5,a5,2
 80021d6:	00f41623          	sh	a5,12(s0)
 80021da:	b7c9                	j	800219c <__smakebuf_r+0x14>
 80021dc:	00000797          	auipc	a5,0x0
 80021e0:	d9678793          	addi	a5,a5,-618 # 8001f72 <_cleanup_r>
 80021e4:	02f92423          	sw	a5,40(s2)
 80021e8:	00c45783          	lhu	a5,12(s0)
 80021ec:	c008                	sw	a0,0(s0)
 80021ee:	c808                	sw	a0,16(s0)
 80021f0:	0807e793          	ori	a5,a5,128
 80021f4:	00f41623          	sh	a5,12(s0)
 80021f8:	47a2                	lw	a5,8(sp)
 80021fa:	c85c                	sw	a5,20(s0)
 80021fc:	47b2                	lw	a5,12(sp)
 80021fe:	cf91                	beqz	a5,800221a <__smakebuf_r+0x92>
 8002200:	00e41583          	lh	a1,14(s0)
 8002204:	854a                	mv	a0,s2
 8002206:	199000ef          	jal	ra,8002b9e <_isatty_r>
 800220a:	c901                	beqz	a0,800221a <__smakebuf_r+0x92>
 800220c:	00c45783          	lhu	a5,12(s0)
 8002210:	9bf1                	andi	a5,a5,-4
 8002212:	0017e793          	ori	a5,a5,1
 8002216:	00f41623          	sh	a5,12(s0)
 800221a:	00c45503          	lhu	a0,12(s0)
 800221e:	8cc9                	or	s1,s1,a0
 8002220:	00941623          	sh	s1,12(s0)
 8002224:	b751                	j	80021a8 <__smakebuf_r+0x20>

08002226 <_free_r>:
 8002226:	c1d5                	beqz	a1,80022ca <_free_r+0xa4>
 8002228:	ffc5a783          	lw	a5,-4(a1)
 800222c:	1101                	addi	sp,sp,-32
 800222e:	cc22                	sw	s0,24(sp)
 8002230:	ce06                	sw	ra,28(sp)
 8002232:	ffc58413          	addi	s0,a1,-4
 8002236:	0007d363          	bgez	a5,800223c <_free_r+0x16>
 800223a:	943e                	add	s0,s0,a5
 800223c:	c62a                	sw	a0,12(sp)
 800223e:	1db000ef          	jal	ra,8002c18 <__malloc_lock>
 8002242:	17ffe717          	auipc	a4,0x17ffe
 8002246:	e3270713          	addi	a4,a4,-462 # 20000074 <__malloc_free_list>
 800224a:	431c                	lw	a5,0(a4)
 800224c:	4532                	lw	a0,12(sp)
 800224e:	eb89                	bnez	a5,8002260 <_free_r+0x3a>
 8002250:	00042223          	sw	zero,4(s0)
 8002254:	c300                	sw	s0,0(a4)
 8002256:	4462                	lw	s0,24(sp)
 8002258:	40f2                	lw	ra,28(sp)
 800225a:	6105                	addi	sp,sp,32
 800225c:	1bf0006f          	j	8002c1a <__malloc_unlock>
 8002260:	00f47d63          	bgeu	s0,a5,800227a <_free_r+0x54>
 8002264:	4010                	lw	a2,0(s0)
 8002266:	00c406b3          	add	a3,s0,a2
 800226a:	00d79663          	bne	a5,a3,8002276 <_free_r+0x50>
 800226e:	4394                	lw	a3,0(a5)
 8002270:	43dc                	lw	a5,4(a5)
 8002272:	96b2                	add	a3,a3,a2
 8002274:	c014                	sw	a3,0(s0)
 8002276:	c05c                	sw	a5,4(s0)
 8002278:	bff1                	j	8002254 <_free_r+0x2e>
 800227a:	873e                	mv	a4,a5
 800227c:	43dc                	lw	a5,4(a5)
 800227e:	c399                	beqz	a5,8002284 <_free_r+0x5e>
 8002280:	fef47de3          	bgeu	s0,a5,800227a <_free_r+0x54>
 8002284:	4314                	lw	a3,0(a4)
 8002286:	00d70633          	add	a2,a4,a3
 800228a:	00861f63          	bne	a2,s0,80022a8 <_free_r+0x82>
 800228e:	4010                	lw	a2,0(s0)
 8002290:	96b2                	add	a3,a3,a2
 8002292:	c314                	sw	a3,0(a4)
 8002294:	00d70633          	add	a2,a4,a3
 8002298:	fac79fe3          	bne	a5,a2,8002256 <_free_r+0x30>
 800229c:	4390                	lw	a2,0(a5)
 800229e:	43dc                	lw	a5,4(a5)
 80022a0:	96b2                	add	a3,a3,a2
 80022a2:	c314                	sw	a3,0(a4)
 80022a4:	c35c                	sw	a5,4(a4)
 80022a6:	bf45                	j	8002256 <_free_r+0x30>
 80022a8:	00c47563          	bgeu	s0,a2,80022b2 <_free_r+0x8c>
 80022ac:	47b1                	li	a5,12
 80022ae:	c11c                	sw	a5,0(a0)
 80022b0:	b75d                	j	8002256 <_free_r+0x30>
 80022b2:	4010                	lw	a2,0(s0)
 80022b4:	00c406b3          	add	a3,s0,a2
 80022b8:	00d79663          	bne	a5,a3,80022c4 <_free_r+0x9e>
 80022bc:	4394                	lw	a3,0(a5)
 80022be:	43dc                	lw	a5,4(a5)
 80022c0:	96b2                	add	a3,a3,a2
 80022c2:	c014                	sw	a3,0(s0)
 80022c4:	c05c                	sw	a5,4(s0)
 80022c6:	c340                	sw	s0,4(a4)
 80022c8:	b779                	j	8002256 <_free_r+0x30>
 80022ca:	8082                	ret

080022cc <_malloc_r>:
 80022cc:	1101                	addi	sp,sp,-32
 80022ce:	ca26                	sw	s1,20(sp)
 80022d0:	00358493          	addi	s1,a1,3
 80022d4:	98f1                	andi	s1,s1,-4
 80022d6:	c84a                	sw	s2,16(sp)
 80022d8:	ce06                	sw	ra,28(sp)
 80022da:	cc22                	sw	s0,24(sp)
 80022dc:	c64e                	sw	s3,12(sp)
 80022de:	04a1                	addi	s1,s1,8
 80022e0:	47b1                	li	a5,12
 80022e2:	892a                	mv	s2,a0
 80022e4:	04f4f663          	bgeu	s1,a5,8002330 <_malloc_r+0x64>
 80022e8:	44b1                	li	s1,12
 80022ea:	04b4e563          	bltu	s1,a1,8002334 <_malloc_r+0x68>
 80022ee:	854a                	mv	a0,s2
 80022f0:	129000ef          	jal	ra,8002c18 <__malloc_lock>
 80022f4:	17ffe697          	auipc	a3,0x17ffe
 80022f8:	d8068693          	addi	a3,a3,-640 # 20000074 <__malloc_free_list>
 80022fc:	4298                	lw	a4,0(a3)
 80022fe:	843a                	mv	s0,a4
 8002300:	e429                	bnez	s0,800234a <_malloc_r+0x7e>
 8002302:	17ffe417          	auipc	s0,0x17ffe
 8002306:	d7640413          	addi	s0,s0,-650 # 20000078 <__malloc_sbrk_start>
 800230a:	401c                	lw	a5,0(s0)
 800230c:	e789                	bnez	a5,8002316 <_malloc_r+0x4a>
 800230e:	4581                	li	a1,0
 8002310:	854a                	mv	a0,s2
 8002312:	2f11                	jal	8002a26 <_sbrk_r>
 8002314:	c008                	sw	a0,0(s0)
 8002316:	85a6                	mv	a1,s1
 8002318:	854a                	mv	a0,s2
 800231a:	2731                	jal	8002a26 <_sbrk_r>
 800231c:	59fd                	li	s3,-1
 800231e:	07351a63          	bne	a0,s3,8002392 <_malloc_r+0xc6>
 8002322:	47b1                	li	a5,12
 8002324:	00f92023          	sw	a5,0(s2)
 8002328:	854a                	mv	a0,s2
 800232a:	0f1000ef          	jal	ra,8002c1a <__malloc_unlock>
 800232e:	a031                	j	800233a <_malloc_r+0x6e>
 8002330:	fa04dde3          	bgez	s1,80022ea <_malloc_r+0x1e>
 8002334:	47b1                	li	a5,12
 8002336:	00f92023          	sw	a5,0(s2)
 800233a:	4501                	li	a0,0
 800233c:	40f2                	lw	ra,28(sp)
 800233e:	4462                	lw	s0,24(sp)
 8002340:	44d2                	lw	s1,20(sp)
 8002342:	4942                	lw	s2,16(sp)
 8002344:	49b2                	lw	s3,12(sp)
 8002346:	6105                	addi	sp,sp,32
 8002348:	8082                	ret
 800234a:	401c                	lw	a5,0(s0)
 800234c:	8f85                	sub	a5,a5,s1
 800234e:	0207cf63          	bltz	a5,800238c <_malloc_r+0xc0>
 8002352:	462d                	li	a2,11
 8002354:	00f67663          	bgeu	a2,a5,8002360 <_malloc_r+0x94>
 8002358:	c01c                	sw	a5,0(s0)
 800235a:	943e                	add	s0,s0,a5
 800235c:	c004                	sw	s1,0(s0)
 800235e:	a029                	j	8002368 <_malloc_r+0x9c>
 8002360:	405c                	lw	a5,4(s0)
 8002362:	02871363          	bne	a4,s0,8002388 <_malloc_r+0xbc>
 8002366:	c29c                	sw	a5,0(a3)
 8002368:	854a                	mv	a0,s2
 800236a:	0b1000ef          	jal	ra,8002c1a <__malloc_unlock>
 800236e:	00b40513          	addi	a0,s0,11
 8002372:	00440793          	addi	a5,s0,4
 8002376:	9961                	andi	a0,a0,-8
 8002378:	40f50733          	sub	a4,a0,a5
 800237c:	fcf500e3          	beq	a0,a5,800233c <_malloc_r+0x70>
 8002380:	943a                	add	s0,s0,a4
 8002382:	8f89                	sub	a5,a5,a0
 8002384:	c01c                	sw	a5,0(s0)
 8002386:	bf5d                	j	800233c <_malloc_r+0x70>
 8002388:	c35c                	sw	a5,4(a4)
 800238a:	bff9                	j	8002368 <_malloc_r+0x9c>
 800238c:	8722                	mv	a4,s0
 800238e:	4040                	lw	s0,4(s0)
 8002390:	bf85                	j	8002300 <_malloc_r+0x34>
 8002392:	00350413          	addi	s0,a0,3
 8002396:	9871                	andi	s0,s0,-4
 8002398:	fc8502e3          	beq	a0,s0,800235c <_malloc_r+0x90>
 800239c:	40a405b3          	sub	a1,s0,a0
 80023a0:	854a                	mv	a0,s2
 80023a2:	2551                	jal	8002a26 <_sbrk_r>
 80023a4:	fb351ce3          	bne	a0,s3,800235c <_malloc_r+0x90>
 80023a8:	bfad                	j	8002322 <_malloc_r+0x56>

080023aa <__sfputc_r>:
 80023aa:	461c                	lw	a5,8(a2)
 80023ac:	17fd                	addi	a5,a5,-1
 80023ae:	c61c                	sw	a5,8(a2)
 80023b0:	0007da63          	bgez	a5,80023c4 <__sfputc_r+0x1a>
 80023b4:	4e18                	lw	a4,24(a2)
 80023b6:	00e7c563          	blt	a5,a4,80023c0 <__sfputc_r+0x16>
 80023ba:	47a9                	li	a5,10
 80023bc:	00f59463          	bne	a1,a5,80023c4 <__sfputc_r+0x1a>
 80023c0:	f5cff06f          	j	8001b1c <__swbuf_r>
 80023c4:	421c                	lw	a5,0(a2)
 80023c6:	852e                	mv	a0,a1
 80023c8:	00178713          	addi	a4,a5,1
 80023cc:	c218                	sw	a4,0(a2)
 80023ce:	00b78023          	sb	a1,0(a5)
 80023d2:	8082                	ret

080023d4 <__sfputs_r>:
 80023d4:	1101                	addi	sp,sp,-32
 80023d6:	cc22                	sw	s0,24(sp)
 80023d8:	ca26                	sw	s1,20(sp)
 80023da:	c84a                	sw	s2,16(sp)
 80023dc:	c64e                	sw	s3,12(sp)
 80023de:	c452                	sw	s4,8(sp)
 80023e0:	ce06                	sw	ra,28(sp)
 80023e2:	892a                	mv	s2,a0
 80023e4:	89ae                	mv	s3,a1
 80023e6:	8432                	mv	s0,a2
 80023e8:	00d604b3          	add	s1,a2,a3
 80023ec:	5a7d                	li	s4,-1
 80023ee:	00941463          	bne	s0,s1,80023f6 <__sfputs_r+0x22>
 80023f2:	4501                	li	a0,0
 80023f4:	a809                	j	8002406 <__sfputs_r+0x32>
 80023f6:	00044583          	lbu	a1,0(s0)
 80023fa:	864e                	mv	a2,s3
 80023fc:	854a                	mv	a0,s2
 80023fe:	3775                	jal	80023aa <__sfputc_r>
 8002400:	0405                	addi	s0,s0,1
 8002402:	ff4516e3          	bne	a0,s4,80023ee <__sfputs_r+0x1a>
 8002406:	40f2                	lw	ra,28(sp)
 8002408:	4462                	lw	s0,24(sp)
 800240a:	44d2                	lw	s1,20(sp)
 800240c:	4942                	lw	s2,16(sp)
 800240e:	49b2                	lw	s3,12(sp)
 8002410:	4a22                	lw	s4,8(sp)
 8002412:	6105                	addi	sp,sp,32
 8002414:	8082                	ret

08002416 <_vfiprintf_r>:
 8002416:	7135                	addi	sp,sp,-160
 8002418:	cd22                	sw	s0,152(sp)
 800241a:	cb26                	sw	s1,148(sp)
 800241c:	c94a                	sw	s2,144(sp)
 800241e:	c74e                	sw	s3,140(sp)
 8002420:	cf06                	sw	ra,156(sp)
 8002422:	c552                	sw	s4,136(sp)
 8002424:	c356                	sw	s5,132(sp)
 8002426:	c15a                	sw	s6,128(sp)
 8002428:	dede                	sw	s7,124(sp)
 800242a:	dce2                	sw	s8,120(sp)
 800242c:	dae6                	sw	s9,116(sp)
 800242e:	89aa                	mv	s3,a0
 8002430:	84ae                	mv	s1,a1
 8002432:	8932                	mv	s2,a2
 8002434:	8436                	mv	s0,a3
 8002436:	c501                	beqz	a0,800243e <_vfiprintf_r+0x28>
 8002438:	4d1c                	lw	a5,24(a0)
 800243a:	e391                	bnez	a5,800243e <_vfiprintf_r+0x28>
 800243c:	3659                	jal	8001fc2 <__sinit>
 800243e:	00001797          	auipc	a5,0x1
 8002442:	ed678793          	addi	a5,a5,-298 # 8003314 <__sf_fake_stdin>
 8002446:	0cf49a63          	bne	s1,a5,800251a <_vfiprintf_r+0x104>
 800244a:	0049a483          	lw	s1,4(s3)
 800244e:	00c4d783          	lhu	a5,12(s1)
 8002452:	8ba1                	andi	a5,a5,8
 8002454:	c7ed                	beqz	a5,800253e <_vfiprintf_r+0x128>
 8002456:	489c                	lw	a5,16(s1)
 8002458:	c3fd                	beqz	a5,800253e <_vfiprintf_r+0x128>
 800245a:	02000793          	li	a5,32
 800245e:	02f104a3          	sb	a5,41(sp)
 8002462:	03000793          	li	a5,48
 8002466:	d202                	sw	zero,36(sp)
 8002468:	02f10523          	sb	a5,42(sp)
 800246c:	c622                	sw	s0,12(sp)
 800246e:	02500b93          	li	s7,37
 8002472:	00001a97          	auipc	s5,0x1
 8002476:	ee2a8a93          	addi	s5,s5,-286 # 8003354 <__sf_fake_stdout+0x20>
 800247a:	4c05                	li	s8,1
 800247c:	4b29                	li	s6,10
 800247e:	844a                	mv	s0,s2
 8002480:	00044783          	lbu	a5,0(s0)
 8002484:	c399                	beqz	a5,800248a <_vfiprintf_r+0x74>
 8002486:	0d779f63          	bne	a5,s7,8002564 <_vfiprintf_r+0x14e>
 800248a:	41240cb3          	sub	s9,s0,s2
 800248e:	01240d63          	beq	s0,s2,80024a8 <_vfiprintf_r+0x92>
 8002492:	86e6                	mv	a3,s9
 8002494:	864a                	mv	a2,s2
 8002496:	85a6                	mv	a1,s1
 8002498:	854e                	mv	a0,s3
 800249a:	3f2d                	jal	80023d4 <__sfputs_r>
 800249c:	57fd                	li	a5,-1
 800249e:	1ef50463          	beq	a0,a5,8002686 <_vfiprintf_r+0x270>
 80024a2:	5792                	lw	a5,36(sp)
 80024a4:	97e6                	add	a5,a5,s9
 80024a6:	d23e                	sw	a5,36(sp)
 80024a8:	00044783          	lbu	a5,0(s0)
 80024ac:	1c078d63          	beqz	a5,8002686 <_vfiprintf_r+0x270>
 80024b0:	57fd                	li	a5,-1
 80024b2:	00140913          	addi	s2,s0,1
 80024b6:	c802                	sw	zero,16(sp)
 80024b8:	ce02                	sw	zero,28(sp)
 80024ba:	ca3e                	sw	a5,20(sp)
 80024bc:	cc02                	sw	zero,24(sp)
 80024be:	040109a3          	sb	zero,83(sp)
 80024c2:	d482                	sw	zero,104(sp)
 80024c4:	00094583          	lbu	a1,0(s2)
 80024c8:	4615                	li	a2,5
 80024ca:	8556                	mv	a0,s5
 80024cc:	2f0d                	jal	8002bfe <memchr>
 80024ce:	47c2                	lw	a5,16(sp)
 80024d0:	00190413          	addi	s0,s2,1
 80024d4:	e951                	bnez	a0,8002568 <_vfiprintf_r+0x152>
 80024d6:	0107f713          	andi	a4,a5,16
 80024da:	c709                	beqz	a4,80024e4 <_vfiprintf_r+0xce>
 80024dc:	02000713          	li	a4,32
 80024e0:	04e109a3          	sb	a4,83(sp)
 80024e4:	0087f713          	andi	a4,a5,8
 80024e8:	c709                	beqz	a4,80024f2 <_vfiprintf_r+0xdc>
 80024ea:	02b00713          	li	a4,43
 80024ee:	04e109a3          	sb	a4,83(sp)
 80024f2:	00094683          	lbu	a3,0(s2)
 80024f6:	02a00713          	li	a4,42
 80024fa:	06e68f63          	beq	a3,a4,8002578 <_vfiprintf_r+0x162>
 80024fe:	4772                	lw	a4,28(sp)
 8002500:	844a                	mv	s0,s2
 8002502:	4681                	li	a3,0
 8002504:	4625                	li	a2,9
 8002506:	00044783          	lbu	a5,0(s0)
 800250a:	00140593          	addi	a1,s0,1
 800250e:	fd078793          	addi	a5,a5,-48
 8002512:	10f67863          	bgeu	a2,a5,8002622 <_vfiprintf_r+0x20c>
 8002516:	eaa5                	bnez	a3,8002586 <_vfiprintf_r+0x170>
 8002518:	a8bd                	j	8002596 <_vfiprintf_r+0x180>
 800251a:	00001797          	auipc	a5,0x1
 800251e:	e1a78793          	addi	a5,a5,-486 # 8003334 <__sf_fake_stdout>
 8002522:	00f49563          	bne	s1,a5,800252c <_vfiprintf_r+0x116>
 8002526:	0089a483          	lw	s1,8(s3)
 800252a:	b715                	j	800244e <_vfiprintf_r+0x38>
 800252c:	00001797          	auipc	a5,0x1
 8002530:	dc878793          	addi	a5,a5,-568 # 80032f4 <__sf_fake_stderr>
 8002534:	f0f49de3          	bne	s1,a5,800244e <_vfiprintf_r+0x38>
 8002538:	00c9a483          	lw	s1,12(s3)
 800253c:	bf09                	j	800244e <_vfiprintf_r+0x38>
 800253e:	85a6                	mv	a1,s1
 8002540:	854e                	mv	a0,s3
 8002542:	e9aff0ef          	jal	ra,8001bdc <__swsetup_r>
 8002546:	d911                	beqz	a0,800245a <_vfiprintf_r+0x44>
 8002548:	557d                	li	a0,-1
 800254a:	40fa                	lw	ra,156(sp)
 800254c:	446a                	lw	s0,152(sp)
 800254e:	44da                	lw	s1,148(sp)
 8002550:	494a                	lw	s2,144(sp)
 8002552:	49ba                	lw	s3,140(sp)
 8002554:	4a2a                	lw	s4,136(sp)
 8002556:	4a9a                	lw	s5,132(sp)
 8002558:	4b0a                	lw	s6,128(sp)
 800255a:	5bf6                	lw	s7,124(sp)
 800255c:	5c66                	lw	s8,120(sp)
 800255e:	5cd6                	lw	s9,116(sp)
 8002560:	610d                	addi	sp,sp,160
 8002562:	8082                	ret
 8002564:	0405                	addi	s0,s0,1
 8002566:	bf29                	j	8002480 <_vfiprintf_r+0x6a>
 8002568:	41550533          	sub	a0,a0,s5
 800256c:	00ac1533          	sll	a0,s8,a0
 8002570:	8fc9                	or	a5,a5,a0
 8002572:	c83e                	sw	a5,16(sp)
 8002574:	8922                	mv	s2,s0
 8002576:	b7b9                	j	80024c4 <_vfiprintf_r+0xae>
 8002578:	4732                	lw	a4,12(sp)
 800257a:	00470693          	addi	a3,a4,4
 800257e:	4318                	lw	a4,0(a4)
 8002580:	c636                	sw	a3,12(sp)
 8002582:	00074463          	bltz	a4,800258a <_vfiprintf_r+0x174>
 8002586:	ce3a                	sw	a4,28(sp)
 8002588:	a039                	j	8002596 <_vfiprintf_r+0x180>
 800258a:	40e00733          	neg	a4,a4
 800258e:	0027e793          	ori	a5,a5,2
 8002592:	ce3a                	sw	a4,28(sp)
 8002594:	c83e                	sw	a5,16(sp)
 8002596:	00044703          	lbu	a4,0(s0)
 800259a:	02e00793          	li	a5,46
 800259e:	02f71163          	bne	a4,a5,80025c0 <_vfiprintf_r+0x1aa>
 80025a2:	00144703          	lbu	a4,1(s0)
 80025a6:	02a00793          	li	a5,42
 80025aa:	08f71463          	bne	a4,a5,8002632 <_vfiprintf_r+0x21c>
 80025ae:	47b2                	lw	a5,12(sp)
 80025b0:	0409                	addi	s0,s0,2
 80025b2:	00478713          	addi	a4,a5,4
 80025b6:	439c                	lw	a5,0(a5)
 80025b8:	c63a                	sw	a4,12(sp)
 80025ba:	0607ca63          	bltz	a5,800262e <_vfiprintf_r+0x218>
 80025be:	ca3e                	sw	a5,20(sp)
 80025c0:	00044583          	lbu	a1,0(s0)
 80025c4:	460d                	li	a2,3
 80025c6:	00001517          	auipc	a0,0x1
 80025ca:	d9650513          	addi	a0,a0,-618 # 800335c <__sf_fake_stdout+0x28>
 80025ce:	2d05                	jal	8002bfe <memchr>
 80025d0:	cd11                	beqz	a0,80025ec <_vfiprintf_r+0x1d6>
 80025d2:	00001797          	auipc	a5,0x1
 80025d6:	d8a78793          	addi	a5,a5,-630 # 800335c <__sf_fake_stdout+0x28>
 80025da:	8d1d                	sub	a0,a0,a5
 80025dc:	04000793          	li	a5,64
 80025e0:	00a797b3          	sll	a5,a5,a0
 80025e4:	4542                	lw	a0,16(sp)
 80025e6:	0405                	addi	s0,s0,1
 80025e8:	8d5d                	or	a0,a0,a5
 80025ea:	c82a                	sw	a0,16(sp)
 80025ec:	00044583          	lbu	a1,0(s0)
 80025f0:	4619                	li	a2,6
 80025f2:	00001517          	auipc	a0,0x1
 80025f6:	d6e50513          	addi	a0,a0,-658 # 8003360 <__sf_fake_stdout+0x2c>
 80025fa:	00140913          	addi	s2,s0,1
 80025fe:	02b10423          	sb	a1,40(sp)
 8002602:	2bf5                	jal	8002bfe <memchr>
 8002604:	c949                	beqz	a0,8002696 <_vfiprintf_r+0x280>
 8002606:	00000793          	li	a5,0
 800260a:	efb1                	bnez	a5,8002666 <_vfiprintf_r+0x250>
 800260c:	4742                	lw	a4,16(sp)
 800260e:	47b2                	lw	a5,12(sp)
 8002610:	10077713          	andi	a4,a4,256
 8002614:	c729                	beqz	a4,800265e <_vfiprintf_r+0x248>
 8002616:	0791                	addi	a5,a5,4
 8002618:	c63e                	sw	a5,12(sp)
 800261a:	5792                	lw	a5,36(sp)
 800261c:	97d2                	add	a5,a5,s4
 800261e:	d23e                	sw	a5,36(sp)
 8002620:	bdb9                	j	800247e <_vfiprintf_r+0x68>
 8002622:	c56717ff          	maddr32	a5,a4,s6
 8002626:	842e                	mv	s0,a1
 8002628:	873e                	mv	a4,a5
 800262a:	4685                	li	a3,1
 800262c:	bde9                	j	8002506 <_vfiprintf_r+0xf0>
 800262e:	57fd                	li	a5,-1
 8002630:	b779                	j	80025be <_vfiprintf_r+0x1a8>
 8002632:	0405                	addi	s0,s0,1
 8002634:	ca02                	sw	zero,20(sp)
 8002636:	4681                	li	a3,0
 8002638:	4701                	li	a4,0
 800263a:	4625                	li	a2,9
 800263c:	00044783          	lbu	a5,0(s0)
 8002640:	00140593          	addi	a1,s0,1
 8002644:	fd078793          	addi	a5,a5,-48
 8002648:	00f67563          	bgeu	a2,a5,8002652 <_vfiprintf_r+0x23c>
 800264c:	dab5                	beqz	a3,80025c0 <_vfiprintf_r+0x1aa>
 800264e:	ca3a                	sw	a4,20(sp)
 8002650:	bf85                	j	80025c0 <_vfiprintf_r+0x1aa>
 8002652:	c56717ff          	maddr32	a5,a4,s6
 8002656:	842e                	mv	s0,a1
 8002658:	873e                	mv	a4,a5
 800265a:	4685                	li	a3,1
 800265c:	b7c5                	j	800263c <_vfiprintf_r+0x226>
 800265e:	079d                	addi	a5,a5,7
 8002660:	9be1                	andi	a5,a5,-8
 8002662:	07a1                	addi	a5,a5,8
 8002664:	bf55                	j	8002618 <_vfiprintf_r+0x202>
 8002666:	0078                	addi	a4,sp,12
 8002668:	00000697          	auipc	a3,0x0
 800266c:	d6c68693          	addi	a3,a3,-660 # 80023d4 <__sfputs_r>
 8002670:	8626                	mv	a2,s1
 8002672:	080c                	addi	a1,sp,16
 8002674:	854e                	mv	a0,s3
 8002676:	00000097          	auipc	ra,0x0
 800267a:	000000e7          	jalr	zero # 0 <__STACK_SIZE-0x2000>
 800267e:	57fd                	li	a5,-1
 8002680:	8a2a                	mv	s4,a0
 8002682:	f8f51ce3          	bne	a0,a5,800261a <_vfiprintf_r+0x204>
 8002686:	00c4d783          	lhu	a5,12(s1)
 800268a:	0407f793          	andi	a5,a5,64
 800268e:	ea079de3          	bnez	a5,8002548 <_vfiprintf_r+0x132>
 8002692:	5512                	lw	a0,36(sp)
 8002694:	bd5d                	j	800254a <_vfiprintf_r+0x134>
 8002696:	0078                	addi	a4,sp,12
 8002698:	00000697          	auipc	a3,0x0
 800269c:	d3c68693          	addi	a3,a3,-708 # 80023d4 <__sfputs_r>
 80026a0:	8626                	mv	a2,s1
 80026a2:	080c                	addi	a1,sp,16
 80026a4:	854e                	mv	a0,s3
 80026a6:	2a01                	jal	80027b6 <_printf_i>
 80026a8:	bfd9                	j	800267e <_vfiprintf_r+0x268>

080026aa <_printf_common>:
 80026aa:	7179                	addi	sp,sp,-48
 80026ac:	cc52                	sw	s4,24(sp)
 80026ae:	499c                	lw	a5,16(a1)
 80026b0:	8a3a                	mv	s4,a4
 80026b2:	4598                	lw	a4,8(a1)
 80026b4:	d422                	sw	s0,40(sp)
 80026b6:	d226                	sw	s1,36(sp)
 80026b8:	ce4e                	sw	s3,28(sp)
 80026ba:	ca56                	sw	s5,20(sp)
 80026bc:	d606                	sw	ra,44(sp)
 80026be:	d04a                	sw	s2,32(sp)
 80026c0:	c85a                	sw	s6,16(sp)
 80026c2:	c65e                	sw	s7,12(sp)
 80026c4:	89aa                	mv	s3,a0
 80026c6:	842e                	mv	s0,a1
 80026c8:	84b2                	mv	s1,a2
 80026ca:	8ab6                	mv	s5,a3
 80026cc:	00e7d363          	bge	a5,a4,80026d2 <_printf_common+0x28>
 80026d0:	87ba                	mv	a5,a4
 80026d2:	c09c                	sw	a5,0(s1)
 80026d4:	04344703          	lbu	a4,67(s0)
 80026d8:	c319                	beqz	a4,80026de <_printf_common+0x34>
 80026da:	0785                	addi	a5,a5,1
 80026dc:	c09c                	sw	a5,0(s1)
 80026de:	401c                	lw	a5,0(s0)
 80026e0:	0207f793          	andi	a5,a5,32
 80026e4:	c781                	beqz	a5,80026ec <_printf_common+0x42>
 80026e6:	409c                	lw	a5,0(s1)
 80026e8:	0789                	addi	a5,a5,2
 80026ea:	c09c                	sw	a5,0(s1)
 80026ec:	00042903          	lw	s2,0(s0)
 80026f0:	00697913          	andi	s2,s2,6
 80026f4:	00091a63          	bnez	s2,8002708 <_printf_common+0x5e>
 80026f8:	01940b13          	addi	s6,s0,25
 80026fc:	5bfd                	li	s7,-1
 80026fe:	445c                	lw	a5,12(s0)
 8002700:	4098                	lw	a4,0(s1)
 8002702:	8f99                	sub	a5,a5,a4
 8002704:	04f94c63          	blt	s2,a5,800275c <_printf_common+0xb2>
 8002708:	04344783          	lbu	a5,67(s0)
 800270c:	00f036b3          	snez	a3,a5
 8002710:	401c                	lw	a5,0(s0)
 8002712:	0207f793          	andi	a5,a5,32
 8002716:	eba5                	bnez	a5,8002786 <_printf_common+0xdc>
 8002718:	04340613          	addi	a2,s0,67
 800271c:	85d6                	mv	a1,s5
 800271e:	854e                	mv	a0,s3
 8002720:	9a02                	jalr	s4
 8002722:	57fd                	li	a5,-1
 8002724:	04f50363          	beq	a0,a5,800276a <_printf_common+0xc0>
 8002728:	401c                	lw	a5,0(s0)
 800272a:	4611                	li	a2,4
 800272c:	4098                	lw	a4,0(s1)
 800272e:	8b99                	andi	a5,a5,6
 8002730:	4454                	lw	a3,12(s0)
 8002732:	4481                	li	s1,0
 8002734:	00c79763          	bne	a5,a2,8002742 <_printf_common+0x98>
 8002738:	40e684b3          	sub	s1,a3,a4
 800273c:	0004d363          	bgez	s1,8002742 <_printf_common+0x98>
 8002740:	4481                	li	s1,0
 8002742:	441c                	lw	a5,8(s0)
 8002744:	4818                	lw	a4,16(s0)
 8002746:	00f75463          	bge	a4,a5,800274e <_printf_common+0xa4>
 800274a:	8f99                	sub	a5,a5,a4
 800274c:	94be                	add	s1,s1,a5
 800274e:	4901                	li	s2,0
 8002750:	0469                	addi	s0,s0,26
 8002752:	5b7d                	li	s6,-1
 8002754:	05249863          	bne	s1,s2,80027a4 <_printf_common+0xfa>
 8002758:	4501                	li	a0,0
 800275a:	a809                	j	800276c <_printf_common+0xc2>
 800275c:	4685                	li	a3,1
 800275e:	865a                	mv	a2,s6
 8002760:	85d6                	mv	a1,s5
 8002762:	854e                	mv	a0,s3
 8002764:	9a02                	jalr	s4
 8002766:	01751e63          	bne	a0,s7,8002782 <_printf_common+0xd8>
 800276a:	557d                	li	a0,-1
 800276c:	50b2                	lw	ra,44(sp)
 800276e:	5422                	lw	s0,40(sp)
 8002770:	5492                	lw	s1,36(sp)
 8002772:	5902                	lw	s2,32(sp)
 8002774:	49f2                	lw	s3,28(sp)
 8002776:	4a62                	lw	s4,24(sp)
 8002778:	4ad2                	lw	s5,20(sp)
 800277a:	4b42                	lw	s6,16(sp)
 800277c:	4bb2                	lw	s7,12(sp)
 800277e:	6145                	addi	sp,sp,48
 8002780:	8082                	ret
 8002782:	0905                	addi	s2,s2,1
 8002784:	bfad                	j	80026fe <_printf_common+0x54>
 8002786:	00d40733          	add	a4,s0,a3
 800278a:	03000613          	li	a2,48
 800278e:	04c701a3          	sb	a2,67(a4)
 8002792:	04544703          	lbu	a4,69(s0)
 8002796:	00168793          	addi	a5,a3,1
 800279a:	97a2                	add	a5,a5,s0
 800279c:	0689                	addi	a3,a3,2
 800279e:	04e781a3          	sb	a4,67(a5)
 80027a2:	bf9d                	j	8002718 <_printf_common+0x6e>
 80027a4:	4685                	li	a3,1
 80027a6:	8622                	mv	a2,s0
 80027a8:	85d6                	mv	a1,s5
 80027aa:	854e                	mv	a0,s3
 80027ac:	9a02                	jalr	s4
 80027ae:	fb650ee3          	beq	a0,s6,800276a <_printf_common+0xc0>
 80027b2:	0905                	addi	s2,s2,1
 80027b4:	b745                	j	8002754 <_printf_common+0xaa>

080027b6 <_printf_i>:
 80027b6:	7179                	addi	sp,sp,-48
 80027b8:	d422                	sw	s0,40(sp)
 80027ba:	d226                	sw	s1,36(sp)
 80027bc:	d04a                	sw	s2,32(sp)
 80027be:	ce4e                	sw	s3,28(sp)
 80027c0:	d606                	sw	ra,44(sp)
 80027c2:	cc52                	sw	s4,24(sp)
 80027c4:	ca56                	sw	s5,20(sp)
 80027c6:	c85a                	sw	s6,16(sp)
 80027c8:	0185c803          	lbu	a6,24(a1)
 80027cc:	07800793          	li	a5,120
 80027d0:	84aa                	mv	s1,a0
 80027d2:	842e                	mv	s0,a1
 80027d4:	8932                	mv	s2,a2
 80027d6:	89b6                	mv	s3,a3
 80027d8:	0107ee63          	bltu	a5,a6,80027f4 <_printf_i+0x3e>
 80027dc:	06200793          	li	a5,98
 80027e0:	04358693          	addi	a3,a1,67
 80027e4:	0107ed63          	bltu	a5,a6,80027fe <_printf_i+0x48>
 80027e8:	1c080563          	beqz	a6,80029b2 <_printf_i+0x1fc>
 80027ec:	05800793          	li	a5,88
 80027f0:	12f80a63          	beq	a6,a5,8002924 <_printf_i+0x16e>
 80027f4:	04240a93          	addi	s5,s0,66
 80027f8:	05040123          	sb	a6,66(s0)
 80027fc:	a815                	j	8002830 <_printf_i+0x7a>
 80027fe:	f9d80793          	addi	a5,a6,-99
 8002802:	0ff7f793          	zext.b	a5,a5
 8002806:	4655                	li	a2,21
 8002808:	fef666e3          	bltu	a2,a5,80027f4 <_printf_i+0x3e>
 800280c:	00001617          	auipc	a2,0x1
 8002810:	b8460613          	addi	a2,a2,-1148 # 8003390 <__sf_fake_stdout+0x5c>
 8002814:	078a                	slli	a5,a5,0x2
 8002816:	97b2                	add	a5,a5,a2
 8002818:	439c                	lw	a5,0(a5)
 800281a:	97b2                	add	a5,a5,a2
 800281c:	8782                	jr	a5
 800281e:	431c                	lw	a5,0(a4)
 8002820:	04258a93          	addi	s5,a1,66
 8002824:	00478693          	addi	a3,a5,4
 8002828:	439c                	lw	a5,0(a5)
 800282a:	c314                	sw	a3,0(a4)
 800282c:	04f58123          	sb	a5,66(a1)
 8002830:	4785                	li	a5,1
 8002832:	a25d                	j	80029d8 <_printf_i+0x222>
 8002834:	419c                	lw	a5,0(a1)
 8002836:	4308                	lw	a0,0(a4)
 8002838:	0807f613          	andi	a2,a5,128
 800283c:	00450593          	addi	a1,a0,4
 8002840:	c20d                	beqz	a2,8002862 <_printf_i+0xac>
 8002842:	411c                	lw	a5,0(a0)
 8002844:	c30c                	sw	a1,0(a4)
 8002846:	0007d863          	bgez	a5,8002856 <_printf_i+0xa0>
 800284a:	02d00713          	li	a4,45
 800284e:	40f007b3          	neg	a5,a5
 8002852:	04e401a3          	sb	a4,67(s0)
 8002856:	00001617          	auipc	a2,0x1
 800285a:	b1260613          	addi	a2,a2,-1262 # 8003368 <__sf_fake_stdout+0x34>
 800285e:	4829                	li	a6,10
 8002860:	a0a1                	j	80028a8 <_printf_i+0xf2>
 8002862:	0407f613          	andi	a2,a5,64
 8002866:	411c                	lw	a5,0(a0)
 8002868:	c30c                	sw	a1,0(a4)
 800286a:	de71                	beqz	a2,8002846 <_printf_i+0x90>
 800286c:	07c2                	slli	a5,a5,0x10
 800286e:	87c1                	srai	a5,a5,0x10
 8002870:	bfd9                	j	8002846 <_printf_i+0x90>
 8002872:	4190                	lw	a2,0(a1)
 8002874:	431c                	lw	a5,0(a4)
 8002876:	08067513          	andi	a0,a2,128
 800287a:	00478593          	addi	a1,a5,4
 800287e:	c501                	beqz	a0,8002886 <_printf_i+0xd0>
 8002880:	c30c                	sw	a1,0(a4)
 8002882:	439c                	lw	a5,0(a5)
 8002884:	a039                	j	8002892 <_printf_i+0xdc>
 8002886:	04067613          	andi	a2,a2,64
 800288a:	c30c                	sw	a1,0(a4)
 800288c:	da7d                	beqz	a2,8002882 <_printf_i+0xcc>
 800288e:	0007d783          	lhu	a5,0(a5)
 8002892:	06f00713          	li	a4,111
 8002896:	00001617          	auipc	a2,0x1
 800289a:	ad260613          	addi	a2,a2,-1326 # 8003368 <__sf_fake_stdout+0x34>
 800289e:	0ee80463          	beq	a6,a4,8002986 <_printf_i+0x1d0>
 80028a2:	4829                	li	a6,10
 80028a4:	040401a3          	sb	zero,67(s0)
 80028a8:	4058                	lw	a4,4(s0)
 80028aa:	c418                	sw	a4,8(s0)
 80028ac:	00074563          	bltz	a4,80028b6 <_printf_i+0x100>
 80028b0:	400c                	lw	a1,0(s0)
 80028b2:	99ed                	andi	a1,a1,-5
 80028b4:	c00c                	sw	a1,0(s0)
 80028b6:	e399                	bnez	a5,80028bc <_printf_i+0x106>
 80028b8:	8ab6                	mv	s5,a3
 80028ba:	cf19                	beqz	a4,80028d8 <_printf_i+0x122>
 80028bc:	8ab6                	mv	s5,a3
 80028be:	0307f733          	remu	a4,a5,a6
 80028c2:	1afd                	addi	s5,s5,-1
 80028c4:	9732                	add	a4,a4,a2
 80028c6:	00074703          	lbu	a4,0(a4)
 80028ca:	00ea8023          	sb	a4,0(s5)
 80028ce:	873e                	mv	a4,a5
 80028d0:	0307d7b3          	divu	a5,a5,a6
 80028d4:	ff0775e3          	bgeu	a4,a6,80028be <_printf_i+0x108>
 80028d8:	47a1                	li	a5,8
 80028da:	00f81e63          	bne	a6,a5,80028f6 <_printf_i+0x140>
 80028de:	401c                	lw	a5,0(s0)
 80028e0:	8b85                	andi	a5,a5,1
 80028e2:	cb91                	beqz	a5,80028f6 <_printf_i+0x140>
 80028e4:	4058                	lw	a4,4(s0)
 80028e6:	481c                	lw	a5,16(s0)
 80028e8:	00e7c763          	blt	a5,a4,80028f6 <_printf_i+0x140>
 80028ec:	03000793          	li	a5,48
 80028f0:	fefa8fa3          	sb	a5,-1(s5)
 80028f4:	1afd                	addi	s5,s5,-1
 80028f6:	415686b3          	sub	a3,a3,s5
 80028fa:	c814                	sw	a3,16(s0)
 80028fc:	874e                	mv	a4,s3
 80028fe:	86ca                	mv	a3,s2
 8002900:	0070                	addi	a2,sp,12
 8002902:	85a2                	mv	a1,s0
 8002904:	8526                	mv	a0,s1
 8002906:	3355                	jal	80026aa <_printf_common>
 8002908:	5a7d                	li	s4,-1
 800290a:	0d451b63          	bne	a0,s4,80029e0 <_printf_i+0x22a>
 800290e:	557d                	li	a0,-1
 8002910:	50b2                	lw	ra,44(sp)
 8002912:	5422                	lw	s0,40(sp)
 8002914:	5492                	lw	s1,36(sp)
 8002916:	5902                	lw	s2,32(sp)
 8002918:	49f2                	lw	s3,28(sp)
 800291a:	4a62                	lw	s4,24(sp)
 800291c:	4ad2                	lw	s5,20(sp)
 800291e:	4b42                	lw	s6,16(sp)
 8002920:	6145                	addi	sp,sp,48
 8002922:	8082                	ret
 8002924:	050582a3          	sb	a6,69(a1)
 8002928:	00001617          	auipc	a2,0x1
 800292c:	a4060613          	addi	a2,a2,-1472 # 8003368 <__sf_fake_stdout+0x34>
 8002930:	400c                	lw	a1,0(s0)
 8002932:	4308                	lw	a0,0(a4)
 8002934:	0805f813          	andi	a6,a1,128
 8002938:	411c                	lw	a5,0(a0)
 800293a:	0511                	addi	a0,a0,4
 800293c:	02080d63          	beqz	a6,8002976 <_printf_i+0x1c0>
 8002940:	c308                	sw	a0,0(a4)
 8002942:	0015f713          	andi	a4,a1,1
 8002946:	c701                	beqz	a4,800294e <_printf_i+0x198>
 8002948:	0205e593          	ori	a1,a1,32
 800294c:	c00c                	sw	a1,0(s0)
 800294e:	4841                	li	a6,16
 8002950:	fbb1                	bnez	a5,80028a4 <_printf_i+0xee>
 8002952:	4018                	lw	a4,0(s0)
 8002954:	fdf77713          	andi	a4,a4,-33
 8002958:	c018                	sw	a4,0(s0)
 800295a:	b7a9                	j	80028a4 <_printf_i+0xee>
 800295c:	419c                	lw	a5,0(a1)
 800295e:	0207e793          	ori	a5,a5,32
 8002962:	c19c                	sw	a5,0(a1)
 8002964:	07800793          	li	a5,120
 8002968:	04f402a3          	sb	a5,69(s0)
 800296c:	00001617          	auipc	a2,0x1
 8002970:	a1060613          	addi	a2,a2,-1520 # 800337c <__sf_fake_stdout+0x48>
 8002974:	bf75                	j	8002930 <_printf_i+0x17a>
 8002976:	0405f813          	andi	a6,a1,64
 800297a:	c308                	sw	a0,0(a4)
 800297c:	fc0803e3          	beqz	a6,8002942 <_printf_i+0x18c>
 8002980:	07c2                	slli	a5,a5,0x10
 8002982:	83c1                	srli	a5,a5,0x10
 8002984:	bf7d                	j	8002942 <_printf_i+0x18c>
 8002986:	4821                	li	a6,8
 8002988:	bf31                	j	80028a4 <_printf_i+0xee>
 800298a:	4190                	lw	a2,0(a1)
 800298c:	431c                	lw	a5,0(a4)
 800298e:	49cc                	lw	a1,20(a1)
 8002990:	08067813          	andi	a6,a2,128
 8002994:	00478513          	addi	a0,a5,4
 8002998:	00080663          	beqz	a6,80029a4 <_printf_i+0x1ee>
 800299c:	c308                	sw	a0,0(a4)
 800299e:	439c                	lw	a5,0(a5)
 80029a0:	c38c                	sw	a1,0(a5)
 80029a2:	a801                	j	80029b2 <_printf_i+0x1fc>
 80029a4:	c308                	sw	a0,0(a4)
 80029a6:	04067613          	andi	a2,a2,64
 80029aa:	439c                	lw	a5,0(a5)
 80029ac:	da75                	beqz	a2,80029a0 <_printf_i+0x1ea>
 80029ae:	00b79023          	sh	a1,0(a5)
 80029b2:	00042823          	sw	zero,16(s0)
 80029b6:	8ab6                	mv	s5,a3
 80029b8:	b791                	j	80028fc <_printf_i+0x146>
 80029ba:	431c                	lw	a5,0(a4)
 80029bc:	41d0                	lw	a2,4(a1)
 80029be:	4581                	li	a1,0
 80029c0:	00478693          	addi	a3,a5,4
 80029c4:	c314                	sw	a3,0(a4)
 80029c6:	0007aa83          	lw	s5,0(a5)
 80029ca:	8556                	mv	a0,s5
 80029cc:	2c0d                	jal	8002bfe <memchr>
 80029ce:	c501                	beqz	a0,80029d6 <_printf_i+0x220>
 80029d0:	41550533          	sub	a0,a0,s5
 80029d4:	c048                	sw	a0,4(s0)
 80029d6:	405c                	lw	a5,4(s0)
 80029d8:	c81c                	sw	a5,16(s0)
 80029da:	040401a3          	sb	zero,67(s0)
 80029de:	bf39                	j	80028fc <_printf_i+0x146>
 80029e0:	4814                	lw	a3,16(s0)
 80029e2:	8656                	mv	a2,s5
 80029e4:	85ca                	mv	a1,s2
 80029e6:	8526                	mv	a0,s1
 80029e8:	9982                	jalr	s3
 80029ea:	f34502e3          	beq	a0,s4,800290e <_printf_i+0x158>
 80029ee:	401c                	lw	a5,0(s0)
 80029f0:	8b89                	andi	a5,a5,2
 80029f2:	e78d                	bnez	a5,8002a1c <_printf_i+0x266>
 80029f4:	47b2                	lw	a5,12(sp)
 80029f6:	4448                	lw	a0,12(s0)
 80029f8:	f0f55ce3          	bge	a0,a5,8002910 <_printf_i+0x15a>
 80029fc:	853e                	mv	a0,a5
 80029fe:	bf09                	j	8002910 <_printf_i+0x15a>
 8002a00:	4685                	li	a3,1
 8002a02:	8656                	mv	a2,s5
 8002a04:	85ca                	mv	a1,s2
 8002a06:	8526                	mv	a0,s1
 8002a08:	9982                	jalr	s3
 8002a0a:	f16502e3          	beq	a0,s6,800290e <_printf_i+0x158>
 8002a0e:	0a05                	addi	s4,s4,1
 8002a10:	445c                	lw	a5,12(s0)
 8002a12:	4732                	lw	a4,12(sp)
 8002a14:	8f99                	sub	a5,a5,a4
 8002a16:	fefa45e3          	blt	s4,a5,8002a00 <_printf_i+0x24a>
 8002a1a:	bfe9                	j	80029f4 <_printf_i+0x23e>
 8002a1c:	4a01                	li	s4,0
 8002a1e:	01940a93          	addi	s5,s0,25
 8002a22:	5b7d                	li	s6,-1
 8002a24:	b7f5                	j	8002a10 <_printf_i+0x25a>

08002a26 <_sbrk_r>:
 8002a26:	1141                	addi	sp,sp,-16
 8002a28:	c422                	sw	s0,8(sp)
 8002a2a:	842a                	mv	s0,a0
 8002a2c:	852e                	mv	a0,a1
 8002a2e:	17ffd797          	auipc	a5,0x17ffd
 8002a32:	6407a723          	sw	zero,1614(a5) # 2000007c <errno>
 8002a36:	c606                	sw	ra,12(sp)
 8002a38:	249d                	jal	8002c9e <_sbrk>
 8002a3a:	57fd                	li	a5,-1
 8002a3c:	00f51863          	bne	a0,a5,8002a4c <_sbrk_r+0x26>
 8002a40:	17ffd797          	auipc	a5,0x17ffd
 8002a44:	63c7a783          	lw	a5,1596(a5) # 2000007c <errno>
 8002a48:	c391                	beqz	a5,8002a4c <_sbrk_r+0x26>
 8002a4a:	c01c                	sw	a5,0(s0)
 8002a4c:	40b2                	lw	ra,12(sp)
 8002a4e:	4422                	lw	s0,8(sp)
 8002a50:	0141                	addi	sp,sp,16
 8002a52:	8082                	ret

08002a54 <__sread>:
 8002a54:	1141                	addi	sp,sp,-16
 8002a56:	c422                	sw	s0,8(sp)
 8002a58:	842e                	mv	s0,a1
 8002a5a:	00e59583          	lh	a1,14(a1)
 8002a5e:	c606                	sw	ra,12(sp)
 8002a60:	2a75                	jal	8002c1c <_read_r>
 8002a62:	00054963          	bltz	a0,8002a74 <__sread+0x20>
 8002a66:	487c                	lw	a5,84(s0)
 8002a68:	97aa                	add	a5,a5,a0
 8002a6a:	c87c                	sw	a5,84(s0)
 8002a6c:	40b2                	lw	ra,12(sp)
 8002a6e:	4422                	lw	s0,8(sp)
 8002a70:	0141                	addi	sp,sp,16
 8002a72:	8082                	ret
 8002a74:	00c45783          	lhu	a5,12(s0)
 8002a78:	777d                	lui	a4,0xfffff
 8002a7a:	177d                	addi	a4,a4,-1
 8002a7c:	8ff9                	and	a5,a5,a4
 8002a7e:	00f41623          	sh	a5,12(s0)
 8002a82:	b7ed                	j	8002a6c <__sread+0x18>

08002a84 <__swrite>:
 8002a84:	00c5d783          	lhu	a5,12(a1)
 8002a88:	1101                	addi	sp,sp,-32
 8002a8a:	cc22                	sw	s0,24(sp)
 8002a8c:	ca26                	sw	s1,20(sp)
 8002a8e:	c84a                	sw	s2,16(sp)
 8002a90:	c64e                	sw	s3,12(sp)
 8002a92:	ce06                	sw	ra,28(sp)
 8002a94:	1007f793          	andi	a5,a5,256
 8002a98:	84aa                	mv	s1,a0
 8002a9a:	842e                	mv	s0,a1
 8002a9c:	8932                	mv	s2,a2
 8002a9e:	89b6                	mv	s3,a3
 8002aa0:	c791                	beqz	a5,8002aac <__swrite+0x28>
 8002aa2:	00e59583          	lh	a1,14(a1)
 8002aa6:	4689                	li	a3,2
 8002aa8:	4601                	li	a2,0
 8002aaa:	220d                	jal	8002bcc <_lseek_r>
 8002aac:	00c45783          	lhu	a5,12(s0)
 8002ab0:	777d                	lui	a4,0xfffff
 8002ab2:	177d                	addi	a4,a4,-1
 8002ab4:	8ff9                	and	a5,a5,a4
 8002ab6:	00e41583          	lh	a1,14(s0)
 8002aba:	00f41623          	sh	a5,12(s0)
 8002abe:	4462                	lw	s0,24(sp)
 8002ac0:	40f2                	lw	ra,28(sp)
 8002ac2:	86ce                	mv	a3,s3
 8002ac4:	864a                	mv	a2,s2
 8002ac6:	49b2                	lw	s3,12(sp)
 8002ac8:	4942                	lw	s2,16(sp)
 8002aca:	8526                	mv	a0,s1
 8002acc:	44d2                	lw	s1,20(sp)
 8002ace:	6105                	addi	sp,sp,32
 8002ad0:	a83d                	j	8002b0e <_write_r>

08002ad2 <__sseek>:
 8002ad2:	1141                	addi	sp,sp,-16
 8002ad4:	c422                	sw	s0,8(sp)
 8002ad6:	842e                	mv	s0,a1
 8002ad8:	00e59583          	lh	a1,14(a1)
 8002adc:	c606                	sw	ra,12(sp)
 8002ade:	20fd                	jal	8002bcc <_lseek_r>
 8002ae0:	57fd                	li	a5,-1
 8002ae2:	00c45703          	lhu	a4,12(s0)
 8002ae6:	00f51b63          	bne	a0,a5,8002afc <__sseek+0x2a>
 8002aea:	77fd                	lui	a5,0xfffff
 8002aec:	17fd                	addi	a5,a5,-1
 8002aee:	8ff9                	and	a5,a5,a4
 8002af0:	00f41623          	sh	a5,12(s0)
 8002af4:	40b2                	lw	ra,12(sp)
 8002af6:	4422                	lw	s0,8(sp)
 8002af8:	0141                	addi	sp,sp,16
 8002afa:	8082                	ret
 8002afc:	6785                	lui	a5,0x1
 8002afe:	8fd9                	or	a5,a5,a4
 8002b00:	00f41623          	sh	a5,12(s0)
 8002b04:	c868                	sw	a0,84(s0)
 8002b06:	b7fd                	j	8002af4 <__sseek+0x22>

08002b08 <__sclose>:
 8002b08:	00e59583          	lh	a1,14(a1)
 8002b0c:	a815                	j	8002b40 <_close_r>

08002b0e <_write_r>:
 8002b0e:	1141                	addi	sp,sp,-16
 8002b10:	c422                	sw	s0,8(sp)
 8002b12:	842a                	mv	s0,a0
 8002b14:	852e                	mv	a0,a1
 8002b16:	85b2                	mv	a1,a2
 8002b18:	8636                	mv	a2,a3
 8002b1a:	17ffd797          	auipc	a5,0x17ffd
 8002b1e:	5607a123          	sw	zero,1378(a5) # 2000007c <errno>
 8002b22:	c606                	sw	ra,12(sp)
 8002b24:	2a69                	jal	8002cbe <_write>
 8002b26:	57fd                	li	a5,-1
 8002b28:	00f51863          	bne	a0,a5,8002b38 <_write_r+0x2a>
 8002b2c:	17ffd797          	auipc	a5,0x17ffd
 8002b30:	5507a783          	lw	a5,1360(a5) # 2000007c <errno>
 8002b34:	c391                	beqz	a5,8002b38 <_write_r+0x2a>
 8002b36:	c01c                	sw	a5,0(s0)
 8002b38:	40b2                	lw	ra,12(sp)
 8002b3a:	4422                	lw	s0,8(sp)
 8002b3c:	0141                	addi	sp,sp,16
 8002b3e:	8082                	ret

08002b40 <_close_r>:
 8002b40:	1141                	addi	sp,sp,-16
 8002b42:	c422                	sw	s0,8(sp)
 8002b44:	842a                	mv	s0,a0
 8002b46:	852e                	mv	a0,a1
 8002b48:	17ffd797          	auipc	a5,0x17ffd
 8002b4c:	5207aa23          	sw	zero,1332(a5) # 2000007c <errno>
 8002b50:	c606                	sw	ra,12(sp)
 8002b52:	28f5                	jal	8002c4e <_close>
 8002b54:	57fd                	li	a5,-1
 8002b56:	00f51863          	bne	a0,a5,8002b66 <_close_r+0x26>
 8002b5a:	17ffd797          	auipc	a5,0x17ffd
 8002b5e:	5227a783          	lw	a5,1314(a5) # 2000007c <errno>
 8002b62:	c391                	beqz	a5,8002b66 <_close_r+0x26>
 8002b64:	c01c                	sw	a5,0(s0)
 8002b66:	40b2                	lw	ra,12(sp)
 8002b68:	4422                	lw	s0,8(sp)
 8002b6a:	0141                	addi	sp,sp,16
 8002b6c:	8082                	ret

08002b6e <_fstat_r>:
 8002b6e:	1141                	addi	sp,sp,-16
 8002b70:	c422                	sw	s0,8(sp)
 8002b72:	842a                	mv	s0,a0
 8002b74:	852e                	mv	a0,a1
 8002b76:	85b2                	mv	a1,a2
 8002b78:	17ffd797          	auipc	a5,0x17ffd
 8002b7c:	5007a223          	sw	zero,1284(a5) # 2000007c <errno>
 8002b80:	c606                	sw	ra,12(sp)
 8002b82:	28f1                	jal	8002c5e <_fstat>
 8002b84:	57fd                	li	a5,-1
 8002b86:	00f51863          	bne	a0,a5,8002b96 <_fstat_r+0x28>
 8002b8a:	17ffd797          	auipc	a5,0x17ffd
 8002b8e:	4f27a783          	lw	a5,1266(a5) # 2000007c <errno>
 8002b92:	c391                	beqz	a5,8002b96 <_fstat_r+0x28>
 8002b94:	c01c                	sw	a5,0(s0)
 8002b96:	40b2                	lw	ra,12(sp)
 8002b98:	4422                	lw	s0,8(sp)
 8002b9a:	0141                	addi	sp,sp,16
 8002b9c:	8082                	ret

08002b9e <_isatty_r>:
 8002b9e:	1141                	addi	sp,sp,-16
 8002ba0:	c422                	sw	s0,8(sp)
 8002ba2:	842a                	mv	s0,a0
 8002ba4:	852e                	mv	a0,a1
 8002ba6:	17ffd797          	auipc	a5,0x17ffd
 8002baa:	4c07ab23          	sw	zero,1238(a5) # 2000007c <errno>
 8002bae:	c606                	sw	ra,12(sp)
 8002bb0:	287d                	jal	8002c6e <_isatty>
 8002bb2:	57fd                	li	a5,-1
 8002bb4:	00f51863          	bne	a0,a5,8002bc4 <_isatty_r+0x26>
 8002bb8:	17ffd797          	auipc	a5,0x17ffd
 8002bbc:	4c47a783          	lw	a5,1220(a5) # 2000007c <errno>
 8002bc0:	c391                	beqz	a5,8002bc4 <_isatty_r+0x26>
 8002bc2:	c01c                	sw	a5,0(s0)
 8002bc4:	40b2                	lw	ra,12(sp)
 8002bc6:	4422                	lw	s0,8(sp)
 8002bc8:	0141                	addi	sp,sp,16
 8002bca:	8082                	ret

08002bcc <_lseek_r>:
 8002bcc:	1141                	addi	sp,sp,-16
 8002bce:	c422                	sw	s0,8(sp)
 8002bd0:	842a                	mv	s0,a0
 8002bd2:	852e                	mv	a0,a1
 8002bd4:	85b2                	mv	a1,a2
 8002bd6:	8636                	mv	a2,a3
 8002bd8:	17ffd797          	auipc	a5,0x17ffd
 8002bdc:	4a07a223          	sw	zero,1188(a5) # 2000007c <errno>
 8002be0:	c606                	sw	ra,12(sp)
 8002be2:	2871                	jal	8002c7e <_lseek>
 8002be4:	57fd                	li	a5,-1
 8002be6:	00f51863          	bne	a0,a5,8002bf6 <_lseek_r+0x2a>
 8002bea:	17ffd797          	auipc	a5,0x17ffd
 8002bee:	4927a783          	lw	a5,1170(a5) # 2000007c <errno>
 8002bf2:	c391                	beqz	a5,8002bf6 <_lseek_r+0x2a>
 8002bf4:	c01c                	sw	a5,0(s0)
 8002bf6:	40b2                	lw	ra,12(sp)
 8002bf8:	4422                	lw	s0,8(sp)
 8002bfa:	0141                	addi	sp,sp,16
 8002bfc:	8082                	ret

08002bfe <memchr>:
 8002bfe:	0ff5f593          	zext.b	a1,a1
 8002c02:	962a                	add	a2,a2,a0
 8002c04:	00c51463          	bne	a0,a2,8002c0c <memchr+0xe>
 8002c08:	4501                	li	a0,0
 8002c0a:	8082                	ret
 8002c0c:	00054783          	lbu	a5,0(a0)
 8002c10:	feb78de3          	beq	a5,a1,8002c0a <memchr+0xc>
 8002c14:	0505                	addi	a0,a0,1
 8002c16:	b7fd                	j	8002c04 <memchr+0x6>

08002c18 <__malloc_lock>:
 8002c18:	8082                	ret

08002c1a <__malloc_unlock>:
 8002c1a:	8082                	ret

08002c1c <_read_r>:
 8002c1c:	1141                	addi	sp,sp,-16
 8002c1e:	c422                	sw	s0,8(sp)
 8002c20:	842a                	mv	s0,a0
 8002c22:	852e                	mv	a0,a1
 8002c24:	85b2                	mv	a1,a2
 8002c26:	8636                	mv	a2,a3
 8002c28:	17ffd797          	auipc	a5,0x17ffd
 8002c2c:	4407aa23          	sw	zero,1108(a5) # 2000007c <errno>
 8002c30:	c606                	sw	ra,12(sp)
 8002c32:	28b1                	jal	8002c8e <_read>
 8002c34:	57fd                	li	a5,-1
 8002c36:	00f51863          	bne	a0,a5,8002c46 <_read_r+0x2a>
 8002c3a:	17ffd797          	auipc	a5,0x17ffd
 8002c3e:	4427a783          	lw	a5,1090(a5) # 2000007c <errno>
 8002c42:	c391                	beqz	a5,8002c46 <_read_r+0x2a>
 8002c44:	c01c                	sw	a5,0(s0)
 8002c46:	40b2                	lw	ra,12(sp)
 8002c48:	4422                	lw	s0,8(sp)
 8002c4a:	0141                	addi	sp,sp,16
 8002c4c:	8082                	ret

08002c4e <_close>:
 8002c4e:	05800793          	li	a5,88
 8002c52:	17ffd717          	auipc	a4,0x17ffd
 8002c56:	42f72523          	sw	a5,1066(a4) # 2000007c <errno>
 8002c5a:	557d                	li	a0,-1
 8002c5c:	8082                	ret

08002c5e <_fstat>:
 8002c5e:	05800793          	li	a5,88
 8002c62:	17ffd717          	auipc	a4,0x17ffd
 8002c66:	40f72d23          	sw	a5,1050(a4) # 2000007c <errno>
 8002c6a:	557d                	li	a0,-1
 8002c6c:	8082                	ret

08002c6e <_isatty>:
 8002c6e:	05800793          	li	a5,88
 8002c72:	17ffd717          	auipc	a4,0x17ffd
 8002c76:	40f72523          	sw	a5,1034(a4) # 2000007c <errno>
 8002c7a:	4501                	li	a0,0
 8002c7c:	8082                	ret

08002c7e <_lseek>:
 8002c7e:	05800793          	li	a5,88
 8002c82:	17ffd717          	auipc	a4,0x17ffd
 8002c86:	3ef72d23          	sw	a5,1018(a4) # 2000007c <errno>
 8002c8a:	557d                	li	a0,-1
 8002c8c:	8082                	ret

08002c8e <_read>:
 8002c8e:	05800793          	li	a5,88
 8002c92:	17ffd717          	auipc	a4,0x17ffd
 8002c96:	3ef72523          	sw	a5,1002(a4) # 2000007c <errno>
 8002c9a:	557d                	li	a0,-1
 8002c9c:	8082                	ret

08002c9e <_sbrk>:
 8002c9e:	17ffd717          	auipc	a4,0x17ffd
 8002ca2:	3e270713          	addi	a4,a4,994 # 20000080 <heap_end.0>
 8002ca6:	431c                	lw	a5,0(a4)
 8002ca8:	c789                	beqz	a5,8002cb2 <_sbrk+0x14>
 8002caa:	953e                	add	a0,a0,a5
 8002cac:	c308                	sw	a0,0(a4)
 8002cae:	853e                	mv	a0,a5
 8002cb0:	8082                	ret
 8002cb2:	90018793          	addi	a5,gp,-1792 # 20000160 <_end>
 8002cb6:	953e                	add	a0,a0,a5
 8002cb8:	c308                	sw	a0,0(a4)
 8002cba:	853e                	mv	a0,a5
 8002cbc:	8082                	ret

08002cbe <_write>:
 8002cbe:	05800793          	li	a5,88
 8002cc2:	17ffd717          	auipc	a4,0x17ffd
 8002cc6:	3af72d23          	sw	a5,954(a4) # 2000007c <errno>
 8002cca:	557d                	li	a0,-1
 8002ccc:	8082                	ret
