//
//  AdjacencyList.swift
//  Graph
//
//  Created by Gaoxiang Zhang on 2020/10/25.
//

import Foundation

// MARK:- 邻接表
final class AdjacencyList<Element> {
    private var adjacencies: [Vertex<Element>: [Edge<Element>]] = [:]
    init() {}
    
    var visited: [Bool] = []
}

// Graph协议
extension AdjacencyList: Graph {
   
    func createVertex(value: Element) -> Vertex<Element> {
        let vertex = Vertex(index: adjacencies.count, value: value)
        adjacencies[vertex] = []
        return vertex
    }
    
    func addDirectedEdge(from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double?) {
        let newEdge = Edge(source: source, destination: destination, weight: weight)
        adjacencies[source]?.append(newEdge)
    }
    
    func edges(from source: Vertex<Element>) -> [Edge<Element>] {
        return adjacencies[source] ?? []
    }
    
    func weight(from source: Vertex<Element>, to destination: Vertex<Element>) -> Double? {
        return edges(from: source).first { $0.destination == destination }?.weight
    }
    
}

// 打印协议
extension AdjacencyList: CustomStringConvertible {
    var description: String {
        var result = ""
        for (vertex, edges) in adjacencies {
            var edgeString = ""
            for (index, edge) in edges.enumerated() {
                if index < edges.count - 1 {
                    edgeString.append("\(edge.destination), ")
                } else {
                    edgeString.append("\(edge.destination)")
                }
            }
            result.append("\(vertex) --> [ \(edgeString) ]\n")
        }
        return result
    }
}

// MARK: - 广度优先遍历(和Matrix一样)
extension AdjacencyList {
    
    func breathFirstSearch(from source: Vertex<Element>) -> [Vertex<Element>] {
        
        let queue = Queue<Vertex<Element>>()
        var enqueued = Set<Vertex<Element>>() // 没有顺序
        var visited = [Vertex<Element>]()
        
        queue.enqueue(source)
        enqueued.insert(source)
        
        while let vertex = queue.dequeue() {
            visited.append(vertex)
            let neighborEdges = edges(from: vertex)
            for edge in neighborEdges where !enqueued.contains(edge.destination) {
                queue.enqueue(edge.destination)
                enqueued.insert(edge.destination)
            }
        }
        
        return visited
    }
    
}
