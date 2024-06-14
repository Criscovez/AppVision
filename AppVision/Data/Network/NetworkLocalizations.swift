//
//  NetworkLocalizations.swift
//  AppVision
//
//  Created by Cristian Contreras Velásquez on 11-06-24.
//

import Foundation


//Protocolo
public protocol NetworkLocalizationsProtocol {
     func getHerosLocalizations(idHero: String) async -> [HerosLocationsModelResponse]
}


public final class NetworkLocalizations: NetworkLocalizationsProtocol{
    public init(){}
    
    public func getHerosLocalizations(idHero: String) async -> [HerosLocationsModelResponse] {
        var modelReturn = [HerosLocationsModelResponse]()
        
        let urlCad : String = "\(ConstantsLibrary.CONST_API_URL)\(EndPoints.locations.rawValue)"
        var request : URLRequest = URLRequest(url: URL(string: urlCad)!)
        request.httpMethod = HTTPMethods.post
        request.httpBody = try? JSONEncoder().encode(HeroTransformationsMOdelRequest(id: idHero))
        request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-type")
    
        //Token JWT (habría que extraer de aqui) a algo generico o interceptor
        let JwtToken =  KeyChainKC().loadKC(key: ConstantsLibrary.CONST_TOKEN_ID_KEYCHAIN)
        if let tokenJWT = JwtToken{
            request.addValue("Bearer \(tokenJWT)", forHTTPHeaderField: "Authorization") //Token
        }
        
        //Call to server
        
        do{
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let resp = response  as? HTTPURLResponse {
                if resp.statusCode == HTTPResponseCodes.SUCCESS {
                    modelReturn = try! JSONDecoder().decode([HerosLocationsModelResponse].self, from: data)
                }
            }
            
        }catch{
            
        }
        
        return modelReturn
    }
}


public final class NetworkLocalizationsFake: NetworkLocalizationsProtocol{
    public init(){}
    
    public func getHerosLocalizations(idHero: String) async -> [HerosLocationsModelResponse] {
       
        //return same always
            
       let model1 = HerosLocationsModelResponse(longitud: "-3.2530422156686045", latitud: "40.596325093190096", id: UUID())
       let model2 = HerosLocationsModelResponse(longitud: "-3.6892525805372927", latitud: "40.42782823915867", id: UUID())
       
    
        return [model1, model2]
    }
}
