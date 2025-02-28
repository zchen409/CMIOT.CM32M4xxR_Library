1、功能说明

	本示例展示ECLIC中断咬尾特性，示例中共实现了TIM2/TIM3/TIM4三个通用定时器的普通定时中断，超时时间分别为0.5秒，立即超时、立即超时；
	其中TIM2超时中断为非向量中断，优先级为1，并在超时后将翻转LED D4，开启TIM3定时器，打印中断计数器
	其中TIM3超时中断为非向量中断，优先级为1，并在超时后将翻转LED D5; 关闭TIM3定时器，开启TIM4定时器，打印中断计数器
	其中TIM4超时中断为非向量中断，优先级为1，并在超时后将翻转LED D6; 关闭TIM4定时器，打印中断计数器

	为了体现中断咬尾特性，在中断上下文处理过程中对中断计数器进行自增，并在各中断处理函数中打印该计数器；

2、使用环境

	/* 软件开发环境：当前工程使用的软件工具名称及版本号 */
    	IDE工具：NucleiStudio IDE for C/C++ 2021-02
	
	/* 开发板 */
	CM32M4xxR_LQFP128_STB

3、使用说明

	/* 描述相关模块配置方法；例如:时钟，I/O等 */
        1、SystemClock：144MHz
        2、GPIO：PB0、PB1、PB5 控制 LED(D4、D5、D6) 闪烁
	3、开发板拨码开关配置：1/2/3/4 连接，其他断开；Boot0配置：LOW。
	4、TIM2定时器为超时中断，超时周期为0.5s，非向量中断，优先级为1；
	5、TIM3定时器为超时中断，超时周期为立即超时，非向量中断，优先级为1；	
	6、TIM4定时器为超时中断，超时周期为立即超时，非向量中断，优先级为1；
	7、USART配置如下：
                - 波特率 = 115200 baud
                - 字长 = 8数据位
                - 1停止位
                - 校验控制禁用
                - 硬件流控制禁用（RTS和CTS信号）
                - 接收器和发送器使能
        8、通过USB Serial连接开发板或外置链接USART引脚连接如下：
                - UART5_Tx.PE8
                - UART5_Rx.PE9
	使用方法：
		1.编译后下载程序复位运行；
	    	2.程序运行后，LED D4/D5/D6将以0.5秒间隔进行闪烁，同时log串口将输出中断计数器，由于中断咬尾特性，
		在一次序列中三个定时器中断打印的中断计数器将相同；
		
4、注意事项

	当新中断优先级小于等于当前中断优先级时，因此新中断不能够打断当前正在处理的中断。
	当处理器完成当前中断之后，理论上需要恢复上下文，然后退出中断回到主应用程序，然后重
	新响应新的中断，响应新的中断又需要再次保存上下文。如果将此背靠背的“恢复上下文”和
	“保存上下文”省略掉，则称之为“中断咬尾”以加快多个中断的背靠背处理速度。