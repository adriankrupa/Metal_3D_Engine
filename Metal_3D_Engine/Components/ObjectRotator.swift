//
//  ObjectRotator.swift
//  Metal_3D_Engine
//
//  Created by Adrian Krupa on 15.12.2015.
//  Copyright © 2015 Adrian Krupa. All rights reserved.
//

import Foundation
import simd

class ObjectRotator: Component {
    
    var rotationSpeed = float3(0.5, 0, 0)
    
    override func Update() {
        super.Update()
        let t = GetTransform()
        t.RotationInEulerAngles = t.RotationInEulerAngles + rotationSpeed * Time.deltaTime
    }
}