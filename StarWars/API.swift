//
//  API.swift
//  StarWars
//
//  Created by Zef Houssney on 10/10/22.
//

import Foundation

class API {
    enum APIError: Error {
        case SomethingWentWrong
    }

    enum Environment: String {
        case staging
        case production = "www"
    }

    enum Paths: String {
        case people = "/people"
        case planets = "/planets"
        case starships = "/starships"
    }

    static var environment: Environment {
        return .staging
    }

    static var apiKey: String {
        // read this from secrets.yml
        return ""
    }

    static var url: String {
        "http://\(environment.rawValue).omdbapi.com/?apikey=\(apiKey)&"
    }

    static func fetchPeople(completion: (Result<[Person], APIError>) -> Void) {
        fetchJSON(path: Paths.people.rawValue) { result in
            switch result {
            case .success(let data):
                // here we would iterate over the data and instantiate people
                //                Person.fromJSON(data: data)
                print("success")
            case .failure(let error):
                print("Got an error \(error)")
            }
        }
    }

    static func fetchJSON(path: String, completion: (Result<Data, APIError>) -> Void) {
        // make the request
    }
}
