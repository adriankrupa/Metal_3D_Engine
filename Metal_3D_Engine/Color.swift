//
//  Color.swift
//  Metal_3D_Engine
//
//  Created by Adrian Krupa on 06.12.2015.
//  Copyright © 2015 Adrian Krupa. All rights reserved.
//

import Foundation

#if os(OSX)
    import AppKit
    typealias Color = NSColor
#else
    import UIKit
    typealias Color = UIColor
#endif
