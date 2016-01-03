//
//  PointsMesh.swift
//  Metal_3D_Engine
//
//  Created by Adrian Krupa on 08.12.2015.
//  Copyright © 2015 Adrian Krupa. All rights reserved.
//

import Foundation
import MetalKit

class PointsMesh<IndicesType: MTLUnsignedIndexType>: Mesh {
    
    var points: [Point<IndicesType>] = []
    
    override init() {
        super.init()
    }
    
    init(points: [Vertex]) {
        super.init()
        self.points.reserveCapacity(points.count)
        var p = Point<IndicesType>()
        for i in 0...points.count  {
            p.a = IndicesType(UIntMax(i))
            self.points.append(p)
        }
        self.vertices = points
    }
    
    override func GetPrimitiveType() -> MTLPrimitiveType {
        return .Point
    }
    
    override func FillIndexBuffer() {
        indexBuffer = EngineController.device.newBufferWithBytes(points, length: points.count * sizeof(Point<IndicesType>), options: [])
        indexBuffer.label = name + "_indexBuffer"
    }
    
    override func GetIndexCount() -> Int {
        return points.count
    }
    
    override func GetMetalIndexType() -> MTLIndexType {
        return IndicesType.GetMetalType()
    }
}