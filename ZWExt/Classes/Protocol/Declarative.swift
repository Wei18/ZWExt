//
//  UIView+Ext.swift
//  Imbrium
//
//  Created by ZhiWei Cao on 4/3/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

public protocol Declarative{}

extension Declarative where Self: AnyObject {
    public func forSelf(_ configureHandler: (Self) -> Void){
        configureHandler(self)
    }
}
