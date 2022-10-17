//
//  Person.swift
//  StarWars
//
//  Created by Zef Houssney on 9/28/22.
//

import Foundation

struct Person: Codable {
    var name: String
//    var height: S?
//    var mass: Int?

    static var luke: Person? {
        Person.fromJSONFile(named: "luke")
    }

    static func fromJSONFile(named name: String) -> Person? {
        if let data = Data.fromJSONFile(forName: name) {
            return try? Person.decodeJSON(from: data)
        }
        return nil
    }
}
