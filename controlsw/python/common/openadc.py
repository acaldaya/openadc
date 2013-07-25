# -*- coding: cp1252 -*-

# This file is part of the OpenADC Project. See www.newae.com for more details,
# or the codebase at http://www.assembla.com/spaces/openadc .
#
# Copyright (c) 2012-2013, Colin O'Flynn <coflynn@newae.com>. All rights reserved.
# This project is released under the Modified FreeBSD License. See LICENSE
# file which should have came with this code.

import sys
import os
import threading
import time
import datetime
import logging
import math
import random

ADDR_GAIN       = 0
ADDR_SETTINGS   = 1
ADDR_STATUS     = 2
ADDR_ADCDATA    = 3
ADDR_ECHO       = 4
ADDR_FREQ       = 5
ADDR_ADVCLK     = 6
ADDR_SYSFREQ    = 7
ADDR_ADCFREQ    = 8
ADDR_PHASE      = 9
ADDR_VERSIONS   = 10
ADDR_OFFSET     = 26
ADDR_SAMPLES    = 16
ADDR_PRESAMPLES = 17
ADDR_BYTESTORX  = 18
ADDR_DDR        = 20
ADDR_MULTIECHO  = 34

CODE_READ       = 0x80
CODE_WRITE      = 0xC0

SETTINGS_RESET     = 0x01
SETTINGS_GAIN_HIGH = 0x02
SETTINGS_GAIN_LOW  = 0x00
SETTINGS_TRIG_HIGH = 0x04
SETTINGS_TRIG_LOW  = 0x00
SETTINGS_ARM       = 0x08
SETTINGS_WAIT_YES  = 0x20
SETTINGS_WAIT_NO   = 0x00
SETTINGS_TRIG_NOW  = 0x40

STATUS_ARM_MASK    = 0x01
STATUS_FIFO_MASK   = 0x02
STATUS_EXT_MASK    = 0x04
STATUS_DCM_MASK    = 0x08
STATUS_DDRCAL_MASK = 0x10
STATUS_DDRERR_MASK = 0x20
STATUS_DDRMODE_MASK= 0x40

# sign extend b low bits in x
# from "Bit Twiddling Hacks"
def SIGNEXT(x, b):
       m = 1 << (b - 1)
       x = x & ((1 << b) - 1)
       return (x ^ m) - m

class OpenADCSettings:
    def __init__(self, oaiface=None):   
        self.parm_hwinfo = HWInformation()
        self.parm_gain = GainSettings()
        self.parm_trigger = TriggerSettings()
        self.parm_clock = ClockSettings()
        
        self.params = [
            self.parm_hwinfo, 
            self.parm_gain, 
            self.parm_trigger, 
            self.parm_clock
            ]
            
        if oaiface is not None:
            self.setInterface(oaiface)  
        
    def setInterface(self, oaiface):
        self.oa = oaiface
        for p in self.params:
            p.setInterface(oaiface)

    def parameters(self,  doUpdate=True):
        """Return a dict of all parameter/settings. Useful for saving."""       
        paramdict = []
        for p in self.params:
            paramref = p.param               
            paramdict.append(paramref)
            
        if doUpdate:
            for p in paramdict:
                for set in p['children']:
                    try:
                        if 'children' in set:
                            for subset in set['children']:
                                if set['type'] != 'action':
                                    subset['value']=subset['get']()
                        else:
                            if set['type'] != 'action':
                                set['value'] = set['get']()
                    except KeyError:
                        print "Error in %s.%s - no 'get'"%(p['name'], set['name'])
        
        return paramdict

    def setParameters(self, paramdict):
        """Set all parameters/settings from a dict. Can pass only part of the dictionary too for changes."""
        return
            
