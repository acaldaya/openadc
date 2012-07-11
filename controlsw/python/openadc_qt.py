# -*- coding: cp1252 -*-
import sys
import os
import threading
import time
import logging
import math
import serial
import openadc
os.environ["QT_API"] = "pyside"
import matplotlib
matplotlib.use("Qt4Agg")
from matplotlib.backends.backend_qt4agg import FigureCanvasQTAgg as FigureCanvas
from matplotlib.figure import Figure
from PySide.QtCore import *
from PySide.QtGui import *

class pysideGraph():
    def __init__(self, name="", xmin=0, xmax=1, ymin=-1.0, ymax=1.0, xfigsize=600, yfigsize=600):
        self.gb = QGroupBox("Results Preview")
        self.fig = Figure(figsize=(xfigsize,yfigsize), dpi=72)
        self.fig_ax =  self.fig.add_subplot(111)
        self.fig_ax.plot([0,0])
        clocklayout = QVBoxLayout()
        canvas = FigureCanvas(self.fig)
        layout = QVBoxLayout()
        layout.addWidget(canvas)
        settingsLayout = QGridLayout()
      
        self.xmin = QSpinBox()
        self.xmin.setMinimum(xmin)
        self.xmin.setMaximum(xmax)
        self.xmax = QSpinBox()
        self.xmax.setMinimum(xmin)
        self.xmax.setMaximum(xmax)
        self.ymin = QDoubleSpinBox()
        self.ymin.setMinimum(ymin)
        self.ymin.setMaximum(ymax)
        self.ymin.setDecimals(5)
        self.ymax = QDoubleSpinBox()
        self.ymax.setMinimum(ymin)
        self.ymax.setMaximum(ymax)
        self.ymin.setValue(ymin)
        self.ymax.setValue(ymax)
        self.xmin.setValue(xmin)
        self.xmax.setValue(xmax)
        self.ymax.setDecimals(5)

        self.persistant = QCheckBox("Persistance")

        settingsLayout.addWidget(QLabel("X Limits:"), 0, 0)
        settingsLayout.addWidget(self.xmin, 0, 1)
        settingsLayout.addWidget(self.xmax, 0, 2)
        settingsLayout.addWidget(QLabel("Y Limits:"), 1, 0)
        settingsLayout.addWidget(self.ymin, 1, 1)
        settingsLayout.addWidget(self.ymax, 1, 2)
        settingsLayout.addWidget(self.persistant, 1, 3)
        layout.addLayout(settingsLayout)       
        self.gb.setLayout(layout)

        self.xmin.valueChanged.connect(self.updateAxis)
        self.xmax.valueChanged.connect(self.updateAxis)
        self.ymin.valueChanged.connect(self.updateAxis)
        self.ymax.valueChanged.connect(self.updateAxis)

    def getWidget(self):
        return self.gb

    def updateAxis(self):
        self.fig_ax.axis([self.xmin.value(), self.xmax.value(), self.ymin.value(), self.ymax.value()])
        self.redraw()

    def redraw(self):
        self.fig.canvas.draw()
            
    def updateData(self, data=None):
        if data:
            if self.persistant.isChecked() == False:
                self.fig_ax.cla()
                
            self.fig_ax.plot(data)

        if self.xmin.value() == self.xmax.value():
            cursettings = self.fig_ax.axis()
            self.xmin.setValue(cursettings[0])
            self.xmax.setValue(cursettings[1])
            self.ymin.setValue(cursettings[2])
            self.ymax.setValue(cursettings[3])
        else:
            self.updateAxis()

        self.redraw()

