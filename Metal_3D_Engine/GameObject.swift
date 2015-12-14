//
//  GameObject.swift
//  Metal_3D_Engine
//
//  Created by Adrian Krupa on 06.12.2015.
//  Copyright © 2015 Adrian Krupa. All rights reserved.
//

import Foundation

class GameObject {
    
    var isEnables = true
    var components: [Component] = []
    
    init() {
        components.append(Transform())
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
    
    func AddComponent(component: Component) -> GameObject {
        components.append(component)
        return self
    }
    
}