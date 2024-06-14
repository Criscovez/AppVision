//
//  Models.swift
//  AppVision
//
//  Created by Cristian Contreras Velásquez on 09-06-24.
//

import Foundation

//Status App.
enum Status {
    case none, loaded, error(error: String)
}

public struct HerosModelResponse: Codable, Identifiable {
    public let id: UUID
    public let favorite: Bool
    public let description: String
    public let photo: String
    public let name: String
}


//Filter the request od Heros by name
public struct HeroModelRequest: Codable {
    public let name: String
}



public struct HerosLocationsModelResponse: Codable, Identifiable {
    public let longitud: String
    public let latitud: String
    public let id: UUID
}


public struct HerosTransformationsModelResponse: Codable, Identifiable {
    public let id: UUID
    public let name: String
    public let description: String
    public let photo: String
}
public struct HeroTransformationsMOdelRequest: Codable {
    public let id: String
}


// Models to TRANSFORM

public struct HerosData: Codable, Identifiable , Hashable {
    public let id: UUID
    public let favorite: Bool
    public let description: String
    public let photo: String
    public let name: String
    public let locations: [HerosLocationsModelResponse]
    public let transformations: [HerosTransformationsModelResponse]
    public let id3DModel: String
    
    
    public init(id: UUID, favorite: Bool, description: String, photo: String, name: String, locations: [HerosLocationsModelResponse], transformations: [HerosTransformationsModelResponse], id3DModel: String = "") {
        
        self.id = id
        self.favorite = favorite
        self.description = description
        self.photo = photo
        self.name = name
        self.locations = locations
        self.transformations = transformations
        
        //goku
        if id.uuidString == "D13A40E5-4418-4223-9CE6-D2F9A28EBE94"{
            self.id3DModel = "goku"
        }
        else if id.uuidString == "6E1B907C-EB3A-45BA-AE03-44FA251F64E9"{
            self.id3DModel = "Vegeta"
        } else{
            self.id3DModel = id3DModel
        }
    }
    
    
    // Implementing Hashable protocol
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    // Implementing Equatable protocol
    public static func ==(lhs: HerosData, rhs: HerosData) -> Bool {
        return lhs.id == rhs.id
    }
    
    
    
    //Mock a Hero
    public static func getHeroMock() -> HerosData{
       
        //locations
        let model1L = HerosLocationsModelResponse(longitud: "-3.2530422156686045", latitud: "40.596325093190096", id: UUID())
        let model2L = HerosLocationsModelResponse(longitud: "-3.6892525805372927", latitud: "40.42782823915867", id: UUID())
        
        //Transformations
        
        let model1T = HerosTransformationsModelResponse(id: UUID(), name: "Transformacion 1", description: "Transformacion de Test de datos 1 de cualquier heroe", photo: "https://areajugones.sport.es/wp-content/uploads/2021/05/ozarru.jpg.webp")
        let model2T = HerosTransformationsModelResponse(id: UUID(), name: "Transformacion 2", description: "Transformacion de Test de datos 2 de cualquier heroe", photo: "https://areajugones.sport.es/wp-content/uploads/2017/05/Goku_Kaio-Ken_Coolers_Revenge.jpg")
        let model3T = HerosTransformationsModelResponse(id: UUID(), name: "Transformacion 3", description: "Transformacion de Test de datos 3 de cualquier heroe", photo: "https://areajugones.sport.es/wp-content/uploads/2021/05/wp4113614.jpg.webp")
        
        return  HerosData(id: UUID(uuidString: "D13A40E5-4418-4223-9CE6-D2F9A28EBE94")!, favorite: true, description: "Sobran las presentaciones cuando se habla de Goku. El Saiyan fue enviado al planeta Tierra, pero hay dos versiones sobre el origen del personaje. Según una publicación especial, cuando Goku nació midieron su poder y apenas llegaba a dos unidades, siendo el Saiyan más débil. Aun así se pensaba que le bastaría para conquistar el planeta. Sin embargo, la versión más popular es que Freezer era una amenaza para su planeta natal y antes de que fuera destruido, se envió a Goku en una incubadora para salvarle.", photo: "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/goku1.jpg?width=300", name: "Goku", locations: [model1L, model2L], transformations: [model1T, model2T, model3T])
        
    }
    
    
}
