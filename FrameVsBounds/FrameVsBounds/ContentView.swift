import SwiftUI

//    1. What is frame and bounds?
//    - Frame: View's position and size in superview's coordinate system.
//    - Bounds: View's internal dimensions in its own coordinate system.
//
//    2. Frame and bounds x,y differ when:
//    - View is rotated/scaled
//    - View is in a scrolling context
//    - Manipulating Core Animation layers
//
//    3. Frame and bounds height/width differ when:
//    - View is rotated
//    - Using scale transforms
//    - View has non-zero contentInset
//    - In scroll views (visible area vs. total size)

struct ContentView: View {
    @State private var rotation: Double = 0
    @State private var frameRect: CGRect = .zero
    @State private var boundsRect: CGRect = .zero
    
    private var outerSquareSize: CGFloat {
        let diagonal = sqrt(2) * 200  // Diagonal of the 200x200 square
        return rotation.truncatingRemainder(dividingBy: 90) == 0 ? 200 : diagonal
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Frame vs Bounds Example")
                .font(.headline)
            
            Button("Rotate 45°") {
                withAnimation {
                    rotation += 45
                }
            }
            
            ZStack {
                // Outer square (frame)
                Rectangle()
                    .fill(Color.blue.opacity(0.3))
                    .frame(width: outerSquareSize, height: outerSquareSize)
                
                // Inner square (bounds)
                Rectangle()
                    .fill(Color.green.opacity(0.7))
                    .frame(width: 200, height: 200)
                    .rotationEffect(.degrees(rotation))
                    .background(
                        GeometryReader { geometry in
                            Color.clear
                                .preference(key: RectPreferenceKey.self, value: RectPreferenceData(
                                    bounds: geometry.frame(in: .local),
                                    frame: geometry.frame(in: .global)
                                ))
                        }
                    )
                    .onPreferenceChange(RectPreferenceKey.self) { rectData in
                        self.boundsRect = rectData.bounds
                        self.frameRect = rectData.frame
                    }
            }
            .frame(width: outerSquareSize, height: outerSquareSize)
            .border(Color.red, width: 2)
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Outer Square (Frame)")
                    .font(.caption)
                Text("Size: \(String(format: "%.1f", outerSquareSize))x\(String(format: "%.1f", outerSquareSize))")
                    .font(.caption)
                
                Text("Inner Square (Bounds)")
                    .font(.caption)
                Group {
                    Text("Bounds:")
                    Text("  Origin: (\(String(format: "%.1f", boundsRect.origin.x)), \(String(format: "%.1f", boundsRect.origin.y)))")
                    Text("  Size: \(String(format: "%.1f", boundsRect.size.width))x\(String(format: "%.1f", boundsRect.size.height))")
                }
                .font(.caption)
                
                Group {
                    Text("Frame:")
                    Text("  Origin: (\(String(format: "%.1f", frameRect.origin.x)), \(String(format: "%.1f", frameRect.origin.y)))")
                    Text("  Size: \(String(format: "%.1f", frameRect.size.width))x\(String(format: "%.1f", frameRect.size.height))")
                }
                .font(.caption)
            }
        }
        .padding()
    }
}

struct RectPreferenceData: Equatable {
    let bounds: CGRect
    let frame: CGRect
}

struct RectPreferenceKey: PreferenceKey {
    static var defaultValue: RectPreferenceData = RectPreferenceData(bounds: .zero, frame: .zero)
    static func reduce(value: inout RectPreferenceData, nextValue: () -> RectPreferenceData) {
        value = nextValue()
    }
}

#Preview {
    ContentView()
}
