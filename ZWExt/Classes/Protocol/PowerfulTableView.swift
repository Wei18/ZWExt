//
//  PowerfulTableView.swift
//  Imbrium
//
//  Created by ZhiWei Cao on 1/6/19.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

public protocol PowerfulTableView{
    func setTableHeaderView(_ v: UIView?)
    func setTableFooterView(_ v: UIView?)
}

public extension PowerfulTableView where Self: UITableView{
    ///dynamic adjust view height
    func setTableHeaderView(_ v: UIView?){
        self.tableHeaderView = v ?? UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: .leastNonzeroMagnitude))
        guard let view = v else { return }
        layout(view)
    }
    
    ///dynamic adjust view height
    func setTableFooterView(_ v: UIView?){
        self.tableFooterView = v
        guard let view = v else { return }
        layout(view)
    }
    
    private func layout(_ v: UIView) {
        let temporaryWidth = NSLayoutConstraint
            .constraints(withVisualFormat: "[v(width)]",
                         options: .directionLeadingToTrailing,
                         metrics: ["width": self.bounds.size.width],
                         views:   ["v": v])
        
        v.addConstraints(temporaryWidth)
        v.frame.size.height = v.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        //Add this line to avoid "Will attempt to recover by breaking constraint"
        v.removeConstraints(temporaryWidth)
    }
}
