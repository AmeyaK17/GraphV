//
//  GraphModel.swift
//  GraphV
//
//  Created by Ameya Kale on 2/19/24.
//

import Foundation
import SwiftUI

class Node: ObservableObject, Identifiable, Equatable, Hashable {
    static var nextID = 0
    
    var id = 0
    var val = 0
    var adjacentNodes: [Int]
    var position: CGPoint
    
    init(val: Int, position: CGPoint) {
        self.id = Node.nextID
        Node.nextID += 1
        self.val = val
        self.adjacentNodes = []
        self.position = position
    }
    
    init(val: Int, id: Int) {
        self.id = id
        self.val = val
        self.adjacentNodes = []
        self.position = CGPoint(x: -1.0, y: -1.0)
    }
    
    static func == (node1: Node, node2: Node) -> Bool{
        return node1.id == node2.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}

struct NodeEditState {
    var isEditingNode = false
    var newNodeValue = ""
}
