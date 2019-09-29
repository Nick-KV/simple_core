onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /test_v0_3_tb/uut/clk_i
add wave -noupdate /test_v0_3_tb/uut/reset_i
add wave -noupdate /test_v0_3_tb/uut/we_i
add wave -noupdate /test_v0_3_tb/uut/address_i
add wave -noupdate /test_v0_3_tb/uut/in_data_i
add wave -noupdate /test_v0_3_tb/uut/rdy_o
add wave -noupdate /test_v0_3_tb/uut/error_o
add wave -noupdate -radix decimal /test_v0_3_tb/uut/result_o
add wave -noupdate -group sig /test_v0_3_tb/uut/code_en_s
add wave -noupdate -group sig /test_v0_3_tb/uut/data_en_s
add wave -noupdate -group sig /test_v0_3_tb/uut/data_wea_s
add wave -noupdate -group sig /test_v0_3_tb/uut/data_web_s
add wave -noupdate -group sig /test_v0_3_tb/uut/load_ram_adds_s
add wave -noupdate -group sig /test_v0_3_tb/uut/load_code_s
add wave -noupdate -group sig /test_v0_3_tb/uut/load_data_s
add wave -noupdate -group sig /test_v0_3_tb/uut/alu_fin_s
add wave -noupdate -group sig /test_v0_3_tb/uut/alu_en_s
add wave -noupdate -group sig /test_v0_3_tb/uut/loading_data_s
add wave -noupdate -group sig -color {Dark Orchid} /test_v0_3_tb/uut/read_code_adds_s
add wave -noupdate -group sig -color Magenta /test_v0_3_tb/uut/read_code_s
add wave -noupdate -group sig -color {Medium Orchid} /test_v0_3_tb/uut/code_s
add wave -noupdate -group sig -color {Medium Orchid} /test_v0_3_tb/uut/read_data1_adds_s
add wave -noupdate -group sig -color {Medium Orchid} /test_v0_3_tb/uut/read_data2_adds_s
add wave -noupdate -group sig -color {Medium Orchid} /test_v0_3_tb/uut/data_b_ram_adds_s
add wave -noupdate -group sig -color Blue /test_v0_3_tb/uut/read_data1_s
add wave -noupdate -group sig -color Blue /test_v0_3_tb/uut/read_data2_s
add wave -noupdate -group sig -color Cyan /test_v0_3_tb/uut/write_data_s
add wave -noupdate -radix decimal /test_v0_3_tb/auto_tb_result_s
add wave -noupdate /test_v0_3_tb/testbench_valid_b
add wave -noupdate /test_v0_3_tb/check_result_b
add wave -noupdate -divider {ALU Comp}
add wave -noupdate /test_v0_3_tb/uut/alu_comb/alu_en_i
add wave -noupdate /test_v0_3_tb/uut/alu_comb/wr_en_o
add wave -noupdate -color {Blue Violet} /test_v0_3_tb/uut/alu_comb/code_i
add wave -noupdate -color {Slate Blue} -radix decimal /test_v0_3_tb/uut/alu_comb/data1_i
add wave -noupdate -color {Slate Blue} -radix decimal /test_v0_3_tb/uut/alu_comb/data2_i
add wave -noupdate -radix unsigned /test_v0_3_tb/uut/alu_comb/rd1_adds_i
add wave -noupdate -radix unsigned /test_v0_3_tb/uut/alu_comb/rd2_adds_i
add wave -noupdate -radix unsigned /test_v0_3_tb/uut/alu_comb/wr_adds_i
add wave -noupdate -radix decimal /test_v0_3_tb/uut/alu_comb/data_o
add wave -noupdate /test_v0_3_tb/uut/alu_comb/error_o
add wave -noupdate /test_v0_3_tb/uut/alu_comb/alu_fin_o
add wave -noupdate /test_v0_3_tb/uut/alu_comb/wr_en_s
add wave -noupdate /test_v0_3_tb/uut/alu_comb/error_s
add wave -noupdate /test_v0_3_tb/uut/alu_comb/error_add_s
add wave -noupdate /test_v0_3_tb/uut/alu_comb/error_sub_s
add wave -noupdate /test_v0_3_tb/uut/alu_comb/error_mul_s
add wave -noupdate -color Magenta -radix decimal /test_v0_3_tb/uut/alu_comb/data1_in_s
add wave -noupdate -color Magenta -radix decimal /test_v0_3_tb/uut/alu_comb/data2_in_s
add wave -noupdate -color {Lime Green} -radix decimal /test_v0_3_tb/uut/alu_comb/data_add_s
add wave -noupdate -color {Lime Green} -radix decimal /test_v0_3_tb/uut/alu_comb/data_sub_s
add wave -noupdate -color {Lime Green} -radix decimal /test_v0_3_tb/uut/alu_comb/data_mul_s
add wave -noupdate -color {Cornflower Blue} -radix decimal /test_v0_3_tb/uut/alu_comb/data_out_s
add wave -noupdate -color {Cornflower Blue} -radix decimal /test_v0_3_tb/uut/alu_comb/data_out_acc_s
add wave -noupdate -radix unsigned /test_v0_3_tb/uut/alu_comb/rd1_adds_s
add wave -noupdate -radix unsigned /test_v0_3_tb/uut/alu_comb/rd2_adds_s
add wave -noupdate /test_v0_3_tb/uut/alu_comb/wr_adds_s
add wave -noupdate /test_v0_3_tb/uut/alu_comb/high_mul_s
add wave -noupdate -divider mem
add wave -noupdate /test_v0_3_tb/uut/command_RAM_inst/RAM
add wave -noupdate -radix decimal -childformat {{/test_v0_3_tb/uut/data1_RAM_inst/RAM(63) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(62) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(61) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(60) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(59) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(58) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(57) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(56) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(55) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(54) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(53) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(52) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(51) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(50) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(49) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(48) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(47) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(46) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(45) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(44) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(43) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(42) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(41) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(40) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(39) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(38) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(37) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(36) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(35) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(34) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(33) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(32) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(31) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(30) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(29) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(28) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(27) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(26) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(25) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(24) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(23) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(22) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(21) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(20) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(19) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(18) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(17) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(16) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(15) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(14) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(13) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(12) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(11) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(10) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(9) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(8) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(7) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(6) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(5) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(4) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(3) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(2) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(1) -radix decimal} {/test_v0_3_tb/uut/data1_RAM_inst/RAM(0) -radix decimal}} -subitemconfig {/test_v0_3_tb/uut/data1_RAM_inst/RAM(63) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(62) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(61) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(60) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(59) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(58) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(57) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(56) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(55) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(54) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(53) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(52) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(51) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(50) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(49) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(48) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(47) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(46) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(45) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(44) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(43) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(42) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(41) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(40) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(39) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(38) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(37) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(36) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(35) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(34) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(33) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(32) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(31) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(30) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(29) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(28) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(27) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(26) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(25) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(24) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(23) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(22) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(21) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(20) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(19) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(18) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(17) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(16) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(15) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(14) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(13) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(12) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(11) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(10) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(9) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(8) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(7) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(6) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(5) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(4) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(3) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(2) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(1) {-height 15 -radix decimal} /test_v0_3_tb/uut/data1_RAM_inst/RAM(0) {-height 15 -radix decimal}} /test_v0_3_tb/uut/data1_RAM_inst/RAM
add wave -noupdate /test_v0_3_tb/uut/data2_RAM_inst/RAM
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3651 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 155
configure wave -valuecolwidth 68
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {3990 ns}
