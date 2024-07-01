# Create ports
create_bd_port -dir I adc_clk_p_i
create_bd_port -dir I adc_clk_n_i

create_bd_port -dir O adc_spi_sclk
create_bd_port -dir O adc_spi_sdio
create_bd_port -dir O adc_spi_cs

create_bd_port -dir O adc_oe

# Create xlconstant
cell xilinx.com:ip:xlconstant const_0

# Create clk_wiz
cell xilinx.com:ip:clk_wiz pll_0 {
  PRIMITIVE PLL
  PRIM_IN_FREQ.VALUE_SRC USER
  PRIM_IN_FREQ 77.76
  PRIM_SOURCE Differential_clock_capable_pin
  CLKOUT1_USED true
  CLKOUT1_REQUESTED_OUT_FREQ 77.76
  USE_RESET false
} {
  clk_in1_p adc_clk_p_i
  clk_in1_n adc_clk_n_i
}

# Create processing_system7
cell xilinx.com:ip:processing_system7 ps_0 {
  PCW_IMPORT_BOARD_PRESET cfg/qmtech_xc7z020.xml
} {
  M_AXI_GP0_ACLK pll_0/clk_out1
  SPI0_SCLK_O adc_spi_sclk
  SPI0_MOSI_O adc_spi_sdio
  SPI0_SS_I const_0/dout
  SPI0_SS_O adc_spi_cs
}

# Create port_slicer
cell pavel-demin:user:port_slicer slice_0 {
  DIN_WIDTH 64 DIN_FROM 1 DIN_TO 1
} {
  din ps_0/GPIO_O
  dout adc_oe
}

# Create all required interconnections
apply_bd_automation -rule xilinx.com:bd_rule:processing_system7 -config {
  make_external {FIXED_IO, DDR}
  Master Disable
  Slave Disable
} [get_bd_cells ps_0]

# LED

# Create c_counter_binary
cell xilinx.com:ip:c_counter_binary cntr_0 {
  Output_Width 32
} {
  CLK pll_0/clk_out1
}

# Create xlslice
cell xilinx.com:ip:xlslice slice_1 {
  DIN_WIDTH 32 DIN_FROM 25 DIN_TO 25 DOUT_WIDTH 1
} {
  Din cntr_0/Q
  Dout led_o
}
