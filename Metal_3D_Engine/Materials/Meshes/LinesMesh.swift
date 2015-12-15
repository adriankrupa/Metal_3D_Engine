//
//  LinesMesh.swift
//  Metal_3D_Engine
//
//  Created by Adrian Krupa on 15.12.2015.
//  Copyright © 2015 Adrian Krupa. All rights reserved.
//

import Foundation
import MetalKit

class LinesMesh: Mesh {
    
    var lines: [Line] = []
    
    override init() {
        super.init()
    }
    
    init(points: [Vertex], stripLine: Bool = true) {
        super.init()

        self.lines.reserveCapacity(stripLine ? points.count-1 : points.count/2)
        var l = Line()
        
        if(stripLine) {
            for i in 0..<points.count-1 {
                l.a = UInt16(i)
                l.b = UInt16(i+1)
                lines.append(l)
            }
        } else {
            for i in 0..<points.count/2 {
                l.a = UInt16(i*2)
                l.b = UInt16(i*2+1)
                lines.append(l);
            }
        }
        self.vertices = points
    }
    
    override func GetPrimitiveType() -> MTLPrimitiveType {
        return .Line
    }
    
    override func FillIndexBuffer() {
        indexBuffer = ViewController.device.newBufferWithBytes(lines, length: lines.count * sizeof(Line), options: [])
        indexBuffer.label = name + "_indexBuffer"
    }
    
    override func GetIndexCount() -> Int {
        return lines.count * 2
    }
}
