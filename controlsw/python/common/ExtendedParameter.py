# -*- coding: cp1252 -*-

# This file is part of the OpenADC Project. See www.newae.com for more details,
# or the codebase at http://www.assembla.com/spaces/openadc .
#
# Copyright (c) 2012-2013, Colin O'Flynn <coflynn@newae.com>. All rights reserved.
# This project is released under the 2-Clause BSD License. See LICENSE
# file which should have came with this code.

try:
    import pyqtgraph.parametertree.parameterTypes as pTypes
    from pyqtgraph.parametertree import Parameter, ParameterTree, ParameterItem, registerParameterType
except ImportError:
    print "*************************************************"
    print "*************************************************"
    print "Install pyqtgraph from http://www.pyqtgraph.org"
    print "*************************************************"
    print "*************************************************"
    
class ExtendedParameter(Parameter):
    def __init__(self, **opts):
        super(Parameter, self).__init__(opts)
        self.sigTreeStateChanged.connect(self.change)

    def getAllParameters(self, parent=None):
        if parent is None:
            parent = self.p
        
        if parent.hasChildren():
            for child in parent.children():
                self.getAllParameters(child)
        else:
            if 'get' in parent.opts:
                parent.setValue(parent.opts['get']())
                    
    ## If anything changes in the tree, print a message
    def change(self, param,  changes):    
        for param, change, data in changes:
            #Call specific 'set' routine associated with data
            if 'set' in param.opts:
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
                        
                    linked.setValue(linked.opts['get']())
                    
            if 'action' in param.opts:
                param.opts['action']()
                    
#            path = self.p.childPath(param)
#            if path is not None:
#                childName = '.'.join(path)
#            else:
#                childName = param.name()
#            print('  parameter: %s'% childName)
#            print('  change:    %s'% change)
#            print('  data:      %s'% str(data))
#            print('  ----------')