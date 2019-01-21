//
//  UIView+Ext.swift
//  Imbrium
//
//  Created by ZhiWei Cao on 4/3/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

protocol Declarative{
    func forSelf(_ configureHandler: (Self) -> Void)
}
extension Declarative where Self: UIView {
    func forSelf(_ configureHandler: (Self) -> Void){
        configureHandler(self)
    }
}
