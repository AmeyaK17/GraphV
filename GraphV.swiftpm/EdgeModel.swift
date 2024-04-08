//
//  EdgeModel.swift
//  GraphV
//
//  Created by Ameya Kale on 2/22/24.
//

import Foundation

class Edge: ObservableObject, Identifiable, Equatable {
    var id: String { "\(node1.id) - \(node2.id)" }
    
    var node1: Node
    var node2: Node
    
    var start: CGPoint
    var end: CGPoint
    
    
    init(node1: Node, node2: Node) {
        self.node1 = node1
        self.node2 = node2
        
        start = node1.position
        end = node2.position
    }
    
    static func == (edge1: Edge, edge2: Edge) -> Bool{
        return edge1.node1.id == edge2.node1.id && edge1.node2.id == edge2.node2.id
    }
}
