//
//  UIDevice.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/08/21.
//

import UIKit

extension UIDevice {
    var modelName: String {
#if targetEnvironment(simulator)
        let identifier = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"]!
        
#else
        var systemInfo = utsname()
        
        uname(&systemInfo)
        
        let machineMirror = Mirror(
            reflecting: systemInfo.machine
        )
        
        let identifier = machineMirror.children
            .reduce("") { identifier, element in
                guard let value = element.value as? Int8,
                      value != 0 else {
                    return identifier
                }
                
                return identifier + String(
                    UnicodeScalar(
                        UInt8(value)
                    )
                )
            }
        
#endif
        switch identifier {
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":           return "iPhone 4"
        case "iPhone4,1":                                     return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                        return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                        return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                        return "iPhone 5s"
        case "iPhone7,2":                                     return "iPhone 6"
        case "iPhone7,1":                                     return "iPhone 6 Plus"
        case "iPhone8,1":                                     return "iPhone 6s"
        case "iPhone8,2":                                     return "iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3":                        return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                        return "iPhone 7 Plus"
        case "iPhone10,1", "iPhone10,4":                      return "iPhone 8"
        case "iPhone10,2", "iPhone10,5":                      return "iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6":                      return "iPhone X"
        case "iPhone11,2":                                    return "iPhone XS"
        case "iPhone11,4", "iPhone11,6":                      return "iPhone XS Max"
        case "iPhone11,8":                                    return "iPhone XR"
        case "iPhone12,1":                                    return "iPhone 11"
        case "iPhone12,3":                                    return "iPhone 11 Pro"
        case "iPhone12,5":                                    return "iPhone 11 Pro Max"
        case "iPhone13,1":                                    return "iPhone 12 Mini"
        case "iPhone13,2":                                    return "iPhone 12"
        case "iPhone13,3":                                    return "iPhone 12 Pro"
        case "iPhone13,4":                                    return "iPhone 12 Pro Max"
        case "iPhone14,4":                                    return "iPhone 13 Mini"
        case "iPhone14,5":                                    return "iPhone 13"
        case "iPhone14,2":                                    return "iPhone 13 Pro"
        case "iPhone14,3":                                    return "iPhone 13 Pro Max"
        case "iPhone14,7":                                    return "iPhone 14"
        case "iPhone14,8":                                    return "iPhone 14 Plus"
        case "iPhone15,2":                                    return "iPhone 14 Pro"
        case "iPhone15,3":                                    return "iPhone 14 Pro Max"
        case "iPhone8,4":                                     return "iPhone SE"
        case "iPhone12,8":                                    return "iPhone SE SecondGen"
        case "iPhone14,6":                                    return "iPhone SE ThirdGen"
        default:                                              return identifier
        }
    }
}

