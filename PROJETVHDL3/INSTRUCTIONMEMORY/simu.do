vlib work

vcom -93 Extention.vhd
vcom -93 instruction_memory.vhd
vcom -93 unite_gestion_instruction.vhd
vcom -93 unite_gestion_instruction_tb.vhd

vsim unite_gestion_instruction_tb

view signals
add wave -radix hexadecimal *
add wave \
{sim:/unite_gestion_instruction_tb/ugi/pc } 



run -all