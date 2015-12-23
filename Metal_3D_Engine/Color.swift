//
//  Color.swift
//  Metal_3D_Engine
//
//  Created by Adrian Krupa on 06.12.2015.
//  Copyright © 2015 Adrian Krupa. All rights reserved.
//

import Foundation
import simd

#if os(OSX)
    import AppKit
    typealias Color = NSColor
#else
    import UIKit
    typealias Color = UIColor
#endif

extension Color {
    func getRGBA() -> float4 {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        var c = self
#if os(OSX)
            c = self.colorUsingColorSpace(NSColorSpace.deviceRGBColorSpace())!
#endif
        
        c.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return float4(Float(red), Float(green), Float(blue), Float(alpha))
    }
    
    convenience init(color: float4) {
        self.init(red: CGFloat(color.x), green: CGFloat(color.y), blue: CGFloat(color.z), alpha: CGFloat(color.w))

    }
}
