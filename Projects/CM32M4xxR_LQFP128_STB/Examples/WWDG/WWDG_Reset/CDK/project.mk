##
## Auto Generated makefile by CDK
## Do not modify this file, and any manual changes will be erased!!!   
##
## Link_FLASHXIP
ProjectName            :=project
ConfigurationName      :=Link_FLASHXIP
WorkspacePath          :=../../../../../../../../workspace/demoexample/XinSheng/
ProjectPath            :=./
IntermediateDirectory  :=Obj
OutDir                 :=$(IntermediateDirectory)
User                   :=cz194840
Date                   :=27/06/2022
CDKPath                :=../../../../../../../../work/cdk/Runtime
ToolchainPath          :=D:/work/cdk/CDKRepo/Toolchain/NucleiGccElf/V10.2.0/R/
LinkerName             :=riscv-nuclei-elf-g++
LinkerNameoption       := "`riscv-nuclei-elf-g++ -mabi=ilp32f -mtune=nuclei-300-series -march=rv32imafcp  -fconvert=little-endian  -print-file-name=crti.o`" "`riscv-nuclei-elf-g++ -mabi=ilp32f -mtune=nuclei-300-series -march=rv32imafcp  -fconvert=little-endian  -print-file-name=crtbegin.o`" "`riscv-nuclei-elf-g++ -mabi=ilp32f -mtune=nuclei-300-series -march=rv32imafcp  -fconvert=little-endian  -print-file-name=crtend.o`" "`riscv-nuclei-elf-g++ -mabi=ilp32f -mtune=nuclei-300-series -march=rv32imafcp  -fconvert=little-endian  -print-file-name=crtn.o`"
SIZE                   :=riscv-nuclei-elf-size
READELF                :=riscv-nuclei-elf-readelf
CHECKSUM               :=crc32
SharedObjectLinkerName :=
ObjectSuffix           :=.o
DependSuffix           :=.d
PreprocessSuffix       :=.i
DisassemSuffix         :=.asm
IHexSuffix             :=.ihex
BinSuffix              :=.bin
ExeSuffix              :=.elf
LibSuffix              :=.a
DebugSwitch            :=-g 
IncludeSwitch          :=-I
LibrarySwitch          :=-l
OutputSwitch           :=-o 
ElfInfoSwitch          :=-hlS
LibraryPathSwitch      :=-L
PreprocessorSwitch     :=-D
UnPreprocessorSwitch   :=-U
SourceSwitch           :=-c 
ObjdumpSwitch          :=-S
ObjcopySwitch          :=-O ihex
ObjcopyBinSwitch       :=-O binary
OutputFile             :=$(ProjectName)
ObjectSwitch           :=-o 
ArchiveOutputSwitch    := 
PreprocessOnlySwitch   :=-E
ObjectsFileList        :=project.txt
MakeDirCommand         :=mkdir
LinkOptions            := -mabi=ilp32f -mtune=nuclei-300-series -march=rv32imafcp  -nostartfiles -Wl,--gc-sections -T"$(ProjectPath)/../../../../../../Drivers/NMSIS/Device/Source/GCC/gcc_cm32m4xxr_flashxip.ld"
LinkOtherFlagsOption   := -mcmodel=medany -mno-save-restore -fno-common -nostartfiles --specs=nano.specs --specs=nosys.specs -u _isatty -u _write -u _sbrk -u _read -u _close -u _fstat -u _lseek -Xlinker --gc-sections
IncludePackagePath     :=
IncludeCPath           := $(IncludeSwitch)../../../../../../Drivers/CM32M4xxR_Algo_Library/Include $(IncludeSwitch)../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Include $(IncludeSwitch)../../../../../../Drivers/NMSIS/Core/Include $(IncludeSwitch)../../../../../../Drivers/NMSIS/DSP/Include $(IncludeSwitch)../../../../../../Drivers/NMSIS/DSP/Include/dsp $(IncludeSwitch)../../../../../../Drivers/NMSIS/DSP/PrivateInclude $(IncludeSwitch)../../../../../../Drivers/NMSIS/Device/Include $(IncludeSwitch)../../../../BSP/Include $(IncludeSwitch)../Application/Include $(IncludeSwitch)../Application/Source $(IncludeSwitch)../coremark  
IncludeAPath           := $(IncludeSwitch)../../../../../../Drivers/CM32M4xxR_Algo_Library/Include $(IncludeSwitch)../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Include $(IncludeSwitch)../../../../../../Drivers/NMSIS/Core/Include $(IncludeSwitch)../../../../../../Drivers/NMSIS/DSP/Include $(IncludeSwitch)../../../../../../Drivers/NMSIS/DSP/Include/dsp $(IncludeSwitch)../../../../../../Drivers/NMSIS/DSP/PrivateInclude $(IncludeSwitch)../../../../../../Drivers/NMSIS/Device/Include $(IncludeSwitch)../../../../BSP/Include $(IncludeSwitch)../Application/Include $(IncludeSwitch)../Application/Source $(IncludeSwitch)../coremark  
Libs                   := -Wl,--start-group  -Wl,--end-group $(LibrarySwitch)nmsis_dsp_rv32imafcp $(LibrarySwitch)cm32m4xxr_aes_rv32imafc $(LibrarySwitch)cm32m4xxr_des_rv32imafc $(LibrarySwitch)cm32m4xxr_hash_rv32imafc $(LibrarySwitch)cm32m4xxr_sm4_rv32imafc $(LibrarySwitch)cm32m4xxr_algo_common_rv32imafc $(LibrarySwitch)stdc++  
ArLibs                 := "nmsis_dsp_rv32imafcp" "cm32m4xxr_aes_rv32imafc" "cm32m4xxr_des_rv32imafc" "cm32m4xxr_hash_rv32imafc" "cm32m4xxr_sm4_rv32imafc" "cm32m4xxr_algo_common_rv32imafc" "stdc++" 
PackagesLibPath        :=
LibPath                :=$(LibraryPathSwitch)../../../../../../Drivers/NMSIS/Library/DSP/GCC $(LibraryPathSwitch)../../../../../../Drivers/CM32M4xxR_Algo_Library/Lib  $(PackagesLibPath) 