class HWInformation:
    def __init__(self):
        self.name = "Hardware Information"
        self.sysFreq = 0
        self.param = {'name': 'HW Information', 'type': 'group', 'children': [
                {'name': 'Version', 'type': 'str', 'value': "unknown", 'get':self.versions, 'readonly':True},
                {'name': 'Synth Date', 'type': 'str', 'value': "unknown", 'get':self.synthDate, 'readonly':True},
                {'name': 'System Freq', 'type': 'int', 'value': 0, 'siPrefix':True, 'suffix': 'Hz', 'get':self.sysFrequency, 'readonly':True},
                {'name': 'Max Samples', 'type': 'int', 'value': 0, 'get':self.maxSamples, 'readonly':True}
                ]}
        
    def setInterface(self, oa):
        self.oa = oa
        oa.hwInfo = self

    def versions(self):
        result = self.oa.sendMessage(CODE_READ, ADDR_VERSIONS, maxResp=6)

        regver = result[0] & 0xff
        hwtype = result[1] >> 3
        hwver = result[1] & 0x07
        hwList = ["Default/Unknown", "LX9 MicroBoard", "SASEBO-W", "ChipWhisperer Rev2 LX25",
                  "Reserved?", "ZedBoard", "Papilio Pro"]

        try:
            textType = hwList[hwtype]
        except:
            textType = "Invalid/Unknown"

        return (regver, hwtype, textType, hwver)  
      
    def synthDate(self):
       return "unknown" 
       
    def maxSamples(self):
        return self.oa.hwMaxSamples

    def sysFrequency(self, force=False):
        if (self.sysFreq > 0) & (force == False):
               return self.sysFreq
           
        '''Return the system clock frequency in specific firmware version'''
        freq = 0x00000000;

        temp = self.oa.sendMessage(CODE_READ, ADDR_SYSFREQ, maxResp=4)
        freq = freq | (temp[0] << 0);
        freq = freq | (temp[1] << 8);
        freq = freq | (temp[2] << 16);
        freq = freq | (temp[3] << 24);

        self.sysFreq = long(freq)
        
        return self.sysFreq

class GainSettings:
    def __init__(self):
        self.name = "Gain Setting"
        self.param = {'name': 'Gain Setting', 'type': 'group', 'children': [
                {'name': 'Mode', 'type': 'list', 'values': {"high", "low"}, 'value':"low", 'set':self.setMode,  'get':self.mode},
                {'name': 'Setting', 'type': 'int', 'value':0, 'limits': (0, 78),  'set':self.setGain,  'get':self.gain, 'linked':['Result']},
                {'name': 'Result', 'type': 'float', 'suffix':'dB', 'readonly':True, 'get':self.gainDB},
                ]}
        self.gainlow_cached = False
        self.gain_cached = 0
    
    def setInterface(self, oa):
        self.oa = oa
        
    def setMode(self, gainmode):
        '''Set the gain Mode'''
        if gainmode == "high":
            self.oa.setSettings(self.oa.settings() | SETTINGS_GAIN_HIGH)
            self.gainlow_cached = False
        elif gainmode == "low":           
            self.setSettings(self.oa.settings() & ~SETTINGS_GAIN_HIGH)
            self.gainlow_cached = True
        else:
            raise ValueError, "Invalid Gain Mode, only 'low' or 'high' allowed"
 
    def mode(self):
        return "low"
        
    def setGain(self, gain):
        '''Set the Gain range 0-78'''
        if (gain < 0) | (gain > 78):
            raise ValueError,  "Invalid Gain, range 0-78 Only"
            
        self.gain_cached = gain
            
        cmd = bytearray(1)
        cmd[0] = gain               
        self.oa.sendMessage(CODE_WRITE, ADDR_GAIN, cmd)

    def gain(self, cached=False):
        if cached == False:
            self.gain_cached = self.oa.sendMessage(CODE_READ, ADDR_GAIN)[0]
            
        return self.gain_cached
        
    def gainDB(self):
        #GAIN (dB) = 50 (dB/V) * VGAIN - 6.5 dB, (HILO = LO)
        #GAIN (dB) = 50 (dB/V) * VGAIN + 5.5 dB, (HILO = HI)        

        gainV = (float(self.gain_cached) / 256.0) * 3.3;

        if self.gainlow_cached:
            gaindb = 50.0 * gainV - 6.5
        else:
            gaindb = 50.0 * gainV + 5.5

        return gaindb

