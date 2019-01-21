//
//  PowerfulXIB.swift
//  Imbrium
//
//  Created by ZhiWei Cao on 1/6/19.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

protocol PowerfulXIB{
    func loadNibFromCoder() -> Self?
    func awakeFromViewOnwerAfter(using view: UIView?) -> Any?
    func initializeFromFileOwner()
}

extension PowerfulXIB where Self: UIView {
    
    /**
     Set false for view custom class to object in xib
     Set true for file's owner custom class to object in xib
     */
    private func instantiateFromNibHelper<T: UIView>(_ haveOnwer: Bool) -> T? {
        let mTpye = type(of: self)
        let nibNames = NSStringFromClass(mTpye).components(separatedBy: ".")
        let owner = haveOnwer ? self : nil
        guard
            let nibName = nibNames.last,
            let views = Bundle(for: mTpye).loadNibNamed(nibName, owner: owner, options: nil),
            let view = views.first as? T else { return nil }
        return view
    }
    
    /**
     ```
     let view: CustomView = CustomView().loadNibFromCoder()
     ```
     */
    func loadNibFromCoder() -> Self? {
        return instantiateFromNibHelper(false)
    }
    
    /**
     ```
     override func awakeAfter(using aDecoder: NSCoder) -> Any? {
     let view = super.awakeAfter(using: aDecoder) as? View
     return awakeFromViewOnwerAfter(using: view)
     }
     ```
     */
    func awakeFromViewOnwerAfter(using view: UIView?) -> Any?{
        guard view?.subviews.isEmpty == true else { return self }
        
        let loaded = instantiateFromNibHelper(false)
        loaded?.frame = self.frame
        loaded?.autoresizingMask = [.flexibleTopMargin,
                                    .flexibleLeftMargin,
                                    .flexibleWidth,
                                    .flexibleHeight,
                                    .flexibleBottomMargin,
                                    .flexibleRightMargin]
        loaded?.translatesAutoresizingMaskIntoConstraints = true
        return loaded
    }
    
    /**
     ```
     required init?(coder aDecoder: NSCoder) {
     // for using CustomView in IB
     super.init(coder: aDecoder)
     self.initializeFromFileOwner()
     }
     override init(frame: CGRect) {
     super.init(frame: frame)
     self.initializeFromFileOwner()
     }
     ```
     */
    func initializeFromFileOwner(){
        guard let view = instantiateFromNibHelper(true) else { return }
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        view.translatesAutoresizingMaskIntoConstraints = true
        self.addSubview(view)
    }
}
