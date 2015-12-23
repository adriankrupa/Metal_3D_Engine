//
//  TrianglesMesh.swift
//  Metal_3D_Engine
//
//  Created by Adrian Krupa on 22.12.2015.
//  Copyright © 2015 Adrian Krupa. All rights reserved.
//

import Foundation
import MetalKit

class TrianglesMesh: Mesh {
    
    var triangles: [Triangle] = []
    
    override init() {
        super.init()
    }
    
    init(points: [Vertex], stripTriangle: Bool = true) {
        super.init()
        
        self.triangles.reserveCapacity(stripTriangle ? points.count-2 : points.count/3)
        var t = Triangle()
        
        if(stripTriangle) {
            for i in 0..<points.count-1 {
                t.a = UInt16(i)
                t.b = UInt16(i+1)
                t.c = UInt16(i+2)
                triangles.append(t)
            }
        } else {
            for i in 0..<points.count/2 {
                t.a = UInt16(i*3)
                t.b = UInt16(i*3+1)
                t.b = UInt16(i*3+2)
                triangles.append(t);
            }
        }
        self.vertices = points
    }
    
    override func GetPrimitiveType() -> MTLPrimitiveType {
        return .Triangle
    }
    
    override func FillIndexBuffer() {
        indexBuffer = ViewController.device.newBufferWithBytes(triangles, length: triangles.count * sizeof(Triangle), options: [])
        indexBuffer.label = name + "_indexBuffer"
    }
    
    override func GetIndexCount() -> Int {
        return triangles.count * 3
    }
}