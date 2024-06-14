//
//  AppVisionApp.swift
//  AppVision
//
//  Created by Cristian Contreras Velásquez on 09-06-24.
//

import SwiftUI

@main
struct AppVisionApp: App {
    
    @State private var appState = AppStateVM()
    var body: some Scene {
        WindowGroup {
            rootView()
                .environment(appState)
                .frame(minWidth: 1000, maxWidth: .infinity, minHeight: 800, maxHeight: .infinity)
        }
        .windowStyle(.plain)
        .windowResizability(.contentMinSize)
        


    }
}
