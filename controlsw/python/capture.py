# -*- coding: cp1252 -*-
import sys
import os
import threading
import time
import serial
import logging
import math
import numpy
from PySide.QtCore import *
from PySide.QtGui import *

ADDR_GAIN       = 0
ADDR_SETTINGS   = 1
ADDR_STATUS     = 2
ADDR_ADCDATA    = 3
ADDR_ECHO       = 4
ADDR_FREQ1      = 5
ADDR_FREQ2      = 6
ADDR_FREQ3      = 7
ADDR_FREQ4      = 8

CODE_READ       = 0x80
CODE_WRITE      = 0xC0

SETTINGS_GAIN_HIGH = 0x02
SETTINGS_GAIN_LOW  = 0x00
SETTINGS_TRIG_HIGH = 0x04
SETTINGS_TRIG_LOW  = 0x00
SETTINGS_ARM       = 0x08
SETTINGS_WAIT_YES  = 0x20
SETTINGS_WAIT_NO   = 0x00

STATUS_ARM_MASK    = 0x01
STATUS_FIFO_MASK   = 0x02
STATUS_EXT_MASK    = 0x04

class serialComm:
    def __init__(self, serial_instance, debug=None):
        self.serial = serial_instance
        self.log = logging.getLogger('serialUsb')

        #Send clearing function
        nullmessage = bytearray([20])
        
        self.serial.write(nullmessage);
    
    def sendMessage(self, mode, address, payload=None):
        """Send a message out the serial port"""

        if payload is None:
          payload = []

        #Get length
        length = len(payload)

        if ((mode == CODE_WRITE) and (length != 1)) or ((mode == CODE_READ) and (length != 0)):
            self.log.error("Invalid payload for mode")
            return None

        #Flip payload around
        pba = bytearray(payload)
        
        ### Setup Message
        message = bytearray([])

        #Message type
        message.append(mode | address)
        message = message + pba

        ### Send out serial port
        self.serial.write(message)

        ### Wait Response (if requested)
        if (mode == CODE_READ):

            if (ADDR_ADCDATA == address):
                datalen = 5000
            else:
                datalen = 1
            
            result = self.serial.read(datalen)

            #Check for timeout, if so abort
            if len(result) < 1:
                self.serial.flushInput()
                self.log.error("Timeout: %d"%len(result))
                return None

            rb = bytearray(result)

            return rb
        else:
            check = self.sendMessage(CODE_READ, address)
            if check != pba:
                self.log.error("Command text not set correctly")
                print "Sent data: ",
                for c in pba: print("%x")%c,
                print("")
                print "Read data: ",
                if check:
                    for c in check: print("%x")%c,
                    print("")
                else:
                    print "<Timeout>"

    def setSettings(self, state):
        cmd = bytearray(1)
        cmd[0] = state        
        self.sendMessage(CODE_WRITE, ADDR_SETTINGS, cmd);

    def getSettings(self):
        sets = self.sendMessage(CODE_READ, ADDR_SETTINGS)
        if sets:
            return sets[0]
        else:
            return 0

    def setGainMode(self, gainmode):
        '''Set the gain Mode'''
        if gainmode == "high":
            self.setSettings(self.sc.getSettings() | SETTINGS_GAIN_HIGH);
        elif gainmode == "low":           
            self.setSettings(self.sc.getSettings() & ~SETTINGS_GAIN_HIGH);
        else:
            raise ValueError, "Invalid Gain Mode, only 'low' or 'high' allowed"

    def setGain(self, gain):
        '''Set the Gain range 0-78'''
        cmd = bytearray(1)
        cmd[0] = gain               
        self.sendMessage(CODE_WRITE, ADDR_GAIN, cmd);

    def getStatus(self):
        result = self.sendMessage(CODE_READ, ADDR_STATUS);

        if len(result) == 1:
            return result[0]
        else:
            return None

    def getExtFrequency(self):
        '''Return the external frequency measured on 'CLOCK' pin. Returned value
           requires conversion to Hz'''
        freq = 0x00000000;

        temp = self.sendMessage(CODE_READ, ADDR_FREQ1)
        freq = freq | (temp[0] << 0);

        temp = self.sendMessage(CODE_READ, ADDR_FREQ2)
        freq = freq | (temp[0] << 8);

        temp = self.sendMessage(CODE_READ, ADDR_FREQ3)
        freq = freq | (temp[0] << 16);

        temp = self.sendMessage(CODE_READ, ADDR_FREQ4)
        freq = freq | (temp[0] << 24);

        #Board samples 40E6/2^25, so convert to Hz
        return long(freq * (40E6 / pow(2,25)))

