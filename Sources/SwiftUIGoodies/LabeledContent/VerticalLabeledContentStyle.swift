import SwiftUI

public struct VerticalLabeledContentStyle: LabeledContentStyle {
    @Environment(\.labelsVisibility) var labelsVisibility
    
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
        switch labelsVisibility {
        case .automatic, .visible:
            true
        case .hidden:
            false
        }
    }
}

extension LabeledContentStyle where Self == VerticalLabeledContentStyle {
    public static var vertical: VerticalLabeledContentStyle { .init() }
}

#Preview {
    Form {
        LabeledContent("Foo", value: "Bar")
        LabeledContent("Foo", value: "Bar")
            .labeledContentStyle(.vertical)
        LabeledContent("Foo", value: "Bar")
            .labelsHidden()
        LabeledContent("Foo", value: "Bar")
            .labeledContentStyle(.vertical)
            .labelsHidden()
    }
}
