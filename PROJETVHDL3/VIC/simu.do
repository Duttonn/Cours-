vlib work

vcom -93 vic.vhd
vcom -93 vic_tb.vhd

vsim vic_tb

view signals
add wave -radix hexadecimal *

run -all