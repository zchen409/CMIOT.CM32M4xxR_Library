1、功能说明

	本示例将展示系统时钟的简单应用；
	样例中配置系统时钟为1秒间隔的超时，并在系统时钟中断中更新系统时钟计数器并重置系统时钟超时时间为1s；
	主函数中在等待系统时钟计数器变化进行LED闪烁控制
	

2、使用环境

	/* 软件开发环境：当前工程使用的软件工具名称及版本号 */
    	IDE工具：NucleiStudio IDE for C/C++ 2021-02
	
	/* 开发板 */
	CM32M4xxR_LQFP128_STB

3、使用说明

	/* 描述相关模块配置方法；例如:时钟，I/O等 */
        1、SystemClock：144MHz
        2、GPIO：PB0控制 LED D4闪烁
	3、开发板拨码开关配置：1连接，其他断开；Boot0配置：LOW。


	使用方法：
		1.编译后下载程序复位运行；
	    	2.程序运行后，LED D4将以间隔1秒交替闪烁
		
4、注意事项

	系统启动后中断默认为关闭状态，若期望启动中断需调用__enable_irq();