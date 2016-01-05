//
//  Transform.swift
//  Metal_3D_Engine
//
//  Created by Adrian Krupa on 06.12.2015.
//  Copyright © 2015 Adrian Krupa. All rights reserved.
//

import Foundation
import simd
import Swift3D

class Transform: Component {
    
    private var position_ = float3()
    private var scale_ = float3(1)
    private var rotation_ = quat()
    private var rotationInEulerAngles_ = float3()
    
    private var transformChanged = true
    private var modelMatrixChanged = true
    
    private var cachedModelMatrix: float4x4!
    private var cachedNormalMatrix: float4x4!
    private var cachedViewMatrix: float4x4!
    
    var Position: float3 {
        get {
            return position_
        }
        set {
            position_ = newValue
            transformChanged = true
        }
    }
    
    var Scale: float3 {
        get {
            return scale_
        }
        set {
            scale_ = newValue
            transformChanged = true
        }
    }
    
    var Rotation: quat {
        get {
            return rotation_
        }
        set {
            rotation_ = normalize(newValue)
            rotationInEulerAngles_ = eulerAngles(rotation_)
            transformChanged = true
        }
    }
    
    var RotationInEulerAngles: float3 {
        get {
            return rotationInEulerAngles_
        }
        set {
            rotationInEulerAngles_ = newValue
            rotation_ = quat(rotationInEulerAngles_)
            transformChanged = true
        }
    }
    
    func GetModelMatrix() -> float4x4 {
        recomputeMatrices();
        return cachedModelMatrix;
    }
    
    func GetNormalMatrix() -> float4x4 {
        /*
        var _transformChanged = transformChanged;
        recomputeMatrices();
        if (_transformChanged) {
            Camera *currentCamera = RendererManager::getInstance().getCurrentCamera();
            if (currentCamera != nullptr) {
                mat4 cameraViewMatrix = currentCamera->getViewMatrix();
                if (scale.x == scale.y && scale.y == scale.z) {
                    cachedNormalMatrix = cameraViewMatrix*cachedModelMatrix ;
                } else {
                    cachedNormalMatrix = transpose(inverse(cameraViewMatrix*cachedModelMatrix));
                }
            }
        }
*/
        return cachedNormalMatrix;
    }
    
    func GetViewMatrix() -> float4x4 {
        recomputeMatrices()
        //if (modelMatrixChanged) {
            modelMatrixChanged = false
            cachedViewMatrix = GetModelMatrix().inverse
        //}
        return cachedViewMatrix;
    }
    
    private func recomputeMatrices() {
        if (transformChanged) {
            transformChanged = false
            cachedModelMatrix = translate(float4x4(1), v: position_) * float4x4_cast(rotation_) * scale(float4x4(1), v: scale_)
            modelMatrixChanged = true
        }
    }
}