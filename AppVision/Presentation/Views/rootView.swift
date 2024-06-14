//
//  rootView.swift
//  AppVision
//
//  Created by Cristian Contreras Velásquez on 10-06-24.
//

import SwiftUI

struct rootView: View {
    @Environment(AppStateVM.self) private var appStateVM
    
    var body: some View {
        ZStack {
            VStack {
                switch (appStateVM.status) {
                case .none:
                    loginView()
                    Text("login")
                case .error(error: let errorString):
                    Text("Error \(errorString)")
                case .loaded:
                   PrincipalView()
                }
            }
        }
    }
}

#Preview {
    rootView()
        .environment(AppStateVM())
}
