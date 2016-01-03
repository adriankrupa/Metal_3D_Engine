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
    
    override func Render(commandEncoder: MTLRenderCommandEncoder, camera: Camera) {
        super.Render(commandEncoder, camera: camera)
        for material in materials {
            Render(commandEncoder, camera: camera, material: material)
        }
    }
    
    init(mesh: Mesh) {
        super.init()
        self.mesh = mesh
    }
    
    private func Render(commandEncoder: MTLRenderCommandEncoder, camera: Camera, material: Material) {
        mesh.FillData()
        
        let projection = camera.GetProjectionMatrix() * camera.GetViewMatrix() * GetTransform().GetModelMatrix()
        let Uniforms: [float4x4] = [projection]
        
        if(material.uniformBuffer == nil) {
#if os(OSX)
            material.uniformBuffer = EngineController.device.newBufferWithLength(sizeof(float4x4), options: [.StorageModeManaged])
#else
            material.uniformBuffer = EngineController.device.newBufferWithLength(sizeof(float4x4), options: [.StorageModeShared])
#endif
            material.uniformBuffer.label = "uniforms_vertexBuffer"
        } else {
            memcpy(material.uniformBuffer.contents(), Uniforms, sizeof(float4x4))
#if os(OSX)
            material.uniformBuffer.didModifyRange(NSMakeRange(0, sizeof(float4x4)))
#endif
        }

        commandEncoder.setRenderPipelineState(material.pipelineState)
        commandEncoder.setVertexBuffer(mesh.vertexBuffer, offset: 0, atIndex: 0)
        commandEncoder.setVertexBuffer(material.uniformBuffer, offset: 0, atIndex: 1)
        commandEncoder.drawIndexedPrimitives(mesh.GetPrimitiveType(), indexCount: mesh.GetIndexCount(), indexType: mesh.GetMetalIndexType(), indexBuffer: mesh.indexBuffer, indexBufferOffset: 0)
    }
    
    func AddMaterial(material: Material) -> MeshRenderer {
        materials.append(material)
        return self
    }
    
}