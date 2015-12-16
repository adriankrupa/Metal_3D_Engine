//
//  LineMesh.swift
//  Metal_3D_Engine
//
//  Created by Adrian Krupa on 15.12.2015.
//  Copyright © 2015 Adrian Krupa. All rights reserved.
//

import Foundation
import simd

class LineMesh: LinesMesh {
    
    override init() {
        super.init()
        name = "LineMesh"
        var v = Vertex()

        v.color = float4(1.0, 1.0, 1.0, 1.0)
        v.position = float3(-1,0,0)
        
        var l = Line()
        l.a = UInt16(0)
        l.a = UInt16(1)
        vertices.append(v)
        v.position = float3(1,0,0)
        vertices.append(v)
        lines.append(l)
    }
    
}