class TriggerSettings:
    def __init__(self):
        self.name = "Trigger Settings"
        self.param = {'name': 'Trigger Setup', 'type':'group', 'children': [
            {'name': 'Source', 'type': 'list', 'values':["digital",  "analog"],  'value':"digital", 'set':self.setSource,  'get':self.source}, 
            {'name': 'Mode',   'type':'list',  'values':["rising edge", "falling edge", "low", "high"], 'value':'low', 'set':self.setMode, 'get':self.mode}, 
            {'name': 'Offset', 'type':'int', 'value':0, 'limits':(0, 1000000), 'set':self.setOffset, 'get':self.offset}, 
            {'name': 'Pre-Trigger Samples', 'type':'int', 'value':0, 'limits':(0, 1000000), 'set':self.setPresamples, 'get':self.presamples}, 
            {'name': 'Total Samples', 'type':'int', 'value':0, 'limits':(0, 1000000), 'set':self.setMaxSamples, 'get':self.maxSamples}, 
        ]}
        self.maxsamples = 0


    def setInterface(self, oa):
        self.oa = oa

    def setMaxSamples(self, samples):
        self.maxsamples = samples
        self.oa.setMaxSamples(samples)
        
    def maxSamples(self,  cached=False):
        if cached:
            return self.maxsamples
        else:
            return self.oa.maxSamples()

    def setOffset(self,  offset):
        cmd = bytearray(4)
        cmd[0] = ((offset >> 0) & 0xFF)
        cmd[1] = ((offset >> 8) & 0xFF)
        cmd[2] = ((offset >> 16) & 0xFF)
        cmd[3] = ((offset >> 24) & 0xFF)
        self.oa.sendMessage(CODE_WRITE, ADDR_OFFSET, cmd)
        
    def offset(self):
        cmd = self.oa.sendMessage(CODE_READ, ADDR_OFFSET, maxResp=4)        
        offset = cmd[0]
        offset |= cmd[1] << 8
        offset |= cmd[2] << 16
        offset |= cmd[3] << 24              
        return offset 


    def setPresamples(self, samples):           
        #enforce samples is multiple of 3
        samplesact = int(samples / 3)

        #Account for shitty hardware design
        if samplesact > 0:
               samplesact = samplesact + 16
           
        cmd = bytearray(4)
        cmd[0] = ((samplesact >> 0) & 0xFF)
        cmd[1] = ((samplesact >> 8) & 0xFF)
        cmd[2] = ((samplesact >> 16) & 0xFF)
        cmd[3] = ((samplesact >> 24) & 0xFF)
        self.oa.sendMessage(CODE_WRITE, ADDR_PRESAMPLES, cmd)

        self.presamples_actual = samplesact*3
        self.presamples_desired = samples
        
        return self.presamples_actual

    def presamples(self, cached=False):
        
        if cached:
            return self.presamples_desired
        
        samples = 0x00000000;

        temp = self.oa.sendMessage(CODE_READ, ADDR_PRESAMPLES, maxResp=4)
        samples = samples | (temp[0] << 0)
        samples = samples | (temp[1] << 8)
        samples = samples | (temp[2] << 16)
        samples = samples | (temp[3] << 24)

        self.presamples_actual = samples*3

        return samples*3

    def setSource(self,  src):
        return
        
    def source(self):
        return "digital"

    def setMode(self,  mode):
        """ Input to trigger module options: 'rising edge', 'falling edge', 'high', 'low' """
        if mode == 'rising edge':
            trigmode = SETTINGS_TRIG_HIGH | SETTINGS_WAIT_YES;

        elif mode == 'falling edge':
            trigmode = SETTINGS_TRIG_LOW | SETTINGS_WAIT_YES;

        elif mode == 'high':
            trigmode = SETTINGS_TRIG_HIGH | SETTINGS_WAIT_NO;

        elif mode == 'low':
            trigmode = SETTINGS_TRIG_LOW | SETTINGS_WAIT_NO;

        else:
            raise ValueError,  "%s invalid trigger mode"%mode

        cur = self.oa.settings() & ~(SETTINGS_TRIG_HIGH | SETTINGS_WAIT_YES);
        self.oa.setSettings(cur | trigmode)
        
    def mode(self):
        sets = self.oa.settings()
        case = sets & (SETTINGS_TRIG_HIGH | SETTINGS_WAIT_YES);
        
        if case == SETTINGS_TRIG_HIGH | SETTINGS_WAIT_YES:
            mode = "rising edge"
        elif case == SETTINGS_TRIG_LOW | SETTINGS_WAIT_YES:
            mode = "falling edge"
        elif case == SETTINGS_TRIG_HIGH | SETTINGS_WAIT_NO:
            mode = "high"
        else:
            mode = "low"
            
        return mode

