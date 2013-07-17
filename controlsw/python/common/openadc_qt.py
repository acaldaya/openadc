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

from PySide.QtCore import *
from PySide.QtGui import *

try:
    import pyqtgraph as pg
except ImportError:
    print "*************************************************"
    print "*************************************************"
    print "Install pyqtgraph from http://www.pyqtgraph.org"
    print "*************************************************"
    print "*************************************************"

def freqToText(freqInHz):
    fmhz = float(freqInHz) / 1000000.0
    return "%1.4f MHz"%fmhz
    

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

    def hideGraph(self):
        self.dock.close()
        

class OpenADCQt(QObject):
    
    dataUpdated = Signal(list)
    
    def __init__(self, MainWindow=None, includePreview=True, setupLayout=True):
        super(OpenADCQt,  self).__init__()
        self.offset = 0.5
        self.ser = None
        self.sc = None

        self.datapoints = []

        self.preview = None

        self.timerStatusRefresh = QTimer(self)
        self.timerStatusRefresh.timeout.connect(self.statusRefresh)

        if setupLayout:
            self.setupLayout(MainWindow, includePreview)

    def setEnabled(self, mode):        
        self.gainlow.setEnabled(mode)
        self.gainhigh.setEnabled(mode)
        self.gain.setEnabled(mode)

        self.trigmoderising.setEnabled(mode)
        self.trigmodefalling.setEnabled(mode)
        self.trigmodehigh.setEnabled(mode)
        self.trigmodelow.setEnabled(mode)
        self.trigmodeextsimple.setEnabled(mode)

        self.phase.setEnabled(mode)
        #self.clockInternal.setEnabled(mode)
        #self.clockExternal.setEnabled(mode)    

    def setupWidgets(self):

        ###### Various System Information
        self.systemWidget = QWidget()
        syslayout = QGridLayout()
        self.systemWidget.setLayout(syslayout)
        self.verText = QLineEdit()
        self.verText.setReadOnly(True)
        self.synText = QLineEdit()
        self.synText.setReadOnly(True)
        self.sysFreq = QLineEdit()
        self.sysFreq.setReadOnly(True)
        syslayout.addWidget(QLabel("HW Version:"), 0, 0)
        syslayout.addWidget(self.verText, 0, 1)
        syslayout.addWidget(QLabel("HW Synth Date:"), 1, 0)
        syslayout.addWidget(self.synText, 1, 1)
        syslayout.addWidget(QLabel("System Freq:"), 2, 0)
        syslayout.addWidget(self.sysFreq, 2, 1)
        
        ###### Gain Setup
        self.gainWidget = QWidget()
        
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
        
        gainlayout = QGridLayout()
        self.gainWidget.setLayout(gainlayout)
        gainlayout.addWidget(QLabel("Gain Mode: "), 0, 0);
        gainlayout.addWidget(self.gainhigh, 0, 1)
        gainlayout.addWidget(self.gainlow, 0, 2)
        gainlayout.addWidget(QLabel("Setting: "), 0, 3);
        gainlayout.addWidget(self.gain, 0, 4)
        gainlayout.addWidget(self.gainresults, 1, 0)

        #Set default
        self.gainlow.setChecked(True)

        ###### Trigger Setup - Basic
        basictriggerModeGroup = QButtonGroup()
        self.trigmoderising = QRadioButton("Rising Edge")
        self.trigmodefalling = QRadioButton("Falling Edge")
        self.trigmodelow = QRadioButton("Low Level")
        self.trigmodehigh = QRadioButton("High Level")
        basictriggerModeGroup.addButton(self.trigmoderising)
        basictriggerModeGroup.addButton(self.trigmodefalling)
        basictriggerModeGroup.addButton(self.trigmodelow)
        basictriggerModeGroup.addButton(self.trigmodehigh)

        self.trigmoderising.clicked.connect(self.ADCsettrigmode)
        self.trigmodefalling.clicked.connect(self.ADCsettrigmode)
        self.trigmodelow.clicked.connect(self.ADCsettrigmode)
        self.trigmodehigh.clicked.connect(self.ADCsettrigmode)

        ###### Trigger Setup - General
        triggerModeGroup = QButtonGroup()
        self.trigmodeextsimple = QRadioButton("Digital")
        self.trigmodeintsimple = QRadioButton("Analog")
        triggerModeGroup.addButton(self.trigmodeextsimple)
        triggerModeGroup.addButton(self.trigmodeintsimple)
        self.trigmodeextsimple.setChecked(True)
        self.trigmodeextsimple.clicked.connect(self.ADCsettrigmode)
        self.trigmodeintsimple.clicked.connect(self.ADCsettrigmode)
        self.trigmodeintsimple.setEnabled(False)
                
        ###### Trigger Setup - Timeout
        self.trigTimeout = QDoubleSpinBox()
        self.trigTimeout.setMinimum(0.01)
        self.trigTimeout.setMaximum(5)
        self.trigTimeout.setSuffix("S")
        self.trigTimeout.setDecimals(2)
        self.trigTimeout.valueChanged.connect(self.timeoutValidate)
        
        self.timeoutInf = QCheckBox("Timeout Infinite")
        self.timeoutInf.clicked.connect(self.timeoutValidate)
        
        ###### Trigger Setup - Offset
        self.trigOffset = QSpinBox()
        self.trigOffset.setMinimum(0)
        self.trigOffset.setMaximum(100000) #Artificial limit - HW can do 2^32 max
        self.trigOffset.valueChanged.connect(self.offsetChanged)
                
        #Add to layout
        self.triggerWidget = QWidget()
        triglayout = QHBoxLayout()
        self.triggerWidget.setLayout(triglayout)
        
        simpletrig = QGroupBox("Level/Edge")        
        simpletriglayout = QGridLayout()
        simpletrig.setLayout(simpletriglayout)
        simpletriglayout.addWidget(self.trigmoderising, 0, 0)
        simpletriglayout.addWidget(self.trigmodefalling, 0, 1)
        simpletriglayout.addWidget(self.trigmodehigh, 1, 0)
        simpletriglayout.addWidget(self.trigmodelow, 1, 1)
        triglayout.addWidget(simpletrig)

        trigmode = QGroupBox("Mode")
        trigmodelayout = QVBoxLayout()
        trigmode.setLayout(trigmodelayout)
        trigmodelayout.addWidget(self.trigmodeextsimple)
        trigmodelayout.addWidget(self.trigmodeintsimple)
        triglayout.addWidget(trigmode)
        
        trigtime = QGroupBox("Timeout")
        trigtimelayout = QVBoxLayout()
        trigtime.setLayout(trigtimelayout)
        trigtimelayout.addWidget(self.trigTimeout)
        trigtimelayout.addWidget(self.timeoutInf)
        triglayout.addWidget(trigtime)
        
        trigoffset = QGroupBox("Offset")
        trigoffsetlayout = QHBoxLayout()
        trigoffset.setLayout(trigoffsetlayout)
        trigoffsetlayout.addWidget(self.trigOffset)
        triglayout.addWidget(trigoffset)
        
        #Set default
        self.trigmodelow.setChecked(True)
        
        ###### Sample Memory Setup
        self.samplesWidget = QWidget()
        samplelayout = QGridLayout()
        self.samplesWidget.setLayout(samplelayout)
        self.samples = QSpinBox()
        self.samples.setMinimum(100)

        self.maxSamplesLabel = QLabel("Max Samples: ?")
        samplelayout.addWidget(self.maxSamplesLabel, 0, 0)
        samplelayout.addWidget(QLabel("Samples/Capture"), 1, 0)
        samplelayout.addWidget(self.samples, 1, 1)
        self.samples.valueChanged.connect(self.samplesChanged)
    
        ####### Master Clock
        self.clockWidget = QWidget()
        mclocklayout = QVBoxLayout()
        self.clockWidget.setLayout(mclocklayout)


        #Refresh Settings
        reflayout = QHBoxLayout()
        reflayout.addStretch()
        statusRefreshCB = QCheckBox("Auto Refresh")
        statusRefreshCB.stateChanged.connect(self.statusRefreshAuto)
        statusRefreshPB = QPushButton("Refresh Clock Status")
        statusRefreshPB.clicked.connect(self.statusRefresh)
        reflayout.addWidget(statusRefreshCB)
        reflayout.addWidget(statusRefreshPB)
        reflayout.addStretch()
        mclocklayout.addLayout(reflayout)
        

        ##### ADC Clock Setup
        clocksettings = QGroupBox("ADC Clock Settings")
        clocklayout = QHBoxLayout()
        clocksettings.setLayout(clocklayout)
        
        self.phase = QSpinBox()
        self.phase.setMinimum(-255)
        self.phase.setMaximum(255)
        self.phase.valueChanged.connect(self.ADCsetclock)       

        self.cbClockSource = QComboBox()
        #DCM Used, Mask, Bits
        self.cbClockSource.addItem("EXTCLK Direct", ["extclk", 4, "clkgen"])
        self.cbClockSource.addItem("EXTCLK x4 via DCM", ["dcm", 4, "extclk"])
        self.cbClockSource.addItem("EXTCLK x1 via DCM", ["dcm", 1, "extclk"])
        self.cbClockSource.addItem("CLKGEN x4 via DCM", ["dcm", 4, "clkgen"])
        self.cbClockSource.addItem("CLKGEN x1 via DCM", ["dcm", 1, "clkgen"])
        self.cbClockSource.currentIndexChanged.connect(self.ADCSetClockSource)

        self.adcfreqDisp = QLineEdit()
        self.adcfreqDisp.setReadOnly(True)

        self.adcdcmLockedButton = QPushButton("UNLOCKED")
        self.adcdcmLockedButton.clicked.connect(self.resetDCM)

        cslayout = QHBoxLayout()
        cslayout.addWidget(QLabel("Source:"))
        cslayout.addWidget(self.cbClockSource)
        clocklayout.addLayout(cslayout)

        palayout = QHBoxLayout()
        palayout.addWidget(QLabel("Phase Adjust:"))
        palayout.addWidget(self.phase)
        clocklayout.addLayout(palayout)

        frlayout = QHBoxLayout()
        frlayout.addWidget(QLabel("ADC Freq:"))
        frlayout.addWidget(self.adcfreqDisp)
        clocklayout.addLayout(frlayout)

        btlayout = QHBoxLayout()
        btlayout.addWidget(self.adcdcmLockedButton)
        clocklayout.addLayout(btlayout)        
        mclocklayout.addWidget(clocksettings)        
        
        ##### EXTCLK Setup
        extclocksettings = QGroupBox("EXTCLK Settings")
        extclocklayout = QHBoxLayout()
        extclocksettings.setLayout(extclocklayout)

        self.extcbClockSource = QComboBox()
        self.extcbClockSource.addItem("Default")

        self.extfreqDisp = QLineEdit()
        self.extfreqDisp.setReadOnly(True)

        cslayout = QHBoxLayout()
        cslayout.addWidget(QLabel("Source:"))
        cslayout.addWidget(self.extcbClockSource)
        extclocklayout.addLayout(cslayout)

        frlayout = QHBoxLayout()
        frlayout.addWidget(QLabel("EXT Freq:"))
        frlayout.addWidget(self.extfreqDisp)
        extclocklayout.addLayout(frlayout)

        mclocklayout.addWidget(extclocksettings)        

        ##### CLKGEN Setup
        genclocksettings = QGroupBox("CLKGEN Settings")
        genclocklayout = QVBoxLayout()
        genclocksettings.setLayout(genclocklayout)

        self.gencbClockSource = QComboBox()
        self.gencbClockSource.addItem("System", 0x08, 0x00)
        self.gencbClockSource.addItem("EXTCLK", 0x08, 0x08)

        self.cbGenClockMul = QComboBox()
        self.cbGenClockMul.addItem("x2")
        
        self.cbGenClockDiv = QComboBox()
        self.cbGenClockDiv.addItem("/2")
        
        self.genoutputcbClockSource = QComboBox()
        #self.genoutputcbClockSource.addItem("Disabled")
        self.genoutputcbClockSource.addItem("/4")

        self.gendcmLockedButton = QPushButton("UNLOCKED")
        self.gendcmLockedButton.clicked.connect(self.resetDCM)

        cgsource = QHBoxLayout()
        cgsource.addWidget(QLabel("CLKFX = "))
        cgsource.addWidget(self.gencbClockSource)
        cgsource.addWidget(self.cbGenClockMul)
        cgsource.addWidget(self.cbGenClockDiv)

        cgdevice = QHBoxLayout()
        cgdevice.addWidget(QLabel("DEVCLK = CLKFX"))
        cgdevice.addWidget(self.genoutputcbClockSource)

        genclocklayout.addLayout(cgsource)
        genclocklayout.addLayout(cgdevice)
        genclocklayout.addWidget(self.gendcmLockedButton)
        
        mclocklayout.addWidget(genclocksettings)

    def setupLayout(self, MainWindow, includePreview=True):
        self.setupWidgets()
    
        vlayout = QVBoxLayout()
        self.tb = QToolBox()
        vlayout.addWidget(self.tb)
        self.tb.addItem(self.systemWidget, "System Information")
        self.tb.addItem(self.gainWidget, "Gain Settings")
        self.tb.addItem(self.triggerWidget, "Trigger Settings")
        self.tb.addItem(self.samplesWidget, "Sample Settings")
        self.tb.addItem(self.clockWidget, "Clock Setup")
 

        ###### Graphical Preview Window
        if includePreview:
            self.preview = previewWindow()
            self.preview.addDock(MainWindow)
            vlayout.addWidget(self.preview.getSetupWidget())           
                  
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
        
    def offsetChanged(self, newoffset):
        self.sc.setTriggerOffset(newoffset)
        
    def readAllSettings(self):
        #Read all settings as needed
        sets = self.sc.getSettings();

        if sets & openadc.SETTINGS_GAIN_HIGH:
            self.hilowmode = openadc.SETTINGS_GAIN_HIGH
            self.gainhigh.setChecked(True)
        else:
            self.hilowmode = openadc.SETTINGS_GAIN_LOW
            self.gainlow.setChecked(True)
           
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

        self.trigOffset.setValue(int(self.sc.getTriggerOffset()))

        self.updateSystemLabel()

        self.statusRefresh()

    def updateSystemLabel(self):
        verinfo = self.sc.getVersions()

        self.verText.setText("Registers = %d, Hardware = %d (%s), Version = %d"%(
                            verinfo[0], verinfo[1], verinfo[2], verinfo[3]))
        self.synText.setText("Unknown")
        self.sysFreq.setText(freqToText(self.sc.getSysFrequency()))

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

        self.dataUpdated.emit(self.datapoints)

        if update & (self.preview is not None):               
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

    def timeoutValidate(self, arg=None):
        if self.trigTimeout.isChecked():
            self.trigTimeout.setEnabled(False)
            self.sc.timeout = 1E99
        else:
            self.trigTimeout.setEnabled(True)
            self.sc.timeout = self.trigTimeout.value()

    def ADCsetclock(self, int=0):
        self.sc.setPhase(self.phase.value())               
        #print "Setting: %d %X %X"%(intval, MSB, LSB)

    def ADCSetClockSource(self):
        settings = self.cbClockSource.itemData(self.cbClockSource.currentIndex())
        self.sc.setADCClk(settings[0], settings[1], settings[2])        

    def statusRefreshAuto(self, doAuto):        
        if doAuto:
            self.timerStatusRefresh.start(1000)
        else:
            self.timerStatusRefresh.stop()     

    def statusRefresh(self):
        self.adcfreqDisp.setText(freqToText(self.sc.getAdcFrequency()))
        self.extfreqDisp.setText(freqToText(self.sc.getExtFrequency()))

        #Check if DCM are locked
        statuses = self.sc.getDCMStatus()

        if statuses[0] == True:
            self.adcdcmLockedButton.setText("locked")
        else:
            self.adcdcmLockedButton.setText("UNLOCKED")

        if statuses[1] == True:
            self.gendcmLockedButton.setText("locked")
        else:
            self.gendcmLockedButton.setText("UNLOCKED")

        #Update other settings too
        adcDCM = self.sc.getADCClk()
        
        indx = self.cbClockSource.findData(adcDCM)
        if indx < 0:
            print "internal error?"
        else:
            self.cbClockSource.setCurrentIndex(indx)
                                                         
    def resetDCM(self):
        self.sc.resetDCMs()

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

    def closeAndHide(self):
        self.close()
        if self.preview:
            self.preview.hideGraph()

    def __del__(self):
        self.close()

        
