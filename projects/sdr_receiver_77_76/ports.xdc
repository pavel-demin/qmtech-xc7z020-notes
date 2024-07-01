# clock

set_property IOSTANDARD LVDS_25 [get_ports adc_clk_p_i]
set_property IOSTANDARD LVDS_25 [get_ports adc_clk_n_i]

set_property DIFF_TERM TRUE [get_ports adc_clk_p_i]
set_property DIFF_TERM TRUE [get_ports adc_clk_n_i]

set_property PACKAGE_PIN Y19 [get_ports adc_clk_p_i]
set_property PACKAGE_PIN AA19 [get_ports adc_clk_n_i]

# overrange

set_property IOSTANDARD LVDS_25 [get_ports {adc_ovr_p_i}]
set_property IOSTANDARD LVDS_25 [get_ports {adc_ovr_n_i}]

set_property DIFF_TERM TRUE [get_ports {adc_ovr_p_i]}]
set_property DIFF_TERM TRUE [get_ports {adc_ovr_n_i}]

set_property PACKAGE_PIN U17 [get_ports {adc_ovr_p_i}]
set_property PACKAGE_PIN V17 [get_ports {adc_ovr_n_i}]

# data

set_property IOSTANDARD LVDS_25 [get_ports {adc_dat_p_i[*]}]
set_property IOSTANDARD LVDS_25 [get_ports {adc_dat_n_i[*]}]

set_property DIFF_TERM TRUE [get_ports {adc_dat_p_i[*]}]
set_property DIFF_TERM TRUE [get_ports {adc_dat_n_i[*]}]

set_property PACKAGE_PIN AA17 [get_ports {adc_dat_p_i[0]}]
set_property PACKAGE_PIN AB17 [get_ports {adc_dat_n_i[0]}]

set_property PACKAGE_PIN AA16 [get_ports {adc_dat_p_i[1]}]
set_property PACKAGE_PIN AB16 [get_ports {adc_dat_n_i[1]}]

set_property PACKAGE_PIN AB14 [get_ports {adc_dat_p_i[2]}]
set_property PACKAGE_PIN AB15 [get_ports {adc_dat_n_i[2]}]

set_property PACKAGE_PIN Y18 [get_ports {adc_dat_p_i[3]}]
set_property PACKAGE_PIN AA18 [get_ports {adc_dat_n_i[3]}]

set_property PACKAGE_PIN W17 [get_ports {adc_dat_p_i[4]}]
set_property PACKAGE_PIN W18 [get_ports {adc_dat_n_i[4]}]

set_property PACKAGE_PIN W16 [get_ports {adc_dat_p_i[5]}]
set_property PACKAGE_PIN Y16 [get_ports {adc_dat_n_i[5]}]

set_property PACKAGE_PIN Y14 [get_ports {adc_dat_p_i[6]}]
set_property PACKAGE_PIN AA14 [get_ports {adc_dat_n_i[6]}]

# SPI

set_property IOSTANDARD LVCMOS25 [get_ports adc_spi_*]

set_property PACKAGE_PIN AA13 [get_ports adc_spi_sclk]
set_property PACKAGE_PIN Y13 [get_ports adc_spi_sdio]
set_property PACKAGE_PIN U15 [get_ports adc_spi_cs]

# output enable

set_property IOSTANDARD LVCMOS25 [get_ports adc_oe]

set_property PACKAGE_PIN Y20 [get_ports adc_oe]
