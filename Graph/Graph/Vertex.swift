//
//  Vertex.swift
//  Graph
//
//  Created by Gaoxiang Zhang on 2020/10/25.
//

import Foundation

struct Vertex<T> {
    var index: Int
    var value: T
}

// 遵守Hashable协议，顶点可以作为字典的key
extension Vertex: Hashable {
    var hashValue: Int {
        return index.hashValue
    }
    
    // static类方法 等价于 class final
    static func == (lhs: Vertex<T>, rhs: Vertex<T>) -> Bool {
        return lhs.index == rhs.index
    }
}

extension Vertex: CustomStringConvertible {
    var description: String {
        return "\(index): \(value)"
    }
}
