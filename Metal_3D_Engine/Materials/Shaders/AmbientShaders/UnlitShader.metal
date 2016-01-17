//
//  UnlitShader.metal
//  Metal_3D_Engine
//
//  Created by Adrian Krupa on 15.12.2015.
//  Copyright © 2015 Adrian Krupa. All rights reserved.
//

#include <metal_stdlib>

#include "VertexAttributesLayoutBindings.h"
#include "LightAttributes.h"


using namespace metal;

struct Vertex {
    float3 position [[attribute(VertexAttributesPosition)]];
    float4 color [[attribute(VertexAttributesColor)]];
};

struct VertexInOut {
    float4  position [[position]];
    float4  color;
};

struct Uniforms {
    float4x4 modelViewProjectionMatrix;
};

vertex VertexInOut unlitVertexShader(Vertex vert [[stage_in]],
                                       constant Uniforms &uniforms [[buffer(1)]]) {
    VertexInOut outVertex;
    outVertex.position = uniforms.modelViewProjectionMatrix * float4(vert.position, 1);
    outVertex.color = vert.color;
    return outVertex;
};

fragment float4 unlitFragmentShader(VertexInOut inFrag [[stage_in]]) {
    return inFrag.color;
};
