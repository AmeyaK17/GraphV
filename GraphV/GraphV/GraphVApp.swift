//
//  GraphVApp.swift
//  GraphV
//
//  Created by Ameya Kale on 2/9/24.
//

import SwiftUI

@main
struct GraphVApp: App {
    var body: some Scene {
        WindowGroup {
            MainScreenView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)
        }
    }
}
