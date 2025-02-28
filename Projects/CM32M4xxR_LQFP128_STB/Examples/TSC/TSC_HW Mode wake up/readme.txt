1、功能说明
    1、配置两个触摸按键为硬件检测模式，MCU依次进入SLEEP、STOP0、STOP2模式，可通过任意触摸按键唤醒。

2、使用环境

	/* 软件开发环境：当前工程使用的软件工具名称及版本号 */
    IDE工具：NucleiStudio IDE for C/C++ 2021-02
	
	/* 开发板 */
	CM32M4xxR_LQFP128_STB

3、使用说明
    
    系统配置；
        1、时钟源：HSE+PLL
        2、系统时钟：16MHz
		3、TSC/RTC时钟：LSI 40KHz
        4、TSC端口：
            PA4:CH0     PA5:CH0 
        4、LED控制端口：PB0、PB1、PB2

    使用方法：
        1、编译后烧录到全功能板，通电，D4闪烁一次，然后三个灯全部闪烁一次后进行SLEEP模式
        2、按下任意触摸按键，唤醒MCU，D4闪烁一次后，进入STOP0模式
        3、按下任意触摸按键，唤醒MCU，D5闪烁一次后，进入STOP2模式
        4、按下任意触摸按键，唤醒MCU，D6闪烁一次，然后三个灯全部闪烁一次后再次进入SLEEP模式
        
4、注意事项
    1、SW4和SW5位置不能焊接实体按键。
	2、如需要进行程序调试，请在main.h中打开TSC_LOWPOWER_DEBUG宏，打开以后，程序不会进入真正的休眠模式。
	3、当三个灯亮起时，程序正在进行触摸按键校准，请不要触碰任何触摸按键。
	4、进入stop2模式之前需要将关键数据存放到retention RAM中，从stop2模式唤醒后需要将关键数据进行恢复，并重新初始化外设。详情可查看程序及工程中的ld文件。