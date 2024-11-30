import SwiftUI

@available(iOS 16, *)
public struct VerticalLabeledContentStyle: LabeledContentStyle {
    #if available(iOS 18)
    @Environment(\.labelsVisibility) var labelsVisibility
    #endif
    
    public func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading) {
            if showLabel {
                configuration.label
                    .padding(.bottom, 2.5)
                configuration.content
                    .foregroundStyle(.secondary)
            } else {
                configuration.content
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var showLabel: Bool {
        #if available(iOS 18)
        switch labelsVisibility {
        case .automatic, .visible:
            true
        case .hidden:
            false
        }
        #else
        true
        #endif
    }
}

@available(iOS 16, *)
extension LabeledContentStyle where Self == VerticalLabeledContentStyle {
    public static var vertical: VerticalLabeledContentStyle { .init() }
}
