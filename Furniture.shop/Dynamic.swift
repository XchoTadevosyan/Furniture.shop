//
//  Dynamic.swift
//  Furniture.shop
//
//  Created by Xachik on 27.01.23.
//

import Foundation

class Dynamic<T> {
    typealias Listener = (T) -> Void
    private var listener : Listener?
    
    
    func bind(_ listener : Listener?) {
        self.listener = listener
    }
    var value: T {
        didSet {
            listener?(value)
        }
    }
    init(_ v: T) {
    value = v
    }
}