##
## Common variables
## AR, CXX, CC, AS, CXXFLAGS and CFLAGS can be overriden using an environment variables
##
AR       :=riscv-nuclei-elf-ar rcs
CXX      :=riscv-nuclei-elf-g++
CC       :=riscv-nuclei-elf-gcc
AS       :=riscv-nuclei-elf-gcc
OBJDUMP  :=riscv-nuclei-elf-objdump
OBJCOPY  :=riscv-nuclei-elf-objcopy
CXXFLAGS := -mabi=ilp32f -mtune=nuclei-300-series -march=rv32imafcp   $(PreprocessorSwitch)__IDE_RV_CORE=n308  $(PreprocessorSwitch)DOWNLOAD_MODE=DOWNLOAD_MODE_FLASHXIP  $(PreprocessorSwitch)DOWNLOAD_MODE_STRING=\"FLASHXIP\"   -O2  -g  -Wall  -ffunction-sections  -fdata-sections  -mcmodel=medany -mno-save-restore -fno-common -nostartfiles --specs=nano.specs --specs=nosys.specs -u _isatty -u _write -u _sbrk -u _read -u _close -u _fstat -u _lseek -Xlinker --gc-sections 
CFLAGS   := -mabi=ilp32f -mtune=nuclei-300-series -march=rv32imafcp   $(PreprocessorSwitch)__IDE_RV_CORE=n308  $(PreprocessorSwitch)DOWNLOAD_MODE=DOWNLOAD_MODE_FLASHXIP  $(PreprocessorSwitch)DOWNLOAD_MODE_STRING=\"FLASHXIP\"   -O2  -g  -Wall  -ffunction-sections  -fdata-sections  -mcmodel=medany -mno-save-restore -fno-common -nostartfiles --specs=nano.specs --specs=nosys.specs -u _isatty -u _write -u _sbrk -u _read -u _close -u _fstat -u _lseek -Xlinker --gc-sections 
ASFLAGS  := -mabi=ilp32f -mtune=nuclei-300-series -march=rv32imafcp   $(PreprocessorSwitch)__IDE_RV_CORE=n308  $(PreprocessorSwitch)DOWNLOAD_MODE=DOWNLOAD_MODE_FLASHXIP  $(PreprocessorSwitch)DOWNLOAD_MODE_STRING="FLASHXIP"   -Wa,--gdwarf2   -mcmodel=medany -mno-save-restore -fno-common -nostartfiles --specs=nano.specs --specs=nosys.specs -u _isatty -u _write -u _sbrk -u _read -u _close -u _fstat -u _lseek -Xlinker --gc-sections  


Objects0=$(IntermediateDirectory)/Source_cm32m4xxr_adc$(ObjectSuffix) $(IntermediateDirectory)/Source_cm32m4xxr_bkp$(ObjectSuffix) $(IntermediateDirectory)/Source_cm32m4xxr_can$(ObjectSuffix) $(IntermediateDirectory)/Source_cm32m4xxr_comp$(ObjectSuffix) $(IntermediateDirectory)/Source_cm32m4xxr_crc$(ObjectSuffix) $(IntermediateDirectory)/Source_cm32m4xxr_dac$(ObjectSuffix) $(IntermediateDirectory)/Source_cm32m4xxr_dbg$(ObjectSuffix) $(IntermediateDirectory)/Source_cm32m4xxr_dma$(ObjectSuffix) $(IntermediateDirectory)/Source_cm32m4xxr_exti$(ObjectSuffix) $(IntermediateDirectory)/Source_cm32m4xxr_flash$(ObjectSuffix) \
	$(IntermediateDirectory)/Source_cm32m4xxr_gpio$(ObjectSuffix) $(IntermediateDirectory)/Source_cm32m4xxr_i2c$(ObjectSuffix) $(IntermediateDirectory)/Source_cm32m4xxr_iwdg$(ObjectSuffix) $(IntermediateDirectory)/Source_cm32m4xxr_opamp$(ObjectSuffix) $(IntermediateDirectory)/Source_cm32m4xxr_pwr$(ObjectSuffix) $(IntermediateDirectory)/Source_cm32m4xxr_qspi$(ObjectSuffix) $(IntermediateDirectory)/Source_cm32m4xxr_rcc$(ObjectSuffix) $(IntermediateDirectory)/Source_cm32m4xxr_rngc$(ObjectSuffix) $(IntermediateDirectory)/Source_cm32m4xxr_rtc$(ObjectSuffix) $(IntermediateDirectory)/Source_cm32m4xxr_spi$(ObjectSuffix) \
	$(IntermediateDirectory)/Source_cm32m4xxr_tim$(ObjectSuffix) $(IntermediateDirectory)/Source_cm32m4xxr_tsc$(ObjectSuffix) $(IntermediateDirectory)/Source_cm32m4xxr_usart$(ObjectSuffix) $(IntermediateDirectory)/Source_cm32m4xxr_wwdg$(ObjectSuffix) $(IntermediateDirectory)/Source_misc$(ObjectSuffix) $(IntermediateDirectory)/Source_cm32m4xxr_it$(ObjectSuffix) $(IntermediateDirectory)/Source_main$(ObjectSuffix) $(IntermediateDirectory)/Source_system_cm32m4xxr$(ObjectSuffix) $(IntermediateDirectory)/Source_key$(ObjectSuffix) $(IntermediateDirectory)/Source_led$(ObjectSuffix) \
	$(IntermediateDirectory)/Source_log$(ObjectSuffix) $(IntermediateDirectory)/Source_tsckey$(ObjectSuffix) 

