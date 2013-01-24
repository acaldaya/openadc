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
import numpy

sys.path.append('../common')
import openadc
import openadc_qt
import serial
import scan
from PySide.QtCore import *
from PySide.QtGui import *

import ftd2xx as ft

import numpy as np
import scipy as sp
import matplotlib as mp
import pylab as pl

class SerialADCLayout():
    def __init__(self):
        self.gb = QGroupBox("Connection Settings");
        layout = QGridLayout()

        self.serialList = QComboBox()
        layout.addWidget(QLabel("Port:"), 0, 0)
        layout.addWidget(self.serialList, 0, 1)

        self.baud = QComboBox()
        self.baud.addItem("512000")
        self.baud.addItem("115200")
        layout.addWidget(QLabel("Baud:"), 1, 0)
        layout.addWidget(self.baud, 1, 1)
        self.gb.setLayout(layout)

        self.ser = None

    def setDisabled(self, disable):
        self.serialList.setDisabled(disable)
        self.baud.setDisabled(disable)
        
    def connect(self):
         # Open serial port if not already
         self.ser = serial.Serial()
         self.ser.port     = self.serialList.currentText()
         self.ser.baudrate = int(self.baud.currentText())
         self.ser.timeout  = 1.0     # 0.5 second timeout

         attempts = 1
         while attempts > 0:
            #if attempts > 2:
            #    self.ser.baudrate = 115200
            try:
                 self.ser.open()
                 attempts = 0
                 self.setDisabled(True)
                 return True
            except serial.SerialException, e:
                 attempts = attempts - 1
                 if attempts == 0:                     
                     QMessageBox.warning(None, "Serial Port",
                                         "Could not open %s"%self.ser.name)
                     self.ser.close()
                     self.ser = None
                     return False
            except ValueError, s:
                QMessageBox.warning(None, "Serial Port",
                                         "Invalid Settings for Port")
                self.ser.close()
                self.ser = None
                return False
         return False
        
    def getTextName(self):
        try:
            return self.ser.name
        except:
            return "None?"

    def disconnect(self):
        self.setDisabled(False)
        if self.ser:
            self.ser.close()
            self.ser = None

    def update(self):
        serialnames = scan.scan()
        for i in range(0, 255):
            self.serialList.removeItem(i)
        self.serialList.addItems(serialnames)

    def __del__(self):
        self.ser.close()

class FTDIOpenADC():
    def __init__(self, name):
        self.adc = ft.openEx(name)
        self.adc.setTimeouts(1000, 1000)
    
    def write(self, a):
        self.adc.write(str(a))

    def read(self, n):
        return self.adc.read(n)

    def flushInput(self):
        return
  
