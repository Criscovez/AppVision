//
//  NetworkHeros.swift
//  AppVision
//
//  Created by Cristian Contreras Velásquez on 15-06-24.
//

import Foundation

//Protocolo
public protocol NetworkHerosProtocol {
    func getHeros(firstLetter: String, filter: String) async -> HeroesResponse?
}


final class NetworkHeros: NetworkHerosProtocol{

    
    public init(){}
    
//    func getHeros(filter: String) async -> [HerosModelResponse] {
//
//    }
    
    func getHeros(firstLetter: String, filter: String = "") async -> HeroesResponse? {
        
        //mockeado
//        if self.mocked{
//            getHerosMock()
//            return
//        }

        do {
            let (data, response) = try await URLSession.shared.data(for: BaseNetwork().getSessionHeros(firstLetter: firstLetter))
            
            if let resp = response as? HTTPURLResponse {
                if resp.statusCode == HTTPResponseCodes.SUCCESS {
                    var modelReturn = try JSONDecoder().decode(HeroesResponse.self, from: data)
         return modelReturn
                }
            }

        } catch {

            print("---> error: \(error)")
            
        }
        
        return nil
    }
    
//    func getSeries(HeroID: String) async {
//        
//        //mockeado
////        if self.mocked{
////            getSeriesMock()
////            return
////        }
//        print(HeroID)
//        do {
//            let (data, response) = try await URLSession.shared.data(for: BaseNetwork().getSessionSeries(HeroID: HeroID))
//            
//            if let resp = response as? HTTPURLResponse {
//                if resp.statusCode == HTTPResponseCodes.SUCCESS {
//                    let modelReturn = try JSONDecoder().decode(SeriesResponse.self, from: data)
//                    Task{@MainActor in
//                        series = (modelReturn.data.results)
//                    }
//                }
//            }
//        } catch {
//            print("---> error: \(error)")
//        }
//    }
}
