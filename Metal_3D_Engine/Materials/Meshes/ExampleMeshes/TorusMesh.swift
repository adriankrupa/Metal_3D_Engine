//
//  TorusMesh.swift
//  Metal_3D_Engine
//
//  Created by Adrian Krupa on 22.12.2015.
//  Copyright © 2015 Adrian Krupa. All rights reserved.
//

import Foundation
import simd

class TorusMesh: TrianglesMesh<UInt16> {
    
    init(R: Float = 1.0, r: Float! = 0.25, density: Int = 40, color: Color = Color.whiteColor()) {
        super.init()
        name = "TorusMesh"
        var v = Vertex()
        
        v.normal = float3(0.0, 1.0, 0.0)
        v.color = color.getRGBA()
        
        for i in 0...density {
            for j in 0...density {
                let alpha = Float(j) * Float(M_PI) * 2 / Float(density)
                let beta = Float(i) *  Float(M_PI) * 2 / Float(density)
                v.position = float3(
                    (R + r * cos(alpha)) * cos(beta),
                    r * sin(alpha),
                    (R + r * cos(alpha)) * sin(beta))
                v.UV = float2(Float(j) / Float(density), Float(i) / Float(density))
                
                let dalpha = float3(-r * sin(alpha) * cos(beta),
                    r * cos(alpha),
                    -r * sin(alpha) * sin(beta))
                let dbeta = float3(-R * sin(beta),
                    0,
                    R * cos(beta))
                v.normal = normalize(cross(dalpha, dbeta))
                v.tangent = dalpha
                vertices.append(v)
            }
        }
        
        var t = Triangle<UInt16>()
        for i in 0..<density {
            for j in 0..<density  {
                
                t.a = UInt16(i + j*(density+1))
                t.b = UInt16(i + j*(density+1)+1)
                t.c = UInt16(i + (j+1)*(density+1))
                triangles.append(t)
                
                t.a = UInt16(i + j*(density+1)+1)
                t.b = UInt16(i + (j+1)*(density+1)+1)
                t.c = UInt16(i + (j+1)*(density+1))
                triangles.append(t)
                
            }
        }
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
