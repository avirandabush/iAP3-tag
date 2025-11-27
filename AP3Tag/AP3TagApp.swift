//
//  AP3TagApp.swift
//  AP3Tag
//
//  Created by Aviran Dabush on 25/11/2025.
//

import SwiftUI

@main
struct AP3TagApp: App {
    @StateObject var viewModel = AppViewModel()

    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: viewModel)
        }
    }
}
