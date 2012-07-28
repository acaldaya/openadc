# -*- coding: cp1252 -*-
import sys
import os
import threading
import time
import serial
import logging
import math

ADDR_GAIN       = 0
ADDR_SETTINGS   = 1
ADDR_STATUS     = 2
ADDR_ADCDATA    = 3
ADDR_ECHO       = 4
ADDR_FREQ1      = 5
ADDR_FREQ2      = 6
ADDR_FREQ3      = 7
ADDR_FREQ4      = 8
ADDR_PHASE1     = 9
ADDR_PHASE2     = 10

ADDR_DDR1       = 16
ADDR_DDR2       = 17
ADDR_DDR3       = 18
ADDR_DDR4       = 19

CODE_READ       = 0x80
CODE_WRITE      = 0xC0

SETTINGS_GAIN_HIGH = 0x02
SETTINGS_GAIN_LOW  = 0x00
SETTINGS_TRIG_HIGH = 0x04
SETTINGS_TRIG_LOW  = 0x00
SETTINGS_ARM       = 0x08
SETTINGS_WAIT_YES  = 0x20
SETTINGS_WAIT_NO   = 0x00
SETTINGS_CLK_EXT   = 0x40

STATUS_ARM_MASK    = 0x01
STATUS_FIFO_MASK   = 0x02
STATUS_EXT_MASK    = 0x04

# sign extend b low bits in x
# from "Bit Twiddling Hacks"
def SIGNEXT(x, b):
       m = 1 << (b - 1)
       x = x & ((1 << b) - 1)
       return (x ^ m) - m

class serialOpenADCInterface:
    def __init__(self, serial_instance, debug=None):
        self.serial = serial_instance
        self.log = logging.getLogger('serialUsb')

        #Send clearing function
        nullmessage = bytearray([20])
        
        self.serial.write(nullmessage);

        self.offset = 0.5
    
    def sendMessage(self, mode, address, payload=None, Validate=True, maxResp=None):
        """Send a message out the serial port"""

        if payload is None:
          payload = []

        #Get length
        length = len(payload)

        if ((mode == CODE_WRITE) and (length != 1)) or ((mode == CODE_READ) and (length != 0)):
            self.log.error("Invalid payload for mode")
            return None

        if mode == CODE_READ:
              self.serial.flushInput()

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
                if maxResp:
                       datalen = maxResp
                else:
                       datalen = 65000
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
            if Validate:
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
            self.setSettings(self.getSettings() | SETTINGS_GAIN_HIGH);
        elif gainmode == "low":           
            self.setSettings(self.getSettings() & ~SETTINGS_GAIN_HIGH);
        else:
            raise ValueError, "Invalid Gain Mode, only 'low' or 'high' allowed"

    def setClockSource(self, source):
        if source == "int":
            self.setSettings(self.getSettings() & ~SETTINGS_CLK_EXT);
        elif source == "ext":
            self.setSettings(self.getSettings() | SETTINGS_CLK_EXT);
        else:
            raise ValueError, "Invalid clock source, only 'int' or 'ext' allowed"

    def setGain(self, gain):
        '''Set the Gain range 0-78'''
        cmd = bytearray(1)
        cmd[0] = gain               
        self.sendMessage(CODE_WRITE, ADDR_GAIN, cmd);

    def getGain(self):
        result = self.sendMessage(CODE_READ, ADDR_GAIN)
        return result[0]

    def setPhase(self, phase):
        '''Set the phase adjust, range -255 to 255'''

        LSB = phase & 0x00FF;
        MSB = (phase & 0x0100) >> 8;
       
        cmd = bytearray(1)
        cmd[0] = LSB;
        self.sendMessage(CODE_WRITE, ADDR_PHASE1, cmd, False);

        cmd[0] = MSB | 0x02;
        self.sendMessage(CODE_WRITE, ADDR_PHASE2, cmd, False);

    def getPhase(self):
        result = self.sendMessage(CODE_READ, ADDR_PHASE2);

        if (result[0] & 0x02):
            MSB = result[0] & 0x01;

            result = self.sendMessage(CODE_READ, ADDR_PHASE1);
            LSB = result[0]

            phase = LSB | (MSB << 8);

            #Sign Extend
            phase = SIGNEXT(phase, 9)

            return phase
        else:
            return None

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

    def devicePresent(self):
        msgin = bytearray([])
        msgin.append(0xAC);
        
        #Send ping
        self.sendMessage(CODE_WRITE, ADDR_ECHO, msgin)
            
        #Pong?
        msgout = self.sendMessage(CODE_READ, ADDR_ECHO)

        if (msgout == msgin):
            return True
        else:
            return False

    def setDDRAddress(self, addr):
        cmd = bytearray(1)
        cmd[0] = ((addr >> 0) & 0xFF)
        self.sendMessage(CODE_WRITE, ADDR_DDR1, cmd)
        cmd[0] = ((addr >> 8) & 0xFF)
        self.sendMessage(CODE_WRITE, ADDR_DDR2, cmd)
        cmd[0] = ((addr >> 16) & 0xFF)
        self.sendMessage(CODE_WRITE, ADDR_DDR3, cmd)
        cmd[0] = ((addr >> 24) & 0xFF)
        self.sendMessage(CODE_WRITE, ADDR_DDR4, cmd)

    def getDDRAddress(self):
        addr = 0x00000000;
        temp = self.sendMessage(CODE_READ, ADDR_DDR1)
        addr = addr | (temp[0] << 0);
        temp = self.sendMessage(CODE_READ, ADDR_DDR2)
        addr = addr | (temp[0] << 8);
        temp = self.sendMessage(CODE_READ, ADDR_DDR3)
        addr = addr | (temp[0] << 16);
        temp = self.sendMessage(CODE_READ, ADDR_DDR4)
        addr = addr | (temp[0] << 24);
        return freq
        
    def arm(self):
       self.setSettings(self.getSettings() | 0x08);

    def capture(self):
       #Wait for trigger
       status = self.getStatus()

       timeout = 0;
       while (status & STATUS_FIFO_MASK) == 0:
           status = self.getStatus()
           time.sleep(0.05)

           timeout = timeout + 1
           if timeout > 100:
               return False

       self.setSettings(self.getSettings() & ~0x08);
       return True

    def readData(self, NumberPoints=None):
       return self.readDataDDR(NumberPoints)

       if NumberPoints:
              NumberPoints = NumberPoints * 2

    def flush(self):
       #Flush output FIFO
       self.sendMessage(CODE_READ, ADDR_ADCDATA, None, False, None)

    def readDataDDR(self, NumberPoints=None):       
       datapoints = []
       start = 0

       if NumberPoints == None:
              NumberPoints = 0x10000

       self.setDDRAddress(start)
       
       for ddraddr in range(start, start+NumberPoints, 0x100):              
              #print ddraddr
              data = self.sendMessage(CODE_READ, ADDR_ADCDATA, None, False, 257);

              #Address of DDR is auto-incremented following a read command
              #so no need to write new address

              print "Address=%x"%self.getDDRAddress()

              datapoints = datapoints + self.processDataDDR(data)

       #print datapoints

       return datapoints

    def processDataDDR(self, data):
        fpData = []
        lastpt = -100;

        if data[0] != 0xAC:
            print("Unexpected sync byte: 0x%x"%data[0])
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

            #print "%x %x %x"%(intpt1, intpt2, intpt3)
            
            fpData.append(float(intpt1) / 1024.0 - self.offset)
            fpData.append(float(intpt2) / 1024.0 - self.offset)
            fpData.append(float(intpt3) / 1024.0 - self.offset)

        return fpData
