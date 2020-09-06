//
//  main.swift
//  SequenceList 线性表顺序存储
//
//  Created by Gaoxiang Zhang on 2020/9/5.
//  Copyright © 2020 Gaoxiang Zhang. All rights reserved.
//

import Foundation

class ListNode {
    var value: Int
        
    public init(_ value: Int) {
        self.value = value
    }
}

class SequenceList {
    // 存储数据元素的数组
    var values: [ListNode]?
    
    // 表的长度
    var length: Int {
        get {
            if let count = values?.count {
                return count
            }
            return 0
        }
    }
        
    // MARK: - 创建
    init() {}
    
    func node(at index: Int) -> ListNode? {
        guard let nodes = values else {
            return nil
        }
        
        if index > 0 && index < nodes.count {
            return nodes[index]
        }
        
        return nil
    }
    
    func insert(_ value: Int, _ index: Int) {
        let newNode = ListNode(value)
        guard let nodes = values else {
            values = []
            values?.append(newNode)
            return
        }
        
        // index 越界
        if index < 0 || index >= nodes.count {
            return
        }
        
        var temp: [ListNode] = []
        
        for i in 0..<nodes.count {
            if i == index {
                temp.append(newNode)
            }
            temp.append(nodes[i])
        }
        values = temp
    }

    func remove(at index: Int) {
        guard let nodes = values else {
            return
        }
        
        // 超出数组长度
        if index < 0 && index >= nodes.count { return }
        
        var temp: [ListNode] = []
        for i in 0..<nodes.count {
            if i != index {
                temp.append(nodes[i])
            }
        }
        values = temp
    }

    
}

let list = SequenceList()
list.insert(1, 0)
list.insert(2, 0)
list.insert(3, 1)



