//
//  CameraMovement3D.swift
//  Metal_3D_Engine
//
//  Created by Adrian Krupa on 16.12.2015.
//  Copyright © 2015 Adrian Krupa. All rights reserved.
//

import Foundation
import simd
import Swift3D

class CameraMovement3D: Component {

    var lastMousePosition = float2()
    var rotationX: Float = 0
    var rotationY: Float = 0
    
    var cameraSensitivity: Float = 0.003
    var cameraSpeed: Float = 2
    
    override func Start() {
        super.Start()
        lastMousePosition = Input.mousePosition
    }
    
    override func Update() {
        super.Update()
        ProcessMouse()
        ProcessKeyboard()
    }
    
    private func ProcessMouse() {
        let mousePosition = Input.mousePosition
        let mousePositionDelta = mousePosition - lastMousePosition
        let transform = GetTransform()
        
        if (Input.GetButton(.LEFT) || Input.touchCount > 0) {
            rotationX -= mousePositionDelta.x * cameraSensitivity
            rotationY -= mousePositionDelta.y * cameraSensitivity
            rotationY = clamp(rotationY, lower: Float(-M_PI_2), upper: Float(M_PI_2))
            
            let rot = rotate(quat(), rotationX, float3(0.0, 1.0, 0.0))
            let rot2 = rotate(quat(), rotationY, float3(1.0, 0.0, 0.0))
            transform.Rotation = rot * rot2
        }
        lastMousePosition = mousePosition;
    }
    
    private func ProcessKeyboard() {
        let transform = GetTransform()

        var trans = float3(0)
        let rot = transform.Rotation

        var tempCameraSpeed = cameraSpeed;
        if (Input.GetKey(.KEY_LEFT_SHIFT) || Input.GetKey(.KEY_RIGHT_SHIFT)) {
                tempCameraSpeed *= 10
        }
        
        if (Input.GetKey(.KEY_W)) {
            trans = rot * float3(0.0, 0.0, -tempCameraSpeed * Time.deltaTime)
        }
        if (Input.GetKey(.KEY_S)) {
            trans = rot * float3(0.0, 0.0, tempCameraSpeed * Time.deltaTime)
        }
        if (Input.GetKey(.KEY_A)) {
            trans += rot * float3(-tempCameraSpeed * Time.deltaTime, 0.0, 0.0)
        }
        if (Input.GetKey(.KEY_D)) {
            trans += rot * float3(tempCameraSpeed * Time.deltaTime, 0.0, 0.0)
        }
        if (Input.GetKey(.KEY_Q)) {
            trans += rot * float3(0.0, -tempCameraSpeed * Time.deltaTime, 0.0)
        }
        if (Input.GetKey(.KEY_E)) {
            trans += rot * float3(0.0, tempCameraSpeed * Time.deltaTime, 0.0)
        }
        
        transform.Position += trans
    }
    
}