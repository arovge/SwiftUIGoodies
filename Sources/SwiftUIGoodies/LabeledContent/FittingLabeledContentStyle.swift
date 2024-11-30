import SwiftUI

public struct FittingLabeledContentStyle: LabeledContentStyle {
    public func makeBody(configuration: Configuration) -> some View {
        ViewThatFits(in: .horizontal) {
            LabeledContent(configuration)
            LabeledContent(configuration)
                .labeledContentStyle(.vertical)
        }
    }
}

extension LabeledContentStyle where Self == FittingLabeledContentStyle {
    public static var fitting: FittingLabeledContentStyle { .init() }
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
