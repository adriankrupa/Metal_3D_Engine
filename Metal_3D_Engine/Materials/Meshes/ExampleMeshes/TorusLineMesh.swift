//
//  TorusLineMesh.swift
//  Metal_3D_Engine
//
//  Created by Adrian Krupa on 23.12.2015.
//  Copyright © 2015 Adrian Krupa. All rights reserved.
//

import Foundation
import simd

class TorusLineMesh: LinesMesh<UInt16> {
    
    init(R: Float? = nil, r: Float? = nil, density: Int? = nil, color: Color? = nil) {
        super.init()
        
        let _R = R ?? 1.0
        let _r = r ?? 0.25
        let _density = density ?? 20
        let _color = color ?? Color.whiteColor()
        
        name = "TorusLineMesh"
        var v = Vertex()
        
        v.normal = float3(0.0, 1.0, 0.0)
        v.color = _color.getRGBA()
        
        for i in 0..._density {
            for j in 0..._density {
                let alpha = Float(j) * Float(M_PI) * 2 / Float(_density)
                let beta = Float(i) *  Float(M_PI) * 2 / Float(_density)
                v.position = float3(
                    (_R + _r * cos(alpha)) * cos(beta),
                    _r * sin(alpha),
                    (_R + _r * cos(alpha)) * sin(beta))
                v.UV = float2(Float(j) / Float(_density), Float(i) / Float(_density))
                
                let dalpha = float3(-_r * sin(alpha) * cos(beta),
                    _r * cos(alpha),
                    -_r * sin(alpha) * sin(beta))
                let dbeta = float3(-_R * sin(beta),
                    0,
                    _R * cos(beta))
                v.normal = normalize(cross(dalpha, dbeta))
                v.tangent = dalpha
                vertices.append(v)
            }
        }
        
        var l = Line<UInt16>()
        for i in 0..<_density {
            for j in 0..<_density  {
                
                l.a = UInt16(i + j*(_density+1))
                l.b = UInt16(i + j*(_density+1)+1)
                lines.append(l)
                
                l.a = UInt16(i + j*(_density+1)+1)
                l.b = UInt16(i + (j+1)*(_density+1)+1)
                lines.append(l)
                
            }
        }
    }
    
    convenience init(parameters: Dictionary<String, AnyObject>) {
        let c = parameters["color"] as? Color
        var C = c ?? parameters["Color"] as? Color
        
        if C == nil {
            let f = parameters["color"] as? float4
            let F = f ?? parameters["Color"] as? float4
            
            if let FF = F {
                C = Color(color: FF)
            }
        }
        
        let r = parameters["r"] as? Float
        let R = parameters["R"] as? Float
        
        let d = parameters["density"] as? Int
        let D = d ?? parameters["Density"] as? Int

        self.init(R: R, r: r, density: D, color: C)
    }
}
