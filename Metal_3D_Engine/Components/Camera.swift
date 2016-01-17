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
    var viewport = float4(0, 0, 1, 1)
    var fieldOfView = Float(M_PI/3)
    var aspectRatio = Float(16.0/9.0)
    var nearClippingPlane = Float(0.1)
    var farClippingPlane = Float(1000)
    var depth = Float(0)
    var size = Float(1)
    var frameSize = CGSize()
    var depthStencilDescriptor: MTLDepthStencilDescriptor!
    
    private var cachedViewMatrix: float4x4!
    private var cachedVPMatrix: float4x4!
    
    
    var projectionMatrix = float4x4(0)
    
    override init() {
        super.init()
        updateProjectionMatrix()
        depthStencilDescriptor = MTLDepthStencilDescriptor()
        depthStencilDescriptor.depthCompareFunction = .Less
        depthStencilDescriptor.depthWriteEnabled = true
    }
    
    func updateProjectionMatrix() {
        switch projection {
        case .Orthographic:
            projectionMatrix = ortho(-size*aspectRatio, right: size*aspectRatio, bottom: -size, top: size, zNear: nearClippingPlane, zFar: farClippingPlane)
        case .Perspective:
            projectionMatrix = perspective(fieldOfView, aspect: aspectRatio, zNear: nearClippingPlane, zFar: farClippingPlane)
        }
    }
    
    func configureRenderPassDescriptor(renderPassDescriptor: MTLRenderPassDescriptor) {
        renderPassDescriptor.depthAttachment.clearDepth = 1.0
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        renderPassDescriptor.colorAttachments[0].clearColor = MTLClearColorMake(Double(red.native), Double(green.native), Double(blue.native), Double(alpha.native))

        switch clearFlag {
        case .DontClear:
            renderPassDescriptor.colorAttachments[0].loadAction = .Load
            renderPassDescriptor.colorAttachments[0].storeAction = .Store
            renderPassDescriptor.depthAttachment.loadAction = .Load
            renderPassDescriptor.depthAttachment.storeAction = .Store
            return
        case .SolidColor:
            renderPassDescriptor.colorAttachments[0].loadAction = .Clear
            renderPassDescriptor.colorAttachments[0].storeAction = .Store
            renderPassDescriptor.depthAttachment.loadAction = .Clear
            renderPassDescriptor.depthAttachment.storeAction = .Store
            break
        case .OnlyDepth:
            renderPassDescriptor.colorAttachments[0].loadAction = .Load
            renderPassDescriptor.colorAttachments[0].storeAction = .Store
            renderPassDescriptor.depthAttachment.loadAction = .Clear
            renderPassDescriptor.depthAttachment.storeAction = .Store
            break
        case .Skybox:
            break
        }
    }
    
    func configureEncoder(renderEncoder: MTLRenderCommandEncoder) {
        renderEncoder.setViewport(MTLViewport(
            originX: Double(viewport.x * Float(frameSize.width)),
            originY: Double(viewport.y * Float(frameSize.height)),
            width: Double((viewport.z - viewport.x) * Float(frameSize.width)),
            height: Double((viewport.w - viewport.y) * Float(frameSize.height)), znear: 0, zfar: 1))
        renderEncoder.setDepthStencilState(EngineController.device.newDepthStencilStateWithDescriptor(depthStencilDescriptor!))
    }
    
    func SetFrameSize(size: CGSize) {
        frameSize = size
        aspectRatio = ((viewport.z - viewport.x) * Float(frameSize.width)) / ((viewport.w - viewport.y) * Float(frameSize.height))
        updateProjectionMatrix()
    }
    
    func GetVPMatrix() -> float4x4 {
        let viewMatrix = GetViewMatrix()
        if (cachedViewMatrix == nil || cachedViewMatrix! == viewMatrix) {
            cachedViewMatrix = viewMatrix;
            cachedVPMatrix = projectionMatrix * viewMatrix;
        }
        return cachedVPMatrix;
    }
    
    func GetProjectionMatrix() -> float4x4 {
        return projectionMatrix
    }
    
    func GetViewMatrix() -> float4x4 {
        return gameObject!.GetTransform().GetViewMatrix();
    }
    
    func GetModelMatrix() -> float4x4 {
        return gameObject!.GetTransform().GetModelMatrix();
    }
}