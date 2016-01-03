//
//  LinesCubeMesh.swift
//  Metal_3D_Engine
//
//  Created by Adrian Krupa on 15.12.2015.
//  Copyright © 2015 Adrian Krupa. All rights reserved.
//

import Foundation
import simd

class LinesCubeMesh: LinesMesh<UInt16> {

    override init() {
        super.init()
        name = "CubeLinesMesh"
        var v = Vertex()

        v.color = float4(1.0, 1.0, 1.0, 1.0);
        for i in 0..<2 {
            v.position = float3(-1, Float(i*2-1), -1);
            vertices.append(v);
            v.position = float3(-1, Float(i*2-1), 1);
            vertices.append(v);
            v.position = float3(1, Float(i*2-1), 1);
            vertices.append(v);
            v.position = float3(1, Float(i*2-1), -1);
            vertices.append(v);
        }
        
        var l = Line<UInt16>()
        for i in 0..<4 {
            l.a = UInt16(i%4);
            l.b = UInt16((i+1)%4);
            lines.append(l);
        }
        
        for i in 0..<4 {
            l.a = UInt16(4+i%4);
            l.b = UInt16(4+(i+1)%4);
            lines.append(l);
        }
        for i in 0..<4 {
            l.a = UInt16(i%4);
            l.b = UInt16(4+i%4);
            lines.append(l);
        }
    }

}
