 //
//  main.swift
//  BinTree
//
//  Created by Gaoxiang Zhang on 2020/9/15.
//  Copyright © 2020 Gaoxiang Zhang. All rights reserved.
//

 import Foundation
 
// 二叉树
// 前、中、后、层序遍历

// 定义二叉树
class BinaryTree<T> {
    var data: T
    var lchild: BinaryTree<T>?
    var rchild: BinaryTree<T>?
    
    init(_ data: T) {
        self.data = data
    }
}

// 前序遍历
func preOrderTraverse(node: BinaryTree<String>?) {
    
    guard let treeNode = node else { return }
    
    print("结点:\(treeNode.data)")
    preOrderTraverse(node: treeNode.lchild)
    preOrderTraverse(node: treeNode.rchild)
    
}

// 中序遍历
func inOrderTraverse(node: BinaryTree<String>?) {
    
    guard let treeNode = node else { return }
    
    inOrderTraverse(node: treeNode.lchild)
    print("结点:\(treeNode.data)")
    inOrderTraverse(node: treeNode.rchild)
    
}

// 后序遍历
func postOrderTraverse(node: BinaryTree<String>?) {
    
    guard let treeNode = node else { return }
    
    postOrderTraverse(node: treeNode.lchild)
    postOrderTraverse(node: treeNode.rchild)
    print("结点:\(treeNode.data)")
    
}

// 层序遍历(队列出上层，进下层)
func layerOrderTraverse(node: BinaryTree<String>?) {
    
    guard let treeNode = node else { return }
    var queue = [treeNode]
    
    while !queue.isEmpty {
        let count = queue.count
        for i in 0 ..< queue.count {
            let node = queue[i]
            print(node.data)
            if let lNode = node.lchild { queue.append(lNode) }
            if let rNode = node.rchild { queue.append(rNode) }
        }
        queue.removeSubrange(0..<count)
    }
    
}


let root = BinaryTree("A")
root.lchild = BinaryTree("B")
root.rchild = BinaryTree("C")
root.lchild?.lchild = BinaryTree("D")
root.lchild?.rchild = BinaryTree("E")
root.rchild?.lchild = BinaryTree("F")
root.rchild?.rchild = BinaryTree("G")
root.lchild?.lchild?.lchild = BinaryTree("H")
root.lchild?.lchild?.rchild = BinaryTree("I")
root.lchild?.rchild?.lchild = BinaryTree("J")

// 前序遍历结果：ABDHIEJCFG => A->(B->(D->H->I)->(E->J))->(C->F->G)
// 中序遍历结果：HDIBJEAFCG => ((H<-D->I)<-B->(J<-E))<-A->(F<-C->G)
// 后序遍历结果：HIDJEBFGCA => ((H->I->D)->(J->E)->B)->(F->G->C)->A
// 层序遍历结果：ABCDEFGHIJ => A->(B->C)->(D->E->F->G)->(H->I->J)
layerOrderTraverse(node: root)

// 二叉线索树
class BinTNode<T>: NSObject {
    let data: T
    var lChild: BinTNode<T>?
    var rChild: BinTNode<T>?
    var lTag: Bool = false  //lTag = true，lChild指向前驱；否则，指向左子树
    var rTag: Bool = false  //rTag = true，rChild指向后续；否则，指向右子树
    init(_ data: T) {
        self.data = data
    }
}
 
 // 中序遍历进行中序线索化
func inOrderTraverse_Thread(node: BinTNode<String>?) {
    
    var pre: BinTNode<String>!
    
    guard let treeNode = node else { return }
     
    inOrderTraverse_Thread(node: treeNode.lChild)
    if (treeNode.lChild == nil) {
        treeNode.lTag = true
        treeNode.lChild = pre
    }
    
    if (pre.rChild == nil) {
        pre.rTag = true
        pre.rChild = treeNode
    }
    pre = treeNode
    inOrderTraverse_Thread(node: treeNode.rChild)
     
}

// 二叉线索树的中序遍历
func inOrderTraverse_Thread(t: BinTNode<String>?) {
    var p = t?.lChild // p指针指向根结点(头结点指向根结点)
    while p != t {
        while p?.lTag == false {  // 二叉树最左边
            p = p?.lChild
        }
        print(p?.data ?? "")  // 打印数据
        while p?.rChild != t, p?.rTag == true {
            p = p?.rChild
            print(p?.data ?? "")
        }
        p = p?.rChild
     }
 }
 
// 核心实现思路：
// 1.遍历二叉树的最左结点，然后输出
// 2.通过后续指针获取双亲结点，然后输出
// 3.遍历到右子树，重复1，2两步骤
