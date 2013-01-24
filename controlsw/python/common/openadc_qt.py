# -*- coding: cp1252 -*-

# This file is part of the OpenADC Project. See www.newae.com for more details,
# or the codebase at http://www.assembla.com/spaces/openadc .
#
# Copyright (c) 2012-2013, Colin O'Flynn <coflynn@newae.com>. All rights reserved.
# This project is released under the 2-Clause BSD License. See LICENSE
# file which should have came with this code.

import sys
import os
import threading
import time
import logging
import math
import serial
import openadc
import pyqtgraph as pg
from PySide.QtCore import *
from PySide.QtGui import *

class previewWindow():
    def __init__(self):
        pg.setConfigOption('background', 'w')
        pg.setConfigOption('foreground', 'k')
        
        self.pw = pg.PlotWidget(name="Trace Preview")
        self.pw.setLabel('bottom', 'Sample Number')
        self.pw.setLabel('left', 'Value')
        vb = self.pw.getPlotItem().getViewBox()
        vb.setMouseMode(vb.RectMode)
            
        self.dock = QDockWidget("Trace Preview")
        self.dock.setAllowedAreas(Qt.BottomDockWidgetArea | Qt.RightDockWidgetArea| Qt.LeftDockWidgetArea)
        self.dock.setWidget(self.pw)

        self.settings = QGroupBox("Trace Preview Settings");
        layout = QGridLayout()
        self.settings.setLayout(layout)

        self.persistant = QCheckBox("Persistance")
        clearPB = QPushButton("Clear")
        clearPB.clicked.connect(self.pw.clear)        
        layout.addWidget(self.persistant, 0, 0)
        layout.addWidget(clearPB, 0, 1)
        
        self.colour = QSpinBox()
        self.colour.setMinimum(0)
        self.colour.setMaximum(7)
        self.autocolour = QCheckBox("Auto Colour")
        layout.addWidget(QLabel("Colour"), 1, 0)
        layout.addWidget(self.colour, 1, 1)
        layout.addWidget(self.autocolour, 1, 2)

    def addDock(self, mainWindow):
        '''Pass the main window, adds the dock for you'''
        mainWindow.addDockWidget(Qt.BottomDockWidgetArea,self.dock)

    def getSetupWidget(self):
        '''Returns the setup widget for the preview graph'''
        return self.settings

    def updateData(self, data):
        if self.persistant.isChecked():
            if self.autocolour.isChecked():
                nc = (self.colour.value() + 1) % 8
                self.colour.setValue(nc)            
        else:
            self.pw.clear()
            
        self.pw.plot(data, pen=(self.colour.value(),8))
        

