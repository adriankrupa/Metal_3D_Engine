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
    
    static func loadTexture(texturePath: String) -> MTLTexture? {
        
        initialize()
        
        let assetURL = NSBundle.mainBundle().URLForResource(texturePath, withExtension: nil)
        
        if assetURL == nil {
            return nil
        }
        

        do {
            //let texture = try textureLoader.newTextureWithContentsOfURL(assetURL!, options: [newTextureWithContentsOfURL : 8])
            let texture = try textureLoader.newTextureWithContentsOfURL(assetURL!, options: [MTKTextureLoaderOptionAllocateMipmaps : 8])
            return texture
        } catch {
            
        }
        return nil
    }
    
}