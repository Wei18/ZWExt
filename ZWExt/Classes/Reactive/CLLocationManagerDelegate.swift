//
//  CLLocationManagerDelegate.swift
//  Imbrium
//
//  Created by ZhiWei Cao on 11/10/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import CoreLocation

extension CLLocationManager: HasDelegate {
    public typealias Delegate = CLLocationManagerDelegate
}

extension Reactive where Base: CLLocationManager{
    var delegate: DelegateProxy<CLLocationManager, CLLocationManagerDelegate> {
        return RxCLLocationManagerDelegateProxy.proxy(for: base)
    }
    
    var didChangeAuthorization: ControlEvent<(CLLocationManager, CLAuthorizationStatus)> {
        let selector = #selector(CLLocationManagerDelegate.locationManager(_:didChangeAuthorization:))
        let source = delegate.methodInvoked(selector).share()
        let manager = source.map{ $0[0] as! CLLocationManager }
        let status  = source.map{ $0[1] as! Int32 }
            .map { CLAuthorizationStatus(rawValue: $0)! }
        let zip = Observable.zip(manager, status)
        return ControlEvent(events: zip)
    }
    
    var didUpdateLocations: ControlEvent<[CLLocation]> {
        let selector = #selector(CLLocationManagerDelegate.locationManager(_:didUpdateLocations:))
        let source = delegate.methodInvoked(selector)
            .map{ $0[1] as! [CLLocation] }
        return ControlEvent(events: source)
    }
}

class RxCLLocationManagerDelegateProxy
    : DelegateProxy<CLLocationManager, CLLocationManagerDelegate>
    , DelegateProxyType
    , CLLocationManagerDelegate {
    
    /// Typed parent object.
    public weak private(set) var parent: CLLocationManager?
    
    /// - parameter searchController: Parent object for delegate proxy.
    public init(lm: CLLocationManager) {
        self.parent = lm
        super.init(parentObject: lm, delegateProxy: RxCLLocationManagerDelegateProxy.self)
    }
    
    // Register known implementations
    public static func registerKnownImplementations() {
        self.register { RxCLLocationManagerDelegateProxy(lm: $0) }
    }
}
