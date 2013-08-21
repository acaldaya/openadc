# -*- coding: cp1252 -*-

# This file is part of the OpenADC Project. See www.newae.com for more details,
# or the codebase at http://www.assembla.com/spaces/openadc .
#
# Copyright (c) 2012-2013, Colin O'Flynn <coflynn@newae.com>. All rights reserved.
# This project is released under the 2-Clause BSD License. See LICENSE
# file which should have came with this code.

import types
from functools import partial
from pyqtgraph.Qt import QtCore

#This class adds some  hacks that allow us to have 'get', 'set', and 'linked' methods in the Parameter specification.
#They are especially helpful for the work done here
    
class ExtendedParameter():
    @staticmethod
    def getAllParameters(self, parent=None):
        if parent is None:
            parent = self
                              
        if parent.hasChildren():
            for child in parent.children():
                self.getAllParameters(child)
        else:
            if 'get' in parent.opts:
                parent.setValue(parent.opts['get']())
             
    @staticmethod
    def setupExtended(curParam, parent=None):
        curParam.getAllParameters = types.MethodType(ExtendedParameter.getAllParameters, curParam)
        curParam.sigTreeStateChanged.connect(ExtendedParameter.change)
        
        if parent is not None:
            parent.paramTreeChanged = types.MethodType(ExtendedParameter.paramTreeChanged, parent)
            curParam.sigTreeStateChanged.connect(parent.paramTreeChanged)
                         
    ## If anything changes in the tree, print a message
    @staticmethod
    def change(param,  changes):  
        for param, change, data in changes:
                                    
            #Call specific 'set' routine associated with data
            if 'set' in param.opts:
                #QtCore.QTimer.singleShot(0, partial(param.opts['set'], data))
                param.opts['set'](data) 
                
            if 'linked' in param.opts:
                par = param.parent()
                for link in param.opts['linked']:
                    linked = par
                    if isinstance(link, tuple):
                        for p in link:
                            linked = linked.names[p]
                    else:                        
                        linked = par.names[link]
                        
                    #QtCore.QTimer.singleShot(0, partial(linked.setValue, linked.opts['get']()))
                    linked.setValue(linked.opts['get']()) 
                    
            if 'action' in param.opts:                
                #QtCore.QTimer.singleShot(0, param.opts['action'])
                param.opts['action']()
    
    @staticmethod
    def paramTreeChanged(self, param, changes):        
        if self.showScriptParameter is not None:
            self.showScriptParameter(param, changes, self.params)
      
    @staticmethod  
    def reloadParams(lst, paramtree):
            """
            Reloads parameters in a paramtree. Hides anything that isn't in the list anymore, adds
            any new parameters. Required to avoid deleting parameters that we actually want to see
            again later, otherwise they are garbage collected.
            """
            
            for i in range(0, paramtree.invisibleRootItem().childCount()):
                refitem = paramtree.invisibleRootItem().child(i)
                if refitem.param in lst:
                    lst.remove(refitem.param)
                    refitem.setHidden(False)
                else:
                    refitem.setHidden(True)                                  
                    
            for p in lst:
                paramtree.addParameters(p)
                
                
if __name__ == '__main__':
    import pyqtgraph as pg
    from pyqtgraph.Qt import QtCore, QtGui

    app = QtGui.QApplication([])
    import pyqtgraph.parametertree.parameterTypes as pTypes
    from pyqtgraph.parametertree import Parameter, ParameterTree, ParameterItem, registerParameterType
    
    class submodule(QtCore.QObject):
        paramListUpdated = QtCore.Signal(list)
        
        def __init__(self):
            super(submodule, self).__init__()
            moreparams = [                  
                      {'name':'Value', 'type':'list', 'values':['2','3','4'], 'set':self.set}
                  ]           
            self.params = Parameter.create(name='Test', type='group', children=moreparams)
            ExtendedParameter.setupExtended(self.params)
            
        def set(self, value):
            print "set %s"%value
            #self.paramListUpdated.emit(self.paramList())
            
        def paramList(self):
            p = [self.params]                
            return p

    
    class module(QtCore.QObject):
        paramListUpdated = QtCore.Signal(list)
        
        def __init__(self):
            super(module, self).__init__()
            moreparams = [                  
                      {'name':'SubModule', 'type':'list', 'values':{'sm1':submodule(), 'sm2':submodule(), 'sm3':submodule()}, 'set':self.setSubmodule}
                  ]           
            self.params = Parameter.create(name='Test', type='group', children=moreparams)
            ExtendedParameter.setupExtended(self.params)
            self.sm = None
            
        def paramList(self):
            p = [self.params]        
            if self.sm is not None:
                for a in self.sm.paramList(): p.append(a)            
            return p
            
        def setSubmodule(self, sm):
            self.sm = sm  
            self.paramListUpdated.emit(self.paramList())
    
    class maintest(QtCore.QObject):
        paramListUpdated = QtCore.Signal(list)
        
        def __init__(self):
            super(maintest, self).__init__()
            p = [
                        {'name': 'Basic parameter data types', 'type': 'group', 'children': [
                            {'name': 'Module 1', 'type': 'list', 'values':{'module 1':module(), 'module 2':module(), 'module 3':module()}, 'set':self.setmodule},
                    ]}]
            self.params = Parameter.create(name='Test', type='group', children=p)
            ExtendedParameter.setupExtended(self.params)
            self.module = None
            
            self.t = ParameterTree()    
            self.reloadParams()        
            
        def setmodule(self, module):
            print "Changing Module"
            self.module = module            
            self.module.paramListUpdated.connect(self.reloadParams)
            self.paramListUpdated.emit(self.paramList())
            self.reloadParams()
            
        def reloadParams(self):
            ExtendedParameter.reloadParams(self.paramList(), self.t)
            
        def reloadParamsBad(self):
            """The following is kept as a reminder you must NOT do this, or else objects get deleted"""
            
            #Notes about my wasted day to report a bug later when I have more time:
            # *Calling the .clear() causes stuff to be deleted
            # *In file parameterTypes.py at line 180 you have the following:
            #    self.widget.sigChanged.disconnect(self.widgetValueChanged)            
            #  If self.widget has been deleted, which will happen once the ParameterTree is cleared, the call
            #  to .disconnect causes a bad crash (sometimes). However - you can insert a call to 'self.widget.value()'
            #  before the .disconnect() call. The self.widget.value() actually checks if the object was deleted, and if so
            #  it raises a nice exception with a handy error message.
            
            lst = self.paramList()
            self.t.clear()            
            for p in lst:
                self.t.addParameters(p)            
            
        def paramList(self):
            p = [self.params]        
            if self.module is not None:
                for a in self.module.paramList(): p.append(a)            
            return p        

    m = maintest()
    
    t = m.t
    t.show()
    t.setWindowTitle('pyqtgraph example: Parameter Tree')
    t.resize(400,800)

    QtGui.QApplication.instance().exec_()
                    