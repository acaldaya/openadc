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
from PySide.QtCore import *
from PySide.QtGui import *
  
class MainWindow(QMainWindow):
                     
    def ADCcapture(self):
        self.oa.ADCarm()
        self.oa.ADCcapture()
              
    def ADCupdate(self):
        self.oa.ADCupdate()

    def ADCconnect(self):
        self.oa.ADCconnect()
        
    def __init__(self, parent=None):
        super(MainWindow, self).__init__(parent)

        self.statusBar()
        self.setWindowTitle("ADC Capture App")
        self.title = QLabel("ADC Capture App")
        self.title.setAlignment(Qt.AlignCenter)
        flabel = self.title.font()
        flabel.setPointSize(24)
        self.title.setFont(flabel)
   
        self.connectButton = QPushButton("Connect to ADC Board")
        self.captureButton = QPushButton("Capture")
        self.updateButton = QPushButton("Get Status")


        self.oa = openadc_qt.OpenADCQt();
        self.connect(self.connectButton, SIGNAL("clicked()"),self, SLOT("ADCconnect()"))
        self.connect(self.captureButton, SIGNAL("clicked()"),self, SLOT("ADCcapture()"))
        self.connect(self.updateButton, SIGNAL("clicked()"),self,SLOT("ADCupdate()"))
       
        
        # Create layout and add widgets
        self.mw = QWidget()
        layout = QVBoxLayout()
        
        layout.addWidget(self.title)
        layout.addWidget(self.connectButton)
        layout.addWidget(self.captureButton)
        layout.addWidget(self.updateButton)

        layout.addLayout(self.oa.getLayout())
              
        # Set dialog layout
        self.setLayout(layout)       
        self.mw.setLayout(layout)
        self.setCentralWidget(self.mw)

        self.trigmode = 0
        self.hilowmode = 0
  
if __name__ == '__main__':
    
    # Create the Qt Application
    app = QApplication(sys.argv)
    # Create and show the form
    window = MainWindow()
    window.show()
   
    # Run the main Qt loop
    sys.exit(app.exec_())
