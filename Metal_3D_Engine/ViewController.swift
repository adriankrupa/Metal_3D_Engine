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

class ViewController: BaseClass, MTKViewDelegate {
    
    let device: MTLDevice = MTLCreateSystemDefaultDevice()!
    
    var commandQueue: MTLCommandQueue! = nil
    var pipelineState: MTLRenderPipelineState! = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        let view = self.view as! MTKView
        view.delegate = self
        view.device = device
        view.sampleCount = 4
        
        commandQueue = device.newCommandQueue()
        commandQueue.label = "main command queue"
    }
    
    func drawInMTKView(view: MTKView) {
        let commandBuffer = commandQueue.commandBuffer()
        commandBuffer.label = "Frame command buffer"
        
        if let renderPassDescriptor = view.currentRenderPassDescriptor, currentDrawable = view.currentDrawable
        {
            renderPassDescriptor.colorAttachments[0].clearColor = MTLClearColorMake(1.0, 1.0, 0.0, 1.0);
            let renderEncoder = commandBuffer.renderCommandEncoderWithDescriptor(renderPassDescriptor)
            renderEncoder.label = "render encoder"
            

            renderEncoder.endEncoding()
            
            commandBuffer.presentDrawable(currentDrawable)
        }

        commandBuffer.commit()

    }

    func mtkView(view: MTKView, drawableSizeWillChange size: CGSize) {
        
    }
}

