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
  
class MainWindow(QMainWindow):
                     
    def ADCcapture(self):
        self.oa.ADCarm()
        self.oa.ADCcapture()
              
    def ADCupdate(self):
        self.oa.ADCupdate()

    def ADCconnect(self):

        if self.ser == None:        
            # Open serial port if not already
            self.ser = serial.Serial()
            self.ser.port     = self.serialList.currentText()
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
        
        self.oa.ADCconnect(self.ser)

    def ADCread(self):
        self.oa.ADCread();

    def serialRefresh(self):
        serialnames = scan.scan()
        for i in range(0, 255):
            self.serialList.removeItem(i)
        self.serialList.addItems(serialnames)
        
    def __init__(self, parent=None):
        super(MainWindow, self).__init__(parent)

        self.ser = None

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
        self.readButton = QPushButton("Re-Read")
        self.updateButton = QPushButton("Get Status")


        self.oa = openadc_qt.OpenADCQt();
        self.connect(self.connectButton, SIGNAL("clicked()"),self, SLOT("ADCconnect()"))
        self.connect(self.captureButton, SIGNAL("clicked()"),self, SLOT("ADCcapture()"))
        self.connect(self.updateButton, SIGNAL("clicked()"),self,SLOT("ADCupdate()"))
        self.connect(self.readButton, SIGNAL("clicked()"),self,SLOT("ADCread()"))
       
        
        # Create layout and add widgets
        self.mw = QWidget()

        glayout = QGridLayout()
        
        layout = QVBoxLayout()
        
        layout.addWidget(self.title)
        glayout.addWidget(self.serialList, 0, 0)
        glayout.addWidget(self.connectButton, 0, 1)
        glayout.addWidget(self.captureButton, 1, 0)
        glayout.addWidget(self.readButton, 1, 1)
        glayout.addWidget(self.updateButton, 2, 0)

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
