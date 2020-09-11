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

// MARK: - 单链表节点(默认含头节点)
class SingleLinkedListNode<T> {
    var data: T?
    var next: SingleLinkedListNode?
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
    public typealias Node = SingleLinkedListNode<T>
    
    // 头节点不存储任何信息或存储线性表长度等附加信息
    // 头节点指针域指向第一个节点
    var head: Node?
    
    // 链表长度
    private(set) var count = 0
    
    /// 单链表创建：头插法
    /// - Parameter newData: 链表数据域
    func insert(atHead newData: T) {
        if head == nil {
            head = Node()
        }
        
        let newNode = Node(newData)
        newNode.next = head?.next
        head?.next = newNode
        
        count += 1
    }
    
    /// 单链表创建：尾插法
    /// - Parameter newData: 链表数据域
    func insert(atTail newData: T) {
        var tail: Node? = getNode(at: count).0 // 尾查法用于只利用尾插法创建单链表时，若结合头插法需要遍历查到尾节点，时间复杂度为O(n)

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

//let list = SingleLinkedList<Int>()
//list.insert(atHead: 1)
//list.insert(atHead: 2)
//list.insert(atTail: 3)
//list.insert(atTail: 999)
//list.insert(atHead: 666)
//list.removeNode(at: 4)
//list.printAllNodes()


// MARK: - 双链表节点(默认含头节点)
class DoubleLinkedNode<T> {
    var data: T?
    var next: DoubleLinkedNode<T>?
    var pre: DoubleLinkedNode<T>?
    
    init() {
        self.data = nil
        self.next = nil
        self.pre = nil
    }
    
    init(data: T) {
        self.data = data
    }
}

class DoubleLinkedList<T> {
    
    public typealias Node = DoubleLinkedNode<T>
    
    var head: Node?
    var tail: Node?
    
    /// 双链表创建：头插法
    /// - Parameter newData: 信息
    func append(atHead newData: T) {
        if (head == nil) {
            head = DoubleLinkedNode()
        }
        
        let newNode = DoubleLinkedNode(data: newData)
        newNode.next = head?.next
        newNode.pre = head
        head?.next?.pre = newNode
        head?.next = newNode
        
    }
    
    
    /// 双链表查找
    /// - Parameter index: 下标
    /// - Returns: 错误信息
    func getNode(at index: Int) -> (Node?, ErrorStatus) {
        var point = head?.next // 指针
        var j = 1 // 计数器
        while ((point != nil && (j < index))) {
            point = point?.next
            j += 1
        }
        
        if (point == nil) {
            return (nil, .Error(message: "\(index)超过界限"))
        }
        
        return (point, .OK)
        
    }
    
    /// 双链表插入
    /// - Parameters:
    ///   - data: 插入节点数据域
    ///   - index: 下标
    /// - Returns: 节点和错误信息
    func insert(node data: T, at index: Int) -> (Node?,ErrorStatus) {
        if (head == nil) {
            head = DoubleLinkedNode()
        }
        
        var point = head // 指针(节点插在指针之后)
        var j = 1 // 计数器
        
        while (point != nil && j < index) {
            point = point?.next
            j += 1
        }
        
        if (point == nil) {
            return (nil, .Error(message: "\(index)超过界限"))
        }
        
        var newNode = Node(data: data)
        newNode.pre = point
        newNode.next = point?.next
        point?.next?.pre = newNode
        point?.next = newNode
        
        return (newNode, .OK)
    }
    
    /// 双链表删除
    /// - Parameter index: 下标
    /// - Returns: 错误信息
    func deleteNode(at index: Int) -> ErrorStatus {
        var point = head // 指针(删除节点的前一个节点)
        var j = 1 // 计数器
        
        while (point != nil && j < index) {
            point = point?.next
            j += 1
        }
        
        if (point == nil) {
            return .Error(message: "\(index)超过界限")
        }
        
        var deleteNode = point?.next
        point?.next = deleteNode?.next
        deleteNode?.next?.pre = point
        deleteNode?.next = nil
        deleteNode?.pre = nil
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
//        print("--------------------------------")
//        node = node?.pre
//        while node != nil {
//            print(node?.data as Any)
//            node = node?.pre
//        }
        
    }
    
    
}

let doubleList = DoubleLinkedList<String>()
doubleList.append(atHead: "1")
doubleList.insert(node: "8", at: 2)
doubleList.append(atHead: "99")
doubleList.deleteNode(at: 1)
doubleList.deleteNode(at: 2)
doubleList.printAllNodes()
