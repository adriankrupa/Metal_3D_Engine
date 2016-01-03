//
//  EngineController.swift
//  Metal_3D_Engine
//
//  Created by Adrian Krupa on 26.12.2015.
//  Copyright © 2015 Adrian Krupa. All rights reserved.
//

import Foundation
import MetalKit

class EngineController {
    
    static var device: MTLDevice!
    static var library: MTLLibrary!
    
    private static var inited = false

    static func initialize() {
        if(inited) {
            return
        }
        device = MTLCreateSystemDefaultDevice()
        library = device.newDefaultLibrary()!
        inited = true
    }
    
}