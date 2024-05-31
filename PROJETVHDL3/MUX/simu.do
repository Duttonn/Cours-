vlib work

vcom -93 multiplexeur2vers1.vhd
vcom -93 multiplexeur2vers1_tb.vhd

vsim multiplexeur2vers1_tb

view signals
add wave -radix hexadecimal *


run -all