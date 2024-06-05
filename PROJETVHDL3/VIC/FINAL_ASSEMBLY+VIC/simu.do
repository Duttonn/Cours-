vlib work


vcom -2008 alu.vhd
vcom -2008 banc.vhd
vcom -2008 vic.vhd
vcom -2008 banc.vhd
vcom -2008 registrecommande.vhd
vcom -2008 decodeurinstruction.vhd
vcom -2008 instruction_memory_IRQ.vhd
vcom -2008 mem.vhd
vcom -2008 Extention.vhd
vcom -2008 ugi.vhd
vcom -2008 multiplexeur2vers1.vhd


vcom -2008 assemblage_utt_final.vhd
vcom -2008 assemblage_utt_final_tb.vhd

vsim assemblage_utt_final_tb

view signals
add wave -radix hexadecimal *
add wave -radix hexadecimal {sim:/assemblage_utt_final_tb/utt/sig_irq } 
add wave -radix hexadecimal {sim:/assemblage_utt_final_tb/utt/bancreg/banc}
add wave -radix hexadecimal {sim:/assemblage_utt_final_tb/utt/vic/vicpc } 
add wave -radix hexadecimal {sim:/assemblage_utt_final_tb/utt/mem/banc }
add wave -radix hexadecimal {sim:/assemblage_utt_final_tb/utt/dcode/instr_courante }
add wave -radix hexadecimal {sim:/assemblage_utt_final_tb/utt/ugi/im/pc }
add wave -radix hexadecimal {sim:/assemblage_utt_final_tb/utt/dcode/instruction }
add wave -radix hexadecimal {sim:/assemblage_utt_final_tb/utt/sig_cpsr_in } 
add wave -radix hexadecimal {sim:/assemblage_utt_final_tb/utt/sig_cpsr_out }
add wave -radix hexadecimal {sim:/assemblage_utt_final_tb/utt/sig_psren }
add wave -radix hexadecimal {sim:/assemblage_utt_final_tb/utt/ugi/lr } 


run -all