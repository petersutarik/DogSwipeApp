import SwiftUI
import UIKit

struct SwipeableCardView: View {
    let dog: DogCard
    let onRemove: () -> Void

    @State private var offset = CGSize.zero
    @State private var rotation: Double = 0
    @State private var hasTriggeredThresholdHaptic = false

    private let impactLight = UIImpactFeedbackGenerator(style: .light)
    private let impactMedium = UIImpactFeedbackGenerator(style: .medium)
    private let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        colors: [dog.color.opacity(0.6), dog.color],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)

            VStack(spacing: 20) {
                Image(systemName: dog.icon)
                    .font(.system(size: 100))
                    .foregroundColor(.white)
                    .padding(.top, 40)

                VStack(spacing: 8) {
                    Text(dog.name)
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundColor(.white)

                    Text(dog.breed)
                        .font(.system(size: 24, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.9))
                }

                Spacer()

                HStack(spacing: 40) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.white.opacity(offset.width < -20 ? 1 : 0.5))

                    Image(systemName: "heart.circle.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.white.opacity(offset.width > 20 ? 1 : 0.5))
                }
                .padding(.bottom, 40)
            }
        }
        .frame(width: 320, height: 420)
        .offset(offset)
        .rotationEffect(.degrees(rotation))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                    rotation = Double(gesture.translation.width / 20)

                    // Trigger haptic when crossing threshold
                    let swipeThreshold: CGFloat = 100
                    if abs(gesture.translation.width) > swipeThreshold && !hasTriggeredThresholdHaptic {
                        impactMedium.impactOccurred()
                        hasTriggeredThresholdHaptic = true
                    } else if abs(gesture.translation.width) <= swipeThreshold && hasTriggeredThresholdHaptic {
                        hasTriggeredThresholdHaptic = false
                    }

                    // Light haptic for continuous feedback
                    if abs(gesture.translation.width) > 20 {
                        impactLight.impactOccurred(intensity: 0.3)
                    }
                }
                .onEnded { gesture in
                    let swipeThreshold: CGFloat = 100

                    if abs(gesture.translation.width) > swipeThreshold {
                        // Heavy haptic for successful swipe
                        impactHeavy.impactOccurred()

                        // Swipe off screen
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            offset = CGSize(
                                width: gesture.translation.width > 0 ? 500 : -500,
                                height: gesture.translation.height
                            )
                            rotation = Double(gesture.translation.width > 0 ? 30 : -30)
                        }

                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            onRemove()
                        }
                    } else {
                        // Light haptic for snap back
                        impactLight.impactOccurred()

                        // Return to center
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            offset = .zero
                            rotation = 0
                        }
                    }

                    hasTriggeredThresholdHaptic = false
                }
        )
    }
}

#Preview {
    SwipeableCardView(dog: DogCard.sampleDogs[0], onRemove: {})
        .padding()
}
