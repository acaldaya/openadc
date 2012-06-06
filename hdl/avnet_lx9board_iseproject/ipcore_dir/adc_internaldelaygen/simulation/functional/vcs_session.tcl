gui_open_window Wave
gui_sg_create adc_internaldelaygen_group
gui_list_add_group -id Wave.1 {adc_internaldelaygen_group}
gui_sg_addsignal -group adc_internaldelaygen_group {adc_internaldelaygen_tb.test_phase}
gui_set_radix -radix {ascii} -signals {adc_internaldelaygen_tb.test_phase}
gui_sg_addsignal -group adc_internaldelaygen_group {{Input_clocks}} -divider
gui_sg_addsignal -group adc_internaldelaygen_group {adc_internaldelaygen_tb.CLK_IN1}
gui_sg_addsignal -group adc_internaldelaygen_group {{Output_clocks}} -divider
gui_sg_addsignal -group adc_internaldelaygen_group {adc_internaldelaygen_tb.dut.clk}
gui_list_expand -id Wave.1 adc_internaldelaygen_tb.dut.clk
gui_sg_addsignal -group adc_internaldelaygen_group {{Status_control}} -divider
gui_sg_addsignal -group adc_internaldelaygen_group {adc_internaldelaygen_tb.RESET}
gui_sg_addsignal -group adc_internaldelaygen_group {{Counters}} -divider
gui_sg_addsignal -group adc_internaldelaygen_group {adc_internaldelaygen_tb.COUNT}
gui_sg_addsignal -group adc_internaldelaygen_group {adc_internaldelaygen_tb.dut.counter}
gui_list_expand -id Wave.1 adc_internaldelaygen_tb.dut.counter
gui_zoom -window Wave.1 -full
