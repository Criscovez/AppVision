//
//  HerosModel.swift
//  AppVision
//
//  Created by Cristian Contreras Velásquez on 11-06-24.
//

import Foundation


struct HeroesResponse: Decodable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: HeroesData
}

struct HeroesData: Decodable {
    let offset, limit, total, count: Int
    let results: [HeroeResult]
}

struct HeroeResult: Identifiable, Decodable, Hashable {

    
//    // Implementing Hashable protocol
//    public func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//    }
    

    
    let id: Int
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
    
    static func ==(lhs: HeroeResult, rhs: HeroeResult) -> Bool {
        return lhs.id == rhs.id
    }
    

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    

}

struct Comics: Decodable {
    let available: Int
    let collectionURI: String
    let items: [ComicsItem]
    let returned: Int
}

struct ComicsItem: Identifiable, Decodable {
    let id = UUID()
    let resourceURI: String
    let name: String
}

struct Stories: Decodable {
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

struct Thumbnail: Decodable {
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

struct URLElement: Identifiable, Decodable {
    let id = UUID()
    let type: String
    let url: String
}

struct SeriesResponse: Decodable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: SeriesData
}

struct SeriesData: Decodable {
    let offset, limit, total, count: Int
    let results: [SerieResult]
}

struct SerieResult: Identifiable, Decodable  {
    let id: Int
    let title: String
    let description: String?
    let resourceURI: String
    let urls: [URLElement]
    let startYear, endYear: Int
    let rating, type, modified: String
    let thumbnail: Thumbnail
    let creators: Creators
    let characters: Characters
    let stories: Stories
    let comics, events: Characters
    //let next, previous: nil
  
}

struct Characters: Codable {
    let available: Int
    let collectionURI: String
    let items: [CharactersItem]
    let returned: Int
}

struct CharactersItem: Codable {
    let resourceURI: String
    let name: String
}

struct Creators: Codable {
    let available: Int
    let collectionURI: String
    let items: [CreatorsItem]
    let returned: Int
}

struct CreatorsItem: Codable {
    let resourceURI: String
    let name, role: String
}

enum TypeEnum: String, Codable {
    case cover = "cover"
    case interiorStory = "interiorStory"
}
