import SwiftUI

@available(iOS 16, *)
public struct VerticalLabeledContentStyle: LabeledContentStyle {
    public func makeBody(configuration: Configuration) -> some View {
        if #available(iOS 18, *) {
            VisibilityVerticalLabeledContent(configuration)
        } else {
            VStack(alignment: .leading) {
                configuration.label
                    .padding(.bottom, 2.5)
                configuration.content
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

@available(iOS 18, *)
struct VisibilityVerticalLabeledContent: View {
    @Environment(\.labelsVisibility) var labelsVisibility
    let configuration: LabeledContentStyleConfiguration
    
    init(_ configuration: LabeledContentStyleConfiguration) {
        self.configuration = configuration
    }
    
    var body: some View {
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
        switch labelsVisibility {
        case .automatic, .visible: true
        case .hidden: false
        }
    }
}

@available(iOS 16, *)
extension LabeledContentStyle where Self == VerticalLabeledContentStyle {
    public static var vertical: VerticalLabeledContentStyle { .init() }
}
