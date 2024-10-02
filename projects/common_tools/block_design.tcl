# HUB

# Create axi_hub
cell pavel-demin:user:axi_hub hub_0 {
  CFG_DATA_WIDTH 64
  STS_DATA_WIDTH 32
} {
  S_AXI /ps_0/M_AXI_GP1
  aclk /pll_0/clk_out1
  aresetn /rst_0/peripheral_aresetn
}

cell pavel-demin:user:port_slicer rst_slice_0 {
  DIN_WIDTH 64 DIN_FROM 0 DIN_TO 0
} {
  din hub_0/cfg_data
}

# Create port_slicer
cell pavel-demin:user:port_slicer rst_slice_1 {
  DIN_WIDTH 64 DIN_FROM 8 DIN_TO 8
} {
  din hub_0/cfg_data
}

# Create port_slicer
cell pavel-demin:user:port_slicer cfg_slice_0 {
  DIN_WIDTH 64 DIN_FROM 63 DIN_TO 32
} {
  din hub_0/cfg_data
}

# Create port_slicer
cell pavel-demin:user:port_slicer pps_slice_0 {
  DIN_WIDTH 1 DIN_FROM 0 DIN_TO 0
} {
  din /pps_i
  dout /ps_0/GPIO_I
}

# PPS

# Create axis_pps_counter
cell pavel-demin:user:axis_pps_counter cntr_0 {
  AXIS_TDATA_WIDTH 32
  CNTR_WIDTH 32
} {
  pps_data pps_slice_0/dout
  aclk /pll_0/clk_out1
  aresetn rst_slice_0/dout
}

# Create axis_fifo
cell pavel-demin:user:axis_fifo fifo_0 {
  S_AXIS_TDATA_WIDTH 32
  M_AXIS_TDATA_WIDTH 32
  WRITE_DEPTH 1024
} {
  S_AXIS cntr_0/M_AXIS
  M_AXIS hub_0/S00_AXIS
  aclk /pll_0/clk_out1
  aresetn rst_slice_0/dout
}

# Level measurement

# Create xlconstant
cell xilinx.com:ip:xlconstant const_0

# Create axis_decimator
cell pavel-demin:user:axis_maxabs_finder maxabs_0 {
  AXIS_TDATA_WIDTH 16
  CNTR_WIDTH 32
} {
  s_axis_tdata /adc_0/m_axis_tdata
  s_axis_tvalid const_0/dout
  cfg_data cfg_slice_0/dout
  aclk /pll_0/clk_out1
  aresetn rst_slice_1/dout
}

# Create axis_fifo
cell pavel-demin:user:axis_fifo fifo_1 {
  S_AXIS_TDATA_WIDTH 16
  M_AXIS_TDATA_WIDTH 32
  WRITE_DEPTH 1024
} {
  S_AXIS maxabs_0/M_AXIS
  M_AXIS hub_0/S01_AXIS
  aclk /pll_0/clk_out1
  aresetn rst_slice_1/dout
}

# Create xlconcat
cell xilinx.com:ip:xlconcat concat_0 {
  NUM_PORTS 2
  IN0_WIDTH 16
  IN1_WIDTH 16
} {
  In0 fifo_0/read_count
  In1 fifo_1/read_count
  dout hub_0/sts_data
}