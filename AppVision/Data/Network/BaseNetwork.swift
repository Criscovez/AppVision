//
//  BaseNetwork.swift
//  AppVision
//
//  Created by Cristian Contreras Velásquez on 11-06-24.
//

import Foundation


let host = "gateway.marvel.com"

struct HTTPMethods {
    static let post = "POST"
    static let get = "GET"
    static let content = "application/json"
}

enum endpoints: String {
    case heros = "/v1/public/characters"
    case series = "/series"

}

//Server Response Codes
struct HTTPRresponseCodes {
    static let SUCESS = 200
    static let NOT_AUTHORIZED = 401
    static let ERROR = 502
}


struct BaseNetwork{
    
    var components = URLComponents()
    
    func getSessionHeros() -> URLRequest {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = endpoints.heros.rawValue
        
        components.queryItems = [
            URLQueryItem(name: "apikey", value: "4c64c5a2e16fb54ba9b851005b3d85fb"),
            URLQueryItem(name: "ts", value: "1"),
            URLQueryItem(name: "hash", value: "09a08b86af7b3f5c25391bbf70249b8e"),
            URLQueryItem(name: "orderBy", value: "name"),
            URLQueryItem(name: "limit", value: "100")
    
            
            
        ]
      
        print(components.string as Any)
        var request = URLRequest(url: URL(string: components.string!)!)
        
        //post
        request.httpMethod = HTTPMethods.get

        return request
    }
    
    func getSessionHeros(firstLetter: String) -> URLRequest {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = endpoints.heros.rawValue
        
        components.queryItems = [
            URLQueryItem(name: "apikey", value: "4c64c5a2e16fb54ba9b851005b3d85fb"),
            URLQueryItem(name: "ts", value: "1"),
            URLQueryItem(name: "hash", value: "09a08b86af7b3f5c25391bbf70249b8e"),
            URLQueryItem(name: "orderBy", value: "name"),
            URLQueryItem(name: "limit", value: "100"),
            URLQueryItem(name: "nameStartsWith", value: firstLetter)
        ]
      
        print(components.string as Any)
        var request = URLRequest(url: URL(string: components.string!)!)
        
        //post
        request.httpMethod = HTTPMethods.get

        return request
    }
    
    func getSessionSeries(HeroID: String) -> URLRequest {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = endpoints.heros.rawValue + "/\(HeroID)" + endpoints.series.rawValue
        
        components.queryItems = [
            URLQueryItem(name: "apikey", value: "4c64c5a2e16fb54ba9b851005b3d85fb"),
            URLQueryItem(name: "ts", value: "1"),
            URLQueryItem(name: "hash", value: "09a08b86af7b3f5c25391bbf70249b8e"),
            URLQueryItem(name: "orderBy", value: "startYear")
            
        ]

        print(components.string as Any)
        var request = URLRequest(url: URL(string: components.string!)!)
        
        //post
        request.httpMethod = HTTPMethods.get

        return request
    }

    
    
    
}
