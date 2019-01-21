//
//  Protocol+Ext.swift
//  AFNetworking
//
//  Created by Wei Cao on 2019/1/21.
//

import Foundation

extension UIView: Declarative {}
extension CALayer: Gradient {}
extension UITableView: PowerfulTableView {}
extension UIView: PowerfulXIB{}

public class NibView: UIView {
    override public func awakeAfter(using aDecoder: NSCoder) -> Any? {
        let view = super.awakeAfter(using: aDecoder) as? UIView
        return awakeFromViewOnwerAfter(using: view)
    }
}
