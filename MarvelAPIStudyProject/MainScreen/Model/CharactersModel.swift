//
//  CharactersModel.swift
//  MarvelAPIStudyProject
//
//  Created by Felipe Lima de Carvalho (P) on 14/12/21.
//

import UIKit

// MARK: - ReturnApi
struct ReturnApi: Decodable {
    let copyright, attributionText: String
    let code : Int
    let attributionHTML: String
    let data: DataClass
    let etag: String
}

// MARK: - DataClass
struct DataClass: Decodable {
    let offset, limit, total, count: Int
    let results: [Result]
}

// MARK: - Result
struct Result: Decodable {
    let id: Int
    let modified, name, resourceURI, description: String
    let thumbnail: Thumbnail
    
    enum CodingKeys: String, CodingKey{
        case id
        case modified, name, resourceURI, thumbnail, description
    }
}

struct Thumbnail: Decodable {
   let path: String
    
   enum CodingKeys: String, CodingKey{
       case path
   }
}

