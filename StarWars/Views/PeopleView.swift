//
//  PeopleView.swift
//  StarWars
//
//  Created by Zef Houssney on 9/28/22.
//

import SwiftUI
import Retry

struct PeopleView: View {

    @State var people = [Person]()
    @State var showAlert = false
    @State var errorMessage: String?

    var body: some View {
        NavigationStack {
            List(people) { person in
                NavigationLink {
                    PersonView(viewModel: PersonView.ViewModel(person: person))
                } label: {
                    Text(person.name)
                }
            }
            .navigationTitle("People")
            .alert("This is bad", isPresented: $showAlert, actions: {
                Button("Try Again", role: .none) {
                    fetchPeople()
                }
                Button("OK", role: .none) {}
            }, message: {
                Text(errorMessage ?? "Not Set")
            })
        }
        .overlay {
            if people.isEmpty {
                Text("Loading people...")
            }
        }
        .onAppear() {
            fetchPeople()
        }
    }

    func fetchPeople() {
        Retry.attempt("Fetch People") { attempt in
            API.fetchPeople { result in
                switch result {
                case .success(let people):
                    self.people = people
                    attempt.success()
                case .failure(let error):
                    print("Failed, might retry.")
                    attempt.failure {
                        errorMessage = error.message
                        showAlert = true
                    }
                }
            }
        }
    }
}

struct PeopleView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleView()
    }
}
