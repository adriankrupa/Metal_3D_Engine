//
//  CubeMesh.swift
//  Metal_3D_Engine
//
//  Created by Adrian Krupa on 22.12.2015.
//  Copyright © 2015 Adrian Krupa. All rights reserved.
//

import Foundation
import simd

class CubeMesh: TrianglesMesh {
    
    init(color: Color = Color.whiteColor()) {
        super.init()
        name = "CubeMesh"
        var v = Vertex()
        
        v.color = color.getRGBA()
        
        v.normal = float3(0.0, 1.0, 0.0)
        v.tangent = float3(1.0, 0.0, 0.0)
        
        v.position = float3(-1.0, 1.0, 1.0)
        v.UV = float2(1,0)
        vertices.append(v)
        
        v.position = float3( 1.0, 1.0, 1.0)
        v.UV = float2(0,0)
        vertices.append(v)
        
        v.position = float3( 1.0, 1.0, -1.0)
        v.UV = float2(0,1)
        vertices.append(v)
        
        v.position = float3(-1.0, 1.0, -1.0)
        v.UV = float2(1,1)
        vertices.append(v)
        
        v.normal = float3(0.0, -1.0, 0.0)
        v.tangent = float3(1.0, 0.0, 0.0)
        
        v.position = float3(-1.0, -1.0, 1.0)
        v.UV = float2(0,1)
        vertices.append(v)
        
        v.position = float3( 1.0, -1.0, 1.0)
        v.UV = float2(1,1)
        vertices.append(v)
        
        v.position = float3( 1.0, -1.0, -1.0)
        v.UV = float2(1,0)
        vertices.append(v)
        
        v.position = float3(-1.0, -1.0, -1.0)
        v.UV = float2(0,0)
        vertices.append(v)
        
        v.normal = float3(1.0, 0.0, 0.0)
        v.tangent = float3(0.0, 0.0, 1.0)
        
        v.position = float3( 1.0, -1.0, 1.0)
        v.UV = float2(0,0)
        vertices.append(v)
        
        v.position = float3( 1.0, 1.0, 1.0)
        v.UV = float2(0,1)
        vertices.append(v)
        
        v.position = float3( 1.0, 1.0, -1.0)
        v.UV = float2(1,1)
        vertices.append(v)
        
        v.position = float3( 1.0, -1.0, -1.0)
        v.UV = float2(1,0)
        vertices.append(v)
        
        v.normal = float3(-1.0, 0.0, 0.0)
        v.tangent = float3(0.0, 0.0, 1.0)
        
        v.position = float3(-1.0, -1.0, 1.0)
        v.UV = float2(0,0)
        vertices.append(v)
        
        v.position = float3(-1.0, 1.0, 1.0)
        v.UV = float2(0,1)
        vertices.append(v)
        
        v.position = float3(-1.0, 1.0, -1.0)
        v.UV = float2(1,1)
        vertices.append(v)
        
        v.position = float3(-1.0, -1.0, -1.0)
        v.UV = float2(1,0)
        vertices.append(v)
        
        v.normal = float3(0.0, 0.0, 1.0)
        v.tangent = float3(0.0, 1.0, 0.0)
        
        v.position = float3(-1.0, 1.0, 1.0)
        v.UV = float2(0,1)
        vertices.append(v)
        
        v.position = float3( 1.0, 1.0, 1.0)
        v.UV = float2(1,1)
        vertices.append(v)
        
        v.position = float3( 1.0, -1.0, 1.0)
        v.UV = float2(1,0)
        vertices.append(v)
        
        v.position = float3(-1.0, -1.0, 1.0)
        v.UV = float2(0,0)
        vertices.append(v)
        
        v.normal = float3(0.0, 0.0,-1.0)
        v.tangent = float3(0.0, 1.0, -0.0)
        
        v.position = float3(-1.0, 1.0,-1.0)
        v.UV = float2(1,1)
        vertices.append(v)
        
        v.position = float3( 1.0, 1.0,-1.0)
        v.UV = float2(0,1)
        vertices.append(v)
        
        v.position = float3( 1.0, -1.0,-1.0)
        v.UV = float2(0,0)
        vertices.append(v)
        
        v.position = float3(-1.0, -1.0,-1.0)
        v.UV = float2(1,0)
        vertices.append(v)
        
        
        var t = Triangle()
        
        t.a = 0
        t.b = 1
        t.c = 2
        triangles.append(t)
        
        t.a = 0
        t.b = 2
        t.c = 3
        triangles.append(t)
        
        t.a = 6
        t.b = 5
        t.c = 4
        triangles.append(t)
        
        t.a = 7
        t.b = 6
        t.c = 4
        triangles.append(t)
        
        t.a = 10
        t.b = 9
        t.c = 8
        triangles.append(t)
        
        t.a = 11
        t.b = 10
        t.c = 8
        triangles.append(t)
        
        t.a = 12
        t.b = 13
        t.c = 14
        triangles.append(t)
        
        t.a = 12
        t.b = 14
        t.c = 15
        triangles.append(t)
        
        t.a = 18
        t.b = 17
        t.c = 16
        triangles.append(t)
        
        t.a = 19
        t.b = 18
        t.c = 16
        triangles.append(t)
        
        t.a = 20
        t.b = 21
        t.c = 22
        triangles.append(t)
        
        t.a = 20
        t.b = 22
        t.c = 23
        triangles.append(t)
        
    }
    
    convenience init(parameters: Dictionary<String, AnyObject>) {
        let c = parameters["color"] as? Color
        let C = parameters["Color"] as? Color
        
        if let cc = c {
            self.init(color: cc)
            return
        }
        if let CC = C {
            self.init(color: CC)
            return
        }
        
        let f = parameters["color"] as? float4
        let F = parameters["Color"] as? float4
        
        if let ff = f {
            self.init(color: Color(color: ff))
            return
        }
        if let FF = F {
            self.init(color: Color(color: FF))
            return
        }
        self.init()
    }
}
