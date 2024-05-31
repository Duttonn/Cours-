vlib work

vcom -93 alu.vhd
vcom -93 alu_tb.vhd

vsim alu_tb

view signals
add wave -radix hexadecimal *
add wave \
{sim:/alu_tb/alu/s_resized } 

run -all