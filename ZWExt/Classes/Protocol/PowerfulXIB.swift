//
//  PowerfulXIB.swift
//  Imbrium
//
//  Created by ZhiWei Cao on 1/6/19.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

public protocol PowerfulXIB{
    func loadNib() -> Self?
    func awakeFromViewOnwerAfter(using view: UIView?) -> Any?
    //func initializeFromFileOwner()
    func addSubviewWithAutoLayout(_ view: UIView)
}

public extension PowerfulXIB where Self: UIView {
    
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
     let view: CustomView = CustomView().loadNib()
     ```
     */
    func loadNib() -> Self? {
        return instantiateFromNibHelper(false)
    }
    
    /**
     ```
     override func awakeAfter(using aDecoder: NSCoder) -> Any? {
     let view = super.awakeAfter(using: aDecoder) as? UIView
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
    
    /*
     //TBD: to be tested
    /**
     For file owner
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
        addSubviewWithAutoLayout(view)
    }
    */
    
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
}
