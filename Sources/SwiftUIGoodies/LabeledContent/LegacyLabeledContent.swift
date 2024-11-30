import SwiftUI

/// A container for attaching a label to a value-bearing view.
///
/// There is no support for the `.labelsHidden()` SwiftUI modifier as there is no trivial way to get that information from the older available environment modifiers.
@available(iOS 13, *)
@available(iOS, deprecated: 15)
public struct LegacyLabeledContent<Label, Content>: View where Label: View, Content: View {
    let label: () -> Label
    let content: () -> Content
    
    public init(_ title: String, value content: String) where Label == Text, Content == Text {
        self.init {
            Text(content)
        } label: {
            Text(title)
        }
    }
    
    public init(content: @escaping () -> Content, label: @escaping () -> Label) {
        self.content = content
        self.label = label
    }
    
    public var body: some View {
        if #available(iOS 16, *) {
            LabeledContent {
                content()
            } label: {
                label()
            }
        } else {
            HStack(alignment: .firstTextBaseline) {
                label()
                Spacer()
                content()
                    .foregroundColor(.secondary)
            }
        }
    }
}
