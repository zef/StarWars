//
//  API.swift
//  StarWars
//
//  Created by Zef Houssney on 10/10/22.
//

import Foundation

class API {
    enum APIError: Error {
        case decodingError
        case networkError(Error)
        case unknownError
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

    static func fetchPeople(completion: @escaping (Result<[Person], APIError>) -> Void) {
        fetchJSON(path: .people) { result in
            switch result {
            case .success(let data):
                do {
                    if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                       let resultData = try? JSONSerialization.data(withJSONObject: json["results"]) {
                        let people = try Person.decodeJSONCollection(from: resultData)
                        completion(.success(people))
                    }
                } catch let error {
                    print("Could not decode collection.", error)
                    completion(.failure(.decodingError))
                }
                print("success")
            case .failure(let error):
                // Handle HTTP failure:
                print("Error occurred when fetching people.", error)
                completion(.failure(.networkError(error)))
            }
        }
    }

    static func fetchJSON(path: Path, completion: @escaping (Result<Data, APIError>) -> Void) {
        let session = URLSession.shared
        let request = URLRequest(url: path.url)
        // add headers to request here, if needed
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                if let error = error {
                    print("Error occurred when fetching json.", error)
                    completion(.failure(.networkError(error)))
                } else {
                    assertionFailure("Unexpected codepath.")
                    completion(.failure(.unknownError))
                }
                return
            }
            completion(.success(data))
        }
        task.resume()
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
