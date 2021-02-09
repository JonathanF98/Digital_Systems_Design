## This file is a general .xdc for the Nexys4 rev C board
## To use it in a project:  was modified for the ROM projecte
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

## Clock signal
#Bank = 35, Pin name = IO_L12P_T1_MRCC_35,					Sch name = CLK100MHZ
set_property PACKAGE_PIN E3 [get_ports CLK]							
	set_property IOSTANDARD LVCMOS33 [get_ports CLK]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports CLK]

set_property PACKAGE_PIN J15 [get_ports {start}]						
	set_property IOSTANDARD LVCMOS33 [get_ports {start}]




set_property PACKAGE_PIN A3 [get_ports {RED[0]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {RED[0]}]


set_property PACKAGE_PIN B4 [get_ports {RED[1]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {RED[1]}]


set_property PACKAGE_PIN C5 [get_ports {RED[2]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {RED[2]}]


set_property PACKAGE_PIN A4 [get_ports {RED[3]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {RED[3]}]


set_property PACKAGE_PIN C6 [get_ports {GRN[0]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {GRN[0]}]


set_property PACKAGE_PIN A5 [get_ports {GRN[1]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {GRN[1]}]


set_property PACKAGE_PIN B6 [get_ports {GRN[2]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {GRN[2]}]


set_property PACKAGE_PIN A6 [get_ports {GRN[3]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {GRN[3]}]


set_property PACKAGE_PIN B7 [get_ports {BLU[0]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {BLU[0]}]


set_property PACKAGE_PIN C7 [get_ports {BLU[1]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {BLU[1]}]


set_property PACKAGE_PIN D7 [get_ports {BLU[2]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {BLU[2]}]


set_property PACKAGE_PIN D8 [get_ports {BLU[3]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {BLU[3]}]


set_property PACKAGE_PIN B11 [get_ports {HSYNC}]
	set_property IOSTANDARD LVCMOS33 [get_ports {HSYNC}]


set_property PACKAGE_PIN B12 [get_ports {VSYNC}]
	set_property IOSTANDARD LVCMOS33 [get_ports {VSYNC}]

##Buttons
##Bank = 15, Pin name = IO_L3P_T0_DQS_AD1P_15,				Sch name = CPU_RESET
#set_property PACKAGE_PIN C12 [get_ports btnCpuReset]				
#	set_property IOSTANDARD LVCMOS33 [get_ports btnCpuReset]
#Bank = 15, Pin name = IO_L11N_T1_SRCC_15,					Sch name = BTNC
set_property PACKAGE_PIN N17 [get_ports {BTNC}]						
	set_property IOSTANDARD LVCMOS33 [get_ports {BTNC}]
#Bank = 15, Pin name = IO_L14P_T2_SRCC_15,					Sch name = BTNU
set_property PACKAGE_PIN M18 [get_ports {BTNU}]						
	set_property IOSTANDARD LVCMOS33 [get_ports {BTNU}]
#Bank = CONFIG, Pin name = IO_L15N_T2_DQS_DOUT_CSO_B_14,	Sch name = BTNL
set_property PACKAGE_PIN P17 [get_ports {BTNL}]						
	set_property IOSTANDARD LVCMOS33 [get_ports {BTNL}]
#Bank = 14, Pin name = IO_25_14,							Sch name = BTNR
set_property PACKAGE_PIN M17 [get_ports {BTNR}]						
	set_property IOSTANDARD LVCMOS33 [get_ports {BTNR}]
#Bank = 14, Pin name = IO_L21P_T3_DQS_14,					Sch name = BTND
set_property PACKAGE_PIN P18 [get_ports {BTND}]						
	set_property IOSTANDARD LVCMOS33 [get_ports {BTND}]