//
//  main.swift
//  Queue
//
//  Created by Gaoxiang Zhang on 2020/9/10.
//  Copyright © 2020 Gaoxiang Zhang. All rights reserved.
//


// MARK: - 队列的顺序存储结构
public struct MyQueue<T> {
    private var queueData: [T] = []
    
    public var front: T? {
        return queueData.first
    }
    
    public var isEmpty: Bool {
        return queueData.isEmpty
    }
    
    public var count: Int {
        return queueData.count
    }
    
    public mutating func enQueue(_ data: T) {
        queueData.append(data)
    }
    
    public mutating func deQueue() -> T? {
        if isEmpty {
            return nil
        } else {
            return queueData.removeFirst()
        }
    }
    
    public mutating func removeAll() {
        queueData.removeAll()
    }
    
    public func printAllData() {
        for value in queueData {
            print(value)
        }
    }
}

// MARK: - 队列的链式存储结构
class Node<T> {
    var data: T?
    var next: Node<T>?
    
    init(_ data: T) {
        self.data = data
        self.next = nil
    }
    
    init() {
        self.data = nil
        self.next = nil
    }
    
}

class Queue<T> {
    
    var head = Node<T>()
    var front: Node<T>
    var rear: Node<T>
    var size: Int
    
    init() {
        self.front = head
        self.rear = head
        size = 0
    }
    
    /// 入队
    func enQueue(data: T) {
        var newNode = Node(data)
        rear.next = newNode
        rear = newNode
        size += 1
    }
    
    
    /// 出队
    func deQueue() {
        if size == 0 {
            fatalError("队列已空")
        }
        
        var point = front.next
        front.next = point?.next
        point = nil
        size -= 1
    }
    
    func printAllNodes() {
        var point = front
        var count = 0
        while count <= size {
            print(point.data)
            if let pointNew = point.next {
                point = pointNew
            }
            size -= 1
        }
    }
    
}

var queue = Queue<Int>()
queue.enQueue(data: 1)
queue.enQueue(data: 3)
queue.enQueue(data: 5)
queue.deQueue()
queue.deQueue()
queue.deQueue()
queue.printAllNodes()

