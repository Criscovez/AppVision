//
//  NetworkHeros.swift
//  AppVision
//
//  Created by Cristian Contreras Velásquez on 15-06-24.
//

import Foundation

//Protocolo
public protocol NetworkHerosProtocol {
    func getHeros(firstLetter: String) async -> HeroesResponse?
}


final class NetworkHeros: NetworkHerosProtocol{
    
    
    public init(){}
    
    
    func getHeros(firstLetter: String) async -> HeroesResponse? {
        
        
        do {
            let (data, response) = try await URLSession.shared.data(for: BaseNetwork().getSessionHeros(firstLetter: firstLetter))
            
            if let resp = response as? HTTPURLResponse {
                if resp.statusCode == HTTPResponseCodes.SUCCESS {
                    let modelReturn = try JSONDecoder().decode(HeroesResponse.self, from: data)
                    return modelReturn
                }
            }
            
        } catch {
            
            print("---> error: \(error)")
            
        }
        
        return nil
    }
    

}
    final class NetworkHerosFake: NetworkHerosProtocol{
        public init(){}
        public func getHeros(firstLetter: String) async -> HeroesResponse?{

            let hero1 = HeroeResult(id: 1, name: "Hit-Monkey", resultDescription: "", modified: "", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/6/30/4ce69c2246c21", thumbnailExtension: "jpg"))
            
            let hero2 = HeroeResult(id: 2, name: "Ghost Rider (Robbie Reyes)", resultDescription: "", modified: "", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/1/10/622795c13e687", thumbnailExtension: "jpg"))
            
            let hero3 = HeroeResult(id: 3, name: "Attuma", resultDescription: "", modified: "", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/9/90/4ce5a862a6c48", thumbnailExtension: "jpg"))

            return HeroesResponse(code: 1, data: HeroesData(results: [hero1, hero2, hero3]))
           
        }
    }

