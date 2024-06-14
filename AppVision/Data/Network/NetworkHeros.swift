//
//  NetworkHeros.swift
//  AppVision
//
//  Created by Cristian Contreras Velásquez on 11-06-24.
//

import Foundation

//Protocolo
public protocol NetworkHerosProtocol {
    func getHeros(filter: String) async -> [HerosModelResponse]
}


final class NetworkHeros: NetworkHerosProtocol{
    public init(){}
    
    public func getHeros(filter: String) async -> [HerosModelResponse] {
        var modelReturn = [HerosModelResponse]()
        
        let urlCad : String = "\(ConstantsLibrary.CONST_API_URL)\(EndPoints.heros.rawValue)"
        var request : URLRequest = URLRequest(url: URL(string: urlCad)!)
        request.httpMethod = HTTPMethods.post
        request.httpBody = try? JSONEncoder().encode(HeroModelRequest(name: filter))
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
                    modelReturn = try! JSONDecoder().decode([HerosModelResponse].self, from: data)
                }
            }
            
        }catch{
            
        }
        
        return modelReturn
    }
}



//fake for UI and Tests


final class NetworkHerosFake: NetworkHerosProtocol{
    public init(){}
    public func getHeros(filter: String) async -> [HerosModelResponse]{

        let model1 = HerosModelResponse(id:  UUID(uuidString: "D13A40E5-4418-4223-9CE6-D2F9A28EBE94")!, favorite: true, description: "Sobran las presentaciones cuando se habla de Goku. El Saiyan fue enviado al planeta Tierra, pero hay dos versiones sobre el origen del personaje. Según una publicación especial, cuando Goku nació midieron su poder y apenas llegaba a dos unidades, siendo el Saiyan más débil. Aun así se pensaba que le bastaría para conquistar el planeta. Sin embargo, la versión más popular es que Freezer era una amenaza para su planeta natal y antes de que fuera destruido, se envió a Goku en una incubadora para salvarle.", photo: "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/goku1.jpg?width=300", name: "Goku")
       
        let model2 = HerosModelResponse(id: UUID(uuidString: "6E1B907C-EB3A-45BA-AE03-44FA251F64E9")!, favorite: true, description: "Vegeta es todo lo contrario. Es arrogante, cruel y despreciable. Quiere conseguir las bolas de Dragón y se enfrenta a todos los protagonistas, matando a Yamcha, Ten Shin Han, Piccolo y Chaos. Es despreciable porque no duda en matar a Nappa, quien entonces era su compañero, como castigo por su fracaso. Tras el intenso entrenamiento de Goku, el guerrero se enfrenta a Vegeta y estuvo a punto de morir. Lejos de sobreponerse, Vegeta huye del planeta Tierra sin saber que pronto tendrá que unirse a los que considera sus enemigos.", photo: "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/vegetita.jpg?width=300", name: "Vegeta")
  
        
        return [model1, model2]
    }
}
