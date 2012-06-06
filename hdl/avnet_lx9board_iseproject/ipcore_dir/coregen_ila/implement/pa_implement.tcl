add_files -norecurse {../example_design/example_coregen_ila.v}
add_files -norecurse {../example_design/example_coregen_ila.ucf}
import_ip -file {chipscope_icon.xco} -name chipscope_icon
set_property top example_coregen_ila [get_filesets sources_1]
reset_run -run synth_1
launch_runs synth_1
