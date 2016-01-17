//
//  MeshRenderer.swift
//  Metal_3D_Engine
//
//  Created by Adrian Krupa on 08.12.2015.
//  Copyright © 2015 Adrian Krupa. All rights reserved.
//

import Foundation
import MetalKit

class MeshRenderer: Component {
    
    var mesh: Mesh!
    var materials: [Material] = []
    
    var builtInUniformBuffers: [BuiltInBuffer] = []
    var uniformsTemp: BuiltInUniforms!
    
    
    
    override func Render(commandEncoder: MTLRenderCommandEncoder, camera: Camera) {
        super.Render(commandEncoder, camera: camera)
        uniformsTemp = BuiltInUniforms()
        for i in 0..<materials.count {
            Render(commandEncoder, camera: camera, index: i)
        }
    }
    
    init(mesh: Mesh) {
        super.init()
        self.mesh = mesh
    }
    
    private func Render(commandEncoder: MTLRenderCommandEncoder, camera: Camera, index: Int) {
        mesh.FillData()
        
        let material = materials[index]
        let builtInUniformBuffer = builtInUniformBuffers[index]
        
        if(builtInUniformBuffer.isUsing_ModelViewProjectionMatrix()) {
            uniformsTemp.modelMatrix = uniformsTemp.modelMatrix ?? GetTransform().GetModelMatrix()
            uniformsTemp.viewMatrix = camera.GetViewMatrix()
            uniformsTemp.projectionMatrix = uniformsTemp.projectionMatrix ?? camera.GetProjectionMatrix()
            uniformsTemp.modelViewProjectionMatrix = uniformsTemp.modelViewProjectionMatrix ?? uniformsTemp.projectionMatrix! * uniformsTemp.viewMatrix! * uniformsTemp.modelMatrix!
            builtInUniformBuffer.set_ModelViewProjectionMatrix(uniformsTemp.modelViewProjectionMatrix!)
        }
        
        builtInUniformBuffer.fillDataAndUpdate()
        
        for uniformBuffer in material.uniformBuffers {
            
            uniformBuffer.fillDataAndUpdate()
        }

        if(EngineController.lastPipelineState == nil || EngineController.lastPipelineState !== material.pipelineState) {
            commandEncoder.setRenderPipelineState(material.pipelineState)
            EngineController.lastPipelineState = material.pipelineState
        }
        commandEncoder.setVertexBuffer(mesh.vertexBuffer, offset: 0, atIndex: 0)
        commandEncoder.setVertexBuffer(builtInUniformBuffer.buffer, offset: 0, atIndex: 1)
        
        for (idx, texture) in material.textures.enumerate() {
            commandEncoder.setFragmentTexture(texture, atIndex: idx)
        }
        
        
        commandEncoder.drawIndexedPrimitives(mesh.GetPrimitiveType(), indexCount: mesh.GetIndexCount(), indexType: mesh.GetMetalIndexType(), indexBuffer: mesh.indexBuffer, indexBufferOffset: 0)
    }
    
    func AddMaterial(material: Material) -> MeshRenderer {
        materials.append(material)
        builtInUniformBuffers.append(material.builtInUniformMeta.init())
        return self
    }
    
    struct BuiltInUniforms {
        var modelMatrix: float4x4?
        var viewMatrix: float4x4?
        var projectionMatrix: float4x4?
        var modelViewProjectionMatrix: float4x4?
    }
    
}