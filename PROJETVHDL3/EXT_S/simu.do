vlib work

vcom -93 Extention.vhd
vcom -93 Extention_tb.vhd

vsim Extention_tb

view signals
add wave -radix hexadecimal *


run -all