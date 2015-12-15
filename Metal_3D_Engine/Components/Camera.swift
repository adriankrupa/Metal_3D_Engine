//
//  Camera.swift
//  Metal_3D_Engine
//
//  Created by Adrian Krupa on 06.12.2015.
//  Copyright © 2015 Adrian Krupa. All rights reserved.
//

import Foundation
import simd
import Swift3D

enum ClearFlag {
    case DontClear
    case SolidColor
    case OnlyDepth
    case Skybox
}

enum Projection {
    case Orthographic
    case Perspective
}

class Camera : Component {
    
    var clearFlag = ClearFlag.SolidColor
    var projection = Projection.Perspective
    var color: Color = Color(red: 1, green: 0, blue: 1, alpha: 1)
    var fieldOfView = Float(M_PI/3)
    var aspectRatio = Float(16.0/9.0)
    var nearClippingPlane = Float(0.1)
    var farClippingPlane = Float(1000)
    var depth = Float(0)
    var size = Float(1)
    
    
    var projectionMatrix = float4x4(0)
    var renderPassDescriptor: MTLRenderPassDescriptor!
    
    
    init(texture: MTLTexture) {
        super.init()
        updateProjectionMatrix()
        
        renderPassDescriptor = MTLRenderPassDescriptor()
        renderPassDescriptor.colorAttachments[0].clearColor = MTLClearColorMake(1.0, 1.0, 0.0, 1.0);
        renderPassDescriptor.colorAttachments[0].loadAction = .Clear
        renderPassDescriptor.colorAttachments[0].storeAction = .Store
        renderPassDescriptor.colorAttachments[0].texture = texture
        //renderPassDescriptor = view.sampleCount
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        renderPassDescriptor.colorAttachments[0].clearColor = MTLClearColorMake(red.native, green.native, blue.native, alpha.native)
    }
    
    func updateProjectionMatrix() {
        switch projection {
        case .Orthographic:
            projectionMatrix = ortho(-size*aspectRatio, right: size*aspectRatio, bottom: -size, top: size, zNear: nearClippingPlane, zFar: farClippingPlane)
        case .Perspective:
            projectionMatrix = perspective(fieldOfView, aspect: aspectRatio, zNear: nearClippingPlane, zFar: farClippingPlane)
        }
    }
    
    func clear(commandBuffer: MTLCommandBuffer, texture: MTLTexture) {
        renderPassDescriptor.colorAttachments[0].texture = texture
        let renderEncoder = commandBuffer.renderCommandEncoderWithDescriptor(renderPassDescriptor)
        switch clearFlag {
        case .DontClear:
            return
        case .SolidColor:
            renderEncoder.label = "render encoder"
            break
        case .OnlyDepth:
            break
        case .Skybox:
            break
        }
        renderEncoder.endEncoding()
    }
    
    func GetProjectionMatrix() -> float4x4 {
        return translate(projectionMatrix, v: float3(0,0,-5))
    }
    
}