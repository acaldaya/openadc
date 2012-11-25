# -*- coding: cp1252 -*-

# This file is part of the OpenADC Project. See www.newae.com for more details,
# or the codebase at http://www.assembla.com/spaces/openadc .
#
# Copyright (c) 2012, Colin O'Flynn <coflynn@newae.com>. All rights reserved.
# This project is released under the Modified FreeBSD License. See LICENSE
# file which should have came with this code.

import sys
import os
import threading
import time
import logging
import math
import numpy
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

    def ADCconnect(self):

        if self.ser == None:        
            # Open serial port if not already
            self.ser = serial.Serial()
            self.ser.port     = self.serialList.currentText()
            self.ser.baudrate = 512000
            self.ser.timeout  = 1.0     # 0.5 second timeout


            attempts = 4
            while attempts > 0:
                #if attempts > 2:
                #    self.ser.baudrate = 115200
                try:
                    self.ser.open()
                    attempts = 0
                except serial.SerialException, e:
                    attempts = attempts - 1
                    if attempts == 0:
                        raise IOError("Could not open %s"%self.ser.name)
        
        self.oa.ADCconnect(self.ser)

#        self.ser = FTDIOpenADC("12345678B")
#        self.oa.ADCconnect(self.ser)

    def ADCread(self):
        self.oa.ADCread();

    def serialRefresh(self):
        serialnames = scan.scan()
        for i in range(0, 255):
            self.serialList.removeItem(i)
        self.serialList.addItems(serialnames)

    def ADCloop(self):
        while True:
            self.ADCcapture()
            QCoreApplication.processEvents()
            time.sleep(0.1)
        
    def __init__(self, parent=None):
        super(MainWindow, self).__init__(parent)

        self.ser = None
        self.base = None
        self.plot = None

        self.statusBar()
        self.setWindowTitle("OpenADC Capture App")
        self.title = QLabel("OpenADC Capture App")
        self.title.setAlignment(Qt.AlignCenter)
        flabel = self.title.font()
        flabel.setPointSize(24)
        self.title.setFont(flabel)
   

        self.serialList = QComboBox()
        self.connectButton = QPushButton("Connect")
        self.captureButton = QPushButton("Capture")
        #self.readButton = QPushButton("Re-Read")
        self.updateButton = QPushButton("Get Status")
        self.startButton = QPushButton("Start Inf")


        self.oa = openadc_qt.OpenADCQt();
        self.connect(self.connectButton, SIGNAL("clicked()"),self, SLOT("ADCconnect()"))
        self.connect(self.captureButton, SIGNAL("clicked()"),self, SLOT("ADCcapture()"))
        self.connect(self.updateButton, SIGNAL("clicked()"),self,SLOT("ADCupdate()"))
        #self.connect(self.readButton, SIGNAL("clicked()"),self,SLOT("ADCread()"))
        self.connect(self.startButton, SIGNAL("clicked()"),self,SLOT("ADCloop()"))
        
        # Create layout and add widgets
        self.mw = QWidget()

        glayout = QGridLayout()
        
        layout = QVBoxLayout()
        
        layout.addWidget(self.title)
        glayout.addWidget(self.serialList, 0, 0)
        glayout.addWidget(self.connectButton, 0, 1)
        glayout.addWidget(self.captureButton, 1, 0)
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

        self.serialRefresh()
  
if __name__ == '__main__':
    
    # Create the Qt Application
    app = QApplication(sys.argv)
    # Create and show the form
    window = MainWindow()
    window.show()
   
    # Run the main Qt loop
    sys.exit(app.exec_())
