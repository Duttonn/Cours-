vlib work


vcom -2008 alu.vhd
vcom -2008 banc.vhd
vcom -2008 registrecommande.vhd
vcom -2008 decodeurinstruction.vhd
vcom -2008 instruction_memory.vhd
vcom -2008 mem.vhd
vcom -2008 Extention.vhd
vcom -2008 unite_gestion_instruction.vhd
vcom -2008 multiplexeur2vers1.vhd


vcom -2008 assemblage_utt_final.vhd
vcom -2008 assemblage_utt_final_tb.vhd

vsim assemblage_utt_final_tb

view signals
add wave -radix hexadecimal *
add wave -radix hexadecimal {sim:/assemblage_utt_final_tb/utt/bancreg/banc}
add wave -radix hexadecimal {sim:/assemblage_utt_final_tb/utt/alu/n}
add wave -radix hexadecimal {sim:/assemblage_utt_final_tb/utt/mem/banc }
add wave -radix hexadecimal {sim:/assemblage_utt_final_tb/utt/dcode/instr_courante }


run -all