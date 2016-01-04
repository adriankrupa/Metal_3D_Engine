//
//  ShadersIncludesHelpers.cpp
//  Metal_3D_Engine
//
//  Created by Adrian Krupa on 03.01.2016.
//  Copyright © 2016 Adrian Krupa. All rights reserved.
//

#ifdef METAL
#define NS_ENUM(_type, _name) enum _name : _type _name; enum _name : _type
#define INTEGER int
#else
@import Foundation;
#define INTEGER NSInteger
#endif