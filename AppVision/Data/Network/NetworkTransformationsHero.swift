//
//  NetworkTransformationsHero.swift
//  AppVision
//
//  Created by Cristian Contreras Velásquez on 11-06-24.
//

import Foundation

//Protocolo
 protocol NetworkTransformationsHeroProtocol {
     func getHerosTransformation(idHero: String) async -> [HerosTransformationsModelResponse]
}


public final class NetworkTransformationsHero: NetworkTransformationsHeroProtocol{
    public init(){}
    
    public func getHerosTransformation(idHero: String) async -> [HerosTransformationsModelResponse] {
        var modelReturn = [HerosTransformationsModelResponse]()
        
        let urlCad : String = "\(ConstantsLibrary.CONST_API_URL)\(EndPoints.tranformations.rawValue)"
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
                    modelReturn = try! JSONDecoder().decode([HerosTransformationsModelResponse].self, from: data)
                }
            }
            
        }catch{
            
        }
        
        return modelReturn
    }
}



public final class NetworkTransformationsHeroFake: NetworkTransformationsHeroProtocol{
    public init(){}
    
    public func getHerosTransformation(idHero: String) async -> [HerosTransformationsModelResponse] {
        
        let model1 = HerosTransformationsModelResponse(id: UUID(), name: "Transformacion 1", description: "Transformacion de Test de datos 1 de cualquier heroe", photo: "https://areajugones.sport.es/wp-content/uploads/2021/05/ozarru.jpg.webp")
        let model2 = HerosTransformationsModelResponse(id: UUID(), name: "Transformacion 2", description: "Transformacion de Test de datos 2 de cualquier heroe", photo: "https://areajugones.sport.es/wp-content/uploads/2017/05/Goku_Kaio-Ken_Coolers_Revenge.jpg")
        let model3 = HerosTransformationsModelResponse(id: UUID(), name: "Transformacion 3", description: "Transformacion de Test de datos 3 de cualquier heroe", photo: "https://areajugones.sport.es/wp-content/uploads/2021/05/wp4113614.jpg.webp")
        
        return [model1, model2, model3]
    }
}