class MainWindow(QMainWindow):

    def plotSpectrum(self,y,Fs):
        """
        Plots a Single-Sided Amplitude Spectrum of y(t)
        """
        n = len(y) # length of the signal
        k = np.arange(n)
        T = n/Fs
        frq = k/T # two sides frequency range
        frq = frq[range(n/2)] # one side frequency range

        Y = sp.fft(y)/n # fft computing and normalization
        Y = Y[range(n/2)]

        pl.clf()
            
        pl.plot(frq,abs(Y),'r') # plotting the spectrum
        pl.xlabel('Freq (Hz)')
        pl.ylabel('|Y(freq)|')
        pl.show()
        pl.draw()

        if self.base == None:
            self.base = max(abs(Y))

        print "%f"%(10.0*np.log10(max(abs(Y[1:-1]))/self.base))
                     
    def ADCcapture(self):
        self.oa.ADCarm()
        self.oa.ADCcapture()

        #freq = sp.fft(self.oa.datapoints)
        #pl.plot(freq)
        #pl.show()
        #self.plotSpectrum(self.oa.datapoints, 40000000.0)

        #print "%f (3dB = %f)"%(max(self.oa.datapoints), 0.707*max(self.oa.datapoints))
              
    def ADCupdate(self):
        self.oa.ADCupdate()

    def ADCread(self):
        self.oa.ADCread();

    def ADCloop(self):
        if self.startButton.isChecked():
            self.startButton.setText("Stop Capture Loop")
        else:
            self.startButton.setText("Start Capture Loop")
        
        while self.startButton.isChecked():
            self.ADCcapture()
            QCoreApplication.processEvents()
            time.sleep(0.1)

    def conUpdate(self):
        if self.adccon:
            self.adccon.update()

    def conModeChange(self, index):
        if index == 0:
            self.adccon = self.OADC_Ser
        elif index == 1:
            self.adccon = None
        elif index == 2:
            self.adccon = None
            #layout = FTDIADCLayout()
        self.conSettings.setCurrentIndex(index)
        self.adccon.update()

    def connectClicked(self):
        if self.connectButton.isChecked():
            self.connectButton.setText("Disconnect")
            self.mode.setDisabled(True)
            self.captureButton.setDisabled(False)
            self.startButton.setDisabled(False)

            #Failed to open port
            if self.adccon.connect() == False:
                self.connectButton.setChecked(False)
                self.connectButton.setText("Connect")
                return

            #Find OpenADC
            try:
                self.oa.ADCconnect(self.adccon.ser)
            except IOError:
                QMessageBox.warning(None, "OpenADC",
                        "Opened port but failed to find OpenADC Connected")
                self.connectButton.setChecked(False)
                self.connectButton.setText("Connect")
                return
        else:
            self.connectButton.setText("Connect")
            self.mode.setDisabled(False)
            self.captureButton.setDisabled(True)
            self.startButton.setDisabled(True)
            self.adccon.disconnect()
        
    def __init__(self, parent=None):
        super(MainWindow, self).__init__(parent)

        settings = QSettings('NewAE', 'openadc-example')
        self.restoreGeometry(settings.value("geometry"))

        self.ser = None
        self.base = None
        self.plot = None

        #General stuff
        self.statusBar()
        self.setWindowTitle("OpenADC Capture App")
        self.title = QLabel("OpenADC Capture App")
        self.title.setAlignment(Qt.AlignCenter)
        flabel = self.title.font()
        flabel.setPointSize(24)
        self.title.setFont(flabel)

        ## Get an OpenADC Instance
        self.oa = openadc_qt.OpenADCQt(self);

        ##
        self.OADC_Ser = SerialADCLayout()

        #Update the list for default widget
        self.OADC_Ser.update()

        ## Setup connection
        self.conSettings = QStackedWidget()

        #Add each group box
        self.conSettings.addWidget(self.OADC_Ser.gb)
        self.conSettings.addWidget(QLabel("FX2 Not Implemented"))
        self.conSettings.addWidget(QLabel("FTDI Not Implemented"))

        self.mode = QComboBox()
        self.mode.addItem("Serial")
        self.mode.addItem("FX2 (Ztex)")
        self.mode.addItem("FTDI FIFO Mode")
        self.mode.currentIndexChanged.connect(self.conModeChange)
        
        self.connectButton = QPushButton("Connect")
        self.connectButton.setCheckable(True)
        self.connectButton.clicked.connect(self.connectClicked)

        self.refreshListButton = QPushButton("Refresh List")
        self.refreshListButton.clicked.connect(self.conUpdate)
        
        self.captureButton = QPushButton("Capture One")
        self.updateButton = QPushButton("Get Status")
        self.startButton = QPushButton("Start Capture Loop")
        self.startButton.setCheckable(True)

        
        #self.connect(self.connectButton, SIGNAL("clicked()"),self, SLOT("ADCconnect()"))
        self.connect(self.captureButton, SIGNAL("clicked()"),self, SLOT("ADCcapture()"))
        self.connect(self.updateButton, SIGNAL("clicked()"),self,SLOT("ADCupdate()"))
        self.connect(self.startButton, SIGNAL("clicked()"),self,SLOT("ADCloop()"))
        
        # Create layout and add widgets
        self.mw = QWidget()

        glayout = QGridLayout()
        
        layout = QVBoxLayout()
        
        layout.addWidget(self.title)

        layoutCon = QGridLayout()
        layoutCon.addWidget(QLabel("Mode:"), 0, 0)
        layoutCon.addWidget(self.mode, 0, 1)
        layoutCon.addWidget(self.connectButton, 1, 1)
        layoutCon.addWidget(self.refreshListButton, 2, 1)
        
        glayout.addWidget(self.conSettings, 0, 0)
        glayout.addLayout(layoutCon, 0, 1)
        #glayout.addWidget(self.serialList, 0, 0)
        #glayout.addWidget(self.connectButton, 0, 1)
        #glayout.addWidget(self.captureButton, 1, 0)
        #glayout.addWidget(self.readButton, 1, 1)
        glayout.addWidget(self.updateButton, 1, 1)
        glayout.addWidget(self.startButton, 2, 0)

        layout.addLayout(glayout)
        layout.addLayout(self.oa.getLayout())
              
        # Set dialog layout
        self.setLayout(layout)       
        self.mw.setLayout(layout)
        self.setCentralWidget(self.mw)

        self.trigmode = 0
        self.hilowmode = 0

        #Force defaults we want
        self.conModeChange(0)
        self.connectClicked()

    def closeEvent(self, event):
        settings = QSettings('NewAE', 'openadc-example')
        settings.setValue("geometry", self.saveGeometry());
        QMainWindow.closeEvent(self, event)

  
if __name__ == '__main__':
    
    # Create the Qt Application
    app = QApplication(sys.argv)
    # Create and show the form
    window = MainWindow()
    window.show()
   
    # Run the main Qt loop
    sys.exit(app.exec_())
