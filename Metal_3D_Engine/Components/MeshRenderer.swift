//
//  MeshRenderer.swift
//  Metal_3D_Engine
//
//  Created by Adrian Krupa on 08.12.2015.
//  Copyright © 2015 Adrian Krupa. All rights reserved.
//

import Foundation
import MetalKit

class MeshRenderer: Component {
    
    var mesh: Mesh!
    
    override func Render(commandBuffer: MTLCommandBuffer, camera: Camera) {
        super.Render(commandBuffer, camera: camera)
        
    }
    
}