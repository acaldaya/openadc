#################################################################
#
#   Initialisation of the core
#
#################################################################
set coreName "selectio_wiz_v3_2"
set TopLevel "root"

addCore "selectio_wiz_v3_2"
addTopLevel $coreName $TopLevel

# generic parameters for clocking network
addParameter $coreName $TopLevel "c_component_name"         "STRING"  "selectio_wiz_v3_2"
addParameter $coreName $TopLevel "c_device_family"        "STRING"  "spartan6"
addParameter $coreName $TopLevel "c_notes"                "STRING"  "None"
addParameter $coreName $TopLevel "c_bus_dir"              "STRING"  "Bus_Dir"
addParameter $coreName $TopLevel "c_bus_sig_type"         "STRING"  "Bus_Sig_Type"
addParameter $coreName $TopLevel "c_bus_io_std"           "STRING"  "Bus_IO_Std"
addParameter $coreName $TopLevel "c_use_serialization"    "INTEGER" "0"
addParameter $coreName $TopLevel "c_serialization_factor" "INTEGER" "2"
addParameter $coreName $TopLevel "c_use_phase_detector"   "INTEGER" "0"
addParameter $coreName $TopLevel "c_enable_bitslip"       "INTEGER" "1"
addParameter $coreName $TopLevel "c_enable_train"         "INTEGER" "0"
addParameter $coreName $TopLevel "c_train_constant"       "INTEGER" "0"
addParameter $coreName $TopLevel "c_system_data_width"    "INTEGER" "1"
addParameter $coreName $TopLevel "c_bus_in_delay"         "STRING"  "Bus_Delay"
addParameter $coreName $TopLevel "c_v6_bus_in_delay"      "STRING"  "v6_Bus_In_Delay"
addParameter $coreName $TopLevel "c_bus_in_tap"           "INTEGER" "0"
addParameter $coreName $TopLevel "c_v6_bus_in_tap"        "INTEGER" "0"
addParameter $coreName $TopLevel "c_bus_tap_reset"        "STRING"  "Bus_Tap_Reset"
addParameter $coreName $TopLevel "c_bus_tap_wrap"         "STRING"  "Bus_Tap_Wrap"
addParameter $coreName $TopLevel "c_bus_out_delay"        "STRING"  "Bus_Delay"
addParameter $coreName $TopLevel "c_v6_bus_out_delay"     "STRING"  "v6_Bus_Out_Delay"
addParameter $coreName $TopLevel "c_bus_out_tap"          "INTEGER" "0"
addParameter $coreName $TopLevel "c_v6_bus_out_tap"       "INTEGER" "0"
addParameter $coreName $TopLevel "c_clk_sig_type"         "STRING"  "Clk_Sig_Type"
addParameter $coreName $TopLevel "c_clk_io_std"           "STRING"  "Clk_IO_Std"
addParameter $coreName $TopLevel "c_v6_clk_sig_type"      "STRING"  "Clk_Sig_Type"
addParameter $coreName $TopLevel "c_v6_clk_io_std"        "STRING"  "Clk_IO_Std"
addParameter $coreName $TopLevel "c_clk_buf"              "STRING"  "Clk_Buf"
addParameter $coreName $TopLevel "c_v6_clk_buf"           "STRING"  "v6_Clk_Buf"
addParameter $coreName $TopLevel "c_active_edge"          "STRING"  "Active_Edge"
addParameter $coreName $TopLevel "c_v6_active_edge"       "STRING"  "v6_Active_Edge"
addParameter $coreName $TopLevel "c_interface_type"       "STRING"  "Interface_Type"
addParameter $coreName $TopLevel "c_v6_interface_type"    "STRING"  "v6_Interface_Type"
addParameter $coreName $TopLevel "c_ddr_alignment"        "STRING"  "DDR_Alignment"
addParameter $coreName $TopLevel "c_v6_ddr_alignment"     "STRING"  "v6_DDR_Alignment"
addParameter $coreName $TopLevel "c_v6_oddr_alignment"    "STRING"  "v6_ODDR_Alignment"
addParameter $coreName $TopLevel "c_clk_delay"            "STRING"  "Clk_Delay"
addParameter $coreName $TopLevel "c_clk_tap"              "INTEGER" "0"
addParameter $coreName $TopLevel "c_clk_tap_reset"        "STRING"  "Clk_Tap_Reset"
addParameter $coreName $TopLevel "c_clk_tap_wrap"         "STRING"  "Clk_Tap_Wrap"
addParameter $coreName $TopLevel "c_clk_fwd"              "INTEGER" "0"
addParameter $coreName $TopLevel "c_use_template"         "STRING"  "use_template"


