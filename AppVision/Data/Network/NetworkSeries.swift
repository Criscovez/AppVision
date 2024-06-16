//
//  NetworkSeries.swift
//  AppVision
//
//  Created by Cristian Contreras Velásquez on 15-06-24.
//

import Foundation

//Protocolo
public protocol NetworkSeriesProtocol {
    func getSeries(HeroID: String) async -> SeriesResponse?
}


final class NetworkSeries: NetworkSeriesProtocol{
    
    
    public init(){}
    
    //    func getHeros(filter: String) async -> [HerosModelResponse] {
    //
    //    }
    
    func getSeries(HeroID: String) async -> SeriesResponse? {
        
        //mockeado
//        if self.mocked{
//            getSeriesMock()
//            return
//        }
        print(HeroID)
        do {
            let (data, response) = try await URLSession.shared.data(for: BaseNetwork().getSessionSeries(HeroID: HeroID))
            
            if let resp = response as? HTTPURLResponse {
                if resp.statusCode == HTTPResponseCodes.SUCCESS {
                    let modelReturn = try JSONDecoder().decode(SeriesResponse.self, from: data)
                    return modelReturn
                }
            }
        } catch {
            print("---> error: \(error)")
        }
        
        return nil
    }
    
}
