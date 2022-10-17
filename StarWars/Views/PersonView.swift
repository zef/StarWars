//
//  PersonView.swift
//  StarWars
//
//  Created by Zef Houssney on 10/17/22.
//

import SwiftUI

struct PersonView: View {
    @State var person: Person

    var body: some View {
        List {
            if let height = person.height {
                Section {
                    Text("\(height)")
                } header: {
                    Text("Height:")
                }
            }
            if let mass = person.mass {
                Section {
                    Text("\(mass)")
                } header: {
                    Text("Mass:")
                }
            }
            Section {
                Text(person.hairColor)
            } header: {
                Text("Hair Color:")
            }
        }.navigationTitle(person.name)
    }
}

struct PersonView_Previews: PreviewProvider {
    static var previews: some View {
        if let person = Person.luke {
            PersonView(person: person)
        }
    }
}
