//
//  NodeView.swift
//  GraphV
//
//  Created by Ameya Kale on 2/19/24.
//

import SwiftUI

struct NodeView: View {
    @State var node: Node
    
    var body: some View {
        Circle()
            .frame(width: 50, height: 50)
            .overlay(
                Text("\(node.val)")
                    .fontWeight(.bold)
                    .foregroundColor(.black)
            )
    }
}

#Preview {
    NodeView(node: Node(val: 5, position: CGPoint(x: 40, y: 750)))
}
