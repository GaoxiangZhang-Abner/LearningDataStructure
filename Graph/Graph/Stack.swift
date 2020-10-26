//
//  Stack.swift
//  Graph
//
//  Created by Gaoxiang Zhang on 2020/10/26.
//

import Foundation

class Stack<T> {
    
    private var nodes = [T]()
    var top: T? {
        return nodes.last
    }
    
    func push(_ data: T) {
        nodes.append(data)
    }
    
    func pop() {
        nodes.removeLast()
    }
}
