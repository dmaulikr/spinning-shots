//
//  InstanceCounter.swift
//  spinning shots
//
//  Created by Marc Zobec on 2015-10-17.
//  Copyright © 2015 Marc Zobec. All rights reserved.
//

import Foundation

/*
    Add to Project Build Settings (Swift Compiler - Custom Flags -> Other Swift Flags -> Debug):
        -D INSTANCECOUNTING
*/

public func InstanceCountingInitInstance(instance: AnyObject) {
    #if INSTANCECOUNTING
        InstanceCounter.sharedCounter.initInstance(instance)
    #endif
}

public func InstanceCountingDeinitInstance(instance: AnyObject) {
    #if INSTANCECOUNTING
        InstanceCounter.sharedCounter.deinitInstance(instance)
    #endif
}

public func InstanceCountingDumpInstances() {
    #if INSTANCECOUNTING
        InstanceCounter.sharedCounter.dump()
    #endif
}

private class InstanceCounter {
    private static var sharedCounter = InstanceCounter()
    
    private struct InstanceWrapper {
        weak var instance: AnyObject?
        var timeStamp = NSDate()
        var address: String
        var className: String {
            return instance != nil ? "\(instance!.dynamicType)" : ""
        }
        
        private init(instance: Any) {
            self.instance = instance as? AnyObject
            address = addressOfInstance(self.instance)
        }
    }
    
    private var dictClassNameToArrayInstanceWrapper = [String : [InstanceWrapper]]()
    
    private init() {}
    
    private func initInstance<T>(instance: T) {
        let wrapper = InstanceWrapper(instance: instance)
        var wrapperArray = dictClassNameToArrayInstanceWrapper[wrapper.className] ?? [InstanceWrapper]()
        wrapperArray.append(wrapper)
        dictClassNameToArrayInstanceWrapper[wrapper.className] = wrapperArray
    }
    
    private func deinitInstance<T>(instance: T) {
        let className = "\(instance.dynamicType)"
        let address = addressOfInstance(instance)
        
        if let wrapperArray = dictClassNameToArrayInstanceWrapper[className] {
            dictClassNameToArrayInstanceWrapper[className] = wrapperArray.filter { $0.address != address }
        }
    }
    
    private func dump(dumpAction: (className: String, wrapperArray: [InstanceWrapper]) -> Void) {
        for className in (Array(dictClassNameToArrayInstanceWrapper.keys).sort()) {
            if var wrapperArray = dictClassNameToArrayInstanceWrapper[className] {
                wrapperArray = wrapperArray.filter { $0.instance != nil }
                dictClassNameToArrayInstanceWrapper[className] = wrapperArray
                dumpAction(className: className, wrapperArray: wrapperArray)
            }
        }
    }
    
    private func dump() {
        dump { (className, wrapperArray) in
            print(className + ": \(wrapperArray.count) instances")
        }
    }
}

private func addressOfInstance<T>(instance: T) -> String {
    return String(format: "%p", unsafeBitCast(instance, Int.self))
}