Objects1=$(IntermediateDirectory)/GCC_intexc_cm32m4xxr$(ObjectSuffix) $(IntermediateDirectory)/GCC_startup_cm32m4xxr$(ObjectSuffix) 



Objects=$(Objects0) $(Objects1) 

##
## Main Build Targets 
##
.PHONY: all
all: $(IntermediateDirectory)/$(OutputFile)

$(IntermediateDirectory)/$(OutputFile):  $(Objects) Always_Link 
	$(LinkerName) $(OutputSwitch) $(IntermediateDirectory)/$(OutputFile)$(ExeSuffix) $(LinkerNameoption) $(LinkOtherFlagsOption)  @$(ObjectsFileList)  $(LinkOptions) $(LibPath) $(Libs)
	$(OBJDUMP) $(ObjdumpSwitch) $(ProjectPath)/$(IntermediateDirectory)/$(OutputFile)$(ExeSuffix)  > $(ProjectPath)/Lst/$(OutputFile)$(DisassemSuffix) 
	@echo size of target:
	@$(SIZE) $(ProjectPath)$(IntermediateDirectory)/$(OutputFile)$(ExeSuffix) 
	@echo -n checksum value of target:  
	@$(CHECKSUM) $(ProjectPath)/$(IntermediateDirectory)/$(OutputFile)$(ExeSuffix) 
	@$(ProjectName).modify.bat $(IntermediateDirectory) $(OutputFile)$(ExeSuffix) 

Always_Link:


##
## Objects
##
$(IntermediateDirectory)/Source_cm32m4xxr_adc$(ObjectSuffix): ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_adc.c  
	$(CC) $(SourceSwitch) ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_adc.c $(CFLAGS) -MMD -MP -MT$(IntermediateDirectory)/Source_cm32m4xxr_adc$(ObjectSuffix) -MF$(IntermediateDirectory)/Source_cm32m4xxr_adc$(DependSuffix) $(ObjectSwitch)$(IntermediateDirectory)/Source_cm32m4xxr_adc$(ObjectSuffix) $(IncludeCPath) $(IncludePackagePath)
Lst/Source_cm32m4xxr_adc$(PreprocessSuffix): ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_adc.c
	$(CC) $(CFLAGS)$(IncludeCPath) $(PreprocessOnlySwitch) $(OutputSwitch) Lst/Source_cm32m4xxr_adc$(PreprocessSuffix) ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_adc.c

$(IntermediateDirectory)/Source_cm32m4xxr_bkp$(ObjectSuffix): ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_bkp.c  
	$(CC) $(SourceSwitch) ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_bkp.c $(CFLAGS) -MMD -MP -MT$(IntermediateDirectory)/Source_cm32m4xxr_bkp$(ObjectSuffix) -MF$(IntermediateDirectory)/Source_cm32m4xxr_bkp$(DependSuffix) $(ObjectSwitch)$(IntermediateDirectory)/Source_cm32m4xxr_bkp$(ObjectSuffix) $(IncludeCPath) $(IncludePackagePath)
Lst/Source_cm32m4xxr_bkp$(PreprocessSuffix): ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_bkp.c
	$(CC) $(CFLAGS)$(IncludeCPath) $(PreprocessOnlySwitch) $(OutputSwitch) Lst/Source_cm32m4xxr_bkp$(PreprocessSuffix) ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_bkp.c

$(IntermediateDirectory)/Source_cm32m4xxr_can$(ObjectSuffix): ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_can.c  
	$(CC) $(SourceSwitch) ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_can.c $(CFLAGS) -MMD -MP -MT$(IntermediateDirectory)/Source_cm32m4xxr_can$(ObjectSuffix) -MF$(IntermediateDirectory)/Source_cm32m4xxr_can$(DependSuffix) $(ObjectSwitch)$(IntermediateDirectory)/Source_cm32m4xxr_can$(ObjectSuffix) $(IncludeCPath) $(IncludePackagePath)
Lst/Source_cm32m4xxr_can$(PreprocessSuffix): ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_can.c
	$(CC) $(CFLAGS)$(IncludeCPath) $(PreprocessOnlySwitch) $(OutputSwitch) Lst/Source_cm32m4xxr_can$(PreprocessSuffix) ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_can.c

$(IntermediateDirectory)/Source_cm32m4xxr_comp$(ObjectSuffix): ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_comp.c  
	$(CC) $(SourceSwitch) ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_comp.c $(CFLAGS) -MMD -MP -MT$(IntermediateDirectory)/Source_cm32m4xxr_comp$(ObjectSuffix) -MF$(IntermediateDirectory)/Source_cm32m4xxr_comp$(DependSuffix) $(ObjectSwitch)$(IntermediateDirectory)/Source_cm32m4xxr_comp$(ObjectSuffix) $(IncludeCPath) $(IncludePackagePath)
Lst/Source_cm32m4xxr_comp$(PreprocessSuffix): ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_comp.c
	$(CC) $(CFLAGS)$(IncludeCPath) $(PreprocessOnlySwitch) $(OutputSwitch) Lst/Source_cm32m4xxr_comp$(PreprocessSuffix) ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_comp.c

