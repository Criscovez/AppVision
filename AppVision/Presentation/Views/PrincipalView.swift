//
//  PrincipalView.swift
//  AppVision
//
//  Created by Cristian Contreras Velásquez on 10-06-24.
//

import SwiftUI
//import KCNetworkVisionPro

struct PrincipalView: View {
    @StateObject var vm: HerosViewModelx = HerosViewModelx()
    
//    init(vm: HerosViewModelx = HerosViewModelx()) {
//        self.vm = vm
//    }
    
    var body: some View {
        ZStack{
            ///
            VStack {
                TabView {
                    HerosView(viewModel: vm)
                    Text("Heroes")
                        .tabItem {
                            Label(
                                title: { Text("Heroes") },
                                icon: { Image(systemName: "42.circle") }
                                
                            )
                        }
                    
                    Text("Heroes 3D")
                        .tabItem {
                            Label(
                                title: { Text("Heroes 3D") },
                                icon: { Image(systemName: "person.fill")}
                            )
                        }
                }
            }
        }
    }
}

//#Preview {
// //   PrincipalView(vm: HerosViewModelx(useCaseHeros: UseCaseHerosFake()))
//}
