//
//  ContentView.swift
//  StarWars
//
//  Created by Zef Houssney on 9/28/22.
//

import SwiftUI

struct ContentView: View {

    @State var people = [Person]()

    var body: some View {
        if people.isEmpty {
            Text("loading people...")
            .onAppear() {
                API.fetchPeople { result in
                    switch result {
                    case .success(let people):
                        self.people = people
                    case .failure(let error):
                        print("Fetching people failed.", error)
                    }
                }
            }
        } else {
            List(people) { person in
                Text(person.name)
            }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
