//
//  PrincipalView.swift
//  AppVision
//
//  Created by Cristian Contreras Velásquez on 10-06-24.
//

import SwiftUI


struct PrincipalView: View {
    
    @StateObject var vm: HerosViewModel = HerosViewModel()
    
    var body: some View {
                    HerosView(viewModel: vm)
    }
}

//#Preview {
// //   PrincipalView(vm: HerosViewModelx(useCaseHeros: UseCaseHerosFake()))
//}