$(IntermediateDirectory)/Source_cm32m4xxr_crc$(ObjectSuffix): ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_crc.c  
	$(CC) $(SourceSwitch) ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_crc.c $(CFLAGS) -MMD -MP -MT$(IntermediateDirectory)/Source_cm32m4xxr_crc$(ObjectSuffix) -MF$(IntermediateDirectory)/Source_cm32m4xxr_crc$(DependSuffix) $(ObjectSwitch)$(IntermediateDirectory)/Source_cm32m4xxr_crc$(ObjectSuffix) $(IncludeCPath) $(IncludePackagePath)
Lst/Source_cm32m4xxr_crc$(PreprocessSuffix): ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_crc.c
	$(CC) $(CFLAGS)$(IncludeCPath) $(PreprocessOnlySwitch) $(OutputSwitch) Lst/Source_cm32m4xxr_crc$(PreprocessSuffix) ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_crc.c

$(IntermediateDirectory)/Source_cm32m4xxr_dac$(ObjectSuffix): ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_dac.c  
	$(CC) $(SourceSwitch) ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_dac.c $(CFLAGS) -MMD -MP -MT$(IntermediateDirectory)/Source_cm32m4xxr_dac$(ObjectSuffix) -MF$(IntermediateDirectory)/Source_cm32m4xxr_dac$(DependSuffix) $(ObjectSwitch)$(IntermediateDirectory)/Source_cm32m4xxr_dac$(ObjectSuffix) $(IncludeCPath) $(IncludePackagePath)
Lst/Source_cm32m4xxr_dac$(PreprocessSuffix): ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_dac.c
	$(CC) $(CFLAGS)$(IncludeCPath) $(PreprocessOnlySwitch) $(OutputSwitch) Lst/Source_cm32m4xxr_dac$(PreprocessSuffix) ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_dac.c

$(IntermediateDirectory)/Source_cm32m4xxr_dbg$(ObjectSuffix): ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_dbg.c  
	$(CC) $(SourceSwitch) ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_dbg.c $(CFLAGS) -MMD -MP -MT$(IntermediateDirectory)/Source_cm32m4xxr_dbg$(ObjectSuffix) -MF$(IntermediateDirectory)/Source_cm32m4xxr_dbg$(DependSuffix) $(ObjectSwitch)$(IntermediateDirectory)/Source_cm32m4xxr_dbg$(ObjectSuffix) $(IncludeCPath) $(IncludePackagePath)
Lst/Source_cm32m4xxr_dbg$(PreprocessSuffix): ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_dbg.c
	$(CC) $(CFLAGS)$(IncludeCPath) $(PreprocessOnlySwitch) $(OutputSwitch) Lst/Source_cm32m4xxr_dbg$(PreprocessSuffix) ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_dbg.c

$(IntermediateDirectory)/Source_cm32m4xxr_dma$(ObjectSuffix): ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_dma.c  
	$(CC) $(SourceSwitch) ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_dma.c $(CFLAGS) -MMD -MP -MT$(IntermediateDirectory)/Source_cm32m4xxr_dma$(ObjectSuffix) -MF$(IntermediateDirectory)/Source_cm32m4xxr_dma$(DependSuffix) $(ObjectSwitch)$(IntermediateDirectory)/Source_cm32m4xxr_dma$(ObjectSuffix) $(IncludeCPath) $(IncludePackagePath)
Lst/Source_cm32m4xxr_dma$(PreprocessSuffix): ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_dma.c
	$(CC) $(CFLAGS)$(IncludeCPath) $(PreprocessOnlySwitch) $(OutputSwitch) Lst/Source_cm32m4xxr_dma$(PreprocessSuffix) ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_dma.c

$(IntermediateDirectory)/Source_cm32m4xxr_exti$(ObjectSuffix): ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_exti.c  
	$(CC) $(SourceSwitch) ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_exti.c $(CFLAGS) -MMD -MP -MT$(IntermediateDirectory)/Source_cm32m4xxr_exti$(ObjectSuffix) -MF$(IntermediateDirectory)/Source_cm32m4xxr_exti$(DependSuffix) $(ObjectSwitch)$(IntermediateDirectory)/Source_cm32m4xxr_exti$(ObjectSuffix) $(IncludeCPath) $(IncludePackagePath)
Lst/Source_cm32m4xxr_exti$(PreprocessSuffix): ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_exti.c
	$(CC) $(CFLAGS)$(IncludeCPath) $(PreprocessOnlySwitch) $(OutputSwitch) Lst/Source_cm32m4xxr_exti$(PreprocessSuffix) ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_exti.c

$(IntermediateDirectory)/Source_cm32m4xxr_flash$(ObjectSuffix): ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_flash.c  
	$(CC) $(SourceSwitch) ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_flash.c $(CFLAGS) -MMD -MP -MT$(IntermediateDirectory)/Source_cm32m4xxr_flash$(ObjectSuffix) -MF$(IntermediateDirectory)/Source_cm32m4xxr_flash$(DependSuffix) $(ObjectSwitch)$(IntermediateDirectory)/Source_cm32m4xxr_flash$(ObjectSuffix) $(IncludeCPath) $(IncludePackagePath)
Lst/Source_cm32m4xxr_flash$(PreprocessSuffix): ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_flash.c
	$(CC) $(CFLAGS)$(IncludeCPath) $(PreprocessOnlySwitch) $(OutputSwitch) Lst/Source_cm32m4xxr_flash$(PreprocessSuffix) ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_flash.c

