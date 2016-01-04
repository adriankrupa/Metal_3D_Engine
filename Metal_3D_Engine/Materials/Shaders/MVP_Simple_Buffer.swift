//
//  MVP_Simple_Buffer.swift
//  Metal_3D_Engine
//
//  Created by Adrian Krupa on 04.01.2016.
//  Copyright © 2016 Adrian Krupa. All rights reserved.
//

import MetalKit
import simd

class MVP_Simple_Buffer: BuiltInBuffer {
    
    struct MVP_Simple_Buffer_Struct {
        var modelViewProjectionMatrix = float4x4(1)
    }
    
    private var data = MVP_Simple_Buffer_Struct()
    
    override func isUsing_ModelViewProjectionMatrix() -> Bool {
        return true
    }
    
    override func set_ModelViewProjectionMatrix(m: float4x4) {
        data.modelViewProjectionMatrix = m
    }
    
    
    override func copyDataIntoBuffer(buffer: MTLBuffer) {
        memcpy(bfr.contents(), &data, getRawDataSize())
    }
    
    override func getRawDataSize() -> Int {
        return sizeof(MVP_Simple_Buffer_Struct)
    }
    
}