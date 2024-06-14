### clock input

set_property IOSTANDARD LVCMOS33 [get_ports clk_i]
set_property PACKAGE_PIN M19 [get_ports clk_i]

### LED

set_property IOSTANDARD LVCMOS33 [get_ports led_o]
set_property SLEW SLOW [get_ports led_o]
set_property DRIVE 4 [get_ports led_o]

set_property PACKAGE_PIN P22 [get_ports led_o]

### PPS

set_property IOSTANDARD LVCMOS33 [get_ports pps_i]
set_property PACKAGE_PIN L22 [get_ports pps_i]
