//
//  ContentView.swift
//  StarWars
//
//  Created by Zef Houssney on 9/28/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            if let luke = Person.luke {
                Text("Hello, \(luke.name)!")
            } else {
                Text("No person found.")
            }
        }
        .padding()
        .onAppear() {
            API.fetchPeople { result in
                print("Done fetching")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
