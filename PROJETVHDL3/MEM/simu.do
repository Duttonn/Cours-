vlib work

vcom -93 mem.vhd
vcom -93 mem_tb.vhd

vsim mem_tb

view signals
add wave -radix hexadecimal *
add wave \
{sim:/mem_tb/mem/banc }


run -all