class ClockSettings:
    def __init__(self):
        self.name = "Clock Setup"
        self.param = {'name': 'Clock Setup', 'type':'group', 'children': [
            {'name':'Refresh Status', 'type':'action', 'linked':[('ADC Clock','DCM Locked'), ('ADC Clock','ADC Freq'), ('CLKGEN Settings','DCM Locked'), 'EXTCLK Input Freq']}, 
            {'name':'Relock DCMs', 'type':'action', 'action':self.resetDcms}, 
        
            {'name': 'ADC Clock', 'type':'group', 'children': [
                {'name': 'Source', 'type':'list', 'values':{"EXTCLK Direct":("extclk", 4, "clkgen"), "EXTCLK x4 via DCM":("dcm", 4, "extclk"), "EXTCLK x1 via DCM":("dcm", 1, "extclk"), "CLKGEN x4 via DCM":("dcm", 4, "clkgen"), "CLKGEN x1 via DCM":("dcm", 1, "clkgen")},  'value':("dcm", 1, "extclk"), 'set':self.setAdcSource,  'get':self.adcSource},
                {'name': 'Phase Adjust', 'type':'int', 'value':0, 'limits':(-100, 100), 'set':self.setPhase, 'get':self.phase}, 
                {'name': 'DCM Locked', 'type':'bool',  'value':False, 'get':self.dcmADCLocked, 'readonly':True}, 
                {'name': 'ADC Freq', 'type': 'int', 'value': 0, 'siPrefix':True, 'suffix': 'Hz', 'readonly':True, 'get':self.adcFrequency},
            ]},            
            {'name': 'EXTCLK Input Freq', 'type': 'int', 'value': 0, 'siPrefix':True, 'suffix': 'Hz', 'readonly':True, 'get':self.extFrequency},
            {'name':'CLKGEN Settings', 'type':'group', 'children': [
                {'name':'Input Source', 'type':'list', 'values':["system", "extclk"], 'value':"system", 'set':self.setClkgenSrc, 'get':self.clkgenSrc}, 
                {'name':'Multiply', 'type':'list', 'values':{'2x':2}, 'value':2, 'set':self.setClkgenMul, 'get':self.clkgenMul}, 
                {'name':'Divide', 'type':'list', 'values':{'/2':2}, 'value':2, 'set':self.setClkgenDiv, 'get':self.clkgenDiv}, 
                {'name':'TargetDivide', 'type':'list', 'values':{'/4':4}, 'value':4, 'set':self.setClkgenDivTarget, 'get':self.clkgenDivTarget},
                {'name':'DCM Locked', 'type':'bool',  'value':False, 'get':self.clkgenLocked, 'readonly':True},                
            ]},             
        ]} 
        
    def setInterface(self, oa):
        self.oa = oa
        
    def setClkgenMul(self, mul):
       return
    
    def clkgenMul(self):
       return 2
       
    def setClkgenDiv(self, div):
       return
       
    def clkgenDiv(self):
       return 2
    
    def setClkgenDivTarget(self, div):
       return
       
    def clkgenDivTarget(self):
       return 4

    def adcSource(self):
        result = self.oa.sendMessage(CODE_READ, ADDR_ADVCLK, maxResp=4)
        result[0] = result[0] & 0x07

        if result[0] & 0x04:
            dcminput = "extclk"
        else:
            dcminput = "clkgen"

        if result[0] & 0x02:
            dcmout = 1
        else:
            dcmout = 4

        if result[0] & 0x01:
            source = "extclk"
        else:
            source = "dcm"

        return (source, dcmout, dcminput)

    def setAdcSource(self, source="dcm", dcmout=4, dcminput="clkgen"):
        
        #Deal with being passed tuple with all 3 arguments
        if isinstance(source, (list, tuple)):
            dcminput = source[2]
            dcmout = source[1]
            source=source[0]
        
        result = self.oa.sendMessage(CODE_READ, ADDR_ADVCLK, maxResp=4)

        result[0] = result[0] & ~0x07

        if dcminput == "clkgen":
            pass
        elif dcminput == "extclk":
            result[0] = result[0] | 0x04
        else:
            raise ValueError("dcminput must be 'clkgen' or 'extclk'")

        if dcmout == 4:
            pass
        elif dcmout == 1:
            result[0] = result[0] | 0x02
        else:
            raise ValueError("dcmout must be 1 or 4") 

        if source == "dcm":
            pass
        elif source == "extclk":
            result[0] = result[0] | 0x01
        else:
            raise ValueError("source must be 'dcm' or 'extclk'")

        self.oa.sendMessage(CODE_WRITE, ADDR_ADVCLK, result)
        
    def setClkgenSrc(self, source="system"):
        result = self.oa.sendMessage(CODE_READ, ADDR_ADVCLK, maxResp=4)

        result[0] = result[0] & ~0x08

        if source == "system":
            pass
        elif source == "extclk":
            result[0] = result[0] | 0x08
        else:
            raise ValueError("source must be 'system' or 'extclk'")             

        self.oa.sendMessage(CODE_WRITE, ADDR_ADVCLK, result)
        
    def clkgenSrc(self):
        result = self.oa.sendMessage(CODE_READ, ADDR_ADVCLK, maxResp=4)
        if result[0] & 0x08:
            return "extclk"
        else:
            return "system"
        
    def setPhase(self, phase):
        '''Set the phase adjust, range -255 to 255'''

        LSB = phase & 0x00FF;
        MSB = (phase & 0x0100) >> 8;
       
        cmd = bytearray(2)
        cmd[0] = LSB;
        cmd[1] = MSB | 0x02;
        self.oa.sendMessage(CODE_WRITE, ADDR_PHASE, cmd, False)

    def phase(self):
        result = self.oa.sendMessage(CODE_READ, ADDR_PHASE, maxResp=2);

        if (result[1] & 0x02):            
            LSB = result[0]
            MSB = result[1] & 0x01

            phase = LSB | (MSB << 8)

            #Sign Extend
            phase = SIGNEXT(phase, 9)

            return phase
        else:
            print "Error Reading Phase"
            return 0

    def dcmADCLocked(self):
        result = self.DCMStatus()
        return result[0]
        
    def clkgenLocked(self):
        result = self.DCMStatus()
        return result[1]

    def DCMStatus(self):
         result = self.oa.sendMessage(CODE_READ, ADDR_ADVCLK, maxResp=4)
         if (result[0] & 0x80) == 0:
             print "ERROR: ADVCLK register not present. Version mismatch"
             return (False, False)

         if (result[0] & 0x40) == 0:
             dcmADCLocked = False
         else:
             dcmADCLocked = True

         if (result[0] & 0x20) == 0:
             dcmCLKGENLocked = False
         else:
             dcmCLKGENLocked = True

         return (dcmADCLocked, dcmCLKGENLocked)

    def resetDcms(self):
        result = self.oa.sendMessage(CODE_READ, ADDR_ADVCLK, maxResp=4)

        #Set reset high
        result[0] = result[0] | 0x10
        
        self.oa.sendMessage(CODE_WRITE, ADDR_ADVCLK, result, Validate=False)

        #Set reset low
        result[0] = result[0] & ~(0x10)
        self.oa.sendMessage(CODE_WRITE, ADDR_ADVCLK, result, Validate=False)

    def extFrequency(self):
        """Return frequency of clock measured on EXTCLOCK pin in Hz"""
        freq = 0x00000000;

        #Get sample frequency
        samplefreq = float(self.oa.hwInfo.sysFrequency()) / float(pow(2,24))

        temp = self.oa.sendMessage(CODE_READ, ADDR_FREQ, maxResp=4)
        freq = freq | (temp[0] << 0);
        freq = freq | (temp[1] << 8);
        freq = freq | (temp[2] << 16);
        freq = freq | (temp[3] << 24);

        measured = freq * samplefreq * 0.8
        return long(measured)

    def adcFrequency(self):
        """Return the external frequency measured on 'CLOCK' pin. Returned value
           is in Hz"""
        freq = 0x00000000;

        #Get sample frequency
        samplefreq = float(self.oa.hwInfo.sysFrequency()) / float(pow(2,24))

        temp = self.oa.sendMessage(CODE_READ, ADDR_ADCFREQ, maxResp=4)
        freq = freq | (temp[0] << 0);
        freq = freq | (temp[1] << 8);
        freq = freq | (temp[2] << 16);
        freq = freq | (temp[3] << 24);

        measured = freq * samplefreq * 0.8

        return long(measured)


