//
//  HerosViewModelx.swift
//  AppVision
//
//  Created by Cristian Contreras Velásquez on 11-06-24.
//

import Foundation

final class HerosViewModelx: ObservableObject {
    @Published var heros: [HeroeResult] = []
    @Published var series: [SerieResult] = []


    var mocked: Bool = false //para saber si estoy en modo Mockeado
    
    init(mocked : Bool = false){
        self.mocked = mocked
    }
    init() {
 
        
        Task {
            await getHeros(firstLetter: "a")
        }
    }
    
    func getHeros(firstLetter: String) async {
        
        //mockeado
        if self.mocked{
            getHerosMock()
            return
        }

        do {
            let (data, response) = try await URLSession.shared.data(for: BaseNetwork().getSessionHeros(firstLetter: firstLetter))
            
            if let resp = response as? HTTPURLResponse {
                if resp.statusCode == HTTPRresponseCodes.SUCESS {
                                let modelReturn = try JSONDecoder().decode(HeroesResponse.self, from: data)
                                Task{@MainActor in
                                    heros = modelReturn.data.results
                                }
                }
            }

        } catch {

            print("---> error: \(error)")
            
        }
    }
    
    func getSeries(HeroID: String) async {
        
        //mockeado
//        if self.mocked{
//            getSeriesMock()
//            return
//        }
        print(HeroID)
        do {
            let (data, response) = try await URLSession.shared.data(for: BaseNetwork().getSessionSeries(HeroID: HeroID))
            
            if let resp = response as? HTTPURLResponse {
                if resp.statusCode == HTTPRresponseCodes.SUCESS {
                    let modelReturn = try JSONDecoder().decode(SeriesResponse.self, from: data)
                    Task{@MainActor in
                        series = (modelReturn.data.results)
                    }
                }
            }
        } catch {
            print("---> error: \(error)")
        }
    }

    func getHerosMock(){
        //mockear los modelos.
        
        let comicItem1 = ComicsItem(resourceURI: "", name: "")
        
        let comicItem2 = ComicsItem(resourceURI: "", name: "")
        
        let comics1 = Comics(available: 1, collectionURI: "", items:[comicItem1, comicItem2], returned: 1)
        
        let comics2 = Comics(available: 2, collectionURI: "", items:[comicItem1, comicItem2], returned: 2)
        
        let hero1 = HeroeResult(id: 1, name: "Hit-Monkey", resultDescription: "", modified: "", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/6/30/4ce69c2246c21", thumbnailExtension: "jpg"), resourceURI: "", comics: comics1, series: comics1, stories: Stories(available: 1, collectionURI: "", items: [StoriesItem(resourceURI: "", name: "", type: "")], returned: 1), events: comics1, urls: [])
        
        let hero2 = HeroeResult(id: 2, name: "Ghost Rider (Robbie Reyes)", resultDescription: "", modified: "", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/1/10/622795c13e687", thumbnailExtension: "jpg"), resourceURI: "", comics: comics1, series: comics1, stories: Stories(available: 1, collectionURI: "", items: [StoriesItem(resourceURI: "", name: "", type: "")], returned: 1), events: comics1, urls: [])
        
        let hero3 = HeroeResult(id: 3, name: "Attuma", resultDescription: "", modified: "", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/9/90/4ce5a862a6c48", thumbnailExtension: "jpg"), resourceURI: "", comics: comics1, series: comics1, stories: Stories(available: 1, collectionURI: "", items: [StoriesItem(resourceURI: "", name: "", type: "")], returned: 1), events: comics1, urls: [])


        self.heros = [hero1, hero2, hero3]
        
    }
    
}
