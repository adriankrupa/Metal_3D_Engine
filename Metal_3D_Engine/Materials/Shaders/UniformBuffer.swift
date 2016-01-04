//
//  UniformBuffer.swift
//  Metal_3D_Engine
//
//  Created by Adrian Krupa on 04.01.2016.
//  Copyright © 2016 Adrian Krupa. All rights reserved.
//

import Foundation
import MetalKit

class UniformBuffer {
    
    var bfr: MTLBuffer!
    
    var buffer: MTLBuffer {
        get {
            return bfr
        }
    }
    
    var updateClosure: (inout buffer: MTLBuffer) -> ()
    
    init(c:(inout buffer: MTLBuffer) -> ()) {
        updateClosure = c
    }
    
    func fillDataAndUpdate() {
        updateClosure(buffer: &bfr!)
    }
    
    func copy() -> UniformBuffer {
        return UniformBuffer(c: { (buffer) -> () in })
    }
}