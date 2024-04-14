//
//  Shader.metal
//  Sobel
//
//  Created by Dmitry Bakcheev on 4/14/24.
//

#include <metal_stdlib>
using namespace metal;



struct VertexIn {
    float4 position [[attribute(0)]];
    float2 texcoord [[attribute(1)]];
    
};

struct VertexOut {
    float4 position [[position]];
    float2 texcoord;
};


vertex VertexOut myVertexShader(VertexIn in [[stage_in]]) {
    
    VertexOut out;
    
    out.position = in.position;
    out.texcoord = float2((in.position.x + 1.0) * 0.5, (in.position.y + 1.0) * -0.5);
    
    return out;
};


constexpr sampler s = sampler(coord::normalized, address::repeat, filter::nearest);



fragment float4 myFragmentShader(VertexOut in [[stage_in]],
                                 depth2d<float, access::sample> depthTexture [[texture(0)]],
                                 texture2d<float, access::sample> color [[texture(1)]]) {
    
    
    float thikness = 0.001;
    
    float2 sobelSamplePoints[9] =
    {
        float2(-1,1),float2(0,1),float2(1,1),
        float2(-1,0),float2(0,0),float2(1,0),
        float2(-1,-1),float2(0,-1),float2(1,-1),
    };
    
    
    float sobelXMatrix[9] =
    {
        1, 0, -1,
        2, 0, -2,
        1, 0, -1
    };
    
    float sobelYMatrix[9] =
    {
        1, 2, 1,
        0,  0,  0,
        -1, -2, -1
    };
    
    
    
    float2 sobel = 0;
    for (int i = 0; i < 9; i++)
    {
        // depth
        float depth = depthTexture.sample(s, in.texcoord + sobelSamplePoints[i] * thikness);
        sobel += depth * float2(sobelXMatrix[i], sobelYMatrix[i]);
     
        
        // color
//      float4 baseColor = color.sample(s, in.texcoord + sobelSamplePoints[i] * thikness);
//      float gColor = (baseColor.r + baseColor.g + baseColor.b)/3;
//      sobel += gColor * float2(sobelXMatrix[i], sobelYMatrix[i]);
        
    };
    
    float out = length(sobel);
    
    return out;
    
};






