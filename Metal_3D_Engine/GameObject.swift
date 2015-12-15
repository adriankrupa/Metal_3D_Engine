//
//  GameObject.swift
//  Metal_3D_Engine
//
//  Created by Adrian Krupa on 06.12.2015.
//  Copyright © 2015 Adrian Krupa. All rights reserved.
//

import Foundation
import MetalKit

class GameObject {
    
    var isEnables = true
    var name: String = "GameObject"
    
    var transform: Transform
    var components: [Component] = []
    
    init() {
        transform = Transform()
        components.append(transform)
    }
    
    func Update() {
        for component in components {
            component.Update()
        }
    }
    
    func FixedUpdate() {
        for component in components {
            component.FixedUpdate()
        }
    }
    
    func Render(commandEncoder: MTLRenderCommandEncoder, camera: Camera) {
        for component in components {
            component.Render(commandEncoder, camera: camera)
        }
    }
    
    func AddComponent(component: Component) -> GameObject {
        components.append(component)
        component.AssignGameObject(self)
        return self
    }
    
}