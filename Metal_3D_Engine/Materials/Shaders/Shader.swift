//
//  Shader.swift
//  Metal_3D_Engine
//
//  Created by Adrian Krupa on 08.12.2015.
//  Copyright © 2015 Adrian Krupa. All rights reserved.
//

import Foundation
import MetalKit

class Shader {
    
    private static var vertexShader: MTLFunction!
    private static var fragmentShader: MTLFunction!
    
    init() {
        if(self.dynamicType.vertexShader == nil) {
            self.dynamicType.vertexShader =  EngineController.library.newFunctionWithName(vertexShaderName())!
        }
        if(self.dynamicType.fragmentShader == nil) {
            self.dynamicType.fragmentShader =  EngineController.library.newFunctionWithName(fragmentShaderName())!
        }
    }
    
    func vertexShaderName() -> String {
        return "ambientVertexShader"
    }
    
    func fragmentShaderName() -> String {
        return "ambientFragmentShader"
    }
    
    func getVertexShader() -> MTLFunction {
        return self.dynamicType.vertexShader
    }
    
    func getFragmentShader() -> MTLFunction {
        return self.dynamicType.fragmentShader
    }
    
    func getBuiltInUniformsBufferMetaData() -> BuiltInBuffer.Type {
        return BuiltInBuffer.self
    }
    
}