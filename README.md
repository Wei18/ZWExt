# ZWExt

[![CI Status](https://img.shields.io/travis/wei18/ZWExt.svg?style=flat)](https://travis-ci.org/wei18/ZWExt)
[![Version](https://img.shields.io/cocoapods/v/ZWExt.svg?style=flat)](https://cocoapods.org/pods/ZWExt)
[![License](https://img.shields.io/cocoapods/l/ZWExt.svg?style=flat)](https://cocoapods.org/pods/ZWExt)
[![Platform](https://img.shields.io/cocoapods/p/ZWExt.svg?style=flat)](https://cocoapods.org/pods/ZWExt)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Usage

```swift
// swift-tools-version:4.0

import ZWExt

//with autolayout
tableView.setTableHeaderView(CustomView())
tableView.setTableFooterView(CustomView())

//config customViewSelf
customView.forSelf{ aView in
  //code
}

//SwipeDismissAnimation
let swipe = SwipeDismissAnimation(_ viewController: UIViewController, contentView aView: UIView?)
//you can use reactive way by
Observable.of(true).bind(to: swipe.rx.dismiss).disposed(by: disposeBag)
//or native 
swipe.dismis()

//TableHeaderViewZoomAnimation
let header = TableHeaderViewZoomAnimation(zoomView: UIView, tableView: UITableView)
//you can use reactive way by
header.rx.properties
//or using native and put in delegate
header.zoom()

```


## Installation

ZWExt is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ZWExt'
```

## Author

wei18, 41205mw@gmail.com

## License

ZWExt is available under the MIT license. See the LICENSE file for more info.
