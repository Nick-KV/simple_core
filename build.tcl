#*****************************************************************************************
#
#	Core builder script 
#
#*****************************************************************************************

# Create project
create_project core_top ./project -part xc7s100fgga484-2

# Set project properties
set obj [get_projects core_top]
set_property -name "default_lib" -value "xil_defaultlib" -objects $obj
set_property -name "sim.ip.auto_export_scripts" -value "1" -objects $obj
set_property -name "simulator_language" -value "Mixed" -objects $obj
set_property -name "target_language" -value "VHDL" -objects $obj

# Set sources fileset object
add_files -norecurse ./rtl/core_top.vhd
add_files -norecurse ./rtl/alu_comb.vhd
add_files -norecurse ./rtl/top_control_unit.vhd
add_files -norecurse ./rtl/ram_primitive.vhd

set obj [get_filesets sources_1]
set_property "top" "core_top" $obj

set obj [get_filesets sim_1]
add_files -norecurse -fileset $obj ./sim/core_top_tb.vhd
add_files -norecurse -fileset $obj ./sim/wave.do
add_files -norecurse -fileset $obj ./sim/wave.wcfg
add_files -norecurse -fileset $obj ./sim/auto_testbench_pkg.vhd
add_files -norecurse -fileset $obj ./sim/test_pkg.vhd

update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

# close_project