class OpenADCInterface:        
    def __init__(self, serial_instance, debug=None):
        self.serial = serial_instance
        self.log = logging.getLogger('serialUsb')
        self.timeout = 5
        self.offset = 0.5
        self.ddrMode = False        
        self.presamples_desired = 0
        self.sysFreq = 0

        self.settings();

        #self.params = OpenADCSettings(self)

        #Send clearing function
        nullmessage = bytearray([0]*20)        
        self.serial.write(str(nullmessage));
        
        self.setReset(True)
        self.setReset(False)


    def testAndTime(self):
        totalbytes = 0
        totalerror = 0

        for n in range(10):
               #Generate 500 bytes         
               testData = bytearray(range(250) + range(250)) #bytearray(random.randint(0,255) for r in xrange(500))
               self.sendMessage(CODE_WRITE, ADDR_MULTIECHO, testData, False)
               testDataEcho = self.sendMessage(CODE_READ, ADDR_MULTIECHO, None, False, 502)
               testDataEcho = testDataEcho[2:]      

               #Compare
               totalerror = totalerror + len([(i,j) for i,j in zip(testData,testDataEcho) if i!=j])
               totalbytes = totalbytes + len(testData)

               print "%d errors in %d"%(totalerror, totalbytes)

    
    def sendMessage(self, mode, address, payload=None, Validate=True, maxResp=None):
        """Send a message out the serial port"""

        if payload is None:
          payload = []

        #Get length
        length = len(payload)

        if ((mode == CODE_WRITE) and (length < 1)) or ((mode == CODE_READ) and (length != 0)):
            self.log.error("Invalid payload for mode")
            return None

        if mode == CODE_READ:
              self.flushInput()

        #Flip payload around
        pba = bytearray(payload)
        
        ### Setup Message
        message = bytearray([])

        #Message type
        message.append(mode | address)
       
        #Length
        lenpayload = len(pba)
        message.append(lenpayload & 0xff)
        message.append((lenpayload >> 8) & 0xff)

        #append payload
        message = message + pba

        ### Send out serial port
        self.serial.write(str(message))

        #for b in message: print "%02x "%b,
        #print ""               

        ### Wait Response (if requested)
        if (mode == CODE_READ):
            if (maxResp):
                datalen = maxResp
            elif (ADDR_ADCDATA == address):
                datalen = 65000
            else:
                datalen = 1
            
            result = self.serial.read(datalen)

            #Check for timeout, if so abort
            if len(result) < 1:
                self.flushInput()
                self.log.error("Timeout: %d"%len(result))
                return None

            rb = bytearray(result)

            return rb
        else:
            if Validate:
                check = self.sendMessage(CODE_READ, address, maxResp=len(pba))
                if check != pba:
                    self.log.error("Command text not set correctly")
                    print "For address 0x%02x=%d"%(address,address)
                    print "  Sent data: ",
                    for c in pba: print("%x")%c,
                    print("")
                    print "  Read data: ",
                    if check:
                        for c in check: print("%x")%c,
                        print("")
                    else:
                        print "<Timeout>"

