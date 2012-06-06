HOW TO BUILD EXAMPLE DESIGN:

Example design module is placed in example_design directory during core generation. Along with example design, ucf template is also generated targeting ml605 board where User can make changes based on the device selected. To implement the example design provided, run implement.sh/implement.bat scripts based on the platform from implement directory. Use the generated bit file to configure the FPGA.

When this example design is run on analyzer, the following scenarios can be tested.

1) Shift operation is observed on each trigger port. Each trigger port can be distinguished from other trigger ports with pulse width. 

For example, consider if two trigger ports are selected of width 2, shift operation observed on each trigger port is shown below:

For TRIG0:
	           __    __    __    __    __    __    __    
TRIG0[0]:	     |__|  |__|	 |__|  |__|  |__|  |__|  |__	
                      __    __    __    __    __    __    __
TRIG0[1]:          __|  |__|  |__|  |__|  |__|  |__|  |__|   

FOR TRIG1:
                         _____       _____       _____       _____
TRIG1[0]:           ____|     |_____|     |_____|     |_____|     |_____
                    ____       _____       _____       _____       _____
TRIG1[1]:               |_____|     |_____|     |_____|     |_____|

2) If Data port is selected, Johnson Counter operation can be observed on Data port. 
3) If TRIG_OUT port is selected, shift operation is observed on VIO console. To observe walking one pattern on VIO console, enable trig_out while setting trigger condition.The option is set to DISABLED by default.

