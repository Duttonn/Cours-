vlib work

vcom -2008 Extention.vhd
vcom -2008 instruction_memory_IRQ.vhd
vcom -93 vic.vhd
vcom -93 PC_Calculator.vhd
vcom -93 LR_PC_Reg.vhd
vcom -93 decodeurinstruction.vhd
vcom -93 gestionInterruptions_tb.vhd

vsim gestionInterruptions_tb

view signals
add wave -radix hexadecimal {sim:/gestioninterruptions_tb/tb_clk }
add wave -radix hexadecimal {sim:/gestioninterruptions_tb/tb_irq0 } 
add wave -radix hexadecimal {sim:/gestioninterruptions_tb/tb_irq1 }
add wave -radix hexadecimal {sim:/gestioninterruptions_tb/tb_irq } 
add wave -radix hexadecimal {sim:/gestioninterruptions_tb/tb_irq_end } 
add wave -radix hexadecimal {sim:/gestioninterruptions_tb/tb_irq_serv } 
add wave -radix hexadecimal {sim:/gestioninterruptions_tb/tb_vicpc } 
add wave -radix hexadecimal {sim:/gestioninterruptions_tb/dcode/instr_courante }
add wave -radix hexadecimal {sim:/gestioninterruptions_tb/calc/pc } 
add wave -radix hexadecimal {sim:/gestioninterruptions_tb/calc/lrout } 
add wave -radix hexadecimal {sim:/gestioninterruptions_tb/calc/npcsel }



run -all