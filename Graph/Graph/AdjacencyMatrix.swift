//
//  AdjacencyMatrix.swift
//  Graph
//
//  Created by Gaoxiang Zhang on 2020/10/25.
//

import Foundation

// MARK:- 邻接矩阵实现
final class AdjacencyMatrix<Element> {
    private var vertices: [Vertex<Element>] = []
    private var weights: [[Double?]] = []
    init() {}
    
    var visited: [Bool] = []
}

// 实现协议方法
extension AdjacencyMatrix: Graph {
    
    // 创建顶点
    func createVertex(value: Element) -> Vertex<Element> {
        // 点
        let vertex = Vertex(index: vertices.count, value: value)
        vertices.append(vertex)
        
        // 每列增加一个元素
        for i in 0 ..< weights.count {
            weights[i].append(nil)
        }
        
        // 增加一行
        let row = [Double?](repeating: nil, count: vertices.count)
        weights.append(row)
        
        return vertex
    }
    
    func addDirectedEdge(from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double?) {
        weights[source.index][destination.index] = weight
    }

    func edges(from source: Vertex<Element>) -> [Edge<Element>] {
        var edges: [Edge<Element>] = []
        for column in 0 ..< vertices.count {
            guard let weight = weights[source.index][column] else { continue }
            let edge = Edge(source: source, destination: vertices[column], weight: weight)
            edges.append(edge)
        }
        return edges
        
    }
    
    func weight(from source: Vertex<Element>, to destination: Vertex<Element>) -> Double? {
        return weights[source.index][destination.index]
    }
}

// 扩展CustomStringConvertible协议
extension AdjacencyMatrix: CustomStringConvertible {
    var description: String {
        // 打印节点
        let verticesDes = vertices.map { "\($0)" }
                                  .joined(separator: "\n")
        
        // 打印邻接矩阵
        var grid: [String] = []
        for i in 0 ..< weights.count {
            var row = ""
            for j in 0 ..< weights.count {
                if let value = weights[i][j] {
                    row += "\(value)\t"
                } else {
                    row += "ø\t\t"
                }
            }
            grid.append(row)
        }
        let edgesDes = grid.joined(separator: "\n")
        return "\(verticesDes)\n\n\(edgesDes)"
    }
}

// MARK:- 深度优先遍历
extension AdjacencyMatrix {
    
    // 深度优先遍历递归算法
    private func DFS(i: Int) {
        print("顶点:\(vertices[i])")
        visited[i] = true
        for j in 0 ..< weights.count {
            if let _ = weights[i][j], !visited[j] {
                DFS(i: j)
            }
        }
    }
    
    // 方法一：深度优先遍历操作(利用递归)
    func DFSTraverse() {
        for _ in vertices {
            visited.append(false)
        }
        
        for i in 0 ..< vertices.count {
            if (!visited[i]) {
                DFS(i: i)
            }
        }
    }
    
    // 方法二：深度优先遍历操作(利用栈)
    // 具体思路：遍历一个顶点的所有边，如果边的终点都没有顶点的话则
    func depthFirstSearch(from source: Vertex<Element>) -> [Vertex<Element>] {
            // 存储即将遍历的顶点
            var stack = Stack<Vertex<Element>>()
            // 存储已经入过栈的顶点
            var pushed: Set<Vertex<Element>> = []
            // 存储已经遍历过的顶点
            var visited: [Vertex<Element>] = []
            
            stack.push(source)
            pushed.insert(source)
            visited.append(source)
            
            // 给循环命名，可以指定continue或者break哪个循环
            outer: while let vertex = stack.top { // 判断栈顶的顶点是否为空
                let neighborEdges = edges(from: vertex)
                guard !neighborEdges.isEmpty else {
                    // 如果当前顶点没有邻居，把栈顶顶点取出
                    stack.pop()
                    continue
                }
                for edge in neighborEdges {
                    if !pushed.contains(edge.destination) { // 当前顶点的邻居没遍历过
                        stack.push(edge.destination)
                        pushed.insert(edge.destination)
                        visited.append(edge.destination)
                        // 继续执行外部的 while 循环，尝试往更深的一层继续遍历
                        continue outer
                    }
                }
                // 没有其他没有遍历过的邻居，把栈顶顶点取出
                stack.pop()
            }
            
            return visited
        }
}

// MARK:- 广度优先遍历
extension AdjacencyMatrix {
    
    func breathFirstSearch(from source: Vertex<Element>) -> [Vertex<Element>] {
        // 存储即将遍历的顶点
        var queue = Queue<Vertex<Element>>()
        // 存储已经入队的顶点
        var enqueued: Set<Vertex<Element>> = []
        // 存储已经遍历的顶点
        var visited: [Vertex<Element>] = []
        
        queue.enqueue(source)
        enqueued.insert(source)
        
        while let vertex = queue.dequeue() { // 取出队列的顶点
            visited.append(vertex)
            let neighborEdges = edges(from: vertex)
            for edge in neighborEdges
                where !enqueued.contains(edge.destination) {
                    // 把没有入队的邻居加入队列中
                    queue.enqueue(edge.destination)
                    enqueued.insert(edge.destination)
            }
        }
        
        return visited
    }
    
}
