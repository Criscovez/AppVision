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
        
        //get Heros
        let heros = await NetWorkHeros.getHeros(firstLetter: firstLetter)
        
        herosFinal = (heros?.data.results)!
        

        return herosFinal
    }
    
    public func getSeriesData(HeroID: String) async -> [SerieResult] {
        var seriesFinal = [SerieResult]()
        
        //get Series
        let series = await NetWorkSeries.getSeries(HeroID: HeroID)
        
        seriesFinal = (series?.data.results)!

        return seriesFinal
    }
   
}

public final class UseCaseHerosFake: UseCaseHerosProtocol{

    
    let NetWorkHeros = NetworkHerosFake()
    let NetWorkSeries = NetworkSeriesFake()

    
    public init(){}
    
    public func getHerosData(firstLetter: String, filter: String) async -> [HeroeResult] {
        var herosFinal = [HeroeResult]()
        
        //get Heros
        let heros = await NetWorkHeros.getHeros(firstLetter: firstLetter)
        
        herosFinal = (heros?.data.results)!
        

        return herosFinal
    }
    
    public func getSeriesData(HeroID: String) async -> [SerieResult] {
        var seriesFinal = [SerieResult]()
        
        //get Series
        let series = await NetWorkSeries.getSeries(HeroID: HeroID)
        
        seriesFinal = (series?.data.results)!

        return seriesFinal
    }

}


