//
//  PersonView.swift
//  StarWars
//
//  Created by Zef Houssney on 10/17/22.
//

import SwiftUI

extension PersonView {
    @MainActor class ViewModel: ObservableObject {
        @Published var person: Person

        init(person: Person) {
            self.person = person
        }
    }
}

struct PersonView: View {
    var viewModel: ViewModel

    var body: some View {
        List {
            if let height = viewModel.person.height {
                metadataRow(label: "Height:", value: "\(height)")
            }
            if let mass = viewModel.person.mass {
                metadataRow(label: "Mass:", value: "\(mass)")
            }
            metadataRow(label: "Height to Weight:", value: String(heightToWeight(person: viewModel.person)))
            metadataRow(label: "Hair Color:", value: viewModel.person.hairColor)
        }
        .navigationTitle(viewModel.person.name)
    }

    func metadataRow(label: String, value: String) -> some View {
        Section {
            Text(value)
        } header: {
            Text(label)
        }
    }

    func heightToWeight(person: Person) -> Float {
        guard let height = person.height, let mass = person.mass else { return 0 }
        return Float(height) / Float(mass)
    }
}

struct PersonView_Previews: PreviewProvider {
    static var previews: some View {
        if let person = Person.luke {
            PersonView(viewModel: PersonView.ViewModel(person: person))
        }
    }
}
