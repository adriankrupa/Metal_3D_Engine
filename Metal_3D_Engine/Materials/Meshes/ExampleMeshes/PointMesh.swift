//
//  PointMesh.swift
//  Metal_3D_Engine
//
//  Created by Adrian Krupa on 14.12.2015.
//  Copyright © 2015 Adrian Krupa. All rights reserved.
//

import Foundation
import simd

class PointMesh: PointsMesh<UInt16> {
    
    override init() {
        super.init()
        name = "PointMesh"
        
        var v = Vertex()
        v.color = float4(1, 1, 1, 1)
        v.position = float3(0, 0, 0)
        
        var p = Point<UInt16>()
        p.a = 0
        
        vertices.append(v)
        points.append(p)
    }
}