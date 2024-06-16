//
//  HerosViewModel.swift
//  AppVision
//
//  Created by Cristian Contreras Velásquez on 10-06-24.
//

import Foundation
//import KCNetworkVisionPro


final class HerosViewModel: ObservableObject {
    @Published  var heros: [HeroeResult] = []
    @Published  var series: [SerieResult] = []

    
    var HerosUseCase: UseCaseHerosProtocol
    
    init(useCaseHeros: UseCaseHerosProtocol = UseCaseHeros()) {
        self.HerosUseCase = useCaseHeros
        
        Task {
            await getHeros(firstLetter: "a", filter: "")
        }
    }
    
    func getHeros(firstLetter: String, filter: String) async {
        let data = await HerosUseCase.getHerosData(firstLetter: firstLetter, filter: filter)
        
        DispatchQueue.main.async {
            //self.heros = data
            if filter != "" {
                let herosf = data.filter { hero in
                    if hero.name.contains(filter) {
                        // 1
                        return true
                        
                    } else {
                        // 2
                        return false
                        
                    }
                }
                self.heros = herosf
            } else {
                //heros = modelReturn.data.results
                self.heros = data
            }
        }
    }
    
    func getSeries(HeroID: String) async {
        let data = await HerosUseCase.getSeriesData(HeroID: HeroID)
        
        DispatchQueue.main.async {
            self.series = data
        }
    }
}
