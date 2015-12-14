//
//  Triangle.swift
//  Metal_3D_Engine
//
//  Created by Adrian Krupa on 08.12.2015.
//  Copyright © 2015 Adrian Krupa. All rights reserved.
//

import Foundation

struct Triangle {
    var indices: [Int] = [0, 0, 0]
    
    var a: Int {
        get {
            return indices[0]
        }
        set {
            indices[0] = newValue
        }
    }
    var b: Int {
        get {
            return indices[1]
        }
        set {
            indices[1] = newValue
        }
    }
    var c: Int {
        get {
            return indices[2]
        }
        set {
            indices[2] = newValue
        }
    }
}