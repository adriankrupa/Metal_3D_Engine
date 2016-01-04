//
//  LightAttributes.h
//  Metal_3D_Engine
//
//  Created by Adrian Krupa on 03.01.2016.
//  Copyright © 2016 Adrian Krupa. All rights reserved.
//

#ifndef LightAttributes_h
#define LightAttributes_h

#import "ShadersIncludesHelpers.h"

typedef NS_ENUM(INTEGER, LightType) {
    LightTypeDirectional = 0,
    LightTypePoint = 1,
    LightTypeSpot = 2,
};

#endif /* LightAttributes_h */
