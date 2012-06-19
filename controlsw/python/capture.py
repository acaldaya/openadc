# -*- coding: cp1252 -*-
import sys
import os
import threading
import time
import logging
import math
import numpy
import openadc
import serial
from PySide.QtCore import *
from PySide.QtGui import *

# sign extend b low bits in x
# from "Bit Twiddling Hacks"
def SIGNEXT(x, b):
       m = 1 << (b - 1)
       x = x & ((1 << b) - 1)
       return (x ^ m) - m

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
        while (status & openadc.STATUS_FIFO_MASK) == 0:
            status = self.sc.getStatus()
            time.sleep(0.1)

        self.sc.setSettings(self.sc.getSettings() & ~0x08);

        self.statusBar().showMessage("Reading Data")
        data = self.sc.sendMessage(openadc.CODE_READ, openadc.ADDR_ADCDATA);

        self.statusBar().showMessage("Received %d bytes"%len(data))

        self.datapoints = self.processData(data)
        self.drawarea.loadData(self.datapoints)

        #print "max: %f\nmin: %f"%(max(self.datapoints), min(self.datapoints))
        #print"max %f = %f bits\n"%(max(self.datapoints), math.log((max(self.datapoints) - sum(self.datapoints)/len(self.datapoints)) * 1024, 2))
        stddev = numpy.std(self.datapoints)
        #print "SNR = %f, stddev = %f\n"%(20 * math.log(numpy.average(self.datapoints)/stddev, 10), stddev)
        print "%f dB\n"%(20 * math.log(max(self.datapoints) - 0.5, 10));            

        dpfft= numpy.fft.fft(self.datapoints)
        freqs = numpy.fft.fftfreq(len(dpfft))

        ind = numpy.argsort(numpy.abs(dpfft)**2)

        freq_in_hertz=freqs[ind[-10:]]*abs(100E6)

        for j in ind[-10:]:
              if freqs[j] <= 0:
                      continue

              print "%6f %6f"%(freqs[j]*100E6, numpy.abs(dpfft[j]))
              

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

    def ADCupdate(self):
        print self.sc.getExtFrequency()
        print self.sc.getPhase()

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

        self.phase = QSpinBox()
        self.phase.setMinimum(-255)
        self.phase.setMaximum(255)
        self.connect(self.phase, SIGNAL("valueChanged(int)"),self, SLOT("ADCsetclock(int)"))

        clocksettings = QGroupBox("Clock Settings")
        clocklayout = QVBoxLayout()
        clocksettings.setLayout(clocklayout)
        clocklayout.addWidget(self.phase)
        layout.addWidget(clocksettings)

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

        drawfft = QGroupBox("FFT Preview")
        fftlayout = QVBoxLayout()
        self.fftarea = DrawArea()
        fftlayout.addWidget(self.drawarea)
        drawfft.setLayout(fftlayout)
        layout.addWidget(drawfft)
              
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
