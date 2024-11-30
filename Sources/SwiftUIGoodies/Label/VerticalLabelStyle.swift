import SwiftUI

@available(iOS 14, *)
public struct VerticalLabelStyle: LabelStyle {
    public func makeBody(configuration: Configuration) -> some View {
        VStack {
            configuration.icon
            configuration.title
        }
    }
}

@available(iOS 14, *)
extension LabelStyle where Self == VerticalLabelStyle {
    public static var vertical: VerticalLabelStyle { .init() }
}
