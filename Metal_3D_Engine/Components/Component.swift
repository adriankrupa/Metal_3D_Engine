//
//  Component.swift
//  Metal_3D_Engine
//
//  Created by Adrian Krupa on 06.12.2015.
//  Copyright © 2015 Adrian Krupa. All rights reserved.
//

import Foundation
import MetalKit

class Component {
    
    func Update() {}
    
    func FixedUpdate() {}
    
    func Render(commandBuffer: MTLCommandBuffer, camera: Camera) {}
    
}