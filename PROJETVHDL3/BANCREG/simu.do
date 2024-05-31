vlib work

vcom -2008 alu.vhd
vcom -2008 banc.vhd
vcom -2008 unite_traitement.vhd
vcom -2008 unite_traitement_tb.vhd

vsim unite_traitement_tb

view signals
add wave -radix hexadecimal * 
add wave -radix hexadecimal \
{sim:/unite_traitement_tb/uut/u1/banc } 

run -all
