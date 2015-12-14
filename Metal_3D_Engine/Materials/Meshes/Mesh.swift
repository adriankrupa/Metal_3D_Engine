//
//  Mesh.swift
//  Metal_3D_Engine
//
//  Created by Adrian Krupa on 08.12.2015.
//  Copyright © 2015 Adrian Krupa. All rights reserved.
//

import Foundation
import MetalKit

class Mesh {
    
    var indexBuffer: MTLBuffer! = nil
    var vertexBuffer: MTLBuffer! = nil
    
    let buffers = 1
    
    var vertices: [Vertex] = []
    
    var meshChangeCounter = 0;
    var meshHash = 0;
    
    init() {
        meshChangeCounter++
    }
    
    func GetPrimitiveType() -> MTLPrimitiveType { return .Triangle }
    
}