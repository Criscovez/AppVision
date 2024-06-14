//
//  UseCaseHeros.swift
//  AppVision
//
//  Created by Cristian Contreras Velásquez on 11-06-24.
//

import Foundation

//Protocolo
public protocol UseCaseHerosProtocol {
     func getData(filter: String) async -> [HerosData]
}


public final class UseCaseHeros: UseCaseHerosProtocol{
    let NetWorkHeros = NetworkHeros()
    let NetworkTrans = NetworkTransformationsHero()
    let NetworkLocals = NetworkLocalizations()
    
    public init(){}
    
    public func getData(filter: String = "") async -> [HerosData] {
        var herosFinal = [HerosData]()
        
        //get The Heros
        let heros = await NetWorkHeros.getHeros(filter: filter)
        
        //For Each hero, call to LOcations and transformations
        for hero in heros {
            //Tranformations of Hero
            let trans = await NetworkTrans.getHerosTransformation(idHero: hero.id.uuidString)
            
            //Locations of Hero
            let locals = await NetworkLocals.getHerosLocalizations(idHero: hero.id.uuidString)
            
            
            //Generate final Model and add to Array
            
            let HeroFin  = HerosData(id: hero.id, favorite: hero.favorite, description: hero.description, photo: hero.photo, name: hero.name, locations: locals, transformations: trans)
            herosFinal.append(HeroFin)
            
            
        }
        
        return herosFinal
    }
}



public final class UseCaseHerosFake: UseCaseHerosProtocol{
    let NetWorkHeros = NetworkHerosFake()
    let NetworkTrans = NetworkTransformationsHeroFake()
    let NetworkLocals = NetworkLocalizationsFake()
    
    public init(){}
    
    public func getData(filter: String = "") async -> [HerosData] {
        var herosFinal = [HerosData]()
        
        //get The Heros
        let heros = await NetWorkHeros.getHeros(filter: filter)
        
        //For Each hero, call to LOcations and transformations
        for hero in heros {
            //Tranformations of Hero
            let trans = await NetworkTrans.getHerosTransformation(idHero: hero.id.uuidString)
            
            //Locations of Hero
            let locals = await NetworkLocals.getHerosLocalizations(idHero: hero.id.uuidString)
            
            
            //Generate final Model and add to Array
            
            let HeroFin  = HerosData(id: hero.id, favorite: hero.favorite, description: hero.description, photo: hero.photo, name: hero.name, locations: locals, transformations: trans)
            herosFinal.append(HeroFin)
            
            
        }
        
        return herosFinal
    }
}
