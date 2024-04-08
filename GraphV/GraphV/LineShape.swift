//
//  File.swift
//  GraphV
//
//  Created by Ameya Kale on 2/22/24.
//

import Foundation
import SwiftUI

struct LineShape: Shape {
    var start: CGPoint
    var end: CGPoint

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: start)
        path.addLine(to: end)
        return path
    }
}
