//
//  SetApp.swift
//  Set
//
//  Created by Jake Ledner on 6/5/25.
//

import SwiftUI

@main
struct SetApp: App {
    @StateObject var game = SetCardGame()
    
    var body: some Scene {
        WindowGroup {
            SetCardGameView(viewModel: game)
        }
    }
}