### Generic
    def setSettings(self, state):
        cmd = bytearray(1)
        cmd[0] = state        
        self.sendMessage(CODE_WRITE, ADDR_SETTINGS, cmd);

    def settings(self):
        sets = self.sendMessage(CODE_READ, ADDR_SETTINGS)
        if sets:
            return sets[0]
        else:
            return 0

    def setReset(self, value):           
        if value:
               self.setSettings(self.settings() | SETTINGS_RESET);
               self.hwMaxSamples = self.maxSamples()
        else:
                self.setSettings(self.settings() | SETTINGS_RESET);
                
    def triggerNow(self):
        initial = self.settings()
        self.setSettings(initial | SETTINGS_TRIG_NOW)
        time.sleep(0.01)
        self.setSettings(initial & ~SETTINGS_TRIG_NOW)

    def getStatus(self):
        result = self.sendMessage(CODE_READ, ADDR_STATUS)

        if len(result) == 1:
            return result[0]
        else:
            return None        

    def setMaxSamples(self, samples):
        cmd = bytearray(4)
        cmd[0] = ((samples >> 0) & 0xFF)
        cmd[1] = ((samples >> 8) & 0xFF)
        cmd[2] = ((samples >> 16) & 0xFF)
        cmd[3] = ((samples >> 24) & 0xFF)
        self.sendMessage(CODE_WRITE, ADDR_SAMPLES, cmd)

    def maxSamples(self):
        '''Return the number of samples captured in one go'''
        samples = 0x00000000;
        temp = self.sendMessage(CODE_READ, ADDR_SAMPLES, maxResp=4)
        samples = samples | (temp[0] << 0)
        samples = samples | (temp[1] << 8)
        samples = samples | (temp[2] << 16)
        samples = samples | (temp[3] << 24)
        return samples

    def getBytesInFifo(self):
        samples = 0
        temp = self.sendMessage(CODE_READ, ADDR_BYTESTORX, maxResp=4)
        samples = samples | (temp[0] << 0)
        samples = samples | (temp[1] << 8)
        samples = samples | (temp[2] << 16)
        samples = samples | (temp[3] << 24)
        return samples

    def flushInput(self):
        try:
           self.serial.flushInput()
        except AttributeError:
           return
              
    def devicePresent(self):
        msgin = bytearray([])
        msgin.append(0xAC);

        self.flushInput()

        #Reset... will automatically clear by the time we are done
        self.setReset(True)
        self.flushInput()
        
        #Send ping
        self.sendMessage(CODE_WRITE, ADDR_ECHO, msgin)
            
        #Pong?
        msgout = self.sendMessage(CODE_READ, ADDR_ECHO)

        if (msgout != msgin):
            return False         

        #Init stuff
        state = self.getStatus()

        if state & STATUS_DDRMODE_MASK:
            self.ddrMode = True
        else:
            self.ddrMode = False

        return True

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
        return addr
        
    def arm(self):
       self.setSettings(self.settings() | 0x08);

    def capture(self):
       #Wait for trigger
       status = self.getStatus()

       starttime = datetime.datetime.now()
       
       while ((status & STATUS_ARM_MASK) == STATUS_ARM_MASK) | ((status & STATUS_FIFO_MASK) == 0):
           status = self.getStatus()
           time.sleep(0.05)
           
           diff = datetime.datetime.now() - starttime
           
           if (diff.total_seconds() > self.timeout):
               print "TIMEOUT OCCURED - TRIGGER FORCED"
               self.triggerNow()     

       self.setSettings(self.settings() & ~0x08);
       return True

    def flush(self):
       #Flush output FIFO
       self.sendMessage(CODE_READ, ADDR_ADCDATA, None, False, None)

    def readData(self, NumberPoints=None, progressDialog=None):
       datapoints = []

       if NumberPoints == None:
              NumberPoints = 0x1000

       if self.ddrMode:
              #We were passed number of samples to read. DDR interface
              #reads 3 points per 4 bytes, and reads in blocks of
              #256 bytes (e.g.: 192 samples)
              NumberPackages = NumberPoints / 192

              #If user requests we send extra then scale back afterwards
              if (NumberPoints % 192) > 0:
                     NumberPackages = NumberPackages + 1

              start = 0
              self.setDDRAddress(0)

              
              BytesPerPackage = 257

              if progressDialog:
                     progressDialog.setMinimum(0)
                     progressDialog.setMaximum(NumberPackages)
       else:
              #FIFO takes 3 samples at a time... todo figure this out
              NumberPackages = 1

              #We get 3 samples in each word returned (word = 4 bytes)
              #So need to convert samples requested to words, rounding
              #up if we request an incomplete number
              nwords = NumberPoints / 3
              if NumberPoints % 3:
                     nwords = nwords + 1

              #Return 4x as many bytes as words, +1 for sync byte
              BytesPerPackage = nwords * 4 + 1
       
       for status in range(0, NumberPackages):        
              #Address of DDR is auto-incremented following a read command
              #so no need to write new address
              
              #print "Address=%x"%self.getDDRAddress()

              #print "bytes = %d"%self.getBytesInFifo()

              bytesToRead = self.getBytesInFifo()

              if bytesToRead == 0:
                     bytesToRead = BytesPerPackage

              #print bytesToRead

              data = self.sendMessage(CODE_READ, ADDR_ADCDATA, None, False, bytesToRead) #BytesPerPackage)


              #for p in data:
              #       print "%x "%p,

              datapoints = datapoints + self.processData(data, 0)

              if progressDialog:
                     progressDialog.setValue(status)

                     if progressDialog.wasCanceled():
                            break              

       #for point in datapoints:
       #       print "%3x"%(int((point+0.5)*1024))
       
       if len(datapoints) > NumberPoints:
              datapoints = datapoints[0:NumberPoints]

       return datapoints

    def processData(self, data, pad=float('NaN'), pretrigger_out=None):
        fpData = []
        lastpt = -100;

        if data[0] != 0xAC:
            print("Unexpected sync byte: 0x%x"%data[0])
            return None

        trigfound = False
        trigsamp = 0

        for i in range(1, len(data)-3, 4):            
            #Convert
            temppt = (data[i + 3]<<0) | (data[i + 2]<<8) | (data[i + 1]<<16) | (data[i + 0]<<24)

            #print("%2x "%data[i])

            #print "%x %x %x %x"%(data[i +0], data[i +1], data[i +2], data[i +3]);
            #print "%x"%temppt

            intpt1 = temppt & 0x3FF;
            intpt2 = (temppt >> 10) & 0x3FF;
            intpt3 = (temppt >> 20) & 0x3FF;
            
            if trigfound == False:
                mergpt = temppt >> 30;
                if (mergpt != 3):
                       trigfound = True
                       trigsamp = trigsamp + mergpt                       
                       #print "Trigger found at %d"%trigsamp
                else:                     
                   trigsamp += 3
	
            #input validation test: uncomment following and use
            #ramp input on FPGA
            ##if (intpt != lastpt + 1) and (lastpt != 0x3ff):
            ##    print "intpt: %x lstpt %x\n"%(intpt, lastpt)
            ##lastpt = intpt;

            #print "%x %x %x"%(intpt1, intpt2, intpt3)
            
            fpData.append(float(intpt1) / 1024.0 - self.offset)
            fpData.append(float(intpt2) / 1024.0 - self.offset)
            fpData.append(float(intpt3) / 1024.0 - self.offset)

        #print len(fpData)

        #Ensure that the trigger point matches the requested by padding/chopping
        diff = self.presamples_desired - trigsamp
        if diff > 0:
               fpData = [pad]*diff + fpData
        else:
               fpData = fpData[-diff:]

        #print "%d %d"%(len(fpData), diff)

        return fpData

if __name__ == "__main__":
    import serial
    
    ser = serial.Serial()
    ser.port     = "com6"
    ser.baudrate = 512000
    ser.timeout  = 1.0
    
    try:
        ser.open()
    except serial.SerialException, e:
        print "Could not open %s"%ser.name
        sys.exit()
    except ValueError, s:
        print "Invalid settings for serial port"
        ser.close()
        ser = None
        sys.exit()

    adc = OpenADCInterface(ser)
    adc.devicePresent()
    
    adc_settings = OpenADCSettings()
    adc_settings.setInterface(adc)
    adc_settings.parameters()
