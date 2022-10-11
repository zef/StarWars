//
//  API.swift
//  StarWars
//
//  Created by Zef Houssney on 10/10/22.
//

import Foundation

class API {
    enum APIError: Error {
        case fetchError
        case decodingError
        case notImplemented
    }

    enum Environment: String {
        case staging
        case production = "www"
    }

    enum Path: String {
        case people
        case planets
        case starships

        var url: URL {
            API.url.appending(component: self.rawValue)
        }
    }

    static var environment: Environment {
        return .staging
    }

    static var apiKey: String {
        // read this from secrets.yml
        return ""
    }

    static var url: URL {
        // Use SWAPI, URL, and error handle the URL creation.
        guard let url = URL(string: "https://swapi.dev/api/") else {
            preconditionFailure("Could not instantiate URL!")
        }
        return url
    }

    static func fetchPeople(completion: (Result<[Person], APIError>) -> Void) {
        fetchJSON(path: .people) { result in
            switch result {
            case .success(let data):
                // Decoding collection:
                do {
                    let people = try Person.decodeJSONCollection(from: data)
                    completion(.success(people))
                } catch let error {
                    print("Could not decode collection.", error)
                    completion(.failure(.decodingError))
                }
                print("success")
            case .failure(let error):
                // Handle HTTP failure:
                print("Error occurred when fetching people.", error)
                completion(.failure(.fetchError))
            }
        }
    }

    static func fetchJSON(path: Path, completion: (Result<Data, APIError>) -> Void) {
        print("Path URL: \(path.url)")
        // make the request
        completion(.failure(.notImplemented))
    }
}

extension Decodable {
    static func decodeJSON(from data: Data) throws -> Self {
        return try JSONDecoder().decode(Self.self, from: data)
    }

    static func decodeJSONCollection(from data: Data) throws -> [Self] {
        return try JSONDecoder().decode([Self].self, from: data)
    }
}
