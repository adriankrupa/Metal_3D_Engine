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
    
    var lastFrameSize = CGSize()
    
    var depthTexture: MTLTexture! = nil
    
    static var currentTexture: MTLTexture!

    var lastUpdateTime: CFAbsoluteTime = 0
    var thisView: MTKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        EngineController.initialize()
        lastUpdateTime = CFAbsoluteTimeGetCurrent()
        
        
        thisView = self.view as! MTKView
        thisView.delegate = self
        thisView.device = EngineController.device
        thisView.preferredFramesPerSecond = 60
        thisView.sampleCount = 4
        
        
        print(thisView.device!.name!)
        
        commandQueue = EngineController.device.newCommandQueue()
        commandQueue.label = "main command queue"
        
        let fragmentProgram = EngineController.library.newFunctionWithName("passThroughFragment")!
        let vertexProgram = EngineController.library.newFunctionWithName("passThroughVertex")!
        
        let pipelineStateDescriptor = MTLRenderPipelineDescriptor()
        pipelineStateDescriptor.vertexFunction = vertexProgram
        pipelineStateDescriptor.fragmentFunction = fragmentProgram
        pipelineStateDescriptor.colorAttachments[0].pixelFormat = thisView.colorPixelFormat
        pipelineStateDescriptor.depthAttachmentPixelFormat = .Depth32Float
        
        do {
            try pipelineState = EngineController.device.newRenderPipelineStateWithDescriptor(pipelineStateDescriptor)
        } catch let error {
            print("Failed to create pipeline state, error \(error)")
        }
        
        // generate a large enough buffer to allow streaming vertices for 3 semaphore controlled frames
        vertexBuffer = EngineController.device.newBufferWithLength(ConstantBufferSize, options: [])
        vertexBuffer.label = "vertices"
        
        let vertexColorSize = vertexData.count * sizeofValue(vertexColorData[0])
        vertexColorBuffer = EngineController.device.newBufferWithBytes(vertexColorData, length: vertexColorSize, options: [])
        vertexColorBuffer.label = "colors"
        
        #if os(OSX)
            let scale = NSScreen.mainScreen()!.backingScaleFactor
        #else
            let scale = UIScreen.mainScreen().scale
        #endif
        let size = CGSize(width: view.bounds.size.width * scale, height: view.bounds.size.height * scale)
        print(size)
        
        
        initScene()
    }
    
    func initScene() {
        let cameraGO = GameObject()
        cameraGO.GetTransform().Position = float3(0,0,-10)
        let cameraComponent = Camera()
        cameraGO.AddComponent(cameraComponent)
        cameraGO.AddComponent(CameraMovement3D())
        cameras.append(cameraComponent)
        gameObjects.append(cameraGO)
        
        var mesh2 = ModelManager.LoadObject("Data/Assets/teapot/teapot.obj", parameters: ["Color":Color(red: 1, green: 1, blue: 1, alpha: 1)])!

        let m = Material(sampleCount: thisView.sampleCount, shader: AmbientShader())
        for _ in 0..<150 {
            
            let color = Color(red: CGFloat(rand()%255)/255.0, green: CGFloat(rand()%255)/255.0, blue: CGFloat(rand()%255)/255.0, alpha: 1)

            var mesh = CubeMesh()

            let c = MeshRenderer(mesh: mesh2).AddMaterial(m)
            
            let GO = GameObject().AddComponent(c).AddComponent(ObjectRotator())
            GO.GetTransform().Position = float3(
                Float(Int(arc4random_uniform(20000)) - 10000)/Float(200.0),
                Float(Int(arc4random_uniform(20000)) - 10000)/Float(200.0),
                Float(Int(arc4random_uniform(20000)) - 10000)/Float(200.0))
            //GO.GetTransform().Position = float3(0,0,0)
            gameObjects.append(GO)
        }
    }
    
    func update() {
        let currentTime = CFAbsoluteTimeGetCurrent()
        Time.deltaTime = Float(currentTime - lastUpdateTime)
        lastUpdateTime = currentTime
        
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
            #if os(OSX)
                let scale = NSScreen.mainScreen()!.backingScaleFactor
            #else
                let scale = UIScreen.mainScreen().scale
            #endif
            let size = CGSize(width: view.bounds.size.width * scale, height: view.bounds.size.height * scale)
            
            if(lastFrameSize != size) {
                lastFrameSize = size
                for camera in cameras {
                    camera.SetFrameSize(size)
                }
            }
            
            for camera in cameras {
                checkDepthTexture(currentDrawable.texture, view: view)
                
                //camera.clear(commandBuffer, texture: currentDrawable.texture, depthTexture: depthTexture)
                camera.configureRenderPassDescriptor(renderPassDescriptor)
                
                EngineController.lastPipelineState = nil
                
                renderPassDescriptor.colorAttachments[0].texture = currentDrawable.texture
                renderPassDescriptor.depthAttachment.texture = depthTexture
                
                if view.sampleCount > 1 {
                    let description = MTLTextureDescriptor.texture2DDescriptorWithPixelFormat(.BGRA8Unorm, width: currentDrawable.texture.width, height: currentDrawable.texture.height, mipmapped: false)
                    description.textureType = .Type2DMultisample
                    description.sampleCount = view.sampleCount
                    description.storageMode = .Private
                    description.usage = .RenderTarget

                    let tex = EngineController.device.newTextureWithDescriptor(description)
                    renderPassDescriptor.colorAttachments[0].texture = tex
                    renderPassDescriptor.colorAttachments[0].resolveTexture = currentDrawable.texture
                    renderPassDescriptor.colorAttachments[0].storeAction = .MultisampleResolve
                }
                
                let renderEncoder = commandBuffer.renderCommandEncoderWithDescriptor(renderPassDescriptor)
                renderEncoder.setDepthStencilState(EngineController.device.newDepthStencilStateWithDescriptor(camera.depthStencilDescriptor!))
                renderEncoder.setFrontFacingWinding(.Clockwise)
                //renderEncoder.setCullMode(.Back)
                
                renderEncoder.label = "render encoder"
                
                camera.configureEncoder(renderEncoder)
                
                for gameObject in gameObjects {
                    gameObject.Render(renderEncoder, camera: camera)
                }
                
                renderEncoder.endEncoding()
                
                commandBuffer.presentDrawable(currentDrawable)
            }
        }
        commandBuffer.commit()
    }
    
    func checkDepthTexture(currentColorTexture: MTLTexture, view: MTKView) {
        if depthTexture == nil ||
            depthTexture.width != currentColorTexture.width ||
            depthTexture.height != currentColorTexture.height {
                
                let description = MTLTextureDescriptor.texture2DDescriptorWithPixelFormat(.Depth32Float, width: currentColorTexture.width, height: currentColorTexture.height, mipmapped: false)
                description.textureType = view.sampleCount > 1 ? .Type2DMultisample : .Type2D
                description.sampleCount = view.sampleCount
                description.storageMode = .Private
                description.usage = .RenderTarget
                
                depthTexture = EngineController.device.newTextureWithDescriptor(description)
        }
    }
    
    func mtkView(view: MTKView, drawableSizeWillChange size: CGSize) {
        
        
    }
}



