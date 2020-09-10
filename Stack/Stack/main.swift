//
//  main.swift
//  Stack
//
//  Created by Gaoxiang Zhang on 2020/9/10.
//  Copyright © 2020 Gaoxiang Zhang. All rights reserved.
//





// Mark: - 栈：顺序结构
struct stackArray<T> {
    
    private var nodes = [T]()
 
    // 栈的大小
    var size: Int {
        return nodes.count
    }
    
    // 栈的最大容量
    var capacity: Int
    
    init(capacity: Int) {
        self.capacity = capacity
    }
    
    public mutating func push(data: T) {
        if (size >= capacity) {
            fatalError("栈已满，不能再执行入栈操作！")
        }
        nodes.append(data)
    }

    public mutating func pop() -> T {
        if (size == 0) {
            fatalError("栈已空，不能再执行出栈操作！")
        }
        return nodes.removeLast()
    }
    
    public func printAllNodes() {
        for node in nodes {
            print(node)
        }
    }
}

//var myStack = stackArray<Int>(capacity: 3)
//myStack.push(data: 1)
//myStack.push(data: 2)
//myStack.push(data: 3)
//myStack.pop()
//myStack.pop()
//myStack.pop()
//myStack.printAllNodes()


// Mark: - 栈：链式结构 (无头节点)
enum Status {
    case OK
    case Error(message: String)
}


// 栈的节点
class StackNode<T> {
    var data: T
    var next: StackNode<T>?
    
    init(data: T) {
        self.data = data
    }
}

class Stack<T> {
    
    public typealias Node = StackNode<T>
    var top: Node?
    var size: Int = 0
    
    func push(data: T) -> Status {
        
        let newNode = Node(data: data)
        
        if (top == nil) {
            top = Node(data: data)
        } else {
            newNode.next = top
            top = newNode
        }
        
        size += 1
        return .OK
    }
    
    func pop() -> Status {
        
        if (size <= 0) {
            return .Error(message: "栈已空")
        }
        
        let newTop = top?.next
        top?.next = nil
        top = newTop
        size -= 1
        return .OK
    }
    
    func printAllNode() {
        var point = top
        while point != nil {
            print(point?.data)
            point = point?.next
        }
    }
    
}

//var stack = Stack<String>()
//stack.push(data: "a")
//stack.push(data: "b")
//stack.push(data: "c")
//print(stack.pop())
//print(stack.pop())
//print(stack.pop())
//stack.printAllNode()

