//
//  VertexAttributesLayoutBindings.m
//  Metal_3D_Engine
//
//  Created by Adrian Krupa on 24.12.2015.
//  Copyright © 2015 Adrian Krupa. All rights reserved.
//

#ifdef METAL
    #define NS_ENUM(_type, _name) enum _name : _type _name; enum _name : _type
    #define INTEGER int
#else
    @import Foundation;
    #define INTEGER NSInteger
#endif

typedef NS_ENUM(INTEGER, VertexAttributes) {
    VertexAttributesPosition = 0,
    VertexAttributesColor = 1,
    VertexAttributesNormal = 2,
    VertexAttributesTangent = 3,
    VertexAttributesUV = 4,
};