class OpenADCQt():
    def __init__(self, MainWindow=None, includePreview=True):
        self.offset = 0.5
        self.ser = None
        self.sc = None
        self.setupLayout(MainWindow, includePreview)

    def setEnabled(self, mode):        
        self.gainlow.setEnabled(mode)
        self.gainhigh.setEnabled(mode)
        self.gain.setEnabled(mode)

        self.trigmoderising.setEnabled(mode)
        self.trigmodefalling.setEnabled(mode)
        self.trigmodehigh.setEnabled(mode)
        self.trigmodelow.setEnabled(mode)

        self.phase.setEnabled(mode)
        self.clockInternal.setEnabled(mode)
        self.clockExternal.setEnabled(mode)
        

    def setupLayout(self, MainWindow, includePreview=True):
        vlayout = QVBoxLayout()
        layout = QGridLayout()
        
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
        layout.addWidget(gainsettings, 1, 0)

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
        triglayout = QGridLayout()
        triggersettings.setLayout(triglayout)
        triglayout.addWidget(self.trigmoderising, 0, 0);
        triglayout.addWidget(self.trigmodefalling, 0, 1);
        triglayout.addWidget(self.trigmodehigh, 1, 0);
        triglayout.addWidget(self.trigmodelow, 1, 1);
        layout.addWidget(triggersettings, 1, 1)

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
        layout.addWidget(clocksettings, 2, 0)

        ###### Sample Memory Setup
        samplesettings = QGroupBox("Sample Settings")
        samplelayout = QGridLayout()
        samplesettings.setLayout(samplelayout)
        self.samples = QSpinBox()
        self.samples.setMinimum(100)

        self.maxSamplesLabel = QLabel("Max Samples: ?")
        samplelayout.addWidget(self.maxSamplesLabel, 0, 0)
        samplelayout.addWidget(QLabel("Samples/Capture"), 1, 0)
        samplelayout.addWidget(self.samples, 1, 1)
        self.samples.valueChanged.connect(self.samplesChanged)
        layout.addWidget(samplesettings, 2, 1)

        ###### Status Information
        status = QGroupBox("Status")
        statuslayout = QGridLayout()
        status.setLayout(statuslayout)
        self.freqDisp = QLCDNumber(9)
        self.lockLabel = QLabel("DCM Locked: ?")
        statuslayout.addWidget(QLabel("Ext Freq:"),0,0)
        statuslayout.addWidget(self.freqDisp, 0, 1)
        statuslayout.addWidget(self.lockLabel,1,0)
        statusRefreshPB = QPushButton("Refresh")
        statusRefreshPB.clicked.connect(self.statusRefresh)
        statuslayout.addWidget(statusRefreshPB,1,1)
        self.freqDisp.setSegmentStyle(QLCDNumber.Flat)
        layout.addWidget(status, 3, 0)    

        vlayout.addLayout(layout)

        ###### Graphical Preview Window
        if includePreview:
            self.preview = previewWindow()
            self.preview.addDock(MainWindow)
            vlayout.addWidget(self.preview.getSetupWidget())
        else:
            self.preview = None
                  
        self.masterLayout = vlayout

        self.trigmode = 0
        self.hilowmode = 0

        self.setMaxSample(1000)

        self.setEnabled(False)

    def getLayout(self):
        return self.masterLayout

    def setMaxSample(self, samples):
        self.samples.setMaximum(samples)
        self.maxSamplesLabel.setText("Max Samples: %d"%samples)
        
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

        samps = self.sc.getMaxSamples()
        self.setMaxSample(samps)
        self.samples.setValue(samps)

        self.statusRefresh()

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

    def samplesChanged(self, samples):
        self.sc.setMaxSamples(samples)

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
        self.ADCsettrigmode()
        self.sc.arm()

    def ADCread(self, update=True, NumberPoints=None):
        if NumberPoints == None:
            NumberPoints = self.samples.value()

        progress = QProgressDialog("Reading", "Abort", 0, 100)
        progress.setWindowModality(Qt.WindowModal)
        progress.setMinimumDuration(1000)

        self.datapoints = self.sc.readData(NumberPoints, progress)

        if update & (self.preview != None):               
            self.preview.updateData(self.datapoints)

        return True
        
    def ADCcapture(self, update=True, NumberPoints=None):
        self.sc.capture()
        return self.ADCread(update, NumberPoints)

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

    def statusRefresh(self):
        self.freqDisp.display(self.sc.getExtFrequency())
        status = self.sc.getStatus()
        
        if status & 0x08 == 0x00:
            self.lockLabel.setText("DCM Locked: FALSE")
            self.dcmLocked = False
        else:
            self.lockLabel.setText("DCM Locked: True")
            self.dcmLocked = True

    def reset(self):
        self.sc.setReset(True)
        self.readAllSettings()

    def test(self):
        self.sc.testAndTime()

    def ADCupdate(self):
        if self.sc.getExtFrequency():
            print "Ext Freq   = %d"%self.sc.getExtFrequency()
        if self.sc.getPhase():
            print "Phase      = %d"%self.sc.getPhase()
        print "Status Reg = 0x%2x"%self.sc.getStatus()
        
    def ADCconnect(self, ser):

        self.ser = ser

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
                portname = self.ser.name
                self.ser.close()
                self.ser = None

                raise IOError("Opened port %s but failed to find OpenADC"%portname)
                #self.statusBar().showMessage("Failed to received response from USB Device")

#        self.statusBar().showMessage("Connected to ADC Module on port %s" % self.ser.portstr)

        self.readAllSettings()
        self.setEnabled(True)

    def close(self):
        if self.ser:
            self.ser.close()
            self.ser = None

    def __del__(self):
        self.close()
