//
//  Gradient.swift
//  Imbrium
//
//  Created by ZhiWei Cao on 9/30/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

public protocol Gradient {
    func removeGradient()
    func updateGradientFrame()
    func renderGradient(from: RenderDirection, to: RenderDirection, colors: [UIColor])
}

public enum RenderDirection: Int{
    case top
    case bottom
    case left
    case right
    var point: CGPoint {
        switch self {
        case .top:          return CGPoint(x: 0.5, y: 0)
        case .bottom:       return CGPoint(x: 0.5, y: 1)
        case .left:         return CGPoint(x: 0, y: 0.5)
        case .right:        return CGPoint(x: 1, y: 0.5)
        }
    }
}

public extension Gradient where Self: CALayer{
    private var gradientLayerKey: String { return "GradientEffectsLayer" }
    
    private var gradient: CALayer?{
        return sublayers?.first{ $0.name == gradientLayerKey }
    }
    
    func removeGradient(){
        gradient?.removeFromSuperlayer()
    }
    
    func updateGradientFrame(){
        gradient?.frame = frame
    }
    
    func renderGradient(from: RenderDirection, to: RenderDirection, colors: [UIColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = from.point
        gradientLayer.endPoint   = to.point
        gradientLayer.frame      = bounds
        gradientLayer.colors     = colors.map{ $0.cgColor }
        gradientLayer.name       = gradientLayerKey
        
        if let layer = gradient{
            replaceSublayer(layer, with: gradientLayer)
        }else{
            insertSublayer(gradientLayer, at: 0)
        }
    }
}
