import SwiftUI

@available(iOS 14, *)
@available(iOS, deprecated: 16)
public struct LegacyContentUnavailableView<Label, Description, Actions>: View where Label: View, Description: View, Actions: View {
    let label: () -> Label
    let description: () -> Description
    let actions: () -> Actions
    
    public init(
        @ViewBuilder label: @escaping () -> Label,
        @ViewBuilder description: @escaping () -> Description = { EmptyView() },
        @ViewBuilder actions: @escaping () -> Actions = { EmptyView() }
    ) {
        self.label = label
        self.description = description
        self.actions = actions
    }
    
    public var body: some View {
        if #available(iOS 17, *) {
            ContentUnavailableView {
                label()
            } description: {
                description()
            } actions: {
                actions()
            }
        } else {
            VStack {
                label()
                    .font(.title)
                    .labelStyle(.vertical)
                description()
                    .foregroundColor(.secondary)
                actions()
            }
        }
    }
}

@available(iOS 14, *)
extension LegacyContentUnavailableView where Label == SwiftUI.Label<Text, Image>, Description == Text?, Actions == EmptyView {
    public init(_ title: LocalizedStringKey, image name: String, description: Text? = nil) {
        self.init {
            SwiftUI.Label(title, image: name)
        } description: {
            if let description {
                description
            }
        }
    }

    public init(_ title: LocalizedStringKey, systemImage name: String, description: Text? = nil) {
        self.init {
            SwiftUI.Label(title, systemImage: name)
        } description: {
            if let description {
                description
            }
        }
    }

    public init<S>(_ title: S, image name: String, description: Text? = nil) where S: StringProtocol {
        self.init {
            SwiftUI.Label(title, image: name)
        } description: {
            if let description {
                description
            }
        }
    }

    public init<S>(_ title: S, systemImage name: String, description: Text? = nil) where S: StringProtocol {
        self.init {
            SwiftUI.Label(title, systemImage: name)
        } description: {
            if let description {
                description
            }
        }
    }
}

@available(iOS 14, *)
@available(iOS, deprecated: 16)
extension LegacyContentUnavailableView where Label == Text, Description == Text, Actions == EmptyView {
    public static var search: some View {
        LegacySearchUnavailableContent()
    }

    public static func search(text: String) -> some View {
        LegacySearchUnavailableContent(text: text)
    }
}

#Preview {
    if #available(iOS 14, *) {
        LegacyContentUnavailableView("Foo", systemImage: "magnifyingglass", description: Text("Shaba???"))
    } else {
        // Fallback on earlier versions
    }
}
