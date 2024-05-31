vlib work

vcom -2008 alu.vhd
vcom -2008 banc.vhd
vcom -2008 Extention.vhd
vcom -2008 mem.vhd
vcom -2008 multiplexeur2vers1.vhd
vcom -2008 assemblage_utt.vhd
vcom -2008 assemblage_utt_tb.vhd

vsim assemblage_utt_tb

view signals

add wave -radix hexadecimal *
add wave \
{sim:/assemblage_utt_tb/entity_udt/reg/banc }
add wave \
{sim:/assemblage_utt_tb/entity_udt/mem/banc } 


run -all