$(IntermediateDirectory)/Source_cm32m4xxr_gpio$(ObjectSuffix): ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_gpio.c  
	$(CC) $(SourceSwitch) ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_gpio.c $(CFLAGS) -MMD -MP -MT$(IntermediateDirectory)/Source_cm32m4xxr_gpio$(ObjectSuffix) -MF$(IntermediateDirectory)/Source_cm32m4xxr_gpio$(DependSuffix) $(ObjectSwitch)$(IntermediateDirectory)/Source_cm32m4xxr_gpio$(ObjectSuffix) $(IncludeCPath) $(IncludePackagePath)
Lst/Source_cm32m4xxr_gpio$(PreprocessSuffix): ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_gpio.c
	$(CC) $(CFLAGS)$(IncludeCPath) $(PreprocessOnlySwitch) $(OutputSwitch) Lst/Source_cm32m4xxr_gpio$(PreprocessSuffix) ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_gpio.c

$(IntermediateDirectory)/Source_cm32m4xxr_i2c$(ObjectSuffix): ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_i2c.c  
	$(CC) $(SourceSwitch) ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_i2c.c $(CFLAGS) -MMD -MP -MT$(IntermediateDirectory)/Source_cm32m4xxr_i2c$(ObjectSuffix) -MF$(IntermediateDirectory)/Source_cm32m4xxr_i2c$(DependSuffix) $(ObjectSwitch)$(IntermediateDirectory)/Source_cm32m4xxr_i2c$(ObjectSuffix) $(IncludeCPath) $(IncludePackagePath)
Lst/Source_cm32m4xxr_i2c$(PreprocessSuffix): ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_i2c.c
	$(CC) $(CFLAGS)$(IncludeCPath) $(PreprocessOnlySwitch) $(OutputSwitch) Lst/Source_cm32m4xxr_i2c$(PreprocessSuffix) ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_i2c.c

$(IntermediateDirectory)/Source_cm32m4xxr_iwdg$(ObjectSuffix): ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_iwdg.c  
	$(CC) $(SourceSwitch) ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_iwdg.c $(CFLAGS) -MMD -MP -MT$(IntermediateDirectory)/Source_cm32m4xxr_iwdg$(ObjectSuffix) -MF$(IntermediateDirectory)/Source_cm32m4xxr_iwdg$(DependSuffix) $(ObjectSwitch)$(IntermediateDirectory)/Source_cm32m4xxr_iwdg$(ObjectSuffix) $(IncludeCPath) $(IncludePackagePath)
Lst/Source_cm32m4xxr_iwdg$(PreprocessSuffix): ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_iwdg.c
	$(CC) $(CFLAGS)$(IncludeCPath) $(PreprocessOnlySwitch) $(OutputSwitch) Lst/Source_cm32m4xxr_iwdg$(PreprocessSuffix) ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_iwdg.c

$(IntermediateDirectory)/Source_cm32m4xxr_opamp$(ObjectSuffix): ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_opamp.c  
	$(CC) $(SourceSwitch) ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_opamp.c $(CFLAGS) -MMD -MP -MT$(IntermediateDirectory)/Source_cm32m4xxr_opamp$(ObjectSuffix) -MF$(IntermediateDirectory)/Source_cm32m4xxr_opamp$(DependSuffix) $(ObjectSwitch)$(IntermediateDirectory)/Source_cm32m4xxr_opamp$(ObjectSuffix) $(IncludeCPath) $(IncludePackagePath)
Lst/Source_cm32m4xxr_opamp$(PreprocessSuffix): ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_opamp.c
	$(CC) $(CFLAGS)$(IncludeCPath) $(PreprocessOnlySwitch) $(OutputSwitch) Lst/Source_cm32m4xxr_opamp$(PreprocessSuffix) ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_opamp.c

$(IntermediateDirectory)/Source_cm32m4xxr_pwr$(ObjectSuffix): ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_pwr.c  
	$(CC) $(SourceSwitch) ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_pwr.c $(CFLAGS) -MMD -MP -MT$(IntermediateDirectory)/Source_cm32m4xxr_pwr$(ObjectSuffix) -MF$(IntermediateDirectory)/Source_cm32m4xxr_pwr$(DependSuffix) $(ObjectSwitch)$(IntermediateDirectory)/Source_cm32m4xxr_pwr$(ObjectSuffix) $(IncludeCPath) $(IncludePackagePath)
Lst/Source_cm32m4xxr_pwr$(PreprocessSuffix): ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_pwr.c
	$(CC) $(CFLAGS)$(IncludeCPath) $(PreprocessOnlySwitch) $(OutputSwitch) Lst/Source_cm32m4xxr_pwr$(PreprocessSuffix) ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_pwr.c

$(IntermediateDirectory)/Source_cm32m4xxr_qspi$(ObjectSuffix): ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_qspi.c  
	$(CC) $(SourceSwitch) ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_qspi.c $(CFLAGS) -MMD -MP -MT$(IntermediateDirectory)/Source_cm32m4xxr_qspi$(ObjectSuffix) -MF$(IntermediateDirectory)/Source_cm32m4xxr_qspi$(DependSuffix) $(ObjectSwitch)$(IntermediateDirectory)/Source_cm32m4xxr_qspi$(ObjectSuffix) $(IncludeCPath) $(IncludePackagePath)
Lst/Source_cm32m4xxr_qspi$(PreprocessSuffix): ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_qspi.c
	$(CC) $(CFLAGS)$(IncludeCPath) $(PreprocessOnlySwitch) $(OutputSwitch) Lst/Source_cm32m4xxr_qspi$(PreprocessSuffix) ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_qspi.c

