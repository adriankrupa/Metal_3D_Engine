//
//  AmbientTexturedShader.swift
//  Metal_3D_Engine
//
//  Created by Adrian Krupa on 17.01.2016.
//  Copyright © 2016 Adrian Krupa. All rights reserved.
//

import Foundation

class AmbientTexturedShader: Shader {
    
    override func getBuiltInUniformsBufferMetaData() -> BuiltInBuffer.Type {
        return MVP_Simple_Buffer.self
    }
    override func vertexShaderName() -> String {
        return "ambientTexturedVertexShader"
    }
    
    override func fragmentShaderName() -> String {
        return "ambientTexturedFragmentShader"
    }
    
}