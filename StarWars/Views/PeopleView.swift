//
//  PeopleView.swift
//  StarWars
//
//  Created by Zef Houssney on 9/28/22.
//

import SwiftUI

struct PeopleView: View {

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
            NavigationView {
                List(people) { person in
                    NavigationLink {
                        PersonView(viewModel: PersonView.ViewModel(person: person))
                    } label: {
                        Text(person.name)
                    }
                }
                .navigationTitle("People")
            }
        }
    }
}

struct PeopleView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleView()
    }
}
