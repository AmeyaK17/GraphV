//
//  GraphViewModel.swift
//  GraphV
//
//  Created by Ameya Kale on 2/19/24.
//

import Foundation
import SwiftUI

class GraphViewModel: ObservableObject {
    var graphModel = GraphModel.sharedInstance
    
    @Published var nodes: [Int: Node] = [:] // HashSet
    @Published var adjacencyList: [Int: [Int]] = [:] 
    @Published var initialPosition = CGPoint(x: 30, y: 30)
    
    @Published var edges: [Edge] = []
    
    @Published var sourceNode: Node? = nil
    @Published var destinationNode: Node? = nil
    @Published var visitedNodes: Set<Int> = []
    
    @Published var nodeValue = 0
    @Published var traversalOptions = ["BFS", "DFS"]
    //@Published var selectedTraversalOptions: String? = "Traverse Graph"
    @Published var selectedTraversalOptions: String? = nil {
        didSet {
            switch selectedTraversalOptions {
            case "BFS":
                print("Selected Option BFS")
                travelGraphBFS(from: sourceNode ?? Node(val: -1, id: -1), to: destinationNode ?? Node(val: -1, id: -1))
            case "DFS":
                // Perform functionality for Option DFS
                print("Selected Option DFS")
                travelGraphDFS(from: sourceNode ?? Node(val: -1, id: -1), to: destinationNode ?? Node(val: -1, id: -1))
            default:
                break
            }
        }
    }
    
    @Published var showAlert = false
    
    func addNode(val: Int, position: CGPoint) {
        let node = Node(val: val, position: position)
        nodes[node.id] = node
        adjacencyList[node.id] = []
        
        print("from addNode")
        for (key, node) in nodes {
            print("Value: \(node.val) & pos = \(node.position) & id = \(node.id)")
        }
        print("")
    }
    
    func updateNodePosition(key: Int, newPosition: CGPoint){
        guard let node = nodes[key] else { return }
        
        node.position = newPosition
        nodes[key] = node
    }
    
    func updateNodeVal(key: Int, newVal: Int){
        guard let node = nodes[key] else { return }
        
        node.val = newVal
        nodes[key] = node
    }
    
    func addEdge(from node1: Node, to node2: Node) {
        let edge = Edge(node1: node1, node2: node2)
        edges.append(edge)
        adjacencyList[node1.id]?.append(node2.id)
        adjacencyList[node2.id]?.append(node1.id)
    }
    
    func processNodeDelay(nodeID: Int, delay: Double) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            // Ensure UI updates are done on the main thread
            DispatchQueue.main.async {
                self.visitedNodes.insert(nodeID)
            }
        }
    }
    
    func travelGraphBFS(from source: Node, to destination: Node) -> Bool{
        if(source.id == -1){
            showAlert = true
            return false
        }
        
        var delay = 1.0
        print(adjacencyList)
        
        visitedNodes.removeAll()
        var visitedNodesForBFS = visitedNodes
        var q = [source.id]
        
        while(!q.isEmpty){
            let currNodeID = q.removeFirst()
            
            if let currNode = nodes[currNodeID]{
                processNodeDelay(nodeID: currNodeID, delay: delay)
                delay += 1.0
                
                visitedNodesForBFS.insert(currNode.id)
    
                print("currNode = \(currNode.val)")
                if currNode.id == destination.id{
                    return true
                }
                
                if let neighbors = adjacencyList[currNode.id] {
                    print("neighbors = \(neighbors)")
                    for neighbor in neighbors {
                        if !visitedNodesForBFS.contains(neighbor) {
                            q.append(neighbor)
                        }
                    }
                }
            }
        }
        
        return false
    }
    
    func dfs(from currNode: Int, to destination: Node, visitedNodesForDFS: inout Set<Int>, delay delay: inout Double) -> Bool{
        
        delay += 1.0
        processNodeDelay(nodeID: currNode, delay: delay)
        visitedNodesForDFS.insert(currNode)
        
        if currNode == destination.id{
            return true
        }
        
        if(visitedNodes.contains(currNode)){
            return false
        }
        
        if let neighbors = adjacencyList[currNode] {
            print("neighbors = \(neighbors)")
            for neighbor in neighbors {
                if !visitedNodesForDFS.contains(neighbor) {
                    if(dfs(from: neighbor, to: destination, visitedNodesForDFS: &visitedNodesForDFS, delay: &delay) == true){
                        return true
                    }
                }
            }
        }
        
        return false
    }
    
    func travelGraphDFS(from source: Node, to destination: Node) -> Bool{
        if(source.id == -1){
            showAlert = true
            return false
        }
        
        var delay = 0.0
        visitedNodes.removeAll()
        var visitedNodesForDFS = visitedNodes
        
        let res = dfs(from: source.id, to: destination, visitedNodesForDFS: &visitedNodesForDFS, delay: &delay)
        print(res)
        
        return res
    }
    
    func reset(){
        self.nodes.removeAll()
        self.edges.removeAll()
        self.adjacencyList.removeAll()
        selectedTraversalOptions = nil
        nodeValue = 0
        sourceNode = nil
        destinationNode = nil
        showAlert = false
    }
}
