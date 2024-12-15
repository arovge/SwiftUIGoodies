import SwiftUI

@available(iOS 15, *)
public struct LoadingButtonStyle: PrimitiveButtonStyle {
    @Environment(\.loading) var loading
    
    public func makeBody(configuration: Configuration) -> some View {
        Button(role: configuration.role) {
            configuration.trigger()
        } label: {
            if loading {
                ProgressView()
            } else {
                configuration.label
            }
        }
        .buttonStyle(.automatic)
    }
}

@available(iOS 15, *)
extension PrimitiveButtonStyle where Self == LoadingButtonStyle {
    public static var loading: LoadingButtonStyle { .init() }
}

#Preview {
    if #available(iOS 15, *) {
        NavigationView {
            Form {
                Button("Press me") {
                    print("pressed 1")
                }
                .loading(false)
                
                Button("Press me") {
                    print("pressed 2")
                }
                .loading(true)
                
                Button("Press me", role: .destructive) {
                    print("pressed 3")
                }
                .loading(false)
                
                Button("Press me", role: .destructive) {
                    print("pressed 4")
                }
                .loading(true)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel", role: .destructive) {
                        print("pressed leading")
                    }
                    .loading(false)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save", role: .destructive) {
                        print("pressed trailing")
                    }
                    .loading(true)
                }
            }
        }
    }
}
