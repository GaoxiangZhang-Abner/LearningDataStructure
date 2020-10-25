//
//  AdjacencyMatrix.swift
//  Graph
//
//  Created by Gaoxiang Zhang on 2020/10/25.
//

import Foundation

// MARK:- 邻接矩阵
final class AdjacencyMatrix<Element> {
    private var vertices: [Vertex<Element>] = []
    private var weights: [[Double?]] = []
    init() {}
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



