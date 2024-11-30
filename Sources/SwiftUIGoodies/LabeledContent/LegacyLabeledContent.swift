import SwiftUI

@available(iOS 13, *)
@available(iOS, deprecated: 15)
public struct LegacyLabeledContent<Label, Content>: View where Label: View, Content: View {
    let label: () -> Label
    let content: () -> Content
        
    public init(
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder label: @escaping () -> Label
    ) {
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

extension LegacyLabeledContent where Label == Text {
    public init(_ titleKey: LocalizedStringKey, @ViewBuilder content: @escaping () -> Content) {
        self.init {
            content()
        } label: {
            Text(titleKey)
        }
    }
    
    public init<S>(_ title: S, @ViewBuilder content: @escaping () -> Content) where S: StringProtocol {
        self.init {
            content()
        } label: {
            Text(title)
        }
    }
}

extension LegacyLabeledContent where Label == Text, Content == Text {
    public init<S>(_ titleKey: LocalizedStringKey, value content: S) where S: StringProtocol {
        self.init {
            Text(content)
        } label: {
            Text(titleKey)
        }
    }
    
    public init<S1, S2>(_ title: S1, value content: S2) where S1: StringProtocol, S2: StringProtocol {
        self.init {
            Text(content)
        } label: {
            Text(title)
        }
    }
    
    @available(iOS 15, *)
    public init<F>(
        _ titleKey: LocalizedStringKey,
        value: F.FormatInput,
        format: F
    ) where F: FormatStyle, F.FormatInput: Equatable, F.FormatOutput == String {
        self.init {
            Text(value, format: format)
        } label: {
            Text(titleKey)
        }
    }
    
    @available(iOS 15, *)
    public init<S, F>(
        _ title: S,
        value: F.FormatInput,
        format: F
    ) where S: StringProtocol, F: FormatStyle, F.FormatInput: Equatable, F.FormatOutput == String {
        self.init {
            Text(value, format: format)
        } label: {
            Text(title)
        }
    }
}
