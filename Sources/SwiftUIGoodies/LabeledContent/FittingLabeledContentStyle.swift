import SwiftUI

@available(iOS 16, *)
public struct FittingLabeledContentStyle: LabeledContentStyle {
    public func makeBody(configuration: Configuration) -> some View {
        ViewThatFits(in: .horizontal) {
            LabeledContent(configuration)
            LabeledContent(configuration)
                .labeledContentStyle(.vertical)
        }
    }
}

@available(iOS 16, *)
extension LabeledContentStyle where Self == FittingLabeledContentStyle {
    public static var fitting: FittingLabeledContentStyle { .init() }
}
