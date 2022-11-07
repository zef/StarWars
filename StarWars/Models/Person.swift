//
//  Person.swift
//  StarWars
//
//  Created by Zef Houssney on 9/28/22.
//

import Foundation
struct Person: Codable {
    var name: String
    var height: Int?
    var mass: Int?
    var hairColor: String

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)

        if let heightString = try container.decodeIfPresent(String.self, forKey: .height) {
            self.height = Int(heightString)
        }
        if let massString = try container.decodeIfPresent(String.self, forKey: .mass) {
            self.mass = Int(massString)
        }
        self.hairColor = try container.decode(String.self, forKey: .hairColor)
    }


    static var luke: Person? {
        Person.fromJSONFile(named: "luke")
    }
}

extension Person: Identifiable {
    var id: String {
        name
    }
}
