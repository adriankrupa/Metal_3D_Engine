//
//  PointsMesh.swift
//  Metal_3D_Engine
//
//  Created by Adrian Krupa on 08.12.2015.
//  Copyright © 2015 Adrian Krupa. All rights reserved.
//

import Foundation
import MetalKit

class PointsMesh: Mesh {
    
    var points: [Point] = []
    
    override init() {
        super.init()
    }
    
    init(points: [Vertex]) {
        super.init()
        self.points.reserveCapacity(points.count)
        var p = Point()
        for i in 0...points.count  {
            p.a = UInt16(i)
            self.points.append(p)
        }
        self.vertices = points
    }
    
    override func GetPrimitiveType() -> MTLPrimitiveType {
        return .Point
    }
    
    override func FillIndexBuffer() {
        indexBuffer = ViewController.device.newBufferWithBytes(points, length: points.count * sizeof(Point), options: [])
        indexBuffer.label = name + "_indexBuffer"
    }
    
    override func GetIndexCount() -> Int {
        return points.count
    }
}