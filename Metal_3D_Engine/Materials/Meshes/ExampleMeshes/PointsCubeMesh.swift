//
//  PointsCubeMesh.swift
//  Metal_3D_Engine
//
//  Created by Adrian Krupa on 15.12.2015.
//  Copyright © 2015 Adrian Krupa. All rights reserved.
//

import Foundation
import simd

class PointsCubeMesh: PointsMesh<UInt16> {
    
    override init() {
        super.init()
        initialize()
    }
    
    init(pointsNumber: Int) {
        super.init()
        initialize(pointsNumber)
    }
    
    private func initialize(pointsNumber: Int = 20) {
        name = "PointsCubeMesh"
        var v = Vertex()
        v.color = float4(1, 1, 1, 1)
        var index = UInt16(0);
        for i in 0..<pointsNumber {
            for j in 0..<pointsNumber {
                for k in 0..<pointsNumber {
                    if pointsNumber == 1 {
                        v.position = float3(0, 0, 0)
                    } else {
                        v.position = float3((Float(i)/Float(pointsNumber-1))*2.0 - 1,
                                            (Float(j)/Float(pointsNumber-1))*2.0 - 1,
                                            (Float(k)/Float(pointsNumber-1))*2.0 - 1)
                    }
                    var p = Point<UInt16>()
                    p.a = index++

                    vertices.append(v)
                    points.append(p)
                }
            }
        }
    }
}