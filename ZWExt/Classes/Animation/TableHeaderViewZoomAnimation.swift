//
//  TableHeaderViewZoomAnimation.swift
//  cale
//
//  Created by Wei Cao on 2019/1/11.
//  Copyright © 2019 STARLUX airlines. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TableHeaderViewZoomAnimation {
    private var zoomView: UIView!
    private var tableView: UITableView!
    
    init(zoomView: UIView, tableView: UITableView){
        self.zoomView = zoomView
        self.tableView = tableView
        
        UIView().forSelf{
            $0.addSubviewWithAutoLayout(zoomView)
            tableView.setTableHeaderView($0)
        }
    }
    
    
    private func updateRect(_ y: CGFloat){
        guard y < 0, var newRect = tableView.tableHeaderView?.frame else { return }
        newRect.size.height = -y
        newRect.origin.y = y
        zoomView.frame = newRect
    }
    
    private func zoomObservable() -> Observable<Void> {
        return .create{ [weak tableView] _ in
            guard let tableView = tableView else { return Disposables.create() }
            return tableView.rx.contentOffset
                .map{ $0.y }
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: { [weak self] (offsetY) in
                    self?.updateRect(offsetY)
                })
        }
    }
    
    func zoom() -> ControlEvent<Void> {
        let source = zoomObservable()
        return ControlEvent(events: source.map{ _ in })
    }
    
    ////func scrollViewDidScroll(_ scrollView: UIScrollView)
    func zoomNative(_ scrollView: UIScrollView){
        let y = scrollView.contentOffset.y
        updateRect(y)
    }
    
    /*
     func addSubviewWithAutoLayout(_ view: UIView){
     self.addSubview(view)
     view.frame = self.bounds
     view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
     view.translatesAutoresizingMaskIntoConstraints = true
     view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
     view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
     view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
     view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
     }
     
     func setTableHeaderView(_ v: UIView?){
     self.tableHeaderView = v ?? UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: .leastNonzeroMagnitude))
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
     */
}

