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
