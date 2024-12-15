import SwiftUI

extension EnvironmentValues {
    @Entry public var loading = false
}

extension View {
    @available(iOS 15, *)
    public func loading(_ loading: Bool) -> some View {
        self.environment(\.loading, loading)
            .buttonStyle(.loading)
            .disabled(loading)
    }
}

@available(iOS 15, *)
public struct LoadingButtonStyle: ButtonStyle {
    @Environment(\.loading) var loading
    @Environment(\.isEnabled) var isEnabled
    
    public func makeBody(configuration: Configuration) -> some View {
        if loading {
            ProgressView()
        } else {
            configuration.label
                .foregroundStyle(Color.accentColor)
        }
    }
}

@available(iOS 15, *)
extension ButtonStyle where Self == LoadingButtonStyle {
    public static var loading: LoadingButtonStyle { .init() }
}

#Preview {
    if #available(iOS 15, *) {
        Form {
            Button("Press me") {
                print("pressed!")
            }
            .loading(false)
            
            Button("Press me") {
                print("pressed!")
            }
            .loading(true)
        }
    }
}
