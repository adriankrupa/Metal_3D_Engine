//
//  LinesMesh.swift
//  Metal_3D_Engine
//
//  Created by Adrian Krupa on 15.12.2015.
//  Copyright © 2015 Adrian Krupa. All rights reserved.
//

import Foundation
import MetalKit

class LinesMesh<IndicesType: MTLUnsignedIndexType>: Mesh {
    
    var lines: [Line<IndicesType>] = []
    
    override init() {
        super.init()
    }
    
    init(points: [Vertex], stripLine: Bool = true) {
        super.init()

        self.lines.reserveCapacity(stripLine ? points.count-1 : points.count/2)
        var l = Line<IndicesType>()
        
        if(stripLine) {
            for i in 0..<points.count-1 {
                l.a = IndicesType(UIntMax(i))
                l.b = IndicesType(UIntMax(i+1))
                lines.append(l)
            }
        } else {
            for i in 0..<points.count/2 {
                l.a = IndicesType(UIntMax(i*2))
                l.b = IndicesType(UIntMax(i*2+1))
                lines.append(l)
            }
        }
        self.vertices = points
    }
    
    override func GetPrimitiveType() -> MTLPrimitiveType {
        return .Line
    }
    
    override func FillIndexBuffer() {
        indexBuffer = EngineController.device.newBufferWithBytes(lines, length: lines.count * sizeof(Line<IndicesType>), options: [])
        indexBuffer.label = name + "_indexBuffer"
    }
    
    override func GetIndexCount() -> Int {
        return lines.count * 2
    }
    
    override func GetMetalIndexType() -> MTLIndexType {
        return IndicesType.GetMetalType()
    }
}
