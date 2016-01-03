//
//  TubeMesh.swift
//  Metal_3D_Engine
//
//  Created by Adrian Krupa on 23.12.2015.
//  Copyright © 2015 Adrian Krupa. All rights reserved.
//

import Foundation
import simd

class TubeMesh: TrianglesMesh<UInt16> {
    
    init(R _R: Float? = nil, r _r: Float? = nil, height _height: Float? = nil, density _density: Int? = nil, color _color: Color? = nil) {
        super.init()
        
        let R = _R ?? 1.0
        let r = _r ?? 0.5
        let density = _density ?? 40
        let height = _height ?? 2
        let color = _color ?? Color.whiteColor()
        
        var offset = 0
        
        name = "TubeMesh"
        var v = Vertex()
        
        v.normal = float3(0.0, 1.0, 0.0)
        v.color = color.getRGBA()
        
        for i in 0...density {
            let alpha = Float(i) * Float(M_PI) * 2 / Float(density)
            for j in 0..<2 {
                v.position = float3(
                    R * sin(alpha),
                    Float(j * 2 - 1) * height / 2,
                    R * cos(alpha))
                v.normal = float3(
                    sin(alpha),
                    0,
                    cos(alpha))
                v.UV = float2( Float(i) /  Float(density), Float(j))
                vertices.append(v)
            }
        }
        
        for i in 0...density {
            let alpha = Float(i) * Float(M_PI) * 2 / Float(density)
            for j in 0..<2 {
                v.position = float3(
                    r * sin(alpha),
                    Float(j * 2 - 1) * height / 2,
                    r * cos(alpha))
                v.normal = float3(
                    -sin(alpha),
                    0,
                    -cos(alpha))
                v.UV = float2( Float(i) /  Float(density), Float(j))
                vertices.append(v)
            }
        }
        
        for j in 0..<2 {
            v.normal = float3(0, Float(j * 2 - 1), 0)
            for i in 0...density {
                let alpha = Float(i) * Float(M_PI) * 2 / Float(density)
                v.position = float3(
                    R * sin(alpha),
                    Float(j * 2 - 1) * height / 2,
                    R * cos(alpha))
                v.UV = float2(0.5+sin(alpha), 0.5+cos(alpha))
                vertices.append(v)
                
                v.position = float3(
                    r * sin(alpha),
                    Float(j * 2 - 1) * height / 2,
                    r * cos(alpha))
                v.UV = float2(0.5+sin(alpha)*r/R, 0.5+cos(alpha)*r/R)
                vertices.append(v)
            }
        }
        
        var t = Triangle<UInt16>()
        for i in 0..<density {
            
            t.a = UInt16(offset + i * 2)
            t.b = UInt16(offset + (i + 1) * 2)
            t.c = UInt16(offset + i * 2 + 1)
            triangles.append(t)
            
            t.a = UInt16(offset + (i + 1) * 2)
            t.b = UInt16(offset + (i + 1) * 2 + 1)
            t.c = UInt16(offset + i * 2 + 1)
            triangles.append(t)
        }
        offset += 2 * (density + 1)
        
        for i in 0..<density {
            
            t.c = UInt16(offset + i * 2)
            t.b = UInt16(offset + (i + 1) * 2)
            t.a = UInt16(offset + i * 2 + 1)
            triangles.append(t)
            
            t.c = UInt16(offset + (i + 1) * 2)
            t.b = UInt16(offset + (i + 1) * 2 + 1)
            t.a = UInt16(offset + i * 2 + 1)
            triangles.append(t)
        }
        offset += 2 * (density + 1)
        
        for i in 0..<density {
            t.c = UInt16(offset + i * 2)
            t.b = UInt16(offset + (i + 1) * 2)
            t.a = UInt16(offset + i * 2 + 1)
            triangles.append(t)
            
            t.c = UInt16(offset + (i + 1) * 2)
            t.b = UInt16(offset + (i + 1) * 2 + 1)
            t.a = UInt16(offset + i * 2 + 1)
            triangles.append(t)
        }
        offset += 2 * (density + 1)
        
        for i in 0..<density {
            t.a = UInt16(offset + i * 2)
            t.b = UInt16(offset + (i + 1) * 2)
            t.c = UInt16(offset + i * 2 + 1)
            triangles.append(t)
            
            t.a = UInt16(offset + (i + 1) * 2)
            t.b = UInt16(offset + (i + 1) * 2 + 1)
            t.c = UInt16(offset + i * 2 + 1)
            triangles.append(t)
        }
        
    }
    
}
    