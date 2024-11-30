import SwiftUI

@available(iOS 16, *)
public struct VerticalLabeledContentStyle: LabeledContentStyle {
    // @Environment(\.labelsVisibility) var labelsVisibility
    
    public func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading) {
            if showLabel {
                configuration.label
                    .padding(.bottom, 2.5)
                configuration.content
                    .foregroundColor(.secondary)
            } else {
                configuration.content
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var showLabel: Bool {
        // switch labelsVisibility {
        // case .automatic, .visible:
            true
        // case .hidden:
        //     false
        // }
    }
}

@available(iOS 16, *)
extension LabeledContentStyle where Self == VerticalLabeledContentStyle {
    public static var vertical: VerticalLabeledContentStyle { .init() }
}
