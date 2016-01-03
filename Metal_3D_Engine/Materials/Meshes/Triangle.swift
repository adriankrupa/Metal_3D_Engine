//
//  Triangle.swift
//  Metal_3D_Engine
//
//  Created by Adrian Krupa on 08.12.2015.
//  Copyright © 2015 Adrian Krupa. All rights reserved.
//

import Foundation

struct Triangle<IndicesType: MTLUnsignedIndexType> {
    var a: IndicesType = 0
    var b: IndicesType = 0
    var c: IndicesType = 0
}