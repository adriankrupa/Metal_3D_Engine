//
//  VertexAttributesLayoutBindings.h
//  Metal_3D_Engine
//
//  Created by Adrian Krupa on 24.12.2015.
//  Copyright © 2015 Adrian Krupa. All rights reserved.
//

#ifndef VertexAttributesLayoutBindings_h
#define VertexAttributesLayoutBindings_h

#import "ShadersIncludesHelpers.h"

typedef NS_ENUM(INTEGER, VertexAttributes) {
    VertexAttributesPosition = 0,
    VertexAttributesColor = 1,
    VertexAttributesNormal = 2,
    VertexAttributesTangent = 3,
    VertexAttributesUV = 4,
};

#endif /* VertexAttributesLayoutBindings_h */