class OpenADCQt():

    def __init__(self, parent=None):
        self.offset = 0.5
        self.ser = None
        self.sc = None

        self.setupLayout(parent)

    def setupLayout(self, parent):

        layout = QVBoxLayout()

        ###### Gain Setup
        self.gain = QSpinBox()
        self.gain.setMinimum(0)
        self.gain.setMaximum(78)
        self.gain.valueChanged.connect(self.ADCsetgain)
        
        gainModeGroup = QButtonGroup()
        self.gainlow = QRadioButton("Low");
        self.gainhigh = QRadioButton("High");
        gainModeGroup.addButton(self.gainlow)
        gainModeGroup.addButton(self.gainhigh)

        #Output gain
        self.gainresults = QLabel("")
        self.updateGainLabel()

        #Connect events
        self.gainlow.clicked.connect(self.ADCsetgainmode)
        self.gainhigh.clicked.connect(self.ADCsetgainmode)

        #Add to layout
        gainsettings = QGroupBox("Gain Settings");
        gainlayout = QGridLayout()
        gainsettings.setLayout(gainlayout)
        gainlayout.addWidget(QLabel("Gain Mode: "), 0, 0);
        gainlayout.addWidget(self.gainhigh, 0, 1)
        gainlayout.addWidget(self.gainlow, 0, 2)
        gainlayout.addWidget(QLabel("Setting: "), 0, 3);
        gainlayout.addWidget(self.gain, 0, 4)
        gainlayout.addWidget(self.gainresults, 1, 0)
        layout.addWidget(gainsettings)

        #Set default
        self.gainlow.setChecked(True)

        ###### Trigger Setup
        triggerModeGroup = QButtonGroup()
        self.trigmoderising = QRadioButton("Rising Edge");
        self.trigmodefalling = QRadioButton("Falling Edge");
        self.trigmodelow = QRadioButton("Low Level");
        self.trigmodehigh = QRadioButton("High Level");
        triggerModeGroup.addButton(self.trigmoderising)
        triggerModeGroup.addButton(self.trigmodefalling)
        triggerModeGroup.addButton(self.trigmodelow)
        triggerModeGroup.addButton(self.trigmodehigh)

        self.trigmoderising.clicked.connect(self.ADCsettrigmode)
        self.trigmodefalling.clicked.connect(self.ADCsettrigmode)
        self.trigmodelow.clicked.connect(self.ADCsettrigmode)
        self.trigmodehigh.clicked.connect(self.ADCsettrigmode)
        
        #Add to layout
        triggersettings = QGroupBox("Trigger Mode")
        triglayout = QHBoxLayout()
        triggersettings.setLayout(triglayout)
        triglayout.addWidget(self.trigmoderising);
        triglayout.addWidget(self.trigmodefalling);
        triglayout.addWidget(self.trigmodehigh);
        triglayout.addWidget(self.trigmodelow);
        layout.addWidget(triggersettings)

        #Set default
        self.trigmodelow.setChecked(True)

        ###### Clock Setup
        self.phase = QSpinBox()
        self.phase.setMinimum(-255)
        self.phase.setMaximum(255)
        self.phase.valueChanged.connect(self.ADCsetclock)

        bgClockSource = QButtonGroup()
        self.clockInternal = QRadioButton("Internal");
        self.clockExternal = QRadioButton("External");
        bgClockSource.addButton(self.clockInternal)
        bgClockSource.addButton(self.clockExternal)
        self.clockInternal.clicked.connect(self.ADCSetClockSource)
        self.clockExternal.clicked.connect(self.ADCSetClockSource)

        #Set default
        self.clockInternal.setChecked(True)

        clocksettings = QGroupBox("Clock Settings")
        clocklayout = QGridLayout()
        clocksettings.setLayout(clocklayout)
        clocklayout.addWidget(QLabel("Clock Source"), 0, 0)
        clocklayout.addWidget(self.clockInternal, 0, 1)
        clocklayout.addWidget(self.clockExternal, 0, 2)
        clocklayout.addWidget(QLabel("Ext Phase Adjust"), 1, 0)
        clocklayout.addWidget(self.phase, 1, 1)
        layout.addWidget(clocksettings)

        ###### Graphical Preview Window
        self.preview = pysideGraph("Preview", 0, 5000, -0.5, 0.5)
        layout.addWidget(self.preview.getWidget())      
              
        self.masterLayout = layout

        self.trigmode = 0
        self.hilowmode = 0

    def getLayout(self):
        return self.masterLayout
        
    def readAllSettings(self):

        #Read all settings as needed
        sets = self.sc.getSettings();

        if sets & openadc.SETTINGS_GAIN_HIGH:
            self.hilowmode = openadc.SETTINGS_GAIN_HIGH
            self.gainhigh.setChecked(True)
        else:
            self.hilowmode = openadc.SETTINGS_GAIN_LOW
            self.gainlow.setChecked(True)

        if sets & openadc.SETTINGS_CLK_EXT:
            self.clockExternal.setChecked(True)
        else:
            self.clockInternal.setChecked(True)
            
        self.gain.setValue(self.sc.getGain())

        phase = self.sc.getPhase();
        if phase:
            self.phase.setValue(phase)


        case = sets & (openadc.SETTINGS_TRIG_HIGH | openadc.SETTINGS_WAIT_YES);
        if case == openadc.SETTINGS_TRIG_HIGH | openadc.SETTINGS_WAIT_YES:
            self.trigmoderising.setChecked(True)
        elif case == openadc.SETTINGS_TRIG_LOW | openadc.SETTINGS_WAIT_YES:
            self.trigmodefalling.setChecked(True)
        elif case == openadc.SETTINGS_TRIG_HIGH | openadc.SETTINGS_WAIT_NO:
            self.trigmodehigh.setChecked(True)
        else:
            self.trigmodelow.setChecked(True)

    def updateGainLabel(self):
        #GAIN (dB) = 50 (dB/V) * VGAIN - 6.5 dB, (HILO = LO)
        #GAIN (dB) = 50 (dB/V) * VGAIN + 5.5 dB, (HILO = HI)        

        gainV = (float(self.gain.value()) / 256.0) * 3.3;

        gaindb = "Internal Error"

        if self.gainlow.isChecked():
            gaindb = "Gain = " + str(50.0 * gainV - 6.5) + " dB"

        if self.gainhigh.isChecked():
            gaindb = "Gain = " + str(50.0 * gainV + 5.5) + " dB"

        self.gainresults.setText(gaindb);

    def ADCsetgain(self, pwmsetting):
        self.updateGainLabel()
        self.sc.setGain(pwmsetting)

    def ADCsetgainmode(self):
        self.updateGainLabel()

        if self.gainhigh.isChecked():
            self.hilowmode = openadc.SETTINGS_GAIN_HIGH
            self.sc.setSettings(self.sc.getSettings() | openadc.SETTINGS_GAIN_HIGH);

        if self.gainlow.isChecked():            
            self.hilowmode = openadc.SETTINGS_GAIN_LOW
            self.sc.setSettings(self.sc.getSettings() & ~openadc.SETTINGS_GAIN_HIGH);

    def processDataDDR(self, data):

        fpData = []

        lastpt = -100;

        if data[0] != 0xAC:
            self.showMessage("Unexpected sync byte: 0x%x"%data[0])
            return None

        for i in range(2, len(data)-3, 4):
            #Convert
            temppt = (data[i + 3]<<0) | (data[i + 2]<<8) | (data[i + 1]<<16) | (data[i + 0]<<24)

            #print "%x %x %x %x"%(data[i +0], data[i +1], data[i +2], data[i +3]);
            #print "%x"%temppt

            intpt1 = temppt & 0x3FF;
            intpt2 = (temppt >> 10) & 0x3FF;
            intpt3 = (temppt >> 20) & 0x3FF;
	
            #input validation test: uncomment following and use
            #ramp input on FPGA
            ##if (intpt != lastpt + 1) and (lastpt != 0x3ff):
            ##    print "intpt: %x lstpt %x\n"%(intpt, lastpt)
            ##lastpt = intpt;

            print "%x %x %x"%(intpt1, intpt2, intpt3)
            
            fpData.append(float(intpt1) / 1024.0 - self.offset)
            fpData.append(float(intpt2) / 1024.0 - self.offset)
            fpData.append(float(intpt3) / 1024.0 - self.offset)

        return fpData

    def processData(self, data):

        fpData = []

        lastpt = -100;

        if data[0] != 0xAC:
            self.showMessage("Unexpected sync byte: 0x%x"%data[0])
            return None

        for i in range(2, len(data)-1, 2):
            if (0x80 & data[i + 1]) or ((0x80 & data[i + 0]) == 0):
                self.statusBar().showMessage("Error at byte %d"%i)
                print("Bytes: %x %x"%(data[i], data[i+1]))
                return None

            #Convert
            intpt = data[i + 1] | ((data[i+0] & 0x07) << 7)

            #input validation test: uncomment following and use
            #ramp input on FPGA
            ##if (intpt != lastpt + 1) and (lastpt != 0x3ff):
            ##    print "intpt: %x lstpt %x\n"%(intpt, lastpt)
            ##lastpt = intpt;
            
            fpData.append(float(intpt) / 1024.0 - self.offset)

        return fpData

    def ADCarm(self):
        self.ADCsettrigmode();
        self.sc.setSettings(self.sc.getSettings() | 0x08);
        
    def ADCcapture(self, update=True, NumberPoints=None):

        #Wait for trigger
        status = self.sc.getStatus()

        timeout = 0;
        while (status & openadc.STATUS_FIFO_MASK) == 0:
            status = self.sc.getStatus()
            time.sleep(0.05)

            timeout = timeout + 1
            if timeout > 100:
                return False

        self.sc.setSettings(self.sc.getSettings() & ~0x08);

        if NumberPoints:
            NumberPoints = NumberPoints * 2

        #self.statusBar().showMessage("Reading Data")
        data = self.sc.sendMessage(openadc.CODE_READ, openadc.ADDR_ADCDATA, None, False, NumberPoints);

        #self.statusBar().showMessage("Received %d bytes"%len(data))

        self.datapoints = self.processDataDDR(data)

        if update:
            self.preview.updateData(self.datapoints)         

    def ADCsettrigmode(self):
        self.trigmode = 0;

        if self.trigmoderising.isChecked():
            self.trigmode = openadc.SETTINGS_TRIG_HIGH | openadc.SETTINGS_WAIT_YES;

        if self.trigmodefalling.isChecked():
            self.trigmode = openadc.SETTINGS_TRIG_LOW | openadc.SETTINGS_WAIT_YES;

        if self.trigmodehigh.isChecked():
            self.trigmode = openadc.SETTINGS_TRIG_HIGH | openadc.SETTINGS_WAIT_NO;

        if self.trigmodelow.isChecked():
            self.trigmode = openadc.SETTINGS_TRIG_LOW | openadc.SETTINGS_WAIT_NO;

        cur = self.sc.getSettings() & ~(openadc.SETTINGS_TRIG_HIGH | openadc.SETTINGS_WAIT_YES);
        self.sc.setSettings(cur | self.trigmode)

    def ADCsetclock(self, int=0):
        self.sc.setPhase(self.phase.value())               
        #print "Setting: %d %X %X"%(intval, MSB, LSB)

    def ADCSetClockSource(self):
        if self.clockInternal.isChecked():
            self.sc.setClockSource("int")

        if self.clockExternal.isChecked():
            self.sc.setClockSource("ext")

    def ADCupdate(self):
        print self.sc.getExtFrequency()
        print self.sc.getPhase()
        
    def ADCconnect(self):

        if self.ser == None:        
            # Open serial port if not already
            self.ser = serial.Serial()
            self.ser.port     = "com6"
            self.ser.baudrate = 512000;
            self.ser.timeout  = 0.5     # 0.5 second timeout



            attempts = 4
            while attempts > 0:
                try:
                    self.ser.open()
                    attempts = 0
                except serial.SerialException, e:
                    attempts = attempts - 1
                    if attempts == 0:
                        raise IOError("Could not open %s"%self.ser.name)

        #See if device seems to be attached
        self.sc = openadc.serialOpenADCInterface(self.ser)

        deviceFound = False
        numTries = 0

        #Try a few times
        while(deviceFound == False):

            if self.sc.devicePresent():
                deviceFound = True
                break

            numTries += 1

            if (numTries == 5):
                for c in msgin: print("%x")%c,
                print("")
                for c in msgout: print("%x")%c,
                print("")

                self.ser.close()
                self.ser = None

                raise IOError("Opened port %s but failed to find OpenADC"%self.ser.name)
                #self.statusBar().showMessage("Failed to received response from USB Device")

#        self.statusBar().showMessage("Connected to ADC Module on port %s" % self.ser.portstr)

        self.readAllSettings()


    def __del__(self):
        if self.ser:
            self.ser.close()    
    
