//
//  TextureManager.swift
//  Metal_3D_Engine
//
//  Created by Adrian Krupa on 17.01.2016.
//  Copyright © 2016 Adrian Krupa. All rights reserved.
//

import Foundation
import MetalKit

class TextureManager {
    
    static var textureLoader: MTKTextureLoader!
    
    private static func initialize() {
        if textureLoader == nil {
            textureLoader = MTKTextureLoader.init(device: EngineController.device)
        }
    }
    
    static func loadTexture(texturePath: String, generateMipMaps: Bool = true) -> MTLTexture? {
        
        initialize()
        
        let assetURL = NSBundle.mainBundle().URLForResource(texturePath, withExtension: nil)
        
        if let url = assetURL {
        
            do {
                let texture = try textureLoader.newTextureWithContentsOfURL(url, options: [MTKTextureLoaderOptionAllocateMipmaps : generateMipMaps ? 1 : 0])
                
                if generateMipMaps {
                    let commandBuffer = EngineController.commandQueue.commandBuffer()
                    let commandEncoder = commandBuffer.blitCommandEncoder()
                    commandEncoder.generateMipmapsForTexture(texture)
                    commandEncoder.endEncoding()
                    commandBuffer.commit()
                }
                
                return texture
            } catch {
            }
        }
        return nil
    }
    
}