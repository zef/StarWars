//
//  Decodable+.swift
//  StarWars
//
//  Created by Zef Houssney on 10/19/22.
//

import Foundation

extension Decodable {
    static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }

    static func decodeJSON(from data: Data) throws -> Self {
        return try decoder.decode(Self.self, from: data)
    }

    static func decodeJSONCollection(from data: Data) throws -> [Self] {
        return try decoder.decode([Self].self, from: data)
    }
}
