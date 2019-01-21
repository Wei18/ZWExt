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

public extension Reactive where Base: TableHeaderViewZoomAnimation {
    var zoom: ControlEvent<Void> {
        let source = zoomObservable()
        return ControlEvent(events: source.map{ _ in })
    }
    
    private func zoomObservable() -> Observable<Void> {
        return .create{ [weak base = self.base] _ in
            guard let tableView = base?.tableView else { return Disposables.create() }
            return tableView.rx.contentOffset
                .map{ $0.y }
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: { (offsetY) in
                    base?.updateRect(offsetY)
                })
        }
    }
}

public class TableHeaderViewZoomAnimation {
    private var zoomView: UIView!
    fileprivate var tableView: UITableView!
    private init(){}
    fileprivate func updateRect(_ y: CGFloat){
        guard y < 0, var newRect = tableView.tableHeaderView?.frame else { return }
        newRect.size.height = -y
        newRect.origin.y = y
        zoomView.frame = newRect
    }
}

public extension TableHeaderViewZoomAnimation{
    convenience init(zoomView: UIView, tableView: UITableView){
        self.init()
        self.zoomView = zoomView
        self.tableView = tableView
        
        UIView().forSelf{
            $0.addSubviewWithAutoLayout(zoomView)
            tableView.setTableHeaderView($0)
        }
    }
    
    ///For using UIScrollViewDelegate.
    func zoom(_ scrollView: UIScrollView){
        let y = scrollView.contentOffset.y
        updateRect(y)
    }
}

