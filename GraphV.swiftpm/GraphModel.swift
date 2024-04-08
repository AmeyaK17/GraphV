//
//  GraphModel.swift
//  GraphV
//
//  Created by Ameya Kale on 2/19/24.
//

import Foundation

class GraphModel: ObservableObject {
    var nodes: [Int: Node] = [:] // HashSet
    var adjacencyList: [Int: [Int]] = [:] //HashMap
    
    static let sharedInstance = GraphModel()
    
    init() {
        self.nodes = [:]
        self.adjacencyList = [:]
    }
    
    func addNode(val: Int, position: CGPoint) -> Node {
        let node = Node(val: val, position: position)
        nodes[node.id] = node
        adjacencyList[node.id] = []
        return node
    }
    
    func addEdge(source: Int, dest: Int){
        adjacencyList[source]?.append(dest)
        adjacencyList[dest]?.append(source)
    }
}
