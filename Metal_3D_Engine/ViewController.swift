//
//  ViewController.swift
//  Metal_3D_Engine
//
//  Created by Adrian Krupa on 06.12.2015.
//  Copyright © 2015 Adrian Krupa. All rights reserved.
//

#if os(OSX)
import Cocoa
typealias BaseClass = NSViewController
#else
import UIKit
typealias BaseClass = UIViewController
#endif

import MetalKit


let vertexData:[Float] =
[
    /*
    -1.0, -1.0, 0.0, 1.0,
    -1.0,  1.0, 0.0, 1.0,
    1.0, -1.0, 0.0, 1.0,
    
    1.0, -1.0, 0.0, 1.0,
    -1.0,  1.0, 0.0, 1.0,
    1.0,  1.0, 0.0, 1.0,
    */
    -0.0, 0.25, 0.0, 1.0,
    -0.25, -0.25, 0.0, 1.0,
    0.25, -0.25, 0.0, 1.0
]

let vertexColorData:[Float] =
[
    /*
    0.0, 1.0, 1.0, 1.0,
    0.0, 1.0, 1.0, 1.0,
    0.0, 1.0, 1.0, 1.0,
    
    0.0, 0.0, 1.0, 1.0,
    0.0, 0.0, 1.0, 1.0,
    0.0, 0.0, 1.0, 1.0,
    */
    0.0, 0.0, 1.0, 1.0,
    0.0, 1.0, 0.0, 1.0,
    1.0, 0.0, 0.0, 1.0
]

class ViewController: BaseClass, MTKViewDelegate {
    
    static var currentDevice: MTLDevice!
    static var device: MTLDevice = MTLCreateSystemDefaultDevice()!
    
    var commandQueue: MTLCommandQueue! = nil
    var pipelineState: MTLRenderPipelineState! = nil
    
    var vertexBuffer: MTLBuffer! = nil
    var vertexColorBuffer: MTLBuffer! = nil
    
    var gameObjects: [GameObject] = []
    var cameras: [Camera] = []
    
    let ConstantBufferSize = 1024*1024
    
    var xOffset:[Float] = [ -1.0, 1.0, -1.0 ]
    var yOffset:[Float] = [ 1.0, 0.0, -1.0 ]
    var xDelta:[Float] = [ 0.002, -0.001, 0.003 ]
    var yDelta:[Float] = [ 0.001,  0.002, -0.001 ]
    
    static var currentTexture: MTLTexture!

    override func viewDidLoad() {
        super.viewDidLoad()

        let view = self.view as! MTKView
        view.delegate = self
        ViewController.currentDevice = ViewController.device
        view.device = ViewController.device
        //view.sampleCount = 4
        
        initScene()
        
        commandQueue = ViewController.device.newCommandQueue()
        commandQueue.label = "main command queue"
        
        let defaultLibrary = ViewController.device.newDefaultLibrary()!
        let fragmentProgram = defaultLibrary.newFunctionWithName("passThroughFragment")!
        let vertexProgram = defaultLibrary.newFunctionWithName("passThroughVertex")!
        
        let pipelineStateDescriptor = MTLRenderPipelineDescriptor()
        pipelineStateDescriptor.vertexFunction = vertexProgram
        pipelineStateDescriptor.fragmentFunction = fragmentProgram
        pipelineStateDescriptor.colorAttachments[0].pixelFormat = view.colorPixelFormat
        pipelineStateDescriptor.sampleCount = view.sampleCount
        
        do {
            try pipelineState = ViewController.device.newRenderPipelineStateWithDescriptor(pipelineStateDescriptor)
        } catch let error {
            print("Failed to create pipeline state, error \(error)")
        }
        
        // generate a large enough buffer to allow streaming vertices for 3 semaphore controlled frames
        vertexBuffer = ViewController.device.newBufferWithLength(ConstantBufferSize, options: [])
        vertexBuffer.label = "vertices"
        
        let vertexColorSize = vertexData.count * sizeofValue(vertexColorData[0])
        vertexColorBuffer = ViewController.device.newBufferWithBytes(vertexColorData, length: vertexColorSize, options: [])
        vertexColorBuffer.label = "colors"
    }
    
    func initScene() {
        let cameraGO = GameObject()
        let cameraComponent = Camera(texture: ((self.view as! MTKView).currentDrawable?.texture)!)
        cameraGO.AddComponent(cameraComponent)
        cameras.append(cameraComponent)
        gameObjects.append(cameraGO)
        gameObjects.append(GameObject().AddComponent(MeshRenderer(mesh: LinesCubeMesh()).AddMaterial(Material(vertexProgram: "ambientVertexShader", fragmentProgram: "ambientFragmentShader"))))
    }
    
    func update() {
        
        for gameObject in gameObjects {
            gameObject.Update()
        }
        
        // vData is pointer to the MTLBuffer's Float data contents
        let pData = vertexBuffer.contents()
        let vData = UnsafeMutablePointer<Float>(pData)
        
        // reset the vertices to default before adding animated offsets
        vData.initializeFrom(vertexData)
        
        // Animate triangle offsets
        let lastTriVertex = 0
        let vertexSize = 4
        for j in 0..<3 {
            // update the animation offsets
            xOffset[j] += xDelta[j]
            
            if(xOffset[j] >= 1.0 || xOffset[j] <= -1.0) {
                xDelta[j] = -xDelta[j]
                xOffset[j] += xDelta[j]
            }
            
            yOffset[j] += yDelta[j]
            
            if(yOffset[j] >= 1.0 || yOffset[j] <= -1.0) {
                yDelta[j] = -yDelta[j]
                yOffset[j] += yDelta[j]
            }
            
            // Update last triangle position with updated animated offsets
            let pos = lastTriVertex + j*vertexSize
            vData[pos] = xOffset[j]
            vData[pos+1] = yOffset[j]
        }
    }
    
    func drawInMTKView(view: MTKView) {
        let commandBuffer = commandQueue.commandBuffer()
        commandBuffer.label = "Frame command buffer"
        self.update()

        

 
        if let renderPassDescriptor = view.currentRenderPassDescriptor, currentDrawable = view.currentDrawable
        {


            for camera in cameras {
                camera.clear(commandBuffer, texture: currentDrawable.texture)
                
                renderPassDescriptor.colorAttachments[0].loadAction = MTLLoadAction.Load
                renderPassDescriptor.colorAttachments[0].storeAction = MTLStoreAction.Store
                let renderEncoder = commandBuffer.renderCommandEncoderWithDescriptor(renderPassDescriptor)
                renderEncoder.label = "render encoder"
                
                for gameObject in gameObjects {
                    gameObject.Render(renderEncoder, camera: camera)
                }
                /*
                //renderEncoder.pushDebugGroup("draw morphing triangle")
                renderEncoder.setRenderPipelineState(pipelineState)
                renderEncoder.setVertexBuffer(vertexBuffer, offset: 0, atIndex: 0)
                renderEncoder.setVertexBuffer(vertexColorBuffer, offset:0 , atIndex: 1)
                renderEncoder.drawPrimitives(.Triangle, vertexStart: 0, vertexCount: 9, instanceCount: 1)
                */
                //renderEncoder.popDebugGroup()
                renderEncoder.endEncoding()
                
                commandBuffer.presentDrawable(currentDrawable)
            }
        }
        commandBuffer.commit()
    }

    func mtkView(view: MTKView, drawableSizeWillChange size: CGSize) {
        
    }
}

