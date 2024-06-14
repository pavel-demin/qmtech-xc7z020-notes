### clock

set_property IOSTANDARD LVDS_25 [get_ports adc_clk_p_i]
set_property IOSTANDARD LVDS_25 [get_ports adc_clk_n_i]

set_property DIFF_TERM TRUE [get_ports adc_clk_p_i]
set_property DIFF_TERM TRUE [get_ports adc_clk_n_i]

set_property PACKAGE_PIN Y19 [get_ports adc_clk_p_i]
set_property PACKAGE_PIN AA19 [get_ports adc_clk_n_i]

# SPI

set_property IOSTANDARD LVCMOS25 [get_ports adc_spi_*]
set_property SLEW SLOW [get_ports adc_spi_*]
set_property DRIVE 4 [get_ports adc_spi_*]

set_property PACKAGE_PIN AA13 [get_ports adc_spi_sclk]
set_property PACKAGE_PIN Y13 [get_ports adc_spi_sdio]
set_property PACKAGE_PIN U15 [get_ports adc_spi_cs]

# TEST

set_property IOSTANDARD LVCMOS33 [get_ports tst_spi_*]
set_property SLEW SLOW [get_ports tst_spi_*]
set_property DRIVE 4 [get_ports tst_spi_*]

set_property PACKAGE_PIN L22 [get_ports tst_spi_sclk]
set_property PACKAGE_PIN K20 [get_ports tst_spi_sdio]
set_property PACKAGE_PIN J22 [get_ports tst_spi_cs]

# output enable

set_property IOSTANDARD LVCMOS25 [get_ports adc_oe]

set_property PACKAGE_PIN Y20 [get_ports adc_oe]
