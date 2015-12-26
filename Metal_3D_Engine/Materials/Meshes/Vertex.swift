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
        
    var position = float3(0, 0, 0)
    var color = float4(1, 1, 1, 1)
    var tangent = float3(0, 1, 0)
    var UV = float2(0, 0)
    var normal = float3(1, 0, 0)
    
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
        
        var v = Vertex()
        
        withUnsafePointers(&v, &v.position, { (pointerBase, pointerField) -> Void in
            let offset = UnsafePointer<Void>(pointerField) - UnsafePointer<Void>(pointerBase)
            
            Vertex.verDesc.attributes[VertexAttributes.Position.rawValue].format = .Float3
            Vertex.verDesc.attributes[VertexAttributes.Position.rawValue].bufferIndex = 0
            Vertex.verDesc.attributes[VertexAttributes.Position.rawValue].offset = offset
        })
        
        withUnsafePointers(&v, &v.color, { (pointerBase, pointerField) -> Void in
            let offset = UnsafePointer<Void>(pointerField) - UnsafePointer<Void>(pointerBase)
            
            Vertex.verDesc.attributes[VertexAttributes.Color.rawValue].format = .Float4
            Vertex.verDesc.attributes[VertexAttributes.Color.rawValue].bufferIndex = 0
            Vertex.verDesc.attributes[VertexAttributes.Color.rawValue].offset = offset
        })
        
        withUnsafePointers(&v, &v.tangent, { (pointerBase, pointerField) -> Void in
            let offset = UnsafePointer<Void>(pointerField) - UnsafePointer<Void>(pointerBase)
            
            Vertex.verDesc.attributes[VertexAttributes.Tangent.rawValue].format = .Float3
            Vertex.verDesc.attributes[VertexAttributes.Tangent.rawValue].bufferIndex = 0
            Vertex.verDesc.attributes[VertexAttributes.Tangent.rawValue].offset = offset
        })
        
        withUnsafePointers(&v, &v.UV, { (pointerBase, pointerField) -> Void in
            let offset = UnsafePointer<Void>(pointerField) - UnsafePointer<Void>(pointerBase)
            
            Vertex.verDesc.attributes[VertexAttributes.UV.rawValue].format = .Float2
            Vertex.verDesc.attributes[VertexAttributes.UV.rawValue].bufferIndex = 0
            Vertex.verDesc.attributes[VertexAttributes.UV.rawValue].offset = offset
        })
        
        withUnsafePointers(&v, &v.normal, { (pointerBase, pointerField) -> Void in
            let offset = UnsafePointer<Void>(pointerField) - UnsafePointer<Void>(pointerBase)
            
            Vertex.verDesc.attributes[VertexAttributes.Normal.rawValue].format = .Float3
            Vertex.verDesc.attributes[VertexAttributes.Normal.rawValue].bufferIndex = 0
            Vertex.verDesc.attributes[VertexAttributes.Normal.rawValue].offset = offset
        })
        
        Vertex.verDesc.layouts[0].stride = sizeof(Vertex)
        Vertex.verDesc.layouts[0].stepRate = 1
        Vertex.verDesc.layouts[0].stepFunction = .PerVertex
        
    }
}