addPort $coreName $TopLevel "DATA_IN_FROM_PINS"       "IN"    {BUS 0 0}  {DEFAULT}
addPort $coreName $TopLevel "DATA_IN_FROM_PINS_P"     "IN"    {BUS 0 0}  {DEFAULT}
addPort $coreName $TopLevel "DATA_IN_FROM_PINS_N"     "IN"    {BUS 0 0}  {DEFAULT}
addPort $coreName $TopLevel "DATA_OUT_TO_PINS"        "OUT"   {BUS 0 0}  {DEFAULT}
addPort $coreName $TopLevel "DATA_OUT_TO_PINS_P"      "OUT"   {BUS 0 0}  {DEFAULT}
addPort $coreName $TopLevel "DATA_OUT_TO_PINS_N"      "OUT"   {BUS 0 0}  {DEFAULT}
addPort $coreName $TopLevel "DATA_TO_AND_FROM_PINS"   "INOUT" {BUS 0 0}  {DEFAULT}
addPort $coreName $TopLevel "DATA_TO_AND_FROM_PINS_P" "INOUT" {BUS 0 0}  {DEFAULT}
addPort $coreName $TopLevel "DATA_TO_AND_FROM_PINS_N" "INOUT" {BUS 0 0}  {DEFAULT}
addPort $coreName $TopLevel "CLK_IN"                  "IN"    "NET"      {DEFAULT}
addPort $coreName $TopLevel "CLK_IN_P"                "IN"    "NET"      {DEFAULT}
addPort $coreName $TopLevel "CLK_IN_N"                "IN"    "NET"      {DEFAULT}
addPort $coreName $TopLevel "CLK_DIV_IN"              "IN"    "NET"      {DEFAULT}
addPort $coreName $TopLevel "CLK_DIV_OUT"             "OUT"   "NET"      {DEFAULT}
addPort $coreName $TopLevel "LOCKED_IN"               "OUT"   "NET"      {DEFAULT}
addPort $coreName $TopLevel "LOCKED_OUT"              "OUT"   "NET"      {DEFAULT}
addPort $coreName $TopLevel "DATA_IN_TO_DEVICE"       "OUT"   {BUS 0 0}  {DEFAULT}
addPort $coreName $TopLevel "DATA_OUT_FROM_DEVICE"    "IN"    {BUS 0 0}  {DEFAULT}
addPort $coreName $TopLevel "CLK_RESET"               "IN"    "NET"      {DEFAULT}
addPort $coreName $TopLevel "IO_RESET"                "IN"    "NET"      {DEFAULT}
addPort $coreName $TopLevel "DELAY_BUSY"              "IN"    "NET"      {DEFAULT}
addPort $coreName $TopLevel "DELAY_CLK"               "IN"    "NET"      {DEFAULT}
addPort $coreName $TopLevel "DELAY_CLOCK_CAL"         "IN"    "NET"      {DEFAULT}
addPort $coreName $TopLevel "DELAY_CLOCK_CE"          "IN"    "NET"      {DEFAULT}
addPort $coreName $TopLevel "DELAY_CLOCK_INC"         "IN"    "NET"      {DEFAULT}
addPort $coreName $TopLevel "DELAY_DATA_CAL"          "IN"    "NET"      {DEFAULT}
addPort $coreName $TopLevel "DELAY_DATA_CE"           "IN"    "NET"      {DEFAULT}
addPort $coreName $TopLevel "DELAY_DATA_INC"          "IN"    "NET"      {DEFAULT}
addPort $coreName $TopLevel "BITSLIP"                 "IN"    "NET"      {DEFAULT}
addPort $coreName $TopLevel "TRAIN"                   "IN"    "NET"      {DEFAULT}
addPort $coreName $TopLevel "TRISTATE_OUTPUT"         "IN"    "NET"      {DEFAULT}
addPort $coreName $TopLevel "PHASE_SHIFTOUT"          "IN"    "NET"      {DEFAULT}
addPort $coreName $TopLevel "PHASE_INCDEC"            "IN"    "NET"      {DEFAULT}
addPort $coreName $TopLevel "PHASE_VALID"             "IN"    "NET"      {DEFAULT}


addFileName $coreName $TopLevel
addDependencies $coreName $TopLevel


# Source code delivery
#---------------------------------
# clocking network
addEJavaFile $coreName $TopLevel "com.xilinx.ip.selectio_wiz_v3_2.core_v"
addEJavaFile $coreName $TopLevel "com.xilinx.ip.selectio_wiz_v3_2.core_vhd"
addEJavaFile $coreName $TopLevel "com.xilinx.ip.selectio_wiz_v3_2.phase_detector"
addEJavaFile $coreName $TopLevel "com.xilinx.ip.selectio_wiz_v3_2.phase_detector_v"
# implementable example design
addEJavaFile $coreName $TopLevel "com.xilinx.ip.selectio_wiz_v3_2.exdes_v"
addEJavaFile $coreName $TopLevel "com.xilinx.ip.selectio_wiz_v3_2.exdes_vhd"
# simulation-only testbench
addEJavaFile $coreName $TopLevel "com.xilinx.ip.selectio_wiz_v3_2.tb_v"
addEJavaFile $coreName $TopLevel "com.xilinx.ip.selectio_wiz_v3_2.tb_vhd"
addEJavaFile $coreName $TopLevel "com.xilinx.ip.selectio_wiz_v3_2.tb_timing_v"
addEJavaFile $coreName $TopLevel "com.xilinx.ip.selectio_wiz_v3_2.tb_timing_vhd"
# template
addEJavaFile $coreName $TopLevel "com.xilinx.ip.selectio_wiz_v3_2.template_v"
addEJavaFile $coreName $TopLevel "com.xilinx.ip.selectio_wiz_v3_2.template_vhd"

