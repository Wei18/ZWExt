//
//  Array+Ext.swift
//  Imbrium
//
//  Created by ZhiWei Cao on 4/11/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

extension Array {
    func insert(by separator: Element?, by increment: Int = 1) -> [Element?] {
        guard count > 0, increment > 0 else { return self }
        let insertIndex = increment + 1
        return (0 ..< count + count/increment - 1).map { $0 % insertIndex == 0 ? self[$0/insertIndex] : separator }
    }
    
    func removeDuplicate<T: Hashable> (by condition: (Element) -> T) -> [Element] {
        var collection: [T: Int] = [:]
        var arr: [Element] = []
        
        self.enumerated().forEach({ (offset, element) in
            let key = condition(element)
            if collection[key, default: 0] == 0 {
                collection[key, default: 0] += 1
                arr.append(element)
            }
        })
        return arr
    }
    
    func separate(formula: (Element) -> Bool) -> ([Element], [Element]){
        var result: ([Element], [Element]) = ([], [])
        
        self.forEach({ (element) in
            if formula(element) {
                result.0.append(element)
            }else{
                result.1.append(element)
            }
        })
        
        return result
    }
}
