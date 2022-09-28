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
        Person.fromJSON(named: "luke")
    }

    static func fromJSON(named name: String) -> Person? {
        if let data = Data.fromJSONFile(forName: name) {
            let decoder = JSONDecoder()
            do {
                let luke = try decoder.decode(Person.self, from: data)
                return luke
            } catch {
                print("Could not make person from data.", error.localizedDescription)
            }
        }
        return nil
    }
}
