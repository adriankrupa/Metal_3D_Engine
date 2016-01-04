//
//  Light.swift
//  Metal_3D_Engine
//
//  Created by Adrian Krupa on 03.01.2016.
//  Copyright © 2016 Adrian Krupa. All rights reserved.
//

import Foundation
import MetalKit

class Light: Component {
    
    struct LightData {
        var type = LightType.Directional
        var direction = float3(1, 0, 0)
        var position = float3()
        var Range = Float(10)
        var spotAngle = Float(M_PI_4)
        var intensity = 1
        var color = Color(red: CGFloat(255.0/255.0), green: CGFloat(214.0/255.0), blue: CGFloat(170.0/255.0), alpha: 1)
    }
    
    var lightData = LightData()
}