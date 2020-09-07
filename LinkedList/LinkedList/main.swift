//
//  main.swift
//  LinkedList 链表
//
//  Created by Gaoxiang Zhang on 2020/9/5.
//  Copyright © 2020 Gaoxiang Zhang. All rights reserved.
//

/**
 
 不论是带头结点的链表还是不带头结点的链表，头指针head都指向链表中的第一个结点。如果该链表有头结点，则头指针head指向头结点，如果没有头结点，则头指针head指向链表的第一个节点。

 1 带头结点的单链表中头指针head指向头结点，头结点的值域不含任何信息，从头结点的后继结点开始存储信息。头指针head始终不等于NULL，head->next等于NULL的时候链表为空。

 2 不带头结点的单链表中的头指针head直接指向开始结点，当head等于NULL的时候链表为空。

 头结点的存在，使得空链表与非空链表的处理变得一直，也方便了对链表的开始结点插入或删除操作。
 */

public enum ErrorStatus {
    case Error(message: String)
    case OK
}

// MARK: - 链表节点
class LinkedListNode<T> {
    var data: T?
    var next: LinkedListNode?
    init(_ data: T) {
        self.data = data
    }
    
    init() {
        self.data = nil
        self.next = nil
    }
}

// MARK: - 单链表(含头节点)
class SingleLinkedList<T> {
    
    // 节点别名
    public typealias Node = LinkedListNode<T>
    
    // 头节点不存储任何信息或存储线性表长度等附加信息
    // 头节点指针域指向第一个节点
    var head: Node? = LinkedListNode()
    var tail: Node? = LinkedListNode()
    
    // 链表长度
    private(set) var count = 0
    
    /// 单链表创建：头插法
    /// - Parameter newData: 链表数据域
    func insert(atHead newData: T) {
        if head == nil {
            head = Node()
            tail = head
        } else {
            let newNode = Node(newData)
            newNode.next = head?.next
            head?.next = newNode
            tail = newNode.next
        }
        count += 1
    }
    
    /// 单链表创建：尾插法
    /// - Parameter newData: 链表数据域
    func insert(atTail newData: T) {
        if head == nil {
            head = Node()
            tail = head
        } else {
            let newNode = Node(newData)
            tail?.next = newNode
            tail = newNode
            tail?.next = nil
        }
        count += 1
    }
    
    
    /// 单链表的查找
    /// - Parameter index: 下标
    /// - Returns: 节点和信息
    func getNode(at index: Int) -> (Node?, ErrorStatus) {
        var point = head?.next // 指针指向链表的第一个节点(不含头节点)
        var j = 1 // 计数器
        
        while ((point != nil) && (j < index)) {
            point = point?.next
            j += 1
        }
        
        if (point == nil) {
            return (nil, .Error(message: "第\(index)个元素不存在"))
        }
        
        return (point, .OK)
    }
    
    /// 单链表的插入(在index之前，在point后插入)
    /// - Parameters:
    ///     - data: 链表数据域
    ///     - index: 下标
    /// - Returns: 信息
    func insert(node data: T, at index: Int) -> ErrorStatus {
        var point = head // index前一个节点
        var j = 1 // 计数器
        
        while ((point != nil) && (j < index)) {
            point = point?.next
            j += 1
        }
        
        if (point == nil) {
            return .Error(message: "\(index)超过界限")
        }
        
        let newNode = Node(data)
        newNode.next = point?.next
        point?.next = newNode
        return .OK
    }
    
    
    /// 单链表的插入(删除在index的节点，point后的节点)
    /// - Parameters:
    ///   - data: 链表数据域
    ///   - index: 下标
    /// - Returns: 信息
    func removeNode(at index: Int) -> ErrorStatus {
        var point = head
        var j = 1 // 计数器
        
        while ((point?.next != nil) && (j < index)) {
            point = point?.next
            j += 1
        }
        
        var deleteNode = point?.next
        if (point == nil || deleteNode == nil) {
            return .Error(message: "\(index)超过界限")
        }

        point?.next = deleteNode?.next
        deleteNode?.next = nil
        deleteNode = nil
        return .OK
        
    }
    
    /// 打印所有链表数据
    func printAllNodes() {
        print("--------------------------------")
        var node = head
        while node != nil {
            print(node?.data as Any)
            node = node?.next
        }
        
    }
    
}

let list = SingleLinkedList<Int>()
list.insert(atHead: 1)
list.insert(atHead: 2)
list.insert(atTail: 3)
list.insert(node: 666, at: 4)
list.removeNode(at: 4)
list.printAllNodes()


