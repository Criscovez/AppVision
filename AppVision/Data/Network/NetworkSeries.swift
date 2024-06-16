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
    
    func getSeries(HeroID: String) async -> SeriesResponse? {
        
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
final class NetworkSeriesFake: NetworkSeriesProtocol{

    public init(){}
    
    func getSeries(HeroID: String) async -> SeriesResponse? {
        //mockear los modelos.
        
        let series1 = SerieResult(id: 1, title: "Captain America (2018 - 2022)", description: "the Captain",  thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/9/a0/5b34097c5ea9d", thumbnailExtension: "jpg"))
        
        let series2 = SerieResult(id: 2, title: "Betsy Braddock: Captain Britain (2023)", description: "THE CAPTAIN COMES HOME! And she's got a whole new mission! With Otherworld settled, Braddock Manor restored, and her brother Captain Avalon at her side, you'd think things look pretty good for Betsy Braddock. Only it turns out, good ole Britain doesn't want her back. No one wants a mutant menace carrying the shield of Captain Britain, and Betsy's made more than a few enemies along her way. Quest-less and country-less, Betsy must define a role for herself. A fresh take on a beloved character, don't miss the latest Tini Howard extravaganza and fan-favorite artist Vasco Georgiev's Marvel debut!",  thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/30/63ee552a1fee1", thumbnailExtension: "jpg"))
        
        return SeriesResponse(code: 1, status: "", copyright: "", attributionText: "", attributionHTML: "", etag: "", data: SeriesData(offset: 1, limit: 1, total: 1, count: 1, results: [series1, series2]))
        
        
    }
}