$(IntermediateDirectory)/Source_cm32m4xxr_rcc$(ObjectSuffix): ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_rcc.c  
	$(CC) $(SourceSwitch) ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_rcc.c $(CFLAGS) -MMD -MP -MT$(IntermediateDirectory)/Source_cm32m4xxr_rcc$(ObjectSuffix) -MF$(IntermediateDirectory)/Source_cm32m4xxr_rcc$(DependSuffix) $(ObjectSwitch)$(IntermediateDirectory)/Source_cm32m4xxr_rcc$(ObjectSuffix) $(IncludeCPath) $(IncludePackagePath)
Lst/Source_cm32m4xxr_rcc$(PreprocessSuffix): ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_rcc.c
	$(CC) $(CFLAGS)$(IncludeCPath) $(PreprocessOnlySwitch) $(OutputSwitch) Lst/Source_cm32m4xxr_rcc$(PreprocessSuffix) ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_rcc.c

$(IntermediateDirectory)/Source_cm32m4xxr_rngc$(ObjectSuffix): ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_rngc.c  
	$(CC) $(SourceSwitch) ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_rngc.c $(CFLAGS) -MMD -MP -MT$(IntermediateDirectory)/Source_cm32m4xxr_rngc$(ObjectSuffix) -MF$(IntermediateDirectory)/Source_cm32m4xxr_rngc$(DependSuffix) $(ObjectSwitch)$(IntermediateDirectory)/Source_cm32m4xxr_rngc$(ObjectSuffix) $(IncludeCPath) $(IncludePackagePath)
Lst/Source_cm32m4xxr_rngc$(PreprocessSuffix): ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_rngc.c
	$(CC) $(CFLAGS)$(IncludeCPath) $(PreprocessOnlySwitch) $(OutputSwitch) Lst/Source_cm32m4xxr_rngc$(PreprocessSuffix) ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_rngc.c

$(IntermediateDirectory)/Source_cm32m4xxr_rtc$(ObjectSuffix): ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_rtc.c  
	$(CC) $(SourceSwitch) ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_rtc.c $(CFLAGS) -MMD -MP -MT$(IntermediateDirectory)/Source_cm32m4xxr_rtc$(ObjectSuffix) -MF$(IntermediateDirectory)/Source_cm32m4xxr_rtc$(DependSuffix) $(ObjectSwitch)$(IntermediateDirectory)/Source_cm32m4xxr_rtc$(ObjectSuffix) $(IncludeCPath) $(IncludePackagePath)
Lst/Source_cm32m4xxr_rtc$(PreprocessSuffix): ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_rtc.c
	$(CC) $(CFLAGS)$(IncludeCPath) $(PreprocessOnlySwitch) $(OutputSwitch) Lst/Source_cm32m4xxr_rtc$(PreprocessSuffix) ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_rtc.c

$(IntermediateDirectory)/Source_cm32m4xxr_spi$(ObjectSuffix): ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_spi.c  
	$(CC) $(SourceSwitch) ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_spi.c $(CFLAGS) -MMD -MP -MT$(IntermediateDirectory)/Source_cm32m4xxr_spi$(ObjectSuffix) -MF$(IntermediateDirectory)/Source_cm32m4xxr_spi$(DependSuffix) $(ObjectSwitch)$(IntermediateDirectory)/Source_cm32m4xxr_spi$(ObjectSuffix) $(IncludeCPath) $(IncludePackagePath)
Lst/Source_cm32m4xxr_spi$(PreprocessSuffix): ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_spi.c
	$(CC) $(CFLAGS)$(IncludeCPath) $(PreprocessOnlySwitch) $(OutputSwitch) Lst/Source_cm32m4xxr_spi$(PreprocessSuffix) ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_spi.c

$(IntermediateDirectory)/Source_cm32m4xxr_tim$(ObjectSuffix): ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_tim.c  
	$(CC) $(SourceSwitch) ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_tim.c $(CFLAGS) -MMD -MP -MT$(IntermediateDirectory)/Source_cm32m4xxr_tim$(ObjectSuffix) -MF$(IntermediateDirectory)/Source_cm32m4xxr_tim$(DependSuffix) $(ObjectSwitch)$(IntermediateDirectory)/Source_cm32m4xxr_tim$(ObjectSuffix) $(IncludeCPath) $(IncludePackagePath)
Lst/Source_cm32m4xxr_tim$(PreprocessSuffix): ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_tim.c
	$(CC) $(CFLAGS)$(IncludeCPath) $(PreprocessOnlySwitch) $(OutputSwitch) Lst/Source_cm32m4xxr_tim$(PreprocessSuffix) ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_tim.c

$(IntermediateDirectory)/Source_cm32m4xxr_tsc$(ObjectSuffix): ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_tsc.c  
	$(CC) $(SourceSwitch) ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_tsc.c $(CFLAGS) -MMD -MP -MT$(IntermediateDirectory)/Source_cm32m4xxr_tsc$(ObjectSuffix) -MF$(IntermediateDirectory)/Source_cm32m4xxr_tsc$(DependSuffix) $(ObjectSwitch)$(IntermediateDirectory)/Source_cm32m4xxr_tsc$(ObjectSuffix) $(IncludeCPath) $(IncludePackagePath)
Lst/Source_cm32m4xxr_tsc$(PreprocessSuffix): ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_tsc.c
	$(CC) $(CFLAGS)$(IncludeCPath) $(PreprocessOnlySwitch) $(OutputSwitch) Lst/Source_cm32m4xxr_tsc$(PreprocessSuffix) ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_tsc.c

$(IntermediateDirectory)/Source_cm32m4xxr_usart$(ObjectSuffix): ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_usart.c  
	$(CC) $(SourceSwitch) ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_usart.c $(CFLAGS) -MMD -MP -MT$(IntermediateDirectory)/Source_cm32m4xxr_usart$(ObjectSuffix) -MF$(IntermediateDirectory)/Source_cm32m4xxr_usart$(DependSuffix) $(ObjectSwitch)$(IntermediateDirectory)/Source_cm32m4xxr_usart$(ObjectSuffix) $(IncludeCPath) $(IncludePackagePath)
