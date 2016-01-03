//
//  TrianglesMesh.swift
//  Metal_3D_Engine
//
//  Created by Adrian Krupa on 22.12.2015.
//  Copyright © 2015 Adrian Krupa. All rights reserved.
//

import Foundation
import MetalKit

class TrianglesMesh<IndicesType: MTLUnsignedIndexType>: Mesh {
    
    var triangles: [Triangle<IndicesType>] = []
    
    override init() {
        super.init()
    }
    
    init(points: [Vertex], stripTriangle: Bool = true) {
        super.init()
        
        self.triangles.reserveCapacity(stripTriangle ? points.count-2 : points.count/3)
        var t = Triangle<IndicesType>()
        
        if(stripTriangle) {
            for i in 0..<points.count-1 {
                t.a = IndicesType(UIntMax(i))
                t.b = IndicesType(UIntMax(i + 1))
                t.c = IndicesType(UIntMax(i + 2))
                triangles.append(t)
            }
        } else {
            for i in 0..<points.count/2 {
                t.a = IndicesType(UIntMax(i*3))
                t.b = IndicesType(UIntMax(i*3 + 1))
                t.b = IndicesType(UIntMax(i*3 + 2))
                triangles.append(t)
            }
        }
        self.vertices = points
    }
    
    init(points: [Vertex], triangles: [Triangle<IndicesType>]) {
        super.init()
        
        for vertex in points {
            print(vertex.position)
        }
        for triangle in triangles {
            print(triangle)
        }
        
        self.triangles = triangles
        self.vertices = points
    }
    
    override func GetPrimitiveType() -> MTLPrimitiveType {
        return .Triangle
    }
    
    override func FillIndexBuffer() {
        indexBuffer = EngineController.device.newBufferWithBytes(triangles, length: triangles.count * sizeof(Triangle<IndicesType>), options: [])
        indexBuffer.label = name + "_indexBuffer"
    }
    
    override func GetIndexCount() -> Int {
        return triangles.count * 3
    }
    
    override func GetMetalIndexType() -> MTLIndexType {
        return IndicesType.GetMetalType()
    }
}