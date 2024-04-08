//
//  GraphView.swift
//  GraphV
//
//  Created by Ameya Kale on 2/19/24.
//

import SwiftUI

struct GraphView: View {
    @StateObject var graphViewModel = GraphViewModel()
    @State private var startPoint: CGPoint = .zero
    @State private var selectedNode: Node? = nil
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                
                Stepper(
                    value: $graphViewModel.nodeValue,
                    in: 0...50,
                    label: {
                        Text("Node Value: \(graphViewModel.nodeValue)")
                            .fontWeight(.bold)
                    }
                )
                .padding()
                .frame(width: 300, height: 30)
                .overlay(RoundedRectangle(cornerRadius: 20)
                    .stroke(.blue, lineWidth: 2))
                
                Spacer()
                
                Button {
                    graphViewModel.addNode(val: graphViewModel.nodeValue, position: graphViewModel.initialPosition)
                } label: {
                    Text("Add Node")
                        .fontWeight(.bold)
                }
                .frame(width: 100, height: 30)
                .background(.blue)
                .foregroundColor(.black)
                .cornerRadius(20)
                
                
                Spacer()
                
                Menu {
                    ForEach(graphViewModel.traversalOptions, id: \.self) { option in
                        Button{
                            graphViewModel.selectedTraversalOptions = option
                        }
                        label:  {
                            Text(option)
                        }
                        
                    }
                } label: {
                    Text(graphViewModel.selectedTraversalOptions ?? "Traverse Graph")
                        .fontWeight(.bold)
                        .padding()
                }
                .frame(width: 175, height: 30)
                .background(.blue)
                .foregroundColor(.black)
                .cornerRadius(20)
                    
                Spacer()
                
                Button {
                    graphViewModel.reset()
                } label: {
                    Text("Reset")
                        .fontWeight(.bold)
                }
                .frame(width: 90, height: 30)
                .background(.red)
                .foregroundColor(.black)
                .cornerRadius(20)
                
                Spacer()
            }
            .padding()

            GraphContentView(graphViewModel: graphViewModel, startPoint: $startPoint, selectedNode: $selectedNode)
                .background(.ultraThickMaterial)
                .cornerRadius(20)
        }
        .padding()
        .background(
            LinearGradient(
                gradient: Gradient(colors: [.black, .blue]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }
}


#Preview {
    GraphView()
}