Lst/Source_cm32m4xxr_usart$(PreprocessSuffix): ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_usart.c
	$(CC) $(CFLAGS)$(IncludeCPath) $(PreprocessOnlySwitch) $(OutputSwitch) Lst/Source_cm32m4xxr_usart$(PreprocessSuffix) ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_usart.c

$(IntermediateDirectory)/Source_cm32m4xxr_wwdg$(ObjectSuffix): ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_wwdg.c  
	$(CC) $(SourceSwitch) ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_wwdg.c $(CFLAGS) -MMD -MP -MT$(IntermediateDirectory)/Source_cm32m4xxr_wwdg$(ObjectSuffix) -MF$(IntermediateDirectory)/Source_cm32m4xxr_wwdg$(DependSuffix) $(ObjectSwitch)$(IntermediateDirectory)/Source_cm32m4xxr_wwdg$(ObjectSuffix) $(IncludeCPath) $(IncludePackagePath)
Lst/Source_cm32m4xxr_wwdg$(PreprocessSuffix): ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_wwdg.c
	$(CC) $(CFLAGS)$(IncludeCPath) $(PreprocessOnlySwitch) $(OutputSwitch) Lst/Source_cm32m4xxr_wwdg$(PreprocessSuffix) ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/cm32m4xxr_wwdg.c

$(IntermediateDirectory)/Source_misc$(ObjectSuffix): ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/misc.c  
	$(CC) $(SourceSwitch) ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/misc.c $(CFLAGS) -MMD -MP -MT$(IntermediateDirectory)/Source_misc$(ObjectSuffix) -MF$(IntermediateDirectory)/Source_misc$(DependSuffix) $(ObjectSwitch)$(IntermediateDirectory)/Source_misc$(ObjectSuffix) $(IncludeCPath) $(IncludePackagePath)
Lst/Source_misc$(PreprocessSuffix): ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/misc.c
	$(CC) $(CFLAGS)$(IncludeCPath) $(PreprocessOnlySwitch) $(OutputSwitch) Lst/Source_misc$(PreprocessSuffix) ../../../../../../Drivers/CM32M4xxR_StdPeriph_Driver/Source/misc.c

$(IntermediateDirectory)/Source_cm32m4xxr_it$(ObjectSuffix): ../Application/Source/cm32m4xxr_it.c  
	$(CC) $(SourceSwitch) ../Application/Source/cm32m4xxr_it.c $(CFLAGS) -MMD -MP -MT$(IntermediateDirectory)/Source_cm32m4xxr_it$(ObjectSuffix) -MF$(IntermediateDirectory)/Source_cm32m4xxr_it$(DependSuffix) $(ObjectSwitch)$(IntermediateDirectory)/Source_cm32m4xxr_it$(ObjectSuffix) $(IncludeCPath) $(IncludePackagePath)
Lst/Source_cm32m4xxr_it$(PreprocessSuffix): ../Application/Source/cm32m4xxr_it.c
	$(CC) $(CFLAGS)$(IncludeCPath) $(PreprocessOnlySwitch) $(OutputSwitch) Lst/Source_cm32m4xxr_it$(PreprocessSuffix) ../Application/Source/cm32m4xxr_it.c

$(IntermediateDirectory)/Source_main$(ObjectSuffix): ../Application/Source/main.c  
	$(CC) $(SourceSwitch) ../Application/Source/main.c $(CFLAGS) -MMD -MP -MT$(IntermediateDirectory)/Source_main$(ObjectSuffix) -MF$(IntermediateDirectory)/Source_main$(DependSuffix) $(ObjectSwitch)$(IntermediateDirectory)/Source_main$(ObjectSuffix) $(IncludeCPath) $(IncludePackagePath)
Lst/Source_main$(PreprocessSuffix): ../Application/Source/main.c
	$(CC) $(CFLAGS)$(IncludeCPath) $(PreprocessOnlySwitch) $(OutputSwitch) Lst/Source_main$(PreprocessSuffix) ../Application/Source/main.c

$(IntermediateDirectory)/Source_system_cm32m4xxr$(ObjectSuffix): ../Application/Source/system_cm32m4xxr.c  
	$(CC) $(SourceSwitch) ../Application/Source/system_cm32m4xxr.c $(CFLAGS) -MMD -MP -MT$(IntermediateDirectory)/Source_system_cm32m4xxr$(ObjectSuffix) -MF$(IntermediateDirectory)/Source_system_cm32m4xxr$(DependSuffix) $(ObjectSwitch)$(IntermediateDirectory)/Source_system_cm32m4xxr$(ObjectSuffix) $(IncludeCPath) $(IncludePackagePath)
Lst/Source_system_cm32m4xxr$(PreprocessSuffix): ../Application/Source/system_cm32m4xxr.c
	$(CC) $(CFLAGS)$(IncludeCPath) $(PreprocessOnlySwitch) $(OutputSwitch) Lst/Source_system_cm32m4xxr$(PreprocessSuffix) ../Application/Source/system_cm32m4xxr.c

$(IntermediateDirectory)/Source_key$(ObjectSuffix): ../../../../BSP/Source/key.c  
	$(CC) $(SourceSwitch) ../../../../BSP/Source/key.c $(CFLAGS) -MMD -MP -MT$(IntermediateDirectory)/Source_key$(ObjectSuffix) -MF$(IntermediateDirectory)/Source_key$(DependSuffix) $(ObjectSwitch)$(IntermediateDirectory)/Source_key$(ObjectSuffix) $(IncludeCPath) $(IncludePackagePath)
