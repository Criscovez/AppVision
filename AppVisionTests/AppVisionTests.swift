//
//  AppVisionTests.swift
//  AppVisionTests
//
//  Created by Cristian Contreras Velásquez on 09-06-24.
//

import XCTest
@testable import AppVision
import SwiftUI
import ViewInspector
import UIKit


class AppVisionTests: XCTestCase {
    
    func testBaseNetwork() {
        let sessionHeros = BaseNetwork().getSessionHeros().url
        XCTAssertEqual(sessionHeros, URL(string: "https://gateway.marvel.com/v1/public/characters?apikey=4c64c5a2e16fb54ba9b851005b3d85fb&ts=1&hash=09a08b86af7b3f5c25391bbf70249b8e&orderBy=name&limit=100"))
        
        XCTAssertEqual(BaseNetwork().getSessionHeros().httpMethod, HTTPMethods.get)
        
        XCTAssertNoThrow(BaseNetwork().getSessionHeros())
        
        let sessionSeries = BaseNetwork().getSessionSeries(HeroID: "12345").url
        XCTAssertEqual(sessionSeries, URL(string: "https://gateway.marvel.com/v1/public/characters/12345/series?apikey=4c64c5a2e16fb54ba9b851005b3d85fb&ts=1&hash=09a08b86af7b3f5c25391bbf70249b8e&orderBy=startYear"))
        
        XCTAssertEqual(BaseNetwork().getSessionSeries(HeroID: "12345").httpMethod, HTTPMethods.get)
        
        XCTAssertNoThrow(BaseNetwork().getSessionSeries(HeroID: "12345"))
    }
    
    func testHerosViewModel() async {
        
        let hvm = HerosViewModel(useCaseHeros: UseCaseHerosFake())
        
        XCTAssertNotNil(hvm)
        
       
        await  hvm.getHerosMock(firstLetter: "a", filter: "a")
        
        XCTAssertEqual(hvm.heros.count, 1)
        
        await  hvm.getSeriesMock(HeroID: "1")
        
        XCTAssertEqual(hvm.heros.count, 1)
 
    }
    

    
    func testNetworkHeros() async throws {
        let obj1 = NetworkHeros()
        XCTAssertNotNil(obj1)
        let obj2 = NetworkHerosFake()
        XCTAssertNotNil(obj2)
        
        let heroFake = await obj2.getHeros(firstLetter: "a")
        XCTAssertNotEqual(heroFake?.data.results.count, 0)
        
        let hero = await obj1.getHeros(firstLetter: "a")
        XCTAssertEqual(hero?.data.results.count, 84)
    }
    
    func testNetworkSeries() async throws {
        let obj1 = NetworkSeries()
        XCTAssertNotNil(obj1)
        let obj2 = NetworkSeriesFake()
        XCTAssertNotNil(obj2)
        
        let heroFake = await obj2.getSeries(HeroID: "1")
        XCTAssertNotEqual(heroFake?.data.results.count, 0)
        
        let hero = await obj1.getSeries(HeroID: "1017100")
        XCTAssertEqual(hero?.data.results.count, 2)
    }
    func testUseCaseHeros() async throws {
        let usecase = UseCaseHerosFake()
        XCTAssertNotNil(usecase)
        
        let data = await usecase.getHerosData(firstLetter: "a", filter: "a")
        XCTAssertNotNil(data)
        XCTAssertEqual(data.count,3)
        
        let data2 = await usecase.getSeriesData(HeroID: "1")
        XCTAssertNotNil(data2)
        XCTAssertEqual(data2.count,2)
    }
    
}