addEJavaFile $coreName $TopLevel "com.xilinx.ip.selectio_wiz_v3_2.xmdf_v"
addEJavaFile $coreName $TopLevel "com.xilinx.ip.selectio_wiz_v3_2.xmdf_vhd"

# simulation controls
#---------------------------------------------------------------------------
# modelsim simulation control
addEJavaFile $coreName $TopLevel "com.xilinx.ip.selectio_wiz_v3_2.simulate_mti_do"
addEJavaFile $coreName $TopLevel "com.xilinx.ip.selectio_wiz_v3_2.simulate_mti_timing_do"
addEJavaFile $coreName $TopLevel "com.xilinx.ip.selectio_wiz_v3_2.wave_do"
addEJavaFile $coreName $TopLevel "com.xilinx.ip.selectio_wiz_v3_2.wave_timing_do"
# ncsim simulation control
addEJavaFile $coreName $TopLevel "com.xilinx.ip.selectio_wiz_v3_2.simulate_ncsim_sh"
addEJavaFile $coreName $TopLevel "com.xilinx.ip.selectio_wiz_v3_2.simulate_ncsim_timing_sh"
addEJavaFile $coreName $TopLevel "com.xilinx.ip.selectio_wiz_v3_2.sdf_cmd_file"
#addEJavaFile $coreName $TopLevel "com.xilinx.ip.selectio_wiz_v3_2.wave_sv"
# isim simulation control
addEJavaFile $coreName $TopLevel "com.xilinx.ip.selectio_wiz_v3_2.simulate_isim_sh"
addEJavaFile $coreName $TopLevel "com.xilinx.ip.selectio_wiz_v3_2.simulate_isim_bat"
addEJavaFile $coreName $TopLevel "com.xilinx.ip.selectio_wiz_v3_2.simcmds_tcl"
# vcs simulation control
addEJavaFile $coreName $TopLevel "com.xilinx.ip.selectio_wiz_v3_2.simulate_vcs_sh"
addEJavaFile $coreName $TopLevel "com.xilinx.ip.selectio_wiz_v3_2.ucli_commands_key"
addEJavaFile $coreName $TopLevel "com.xilinx.ip.selectio_wiz_v3_2.vcs_session_tcl"
# implementation controls
#--------------------------------------------------------------------------
addEJavaFile $coreName $TopLevel "com.xilinx.ip.selectio_wiz_v3_2.planAhead_ise_bat"
addEJavaFile $coreName $TopLevel "com.xilinx.ip.selectio_wiz_v3_2.planAhead_ise_sh"
addEJavaFile $coreName $TopLevel "com.xilinx.ip.selectio_wiz_v3_2.planAhead_ise_tcl"
addEJavaFile $coreName $TopLevel "com.xilinx.ip.selectio_wiz_v3_2.planAhead_rdn_bat"
addEJavaFile $coreName $TopLevel "com.xilinx.ip.selectio_wiz_v3_2.planAhead_rdn_sh"
addEJavaFile $coreName $TopLevel "com.xilinx.ip.selectio_wiz_v3_2.planAhead_rdn_tcl"
addEJavaFile $coreName $TopLevel "com.xilinx.ip.selectio_wiz_v3_2.implement_sh"
addEJavaFile $coreName $TopLevel "com.xilinx.ip.selectio_wiz_v3_2.implement_bat"
addEJavaFile $coreName $TopLevel "com.xilinx.ip.selectio_wiz_v3_2.ucf"
addEJavaFile $coreName $TopLevel "com.xilinx.ip.selectio_wiz_v3_2.xdc"
# Synplicity
#--------------------------------------------------------------------------
addEJavaFile $coreName $TopLevel "com.xilinx.ip.selectio_wiz_v3_2.synplify_prj"
# XST
#--------------------------------------------------------------------------
addEJavaFile $coreName $TopLevel "com.xilinx.ip.selectio_wiz_v3_2.xst_prj"
addEJavaFile $coreName $TopLevel "com.xilinx.ip.selectio_wiz_v3_2.xst_scr"
#--------------------------------------------------------------------------
# Spyglass files
addEJavaFile $coreName $TopLevel "com.xilinx.ip.selectio_wiz_v3_2.spyglass_sh"
addEJavaFile $coreName $TopLevel "com.xilinx.ip.selectio_wiz_v3_2.spyglass_flist"
addEJavaFile $coreName $TopLevel "com.xilinx.ip.selectio_wiz_v3_2.spyglass_rule"
addEJavaFile $coreName $TopLevel "com.xilinx.ip.selectio_wiz_v3_2.spyglass_waive"
addEJavaFile $coreName $TopLevel "com.xilinx.ip.selectio_wiz_v3_2.spyglass_sgdc"
