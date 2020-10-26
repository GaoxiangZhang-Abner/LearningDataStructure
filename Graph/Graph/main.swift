//
//  main.swift
//  Graph
//
//  Created by Gaoxiang Zhang on 2020/10/25.
//

import Foundation

/**
 操作         邻接表         邻接矩阵
 存储空间       O(V + E)    O(V^2)
 添加顶点       O(1)        O(V^2)
 添加边         O(1)        O(1)
 查找边和权重    O(V)        O(1)
 */

// MARK:- 邻接矩阵测试

//let graph = AdjacencyMatrix<String>()
//
//let wuHan = graph.createVertex(value: "武汉")
//let shangHai = graph.createVertex(value: "上海")
//let shenZhen = graph.createVertex(value: "深圳")
//let beiJing = graph.createVertex(value: "北京")
//
//graph.addDirectedEdge(from: wuHan, to: shangHai, weight: 300)
//graph.addDirectedEdge(from: wuHan, to: shenZhen, weight: 500)
//graph.addDirectedEdge(from: shangHai, to: beiJing, weight: 600)
//graph.addDirectedEdge(from: shenZhen, to: shangHai, weight: 700)
//graph.addUndirectedEdge(between: shenZhen, and: beiJing, weight: 1000)
//
//print(graph)

//let graph = AdjacencyMatrix<String>()
//
//let a = graph.createVertex(value: "A")
//let b = graph.createVertex(value: "B")
//let c = graph.createVertex(value: "C")
//let d = graph.createVertex(value: "D")
//let e = graph.createVertex(value: "E")
//let f = graph.createVertex(value: "F")
//let g = graph.createVertex(value: "G")
//let h = graph.createVertex(value: "H")
//
//graph.addUndirectedEdge(between: a, and: b, weight: 1)
//graph.addUndirectedEdge(between: a, and: c, weight: 1)
//graph.addUndirectedEdge(between: b, and: d, weight: 1)
//graph.addUndirectedEdge(between: c, and: e, weight: 1)
//graph.addUndirectedEdge(between: c, and: f, weight: 1)
//graph.addUndirectedEdge(between: d, and: e, weight: 1)
//graph.addUndirectedEdge(between: e, and: f, weight: 1)
//graph.addUndirectedEdge(between: d, and: g, weight: 1)
//graph.addUndirectedEdge(between: e, and: h, weight: 1)
//graph.addUndirectedEdge(between: f, and: h, weight: 1)
//let vertices = graph.breathFirstSearch(from: a)
//vertices.forEach { print($0) }


// MARK:- 邻接表测试

let graph = AdjacencyList<String>()

let wuHan = graph.createVertex(value: "武汉")
let shangHai = graph.createVertex(value: "上海")
let shenZhen = graph.createVertex(value: "深圳")
let beiJing = graph.createVertex(value: "北京")
let hongKong = graph.createVertex(value: "香港")
let newYork = graph.createVertex(value: "纽约")

graph.addEdge(.undirected, from: wuHan, to: shangHai, weight: 300)
graph.addEdge(.undirected, from: wuHan, to: shenZhen, weight: 500)
graph.addEdge(.undirected, from: shangHai, to: shenZhen, weight: 700)
graph.addEdge(.undirected, from: shangHai, to: beiJing, weight: 600)
graph.addEdge(.undirected, from: shenZhen, to: beiJing, weight: 1000)
graph.addEdge(.undirected, from: shenZhen, to: hongKong, weight: 200)
graph.addEdge(.undirected, from: beiJing, to: newYork, weight: 6000)
graph.addEdge(.undirected, from: hongKong, to: newYork, weight: 5000)

//print(graph)
let vertices = graph.breathFirstSearch(from: wuHan)
vertices.forEach { print($0) }
