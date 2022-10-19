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

        var message: String {
            switch self {
            case .decodingError:
                return "Data could not be decoded."
            case .networkError(_):
                return "There was a network problem."
            case .unknownError:
                return "Something went wrong."
            }
        }
    }

    enum Environment: String {
        case staging
        case production = "www"

        var subdomain: String {
            rawValue
        }

        static var current: Self {
            if StarWarsApp.isDebug {
                return .staging
            } else {
                return .production
            }
        }
    }

    enum Path: String {
        case people
        case planets
        case starships

        var url: URL {
            API.url.appending(component: self.rawValue)
        }
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
        guard !StarWarsApp.failAPICalls else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                completion(.failure(.decodingError))
            }
            return
        }
        fetchJSON(path: .people) { result in
            switch result {
            case .success(let data):
                do {
                    if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                       let resultDictionary = json["results"],
                       let resultData = try? JSONSerialization.data(withJSONObject: resultDictionary) {
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
