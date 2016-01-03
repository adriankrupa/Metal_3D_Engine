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
    
    var name = "Mesh"
    
    let buffers = 1
    
    var vertices: [Vertex] = []
    
    var meshChangeCounter = 0;
    var meshHash = 0;
    
    init() {
        meshChangeCounter++
    }
    
    func FillIndexBuffer() {}
    
    func FillData() {
        
        if(meshHash != meshChangeCounter) {
            meshHash = meshChangeCounter
        } else {
            return
        }
        
        vertexBuffer = EngineController.device.newBufferWithBytes(vertices, length: vertices.count * sizeof(Vertex), options: [])
        vertexBuffer.label = name + "_vertexBuffer"
        vertices = []
        FillIndexBuffer()
    }
    
    func GetPrimitiveType() -> MTLPrimitiveType {
        return .Triangle
    }
    
    func GetIndexCount() -> Int {
        return 0
    }
    
    func GetMetalIndexType() -> MTLIndexType {
        return .UInt32
    }
}