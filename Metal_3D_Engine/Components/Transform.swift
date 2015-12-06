//
//  Transform.swift
//  Metal_3D_Engine
//
//  Created by Adrian Krupa on 06.12.2015.
//  Copyright © 2015 Adrian Krupa. All rights reserved.
//

import Foundation
import simd
import Swift3D

class Transform: Component {
    
    var position = float3()
    var scale = float3()
    var rotation = quat()
    var rotationInEulerAngles = float3()
}