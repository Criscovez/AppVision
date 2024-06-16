//
//  HerosModel.swift
//  AppVision
//
//  Created by Cristian Contreras Velásquez on 11-06-24.
//

import Foundation


public struct HeroesResponse: Decodable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: HeroesData
}

public struct HeroesData: Decodable {
    let offset, limit, total, count: Int
    let results: [HeroeResult]
}

public struct HeroeResult: Identifiable, Decodable, Hashable {
    
    public  let id: Int
    let name, resultDescription: String
    let modified: String
    let thumbnail: Thumbnail
    let resourceURI: String
    let comics, series: Comics
    let stories: Stories
    let events: Comics
    let urls: [URLElement]
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case resultDescription = "description"
        case modified, thumbnail, resourceURI, comics, series, stories, events, urls
    }
    
    public static func ==(lhs: HeroeResult, rhs: HeroeResult) -> Bool {
        return lhs.id == rhs.id
    }
    
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    
}

public struct Comics: Decodable {
    let available: Int
    let collectionURI: String
    let items: [ComicsItem]
    let returned: Int
}

public struct ComicsItem: Identifiable, Decodable {
    public let id = UUID()
    let resourceURI: String
    let name: String
}

public struct Stories: Decodable {
    let available: Int
    let collectionURI: String
    let items: [StoriesItem]
    let returned: Int
}

struct StoriesItem: Identifiable, Decodable {
    let id = UUID()
    let resourceURI: String
    let name: String
    let type: String
}

public struct Thumbnail: Codable {
    let path: String
    let thumbnailExtension: String
    
    func Image() -> String {
        return path + "." + thumbnailExtension
    }
    
    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

public struct URLElement: Identifiable, Codable {
    public let id = UUID()
    let type: String
    let url: String
}

public struct SeriesResponse: Decodable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: SeriesData
}

public struct SeriesData: Decodable {
    let offset, limit, total, count: Int
    let results: [SerieResult]
}

public struct SerieResult: Identifiable, Codable  {
    public let id: Int
    let title: String
    let description: String?
    let thumbnail: Thumbnail
}

public struct Characters: Codable {
    let available: Int
    let collectionURI: String
    let items: [CharactersItem]
    let returned: Int
}

public struct CharactersItem: Codable {
    let resourceURI: String
    let name: String
}

public struct Creators: Codable {
    let available: Int
    let collectionURI: String
    let items: [CreatorsItem]
    let returned: Int
}

public struct CreatorsItem: Codable {
    let resourceURI: String
    let name, role: String
}

enum TypeEnum: String, Codable {
    case cover = "cover"
    case interiorStory = "interiorStory"
}


public struct HeroeData: Codable, Identifiable , Hashable {
    
    public let id: Int
    public let description: String
    public let image: String
    public let name: String
    public let series: [SerieResult]

    
    
    public init(id: Int, description: String, image: String, name: String, series: [SerieResult]) {
        
        self.id = id
        self.description = description
        self.image = image
        self.name = name
        self.series = series

    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public static func ==(lhs: HeroeData, rhs: HeroeData) -> Bool {
        return lhs.id == rhs.id
    }
    
}
