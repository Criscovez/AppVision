//
//  HerosViewModel.swift
//  AppVision
//
//  Created by Cristian Contreras Velásquez on 10-06-24.
//

import Foundation
//import KCNetworkVisionPro

@Observable
final class HerosViewModel {
    var heros: [HerosData]?
    var heros3D: [HerosData]?
    var status = Status.none
    
    var HerosUseCase: UseCaseHerosProtocol
    
    init(useCaseHeros: UseCaseHerosProtocol = UseCaseHeros()) {
        self.HerosUseCase = useCaseHeros
        
        Task {
            await getHeros(filter: "")
        }
    }
    
    func getHeros(filter: String) async {
        let data = await HerosUseCase.getData(filter: filter)
        
        DispatchQueue.main.async {
            self.heros = data
            if let heros = self.heros {
                self.heros3D = heros.filter { $0.id3DModel != "" }
            }
        }
    }
}
