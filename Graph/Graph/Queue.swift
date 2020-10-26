//
//  Queue.swift
//  Graph
//
//  Created by Gaoxiang Zhang on 2020/10/26.
//

import Foundation

class Queue<T> {
    
    private var nodes = [T]()
    var top: T? {
        return nodes.last
    }
    
    func enqueue(_ data: T) {
        nodes.append(data)
    }
    
    func dequeue() -> T? {
        return nodes.count > 0 ? nodes.removeFirst() : nil
        
    }
}
