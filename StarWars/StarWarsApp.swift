//
//  StarWarsApp.swift
//  StarWars
//
//  Created by Zef Houssney on 9/28/22.
//

import SwiftUI

@main
struct StarWarsApp: App {
    var body: some Scene {
        WindowGroup {
            PeopleView()
        }
    }

    static var isDebug: Bool {
        #if DEBUG
            return true
        #else
            return false
        #endif
    }

    static var chaosMonkeyEnabled: Bool {
        return isDebug && true
    }

    // Failing 10% of api calls in Development mode, if enabled
    static var failAPICalls: Bool {
        guard chaosMonkeyEnabled else { return false }
        return Int.random(in: 0..<100) > 90
    }
}
