//
//  UnlitTexturedShader.metal
//  Metal_3D_Engine
//
//  Created by Adrian Krupa on 17.01.2016.
//  Copyright © 2016 Adrian Krupa. All rights reserved.
//

#include <metal_stdlib>

#include "VertexAttributesLayoutBindings.h"
#include "LightAttributes.h"


using namespace metal;

struct Vertex {
    float3 position [[attribute(VertexAttributesPosition)]];
    float4 color [[attribute(VertexAttributesColor)]];
    float2 uv [[attribute(VertexAttributesUV)]];
};

struct VertexInOut {
    float4 position [[position]];
    float4 color;
    float2 uv;
};

struct Uniforms {
    float4x4 modelViewProjectionMatrix;
};

vertex VertexInOut unlitTexturedVertexShader(Vertex vert [[stage_in]],
                                       constant Uniforms &uniforms [[buffer(1)]]) {
    VertexInOut outVertex;
    outVertex.position = uniforms.modelViewProjectionMatrix * float4(vert.position, 1);
    outVertex.color = vert.color;
    outVertex.uv = vert.uv;
    return outVertex;
};

fragment float4 unlitTexturedFragmentShader(VertexInOut inFrag [[stage_in]],
                                              texture2d<half> diffuseTexture [[ texture(0) ]]) {
    
    constexpr sampler defaultSampler(filter::linear, mip_filter::linear);
    
    return float4(diffuseTexture.sample(defaultSampler, inFrag.uv)) * inFrag.color;
};