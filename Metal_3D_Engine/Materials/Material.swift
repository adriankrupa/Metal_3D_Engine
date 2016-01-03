//
//  Material.swift
//  Metal_3D_Engine
//
//  Created by Adrian Krupa on 08.12.2015.
//  Copyright © 2015 Adrian Krupa. All rights reserved.
//

import Foundation
import MetalKit

class Material {
    
    var pipelineStateDescriptor: MTLRenderPipelineDescriptor! = nil
    var pipelineState: MTLRenderPipelineState! = nil
    
    var uniformBuffer: MTLBuffer! = nil
    
    init(vertexProgram: String, fragmentProgram: String) {
                
        let fragmentProgramObject = EngineController.library.newFunctionWithName(fragmentProgram)!
        let vertexProgramObject = EngineController.library.newFunctionWithName(vertexProgram)!
                
        
        pipelineStateDescriptor = MTLRenderPipelineDescriptor()
        pipelineStateDescriptor.vertexFunction = vertexProgramObject
        pipelineStateDescriptor.fragmentFunction = fragmentProgramObject
        pipelineStateDescriptor.colorAttachments[0].pixelFormat = MTLPixelFormat.BGRA8Unorm
        pipelineStateDescriptor.vertexDescriptor = Vertex.vertexDescriptor
        pipelineStateDescriptor.depthAttachmentPixelFormat = .Depth32Float
        initialize()
    }
    
    init(shader: Shader) {
        
        pipelineStateDescriptor = MTLRenderPipelineDescriptor()
        pipelineStateDescriptor.vertexFunction = shader.getVertexShader()
        pipelineStateDescriptor.fragmentFunction = shader.getFragmentShader()
        pipelineStateDescriptor.colorAttachments[0].pixelFormat = MTLPixelFormat.BGRA8Unorm
        pipelineStateDescriptor.vertexDescriptor = Vertex.vertexDescriptor
        pipelineStateDescriptor.depthAttachmentPixelFormat = .Depth32Float
        initialize()
    }
    
    init(pipelineStateDescriptor: MTLRenderPipelineDescriptor) {
        self.pipelineStateDescriptor = pipelineStateDescriptor
        initialize()
    }
    
    private func initialize() {
        do {
            try pipelineState = EngineController.device.newRenderPipelineStateWithDescriptor(pipelineStateDescriptor)
        } catch let error {
            print("Failed to create pipeline state, error \(error)")
        }
    }
    
}