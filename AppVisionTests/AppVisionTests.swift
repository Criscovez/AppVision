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
        
        let hvm = HerosViewModel(useCaseHeros: UseCaseHeros())
        
        XCTAssertNotNil(hvm)
        
       
        //  await  hvm.getHeros()
        
        XCTAssertEqual(hvm.heros.count, 3)
        
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
