//
//  Component.swift
//  Metal_3D_Engine
//
//  Created by Adrian Krupa on 06.12.2015.
//  Copyright © 2015 Adrian Krupa. All rights reserved.
//

import Foundation
import MetalKit

class Component {
    
    weak var gameObject: GameObject? = nil
    
    func AssignGameObject(gameObject: GameObject) {
        if(self.gameObject == nil) {
            self.gameObject = gameObject
            Start()
        } else {
            self.gameObject = gameObject
        }
    }
    
    func GetTransform() -> Transform {
        return gameObject!.GetTransform()
    }
    
    func Start() {}
    
    func Update() {}
    
    func FixedUpdate() {}
    
    func Render(commandEncoder: MTLRenderCommandEncoder, camera: Camera) {}
    
}