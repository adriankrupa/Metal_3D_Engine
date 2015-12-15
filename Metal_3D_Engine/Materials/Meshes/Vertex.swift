//
//  Vertex.swift
//  Metal_3D_Engine
//
//  Created by Adrian Krupa on 08.12.2015.
//  Copyright © 2015 Adrian Krupa. All rights reserved.
//

import Foundation
import MetalKit
import simd

struct Vertex {
    var position = float3(1, 1, 1)
    var color = float4(1, 1, 1, 1)
    
    static private var verDesc: MTLVertexDescriptor!
    
    static var vertexDescriptor: MTLVertexDescriptor {
        get {
            if(verDesc == nil) {
                initVertexDescriptor()
            }
            return verDesc
        }
        set {
            verDesc = newValue
        }
    }
        static private func initVertexDescriptor() {
        Vertex.verDesc = MTLVertexDescriptor()
        Vertex.verDesc.attributes[0].format = .Float3
        Vertex.verDesc.attributes[0].bufferIndex = 0
        Vertex.verDesc.attributes[0].offset = 0
        
        Vertex.verDesc.attributes[1].format = .Float4
        Vertex.verDesc.attributes[1].bufferIndex = 0
        Vertex.verDesc.attributes[1].offset = sizeof(float3)
        
        Vertex.verDesc.layouts[0].stride = sizeof(Vertex)
        Vertex.verDesc.layouts[0].stepFunction = .PerVertex

    }
}
