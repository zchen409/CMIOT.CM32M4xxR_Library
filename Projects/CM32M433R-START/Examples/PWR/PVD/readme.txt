1、功能说明
	1、PVD配置电压产生对应的中断。


2、使用环境
	软件开发环境：  NucleiStudio IDE for C/C++ 2021-02
    硬件环境：      CM32M433R-START
3、使用说明
	
	系统配置；
        1、时钟源：HSE+PLL
        2、时钟频率：144MHz
        3、指示灯：D4(PB0)



	使用方法：
        1.编译后烧录到评估板，通过仿真器进入调试模式，在PVD_IRQHandler()中设置断点。
        2.全速运行。然后再把电压调到PVD设置电压附近，此时程序会停在断点处。
        3.中断处理运行后可以观测到指示灯D4(PB0)的电平翻转


4、注意事项
    1.MSB位可以进行扩展，具体请参考用户手册MSB位使用说明
    2.上位机查看log信息需要J4按RX<->5TX、TX<->5RX的方式使用跳帽进行连接
    3.指示灯D4(PB0)的正常显示需将拨码开关ON1中PB0位进行连通

