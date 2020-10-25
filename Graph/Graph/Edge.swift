//
//  Edge.swift
//  Graph
//
//  Created by Gaoxiang Zhang on 2020/10/25.
//

import Foundation

struct Edge<T> {
    var source: Vertex<T>
    var destination: Vertex<T>
    var weight: Double?
}
