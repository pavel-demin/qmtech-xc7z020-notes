# Create ports
create_bd_port -dir I adc_clk_p_i
create_bd_port -dir I adc_clk_n_i

create_bd_port -dir I adc_ovr_p_i
create_bd_port -dir I adc_ovr_n_i

create_bd_port -dir I -from 6 -to 0 adc_dat_p_i
create_bd_port -dir I -from 6 -to 0 adc_dat_n_i

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
  PCW_USE_M_AXI_GP1 1
} {
  M_AXI_GP0_ACLK pll_0/clk_out1
  M_AXI_GP1_ACLK pll_0/clk_out1
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

# Create proc_sys_reset
cell xilinx.com:ip:proc_sys_reset rst_0 {} {
  ext_reset_in const_0/dout
  dcm_locked pll_0/locked
  slowest_sync_clk pll_0/clk_out1
}

# ADC

# Create util_ds_buf
cell xilinx.com:ip:util_ds_buf buf_0 {
  C_SIZE 7
  C_BUF_TYPE IBUFDS
} {
  IBUF_DS_P adc_dat_p_i
  IBUF_DS_N adc_dat_n_i
}

# Create axis_dac
cell pavel-demin:user:axis_adc_ddr adc_0 {
  ADC_DATA_WIDTH 7
} {
  aclk pll_0/clk_out1
  adc_data buf_0/IBUF_OUT
}

# RX 0

module rx_0 {
  source projects/sdr_receiver_hpsdr_77_76/rx.tcl
} {
  hub_0/S_AXI ps_0/M_AXI_GP0
}

# RX 1

module rx_1 {
  source projects/sdr_receiver_hpsdr_77_76/rx.tcl
} {
  hub_0/S_AXI ps_0/M_AXI_GP1
}

