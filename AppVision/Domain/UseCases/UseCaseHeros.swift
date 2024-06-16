//
//  UseCaseHeros.swift
//  AppVision
//
//  Created by Cristian Contreras Velásquez on 14-06-24.
//

import Foundation



//Protocolo
public protocol UseCaseHerosProtocol {
     func getHerosData(firstLetter: String, filter: String) async -> [HeroeResult]
     func getSeriesData(HeroID: String) async -> [SerieResult]
}


public final class UseCaseHeros: UseCaseHerosProtocol{

    

    
    let NetWorkHeros = NetworkHeros()
    
    let NetWorkSeries = NetworkSeries()

    
    public init(){}
    
    public func getHerosData(firstLetter: String, filter: String = "") async -> [HeroeResult] {
        var herosFinal = [HeroeResult]()
        
        //get The Heros
        let heros = await NetWorkHeros.getHeros(firstLetter: firstLetter)
        
        herosFinal = (heros?.data.results)!
        
        
        
//        for hero in herosFinal {
//            
//            let series = await NetWorkSeries.getSeries(HeroID: String(hero.id))
            
            
            
            
            //Generate final Model and add to Array
            
      //      let HeroFin  = HerosData(id: hero.id, favorite: hero.favorite, description: hero.description, photo: hero.photo, name: hero.name, locations: locals, transformations: trans)
//            herosFinal.append(HeroFin)
//            
            
     //   }
        
        return herosFinal
    }
    
    public func getSeriesData(HeroID: String) async -> [SerieResult] {
        var seriesFinal = [SerieResult]()
        
        //get The Heros
        let series = await NetWorkSeries.getSeries(HeroID: HeroID)
        
        seriesFinal = (series?.data.results)!
        
        
        
//        for hero in herosFinal {
//
//            let series = await NetWorkSeries.getSeries(HeroID: String(hero.id))
            
            
            
            
            //Generate final Model and add to Array
            
      //      let HeroFin  = HerosData(id: hero.id, favorite: hero.favorite, description: hero.description, photo: hero.photo, name: hero.name, locations: locals, transformations: trans)
//            herosFinal.append(HeroFin)
//
            
     //   }
        
        return seriesFinal
    }
   
}



//public final class UseCaseHerosFake: UseCaseHerosProtocol{
////    let NetWorkHeros = NetworkHerosFake()
////    let NetworkTrans = NetworkTransformationsHeroFake()
////    let NetworkLocals = NetworkLocalizationsFake()
//    
//    public init(){}
//    
//    public func getData(filter: String = "") async -> [HerosData] {
//        var herosFinal = [HerosData]()
////        
////        //get The Heros
////        let heros = await NetWorkHeros.getHeros(filter: filter)
////        
////        //For Each hero, call to LOcations and transformations
////        for hero in heros {
////            //Tranformations of Hero
////            let trans = await NetworkTrans.getHerosTransformation(idHero: hero.id.uuidString)
////            
////            //Locations of Hero
////            let locals = await NetworkLocals.getHerosLocalizations(idHero: hero.id.uuidString)
////            
////            
////            //Generate final Model and add to Array
////            
////            let HeroFin  = HerosData(id: hero.id, favorite: hero.favorite, description: hero.description, photo: hero.photo, name: hero.name, locations: locals, transformations: trans)
////            herosFinal.append(HeroFin)
////            
//            
//       // }
//        
//        return herosFinal
//    }
//}