Lst/Source_key$(PreprocessSuffix): ../../../../BSP/Source/key.c
	$(CC) $(CFLAGS)$(IncludeCPath) $(PreprocessOnlySwitch) $(OutputSwitch) Lst/Source_key$(PreprocessSuffix) ../../../../BSP/Source/key.c

$(IntermediateDirectory)/Source_led$(ObjectSuffix): ../../../../BSP/Source/led.c  
	$(CC) $(SourceSwitch) ../../../../BSP/Source/led.c $(CFLAGS) -MMD -MP -MT$(IntermediateDirectory)/Source_led$(ObjectSuffix) -MF$(IntermediateDirectory)/Source_led$(DependSuffix) $(ObjectSwitch)$(IntermediateDirectory)/Source_led$(ObjectSuffix) $(IncludeCPath) $(IncludePackagePath)
Lst/Source_led$(PreprocessSuffix): ../../../../BSP/Source/led.c
	$(CC) $(CFLAGS)$(IncludeCPath) $(PreprocessOnlySwitch) $(OutputSwitch) Lst/Source_led$(PreprocessSuffix) ../../../../BSP/Source/led.c

$(IntermediateDirectory)/Source_log$(ObjectSuffix): ../../../../BSP/Source/log.c  
	$(CC) $(SourceSwitch) ../../../../BSP/Source/log.c $(CFLAGS) -MMD -MP -MT$(IntermediateDirectory)/Source_log$(ObjectSuffix) -MF$(IntermediateDirectory)/Source_log$(DependSuffix) $(ObjectSwitch)$(IntermediateDirectory)/Source_log$(ObjectSuffix) $(IncludeCPath) $(IncludePackagePath)
Lst/Source_log$(PreprocessSuffix): ../../../../BSP/Source/log.c
	$(CC) $(CFLAGS)$(IncludeCPath) $(PreprocessOnlySwitch) $(OutputSwitch) Lst/Source_log$(PreprocessSuffix) ../../../../BSP/Source/log.c

$(IntermediateDirectory)/Source_tsckey$(ObjectSuffix): ../../../../BSP/Source/tsckey.c  
	$(CC) $(SourceSwitch) ../../../../BSP/Source/tsckey.c $(CFLAGS) -MMD -MP -MT$(IntermediateDirectory)/Source_tsckey$(ObjectSuffix) -MF$(IntermediateDirectory)/Source_tsckey$(DependSuffix) $(ObjectSwitch)$(IntermediateDirectory)/Source_tsckey$(ObjectSuffix) $(IncludeCPath) $(IncludePackagePath)
Lst/Source_tsckey$(PreprocessSuffix): ../../../../BSP/Source/tsckey.c
	$(CC) $(CFLAGS)$(IncludeCPath) $(PreprocessOnlySwitch) $(OutputSwitch) Lst/Source_tsckey$(PreprocessSuffix) ../../../../BSP/Source/tsckey.c

$(IntermediateDirectory)/GCC_intexc_cm32m4xxr$(ObjectSuffix): ../../../../../../Drivers/NMSIS/Device/Source/GCC/intexc_cm32m4xxr.S  
	$(AS) $(SourceSwitch) ../../../../../../Drivers/NMSIS/Device/Source/GCC/intexc_cm32m4xxr.S $(ASFLAGS) -MMD -MP -MT$(IntermediateDirectory)/GCC_intexc_cm32m4xxr$(ObjectSuffix) -MF$(IntermediateDirectory)/GCC_intexc_cm32m4xxr$(DependSuffix) $(ObjectSwitch)$(IntermediateDirectory)/GCC_intexc_cm32m4xxr$(ObjectSuffix) $(IncludeAPath) $(IncludePackagePath)
Lst/GCC_intexc_cm32m4xxr$(PreprocessSuffix): ../../../../../../Drivers/NMSIS/Device/Source/GCC/intexc_cm32m4xxr.S
	$(CC) $(CFLAGS)$(IncludeAPath) $(PreprocessOnlySwitch) $(OutputSwitch) Lst/GCC_intexc_cm32m4xxr$(PreprocessSuffix) ../../../../../../Drivers/NMSIS/Device/Source/GCC/intexc_cm32m4xxr.S

$(IntermediateDirectory)/GCC_startup_cm32m4xxr$(ObjectSuffix): ../../../../../../Drivers/NMSIS/Device/Source/GCC/startup_cm32m4xxr.S  
	$(AS) $(SourceSwitch) ../../../../../../Drivers/NMSIS/Device/Source/GCC/startup_cm32m4xxr.S $(ASFLAGS) -MMD -MP -MT$(IntermediateDirectory)/GCC_startup_cm32m4xxr$(ObjectSuffix) -MF$(IntermediateDirectory)/GCC_startup_cm32m4xxr$(DependSuffix) $(ObjectSwitch)$(IntermediateDirectory)/GCC_startup_cm32m4xxr$(ObjectSuffix) $(IncludeAPath) $(IncludePackagePath)
Lst/GCC_startup_cm32m4xxr$(PreprocessSuffix): ../../../../../../Drivers/NMSIS/Device/Source/GCC/startup_cm32m4xxr.S
	$(CC) $(CFLAGS)$(IncludeAPath) $(PreprocessOnlySwitch) $(OutputSwitch) Lst/GCC_startup_cm32m4xxr$(PreprocessSuffix) ../../../../../../Drivers/NMSIS/Device/Source/GCC/startup_cm32m4xxr.S


-include $(IntermediateDirectory)/*$(DependSuffix)
