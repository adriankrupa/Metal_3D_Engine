//
//  Time.swift
//  Metal_3D_Engine
//
//  Created by Adrian Krupa on 06.12.2015.
//  Copyright © 2015 Adrian Krupa. All rights reserved.
//

import Foundation

class Time {
    
    private static var dt: Float = 0
    
    static var deltaTime: Float {
        get {
            return dt
        }
        set {
            dt = newValue
        }
    }
}