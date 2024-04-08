//
//  GraphContentView.swift
//  GraphV
//
//  Created by Ameya Kale on 2/22/24.
//

import SwiftUI

struct GraphContentView: View {
    @ObservedObject var graphViewModel: GraphViewModel
    @Binding var startPoint: CGPoint
    @Binding var selectedNode: Node?
    @State var renderEdges = false
    @State private var editingStates: [Int: NodeEditState] = [:]
    
    var body: some View {
        ZStack{
            ForEach(graphViewModel.edges) { edge in
                    LineShape(start: edge.start, end: edge.end)
                    .stroke(Color.red, lineWidth: 2)
            }
            
            GeometryReader { geometry in
                ForEach(Array(graphViewModel.nodes.values), id: \.id) { node in
                    //NodeView(node: node)
                    let editState = editingStates[node.id, default: NodeEditState()]
                    
                    NodeView(node: node)
                        .position(node.position)
                        .foregroundColor(graphViewModel.visitedNodes.contains(node.id) ? .green : .blue)
                        .animation(.interpolatingSpring(stiffness: 50, damping: 8), value: node.position)
                        .animation(.easeInOut)
                        .shadow(radius: 10)
                        .gesture(DragGesture()
                            .onChanged { value in
                                    if startPoint == .zero {
                                        startPoint = node.position
                                    }
                                    
                                    let translation = value.translation
                                    
                                    let newX = startPoint.x + translation.width
                                    let newY = startPoint.y + translation.height
                                    
                                    node.position.x = max(min(newX, UIScreen.main.bounds.width - 15), 15)
                                    node.position.y = max(min(newY, UIScreen.main.bounds.height - 15), 15)
                            }
                            .onEnded { _ in
                                    startPoint = node.position
                                    graphViewModel.updateNodePosition(key: node.id, newPosition: node.position)
                                    startPoint = .zero
                                    renderEdges.toggle()
                            }
                        )
                        .gesture(
                            TapGesture(count: 1)
                                .onEnded { _ in
                                    selectedNode = node
                                }
                        )
                        .contextMenu {
                            if let selectedNode = selectedNode {
                                ForEach(graphViewModel.nodes.values.filter { $0.id != node.id }, id: \.id) { otherNode in
                                    Button {
                                        graphViewModel.addEdge(from: node, to: otherNode)
                                    } label: {
                                        Text("Node \(otherNode.val)")
                                    }
                                }
                                
                                Button {
                                    graphViewModel.sourceNode = node
                                }
                                label:{
                                    Text("Make Source")
                                }
                                
                                Button {
                                    graphViewModel.destinationNode = node
                                }
                                label:{
                                    Text("Make Destination")
                                }
                            }
                        }
                        preview: {
                            NodeView(node: node)
                        }
                }
            }
        }
        .alert(isPresented: $graphViewModel.showAlert) {
            Alert(
                title: Text("No source node"),
                message: Text("Please add a source node for traversing the graph"),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

//#Preview {
//    GraphContentView(graphViewModel: GraphViewModel(), startPoint: .zero, selectedNode: nil)
//}
