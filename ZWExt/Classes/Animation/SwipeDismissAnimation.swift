//
//  SwipeDismissAnimation.swift
//  UIKitExtension
//
//  Created by Wei Cao on 2019/1/21.
//  Copyright © 2019 Wei Cao. All rights reserved.
//


import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: SwipeDismissAnimation {
    var dismiss: Binder<Bool> {
        return Binder(base) { swipeSelf, value in
            swipeSelf.dismiss(value)
        }
    }
}

class SwipeDismissAnimation {
    private let disposeBag = DisposeBag()
    private weak var view: UIView?
    private weak var vc: UIViewController?
    private lazy var pan = UIPanGestureRecognizer()
    private lazy var defaultFrame = view?.frame
    private var beganPoint: CGPoint!
    
    init(_ viewController: UIViewController, contentView aView: UIView?){
        self.vc = viewController
        self.view = aView ?? viewController.view
        vc?.view.addGestureRecognizer(pan)
        pan.rx.event.subscribe(onNext:{ [weak self] panGesture in
            self?.panGestureRecognizerHandler(panGesture)
        }).disposed(by: disposeBag)
    }
    
    private func panGestureRecognizerHandler(_ sender: UIPanGestureRecognizer) {
        let touchPoint = sender.location(in: vc?.view?.window)
        switch sender.state{
        case .began:
            beganPoint = touchPoint
            
        case .changed where touchPoint.y - beganPoint.y > 0:
            let value = touchPoint.y - beganPoint.y
            delta(value)
            
        case .ended, .cancelled:
            let value = touchPoint.y - beganPoint.y
            if canBeDismissed(value) {
                dismiss()
            } else {
                reset()
            }
        default:
            break
        }
    }
    
    private func canBeDismissed(_ value: CGFloat) -> Bool{
        guard let defaultFrame = defaultFrame else { return true }
        let value0 = defaultFrame.size.height / 3
        let actualValue = max(min(value0, 200), 100)
        return value > actualValue
    }
    
    private func delta(_ value: CGFloat){
        guard let defaultFrame = defaultFrame else { return }
        view?.frame.origin.y = defaultFrame.origin.y + value
    }
    
    private func reset(){
        guard let defaultFrame = defaultFrame else { return }
        UIView.animate(withDuration: 0.3, animations: {
            self.view?.frame.origin.y = defaultFrame.origin.y
        })
    }
    
    func dismiss(_ animated: Bool = false){
        guard let defaultFrame = defaultFrame else { return }
        UIView.animate(withDuration: 0.3, animations: {
            self.view?.frame.origin.y = defaultFrame.origin.y + defaultFrame.size.height
        }, completion: { _ in
            self.vc?.dismiss(animated: animated, completion: nil)
        })
    }
}