class DrawArea(QWidget):

    def __init__(self, parent=None):
        super(DrawArea, self).__init__(parent)

        self.pen = QPen()
        self.brush = QBrush()
        self.pixmap = QPixmap()

        self.setBackgroundRole(QPalette.Base)
        self.setAutoFillBackground(True)

        self.data = None
        self.zoomFactor = 1.0

    def minimumSizeHint(self):
        return QSize(400, 200)

    def sizeHint(self):
        return QSize(400, 200)

    def loadData(self, data):
        self.data = data
        self.update()

    def setZoom(self, zf):
        self.zoomFactor = zf
        self.update()
    
    def paintEvent(self, event):
        rect = QRect(10, 20, 80, 60)

        path = QPainterPath()
        path.moveTo(20, 80)
        path.lineTo(20, 30)
        path.cubicTo(80, 0, 50, 50, 80, 80)

        painter = QPainter(self)
        painter.setPen(self.pen)
        painter.setBrush(self.brush)

        if (self.data):
            #Data may have more points than our current X size
            #allows. If so we decimate as required
            #if len(self.data) > self.width():
            #    #Options: math.ceil: shows all data with some whitespace
            #    #         round     : shows data sometimes going offscreen
            #    #         math.floor : maximizes display area, almost always data offscreen
            #    decimateFactor = int(math.ceil(float(len(self.data)) / float(self.width())))
            #else:
            #    decimateFactor = 1

            #Do not decimate, use scroll bars instead!
            decimateFactor = 1

            dataList = []

            x = 0
            yavg = 0.0
            avgcnt = 0
            for index, p in enumerate(self.data):                                
                if x >= self.width():
                    break
                
                y = self.height() - (((p - 0.5) * self.zoomFactor + 0.5) * self.height())

                if y >= self.height():
                    y = self.height()-1

                if y < 0:
                    y = 0

                yavg = yavg + y
                avgcnt = avgcnt + 1

                if (index % decimateFactor):                    
                    continue
                
                yavg = yavg / avgcnt
                
                dataList.append(QPoint(x, yavg))
                avgcnt = 0
                yavg = 0
                x = x + 1

            painter.drawPolyline(dataList)

        painter.setPen(self.palette().dark().color())
        painter.setBrush(Qt.NoBrush)
        painter.drawRect(QRect(0, 0, self.width() - 1,
                self.height() - 1))

    
