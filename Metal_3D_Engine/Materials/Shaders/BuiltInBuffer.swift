//
//  BuiltInBuffer.swift
//  Metal_3D_Engine
//
//  Created by Adrian Krupa on 04.01.2016.
//  Copyright © 2016 Adrian Krupa. All rights reserved.
//

import Foundation
import MetalKit

class BuiltInBuffer: UniformBuffer {
    
    required init() {
        super.init (c: { (buffer) -> () in })
    }
    
    override func fillDataAndUpdate() {
        if(bfr == nil) {
#if os(OSX)
            bfr = EngineController.device.newBufferWithLength(getRawDataSize(), options: [.StorageModeManaged])
#else
            bfr = EngineController.device.newBufferWithLength(getRawDataSize(), options: [.StorageModeShared])
#endif
            bfr.label = "uniforms_vertexBuffer"
        } else {
            copyDataIntoBuffer(bfr)
#if os(OSX)
            bfr.didModifyRange(NSMakeRange(0, getRawDataSize()))
#endif
        }
    }
    
    func isUsing_ModelViewProjectionMatrix() -> Bool {
        return false
    }
    
    func set_ModelViewProjectionMatrix(m: float4x4) {
        
    }
    
    func copyDataIntoBuffer(buffer: MTLBuffer) {
    }
    
    func getRawDataSize() -> Int {
        return 0
    }
}