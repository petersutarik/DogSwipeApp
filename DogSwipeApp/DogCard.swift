import SwiftUI

struct DogCard: Identifiable {
    let id = UUID()
    let name: String
    let breed: String
    let icon: String
    let color: Color
}

extension DogCard {
    static let sampleDogs = [
        DogCard(name: "Buddy", breed: "Golden Retriever", icon: "dog.fill", color: .orange),
        DogCard(name: "Luna", breed: "Husky", icon: "dog.circle.fill", color: .blue),
        DogCard(name: "Max", breed: "German Shepherd", icon: "dog.fill", color: .brown),
        DogCard(name: "Bella", breed: "Poodle", icon: "dog.circle.fill", color: .pink),
        DogCard(name: "Charlie", breed: "Beagle", icon: "dog.fill", color: .purple),
        DogCard(name: "Daisy", breed: "Corgi", icon: "dog.circle.fill", color: .yellow),
        DogCard(name: "Rocky", breed: "Bulldog", icon: "dog.fill", color: .gray),
        DogCard(name: "Molly", breed: "Labrador", icon: "dog.circle.fill", color: .green)
    ]
}
