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
    
    def sendMessage(self, mode, address, payload=None, Validate=True):
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