class MainWindow(QMainWindow):
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
            self.hilowmode = SETTINGS_GAIN_HIGH
            self.sc.setSettings(self.sc.getSettings() | SETTINGS_GAIN_HIGH);

        if self.gainlow.isChecked():            
            self.hilowmode = SETTINGS_GAIN_LOW
            self.sc.setSettings(self.sc.getSettings() & ~SETTINGS_GAIN_HIGH);

    def processData(self, data):

        fpData = []

        lastpt = -100;

        if data[0] != 0xAC:
            self.statusBar().showMessage("Unexpected sync byte: 0x%x"%data[0])
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
            
            fpData.append(float(intpt) / 1024.0)

        return fpData

    def drawSetZoom(self):
        try:
            self.drawarea.setZoom(float(self.drawingGain.text()))
        except ValueError:
            self.drawingGain.setText("1.0")
            self.drawarea.setZoom(1.0)
                   
    def ADCcapture(self):
        self.ADCsettrigmode();
        self.sc.setSettings(self.sc.getSettings() | 0x08);
        self.statusBar().showMessage("Waiting for trigger")

        status = self.sc.getStatus()
        while (status & STATUS_FIFO_MASK) == 0:
            status = self.sc.getStatus()
            time.sleep(0.1)

        self.sc.setSettings(self.sc.getSettings() & ~0x08);

        self.statusBar().showMessage("Reading Data")
        data = self.sc.sendMessage(CODE_READ, ADDR_ADCDATA);

        self.statusBar().showMessage("Received %d bytes"%len(data))

        self.datapoints = self.processData(data)
        self.drawarea.loadData(self.datapoints)

        #print "max: %f\nmin: %f"%(max(self.datapoints), min(self.datapoints))
        #print"max %f = %f bits\n"%(max(self.datapoints), math.log((max(self.datapoints) - sum(self.datapoints)/len(self.datapoints)) * 1024, 2))
        stddev = numpy.std(self.datapoints)
        print "SNR = %f, stddev = %f\n"%(20 * math.log(numpy.average(self.datapoints)/stddev, 10), stddev)
            

    def ADCsettrigmode(self):
        self.trigmode = 0;

        if self.trigmoderising.isChecked():
            self.trigmode = SETTINGS_TRIG_HIGH | SETTINGS_WAIT_YES;

        if self.trigmodefalling.isChecked():
            self.trigmode = SETTINGS_TRIG_LOW | SETTINGS_WAIT_YES;

        if self.trigmodehigh.isChecked():
            self.trigmode = SETTINGS_TRIG_HIGH | SETTINGS_WAIT_NO;

        if self.trigmodelow.isChecked():
            self.trigmode = SETTINGS_TRIG_LOW | SETTINGS_WAIT_NO;

        cur = self.sc.getSettings() & ~(SETTINGS_TRIG_HIGH | SETTINGS_WAIT_YES);
        self.sc.setSettings(cur | self.trigmode)

    def ADCupdate(self):
        print self.sc.getExtFrequency()

    def ADCconnect(self):
        # connect to serial port
        self.ser = serial.Serial()
        self.ser.port     = "com6"
        self.ser.baudrate = 115200;
        self.ser.timeout  = 0.5     # 0.5 second timeout
    
        try:
            self.ser.open()
        except serial.SerialException, e:
            self.statusBar().showMessage("Could not open com6")


        #See if device seems to be attached
        self.sc = serialComm(self.ser)

        msgin = bytearray([])
        msgin.append(0xAC);  

        deviceFound = False
        numTries = 0

        #Try a few times
        while(deviceFound == False):
            #Send ping
            self.sc.sendMessage(CODE_WRITE, ADDR_ECHO, msgin)
            
            #Pong?
            msgout = self.sc.sendMessage(CODE_READ, ADDR_ECHO)

            if (msgout == msgin):
                deviceFound = True
                break

            numTries += 1

            if (numTries == 5):
                for c in msgin: print("%x")%c,
                print("")
                for c in msgout: print("%x")%c,
                print("")
                
                self.statusBar().showMessage("Failed to received response from USB Device")

        self.statusBar().showMessage("Connected to ADC Module on port %s" % self.ser.portstr)

    def __del__(self):
        if self.ser:
            self.ser.open()
        
    def __init__(self, parent=None):
        super(MainWindow, self).__init__(parent)

        self.ser = None
        self.sc = None

        self.statusBar()
        self.setWindowTitle("ADC Capture App")
        self.title = QLabel("ADC Capture App")
        self.title.setAlignment(Qt.AlignCenter)
        flabel = self.title.font()
        flabel.setPointSize(24)
        self.title.setFont(flabel)
   
        self.connectButton = QPushButton("Connect to ADC Board")
        self.gain = QSpinBox()
        self.gain.setMinimum(0)
        self.gain.setMaximum(78)
        self.captureButton = QPushButton("Capture")
        self.updateButton = QPushButton("Get Status")
        gainModeGroup = QButtonGroup(self)
        self.gainlow = QRadioButton("Low");
        self.gainhigh = QRadioButton("High");
        gainModeGroup.addButton(self.gainlow)
        gainModeGroup.addButton(self.gainhigh)

        triggerModeGroup = QButtonGroup(self)
        self.trigmoderising = QRadioButton("Rising Edge");
        self.trigmodefalling = QRadioButton("Falling Edge");
        self.trigmodelow = QRadioButton("Low Level");
        self.trigmodehigh = QRadioButton("High Level");
        triggerModeGroup.addButton(self.trigmoderising)
        triggerModeGroup.addButton(self.trigmodefalling)
        triggerModeGroup.addButton(self.trigmodelow)
        triggerModeGroup.addButton(self.trigmodehigh)

        self.connect(self.connectButton, SIGNAL("clicked()"),self, SLOT("ADCconnect()"))
        self.connect(self.captureButton, SIGNAL("clicked()"),self, SLOT("ADCcapture()"))
        self.connect(self.updateButton, SIGNAL("clicked()"),self,SLOT("ADCupdate()"))
        self.connect(self.gain, SIGNAL("valueChanged(int)"),self, SLOT("ADCsetgain(int)"))
        self.connect(self.gainlow, SIGNAL("clicked()"),self,SLOT("ADCsetgainmode()"))
        self.connect(self.gainhigh, SIGNAL("clicked()"),self,SLOT("ADCsetgainmode()"))

        self.connect(self.trigmoderising, SIGNAL("clicked()"),self,SLOT("ADCsettrigmode()"))
        self.connect(self.trigmodefalling, SIGNAL("clicked()"),self,SLOT("ADCsettrigmode()"))
        self.connect(self.trigmodelow, SIGNAL("clicked()"),self,SLOT("ADCsettrigmode()"))
        self.connect(self.trigmodehigh, SIGNAL("clicked()"),self,SLOT("ADCsettrigmode()"))

        self.gainresults = QLabel("")
        self.updateGainLabel()
        
        # Create layout and add widgets
        self.mw = QWidget()
        layout = QVBoxLayout()
        
        layout.addWidget(self.title)
        layout.addWidget(self.connectButton)
        layout.addWidget(self.captureButton)
        layout.addWidget(self.updateButton)

        gainsettings = QGroupBox("Gain Settings");
        gainlayout = QVBoxLayout()
        gainsettings.setLayout(gainlayout)
        gainmodelayout = QHBoxLayout()
        gainmodelayout.addWidget(QLabel("Gain Mode: "));
        gainmodelayout.addWidget(self.gainhigh)
        gainmodelayout.addWidget(self.gainlow)
        gainlayout.addLayout(gainmodelayout)
        gainsettinglayout = QHBoxLayout()
        gainsettinglayout.addWidget(QLabel("Setting: "));
        gainsettinglayout.addWidget(self.gain)
        gainlayout.addLayout(gainmodelayout)
        gainlayout.addLayout(gainsettinglayout)
        gainlayout.addWidget(self.gainresults)
        layout.addWidget(gainsettings)

        triggersettings = QGroupBox("Trigger Mode")
        triglayout = QHBoxLayout()
        triggersettings.setLayout(triglayout)
        triglayout.addWidget(self.trigmoderising);
        triglayout.addWidget(self.trigmodefalling);
        triglayout.addWidget(self.trigmodehigh);
        triglayout.addWidget(self.trigmodelow);
        layout.addWidget(triggersettings)

        self.gainlow.setChecked(True)
        self.trigmodelow.setChecked(True)

        drawresults = QGroupBox("Results Preview")
        resultsLayout = QVBoxLayout()
        self.drawarea = DrawArea()
        resultsLayout.addWidget(self.drawarea)
        drawresults.setLayout(resultsLayout)
        drawGainLayout = QHBoxLayout()
        drawGainLayout.addWidget(QLabel("Scale Factor: "))
        self.drawingGain = QLineEdit("1.0")
        drawGainLayout.addWidget(self.drawingGain)
        resultsLayout.addLayout(drawGainLayout)
        layout.addWidget(drawresults)

        self.connect(self.drawingGain, SIGNAL("editingFinished()"),self,SLOT("drawSetZoom()"))
              
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
