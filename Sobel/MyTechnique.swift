//
//  MyTechnique.swift
//  Sobel
//
//  Created by Dmitry Bakcheev on 4/14/24.
//

import Foundation


enum MyTechnique {
    static let techniqueDictionary: [String: Any] = [
        
        "passes": [
         
            "sobel_pass": [
                
                "draw": "DRAW_QUAD",
                "metalVertexShader": "myVertexShader",
                "metalFragmentShader": "myFragmentShader",
                
                "inputs": [
                    "color": "COLOR",
                    "depthTexture": "DEPTH",

                ],
                "outputs": [
                    "color": "COLOR"
                ]
            ]
        ],
        
        "sequence": [
            "sobel_pass"
        ]
    ]
    
   
}
