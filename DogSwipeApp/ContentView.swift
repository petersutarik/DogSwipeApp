import SwiftUI

struct ContentView: View {
    @State private var dogs = DogCard.sampleDogs

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.purple.opacity(0.3), Color.blue.opacity(0.3)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 30) {
                Text("Hello World")
                    .font(.system(size: 48, weight: .bold, design: .rounded))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.purple, .blue],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .padding(.top, 60)

                Text("Swipe the Pups!")
                    .font(.system(size: 24, weight: .medium, design: .rounded))
                    .foregroundColor(.secondary)

                Spacer()

                ZStack {
                    if dogs.isEmpty {
                        VStack(spacing: 20) {
                            Image(systemName: "pawprint.fill")
                                .font(.system(size: 80))
                                .foregroundColor(.gray.opacity(0.5))

                            Text("No more dogs!")
                                .font(.system(size: 28, weight: .semibold, design: .rounded))
                                .foregroundColor(.secondary)

                            Button(action: resetDogs) {
                                Text("Reset")
                                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 40)
                                    .padding(.vertical, 16)
                                    .background(
                                        LinearGradient(
                                            colors: [.purple, .blue],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .cornerRadius(25)
                            }
                            .padding(.top, 10)
                        }
                        .transition(.scale.combined(with: .opacity))
                    } else {
                        ForEach(dogs) { dog in
                            SwipeableCardView(dog: dog) {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                    if let index = dogs.firstIndex(where: { $0.id == dog.id }) {
                                        dogs.remove(at: index)
                                    }
                                }
                            }
                        }
                    }
                }
                .frame(height: 450)

                Spacer()

                HStack(spacing: 16) {
                    Image(systemName: "arrow.left")
                        .font(.title3)
                    Text("Swipe left or right")
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                    Image(systemName: "arrow.right")
                        .font(.title3)
                }
                .foregroundColor(.secondary)
                .padding(.bottom, 40)
            }
        }
    }

    private func resetDogs() {
        withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
            dogs = DogCard.sampleDogs
        }
    }
}

#Preview {
    ContentView()
}
